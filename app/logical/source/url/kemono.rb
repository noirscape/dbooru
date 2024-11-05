# frozen_string_literal: true

class Source::URL::Kemono < Source::URL
    attr_reader :service, :user_id, :post_id, :direct_image_link
  
    def self.match?(url)
      url.domain.in?(%w[kemono.su kemono.party])
    end
  
    def parse
      case [subdomain, domain, *path_segments]
  
      # https://kemono.su/patreon/user/1234567890
      in _, "kemono.su", service, "user", /^\d+$/ => user_id
        @service = service
        @user_id = user_id
  
      # https://kemono.su/patreon/user/1234567890/post/1234567890
      in _, "kemono.su", service, "user", /^\d+$/ => user_id, "post", /^\d+$/ => post_id
        @service = service
        @user_id = user_id
        @post_id = post_id
  
      in _, "kemono.su", "data", *_, /^(?<file_hash>[a-f0-9]{64})\.\w+$/ => file_hash
        @direct_image_link = url
  
      else
        nil
      end
    end
  
    def page_url
      "https://kemono.su/#{service}/user/#{user_id}/post/#{post_id}" if enough_page_data?
    end
  
    def profile_url
      "https://kemono.su/#{service}/user/#{user_id}" if enough_profile_data?
    end
  
    def enough_page_data?
      service.present? && user_id.present? && post_id.present?
    end
  
    def enough_profile_data?
      service.present? && user_id.present?
    end
  end
  