module TarvitHelpers
  class SimpleCrypt
    require 'openssl'
    require 'digest/sha1'
    require 'base64'

    TYPE = "aes-256-cbc"

    def initialize(secret_key)
      @ciper = OpenSSL::Cipher::Cipher.new(TYPE)
      @secret_key = secret_key.to_s
    end

    def encrypt(string)
      @ciper.encrypt
      @ciper.key = Digest::SHA1.hexdigest(@secret_key)
      res = @ciper.update(string)
      res << @ciper.final
      Base64.encode64(res)
    end

    def decrypt(code)
      hash = Base64.decode64(code)
      @ciper.decrypt
      @ciper.key = Digest::SHA1.hexdigest(@secret_key)
      d = @ciper.update(hash)
      d << @ciper.final
    end
  end
end
