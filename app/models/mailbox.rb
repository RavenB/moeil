class Mailbox < ActiveRecord::Base

  belongs_to :domain

  devise :database_authenticatable, :encryptable
  require Rails.root.join('lib', 'devise', 'encryptors', 'sha512_dovecot')

  attr_accessible :active, :admin, :mail_location, :name, :password,
    :password_confirmation, :quota, :username

  def email
    [self.username, self.domain.name].join('@') rescue nil
  end

  def password_salt
    salt = self.encrypted_password.split('$')[2] rescue nil
    return Password::Sha512Crypt.generate_salt if salt.blank?
    salt
  end

  def password_salt=(value)
  end

  def password_scheme
    { 1 => :md5_crypt, 6 => :sha512_crypt }[encrypted_password.split('$')[1]]
  end

end
