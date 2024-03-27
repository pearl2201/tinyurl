module UrlHelper
        def generate_shorten_url(length)
            o = [('a'..'z'), ('A'..'Z'),(0..9)].map(&:to_a).flatten
            (0...length).map { o[rand(o.length)] }.join
        end
end
