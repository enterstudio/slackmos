module Slackmos
  module Commands
    # Random nope images
    class Nope
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
          "http://i.imgur.com/Gw6zf.gif",
          "http://25.media.tumblr.com/tumblr_m7nkubRAi61qg4kkko1_500.png",
          "http://i.imgur.com/cqBTC.gif",
          "http://25.media.tumblr.com/tumblr_me2levf0gR1qh9dubo1_400.gif",
          "http://www.lememe.com/wp-content/uploads/2012/12/nonononono.gif",
          "http://www.abload.de/img/michael-scott-noa6efh.gif",
          "http://i69.photobucket.com/albums/i61/0do/trek/data.gif",
          "http://img714.imageshack.us/img714/6981/1276708167348.gif",
          "http://25.media.tumblr.com/d93252138be979f40768249be6fb5ad8/tumblr_mjfnfxE5vk1qdlh1io1_400.gif",
          "http://24.media.tumblr.com/tumblr_mch5ilaasC1qes27do1_500.gif",
          "http://cdn2.mocksession.com/wp-content/uploads/2013/01/WATT-FINGER-WAG.gif",
          "http://www.netanimations.net/universa-finger-wag.gif",
          "http://www.totalprosports.com/wp-content/uploads/2013/02/kobe-finger-wag-kobe-bryant-gifs.gif",
          "http://f.cl.ly/items/0k0E2j0x3C171F1m3y2A/babu-finger-wag1-1.gif",
          "http://gifrific.com/wp-content/uploads/2012/09/Kanye-West-Shaking-Head-No.gif",
          "http://25.media.tumblr.com/c3bef0904bfae4fdfbea0c45da963c53/tumblr_miv2g4OYWd1qig079o1_250.gif",
          "http://media.tumblr.com/3d04008d4b05a421d877b0852e5b0a0a/tumblr_inline_miok33A2yO1qz4rgp.gif",
          "http://assets.sbnation.com/assets/2175737/dikembereturns.gif",
          "http://gifrific.com/wp-content/uploads/2013/02/Dikembe-Mutumbo-Cereal-Block-Geico.gif",
          "http://25.media.tumblr.com/67050299f2764d1935dc53a97a3c6390/tumblr_miwu76JzxB1renuivo1_500.gif",
          "http://24.media.tumblr.com/571f6d3ab803e0b6a57450780a7f7322/tumblr_miw7mpjIsp1rmazn7o1_500.gif",
          "http://dl.dropboxusercontent.com/u/92083149/hickeynope.jpg",
          "https://github.campfirenow.com/room/165670/uploads/4975550/3sNPQvV.gif",
          "http://i.imgur.com/neEYSFF.gif",
          "http://i.imgur.com/AFDgWs5.gif",
          "https://24.media.tumblr.com/c0cdbdd117bf64111666c32f8f3c815a/tumblr_n13vc9nm1Q1svlvsyo2_250.gif",
          "http://24.media.tumblr.com/e4d438cf6ed41fcf22a3bb4c1cb0e157/tumblr_mr1p7sXQHj1qzxzcso1_500.gif"
        ]
      end
    end
  end
end
