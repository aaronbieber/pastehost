class Paste < ActiveRecord::Base
	validates_presence_of :paste, :message => 'You have to paste <em>something.</em>'
  validates_presence_of :ip
  validates_length_of :paste, :maximum => 5000, :message => 'Try to keep it under 5,000 characters, alright?'

  SANITIZE_ELEM = ['a', 'b', 'i', 's',
                   'strong', 'em', 'u',
                   'sup', 'sub', 'ul',
                   'ol', 'li', 'p', 'br',
                   'blockquote']
  SANITIZE_ATTR = { 'a' => ['href', 'title'] }
  SANITIZE_PROTO = { 'a' => { 'href', [ 'http', 'https' ] } }

  def paste(sanitize = true)
    p = read_attribute(:paste).dup

		# Allow raw URLs to be links
		p.gsub!(/\swww\./, ' http://www.')
		p.gsub!(/([^:])((?:https?:\/\/)[a-z0-9$_.+'()-]*)/, '\1"\2":\2')

    r = RedCloth.new p
    r = r.to_html
    if sanitize
      r = Sanitize.clean(r,
           :elements => SANITIZE_ELEM,
           :attributes => SANITIZE_ATTR ,
           :protocols => SANITIZE_PROTO)
    end

    r
  end

  def short
    (self.paste.length > 100) ?
      Sanitize.clean(self.paste(false)[0,100]) + '...' : self.paste
  end

  def setup
    self.code = self.generate_code()
  end

  def ago
    diff = Time.now.localtime.tv_sec - self.created_at.tv_sec
    duration = []

    if diff > 31557600
      duration << 'years'
    elsif diff > 2629800
      months = diff / 2629800
      duration << months.to_s + ' month' + ((months > 1) ? 's' : '')

      diff = diff % 2629800
    end

    if diff > 525960
      weeks = diff / 525960
      duration << weeks.to_s + ' week' + ((weeks > 1) ? 's' : '')

      diff = diff % 525960
    end

    if diff > 86400
      days = diff / 86400
      duration << days.to_s + ' day' + ((days > 1) ? 's' : '')

      diff = diff % 86400
    end

    if diff > 3600
      hours = diff / 3600
      duration << hours.to_s + ' hour' + ((hours > 1) ? 's' : '')

      diff = diff % 3600
    end
    
    if diff > 60
      minutes = diff / 60
      duration << minutes.to_s + ' minute' + ((minutes > 1) ? 's' : '')

      diff = diff % 60
    end

    if duration.empty?
      duration << 'moments'
    end

    # This would give the FULL resolution:
    # duration.join(', ')

    duration[0]
  end

	def generate_code
    begin
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ1234567890'  
      code = ''  
      5.times { |i| code << chars[rand(chars.length)] }  
    end until Paste.find(:first, :conditions => [ "code = ?", code ]).nil?

		code
	end

  def self.random
    Paste.find_by_sql("SELECT * FROM pastes p JOIN (SELECT FLOOR(MAX(id)*RAND()) AS id FROM pastes) AS x ON p.id >= x.id WHERE p.private = 0 LIMIT 1")[0]
  end
end
