module Slackmos
  module Commands
    # Random pizza images
    class Pizza
      attr_reader :command
      def initialize(command)
        @command = command
      end

      def image
        self.class.images.sample
      end

      def count
        result = 1
        matches = command.command_text.match(/x(\d+)/)
        if matches
          result = Integer(matches[1])
        end
        result = 3 if result > 10
        result
      end

      def results
        (1..count).map { image }
      end

      # rubocop:disable Metrics/MethodLength
      # rubocop:disable Metrics/LineLength
      def self.images
        [
          "http://imgur.com/O20DKF0.gif",
          "http://imgur.com/VLue3fk.gif",
          "http://imgur.com/P0UJOcZ.gif",
          "http://imgur.com/xouJ75i.gif",
          "http://imgur.com/O7bj35F.gif",
          "http://imgur.com/1MaSK9k.gif",
          "http://imgur.com/LVKxRM3.gif",
          "http://imgur.com/l5uHApE.gif",
          "http://imgur.com/rl0Y5iG.gif",
          "http://imgur.com/S1Ga4tc.gif",
          "http://imgur.com/qr4QhPC.gif",
          "http://imgur.com/yR2hqHP.gif",
          "http://imgur.com/SYKoA28.gif",
          "http://imgur.com/N01CgTK.gif",
          "http://imgur.com/05FsusC.gif",
          "http://ak-hdl.buzzfed.com/static/2014-04/enhanced/webdr02/20/22/anigif_enhanced-12473-1398046920-4.gif",
          "http://imgur.com/rRqabqw.gif",
          "http://imgur.com/2wI8fSN.gif",
          "http://imgur.com/lPMnbqn.gif",
          "http://imgur.com/gm5xxIF.gif",
          "http://imgur.com/d2tJx3z.gif",
          "http://imgur.com/HilfXl4.gif",
          "http://imgur.com/PuoDK1g.gif",
          "http://imgur.com/Rjpxptz.gif",
          "http://imgur.com/PVRwMQw.gif",
          "http://imgur.com/HcCqt3j.gif",
          "http://imgur.com/1IfTCPc.gif",
          "http://imgur.com/T06APNW.gif",
          "http://imgur.com/kmtdfjK.gif",
          "http://imgur.com/FS9eC2T.gif",
          "http://imgur.com/apfzxym.gif",
          "http://i.imgur.com/njVTIkZ.gif",
          "http://fc08.deviantart.net/fs71/f/2011/360/e/b/pikachu___pizza_party_by_mnrart-d4kce7x.gif",
          "http://files.gamebanana.com/img/ico/sprays/52a031ecb46ea.gif",
          "http://i.imgur.com/Ie5JN17.jpg",
          "http://boingboing.net/wp-content/uploads/2014/12/ezgif-820126149.gif",
          "http://25.media.tumblr.com/bbb64474b739ce62a7fdad513e85ff56/tumblr_mfq2ywCv2a1s1h0gzo1_250.gif",
          "http://media3.giphy.com/media/sTUWqCKtxd01W/giphy.gif",
          "http://media3.giphy.com/media/xsBP0RdvxJfhu/giphy.gif",
          "https://38.media.tumblr.com/ce3aa0aec854e0a9f6480ef1e2631bd4/tumblr_n9eq8a1HAz1tbe5djo1_400.gif",
          "https://33.media.tumblr.com/c90eab19dbf818b24b37621105572045/tumblr_n4pg7j2RJF1ro8ysbo1_500.gif"
        ]
      end
    end
  end
end
