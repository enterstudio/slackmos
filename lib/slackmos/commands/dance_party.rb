module Slackmos
  module Commands
    # Random motivational dance images
    # rubocop:disable Metrics/ClassLength
    class DanceParty
      attr_reader :command, :title
      def initialize(command)
        @title   = "Dance Party :dancer: :confetti_ball:"
        @command = command
      end

      def image
        self.class.images.sample
      end

      def count
        result = rand(1..5)
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
          "http://www.gif.tv/gifs/giftv-1539-simpson-trippin.gif",
          "http://25.media.tumblr.com/tumblr_lking8lp5o1qe0dg9o1_400.gif",
          "http://cl.ly/1y2F2n2D01383r1z2y1V/animated.gif",
          "http://cl.ly/1e292Q2Y1p0i1f2n0e1u/animated.gif",
          "http://cl.ly/000t1A1d2E06401Z3m19/animated.gif",
          "http://f.cl.ly/items/1k313G320B3y122r3Q1P/dance-party-2.gif",
          "http://i.imgur.com/rDDjz.gif",
          "http://i358.photobucket.com/albums/oo25/thomfletch/l_9c2098bf410d45aea55b10b15172f241.gif",
          "http://www.warprecords.com/dancefloordale/img/dancefloordale_animated.gif",
          "http://www.gifsoup.com/webroot/animatedgifs/814142_o.gif",
          "http://i601.photobucket.com/albums/tt100/a13x2009/dfdclimax.gif",
          "http://media.tumblr.com/tumblr_lp3cbd1UI91qcxb34.gif",
          "http://28.media.tumblr.com/tumblr_lo8fe02WQh1qk6g9oo1_500.gif",
          "http://media.gifshop.tv/96/3APZBWCSP.gif",
          "http://f.cl.ly/items/300I383Z3U3F2O0g0e2U/ddr-fat-kid.gif",
          "http://f.cl.ly/items/3X3b3O123N2B3a2Y0k2N/grandmas-boy-ddr.gif",
          "http://f.cl.ly/items/3J0X3H3f163L290C161J/grandmas-boy-ddr-2.gif",
          "http://25.media.tumblr.com/tumblr_lok3mfZtlM1qzfebyo1_400.gif",
          "http://f.cl.ly/items/3M0o432c453W0e27362b/do-the-jesus-shuffle.gif",
          "http://f.cl.ly/items/3G3w1z0F1w093c2i412E/caw-cawcaw-cawcaw-cawcaw.gif",
          "http://f.cl.ly/items/3v0m1Y3R0X2d1v1d3x0j/animated.gif",
          "http://media.tumblr.com/tumblr_lfedamrDI51qek4a2.gif",
          "http://f.cl.ly/items/3o2W1a2p3F2T3N0f2F2X/carlton-dance_o_gifsoup-com.gif",
          "http://f.cl.ly/items/2L1V430p0E2u3Z3U1O2r/tumblr_lpz5bqIzlG1qh1jmw.gif",
          "http://24.media.tumblr.com/tumblr_lrl2gqz4SM1qe56h2o7_250.gif",
          "http://www.spaceg.com/multimedia/collection/ytmnd.com/break-dancing%20bear.gif",
          "http://24.media.tumblr.com/tumblr_lr49xq6nwt1qb5gkjo1_400.gif",
          "http://i.imgur.com/5Giqf.gif",
          "http://teamcoco.com/sites/default/files/articles/HipHopAbs500.gif",
          "http://www.japemonster.com/wp-content/uploads/2011/09/funny-gifs-never-stop.gif",
          "http://f.cl.ly/items/1b0l011F0j2p0Q3K3i0U/animated2.gif",
          "http://gifsoup.com/view/610552/kid-play-run-o.gif",
          "http://cl.ly/AgfM/animated.gif",
          "http://26.media.tumblr.com/tumblr_lrout8I2Bn1r1oju1o1_500.gif",
          "http://30.media.tumblr.com/tumblr_ly64ifQ5Kt1qzfjvko1_500.gif",
          "http://26.media.tumblr.com/tumblr_ly1x1mRGjD1rnylu2o1_400.gif",
          "http://24.media.tumblr.com/tumblr_lylr3hiztK1qg39ewo1_500.gif",
          "http://30.media.tumblr.com/tumblr_lyifupcG0i1qg39ewo1_500.gif",
          "http://27.media.tumblr.com/tumblr_lkgistqJfG1qg39ewo1_500.gif",
          "http://i.imgur.com/tCD36.gif",
          "http://25.media.tumblr.com/tumblr_ly5s63bTRf1qg39ewo1_500.gif",
          "http://30.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o1_250.gif",
          "http://29.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o2_250.gif",
          "http://30.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o3_250.gif",
          "http://28.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o4_250.gif",
          "http://25.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o5_250.gif",
          "http://27.media.tumblr.com/tumblr_lqc88zhjgW1qbn9g2o6_250.gif",
          "http://27.media.tumblr.com/tumblr_m02byt738v1r6lhmto1_500.gif",
          "http://29.media.tumblr.com/tumblr_m08bkyiFxW1qbcporo1_500.gif",
          "http://27.media.tumblr.com/tumblr_m07nvgcM9q1rq3tteo1_500.gif",
          "http://i.imgur.com/tcPNF.gif",
          "http://www.gif.tv/gifs/giftv-1419-blazing.gif",
          "http://28.media.tumblr.com/tumblr_m0wolqNK2o1qa4z5ho1_500.gif",
          "http://www.gif.tv/gifs/giftv-1640-bunnybunny.gif",
          "http://f.cl.ly/items/1J1G073L1s3G3s1B0H0x/mikenekorock.gif",
          "http://www.gif.tv/gifs/giftv-1677-colbertwalkthisway.gif",
          "http://www.moviespad.com/photos/stephen-colbert-gif-262f8.jpg",
          "http://29.media.tumblr.com/tumblr_lnbyp8HF9E1qhv4q1o1_400.gif",
          "http://www.gif.tv/gifs/giftv-2052-chickendance.gif",
          "http://i.imgur.com/365tf.gif",
          "http://www.gif.tv/gifs/giftv-2-cartoondanceweapons.gif",
          "http://www.gif.tv/gifs/giftv-1866-sillydance.gif",
          "http://www.gif.tv/gifs/giftv-1205-stupidcheer.gif",
          "http://www.gif.tv/gifs/giftv-266-lizdance.gif",
          "http://www.gif.tv/gifs/giftv-554-batman-ulgglglglgughlgh.gif",
          "http://24.media.tumblr.com/tumblr_m3pjcf2GbC1rvq2tyo1_500.gif",
          "http://25.media.tumblr.com/tumblr_m3xmjsKUet1rtlv4jo1_250.gif",
          "http://24.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo2_250.gif",
          "http://24.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo3_250.gif",
          "http://25.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo4_250.gif",
          "http://24.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo5_250.gif",
          "http://24.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo6_250.gif",
          "http://25.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo7_250.gif",
          "http://24.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo8_250.gif",
          "http://25.media.tumblr.com/tumblr_lwdi5bNI0R1qagn3lo9_250.gif",
          "http://25.media.tumblr.com/tumblr_m501nems071qepqt2o1_250.gif",
          "http://i.imgur.com/ngDXn.gif",
          "http://i.imgur.com/eM48c.gif",
          "http://i.imgur.com/bDF1D.jpg",
          "http://i.imgur.com/D2anS.gif",
          "http://i.imgur.com/nNJjR.gif",
          "http://25.media.tumblr.com/tumblr_m7cujsR39y1qdlh1io1_250.gif",
          "http://25.media.tumblr.com/tumblr_m5l1vyCiSS1qiv8xmo1_250.gif",
          "http://i.imgur.com/ITRTc.gif",
          "http://assets.sbnation.com/assets/1278299/carlton.gif",
          "http://i.minus.com/iy1vN9fgIve4I.gif",
          "http://i.imgur.com/vmgzU.gif",
          "http://i.imgur.com/kgiCR.gif",
          "http://i.imgur.com/OKSKz.gif",
          "http://i.imgur.com/hZGZe.gif",
          "http://i.imgur.com/qbtSE.gif",
          "http://i.imgur.com/rm1TM.gif",
          "http://f.cl.ly/items/0Z123g0M1J17120T0l2l/thriller.gif",
          "http://www.gif.tv/gifs/giftv-2061-getdown.gif",
          "http://gifs.gifbin.com/50yuyu29839.gif",
          "http://www.spaceg.com/multimedia/collection/ytmnd.com/Cyrax%20friendship.gif",
          "http://www.spaceg.com/multimedia/collection/ytmnd.com/Liu%20Kang%20dance.gif",
          "https://i.chzbgr.com/completestore/12/8/8/K0Jp24Cytk6mFh-_KQEBCA2.gif",
          "http://25.media.tumblr.com/tumblr_maefr2j2Bt1rrd8d6o1_500.gif",
          "http://assets0.ordienetworks.com/images/GifGuide/dancing/1zl92fn.gif",
          "http://www.gif.tv/gifs/giftv-1843-groundskeeperdance.gif",
          "http://assets0.ordienetworks.com/images/GifGuide/dancing/smith4.gif",
          "http://i.imgur.com/8qZ9s.gif",
          "http://i.imgur.com/HrxQE.gif",
          "http://9.asset.soup.io/asset/4035/7721_331b_420.gif",
          "http://cl.ly/image/3u3n1M3s0Q1f/petpat.gif",
          "http://media.tumblr.com/tumblr_mc9kx2lu9l1qkjvg5.gif",
          "http://imgur.com/juEsq9K.gif",
          "http://media.tumblr.com/57aef9514e4f7da94a7127877032d9d5/tumblr_mmjtljaL3O1s3v8rqo2_500.gif",
          "http://media.tumblr.com/6b3eeb32484de45c8f97c8bbae25649d/tumblr_mjyhlkdLxL1ql2603o1_400.gif",
          "http://24.media.tumblr.com/fe078c6ee77abcba0335a81a3a6823f4/tumblr_mk0z4xKJei1rbg5ufo1_500.gif",
          "http://cdn.all-that-is-interesting.com/wordpress/wp-content/uploads/2013/05/cinemagraph-gifs-dancing.gif",
          "http://img.ffffound.com/static-data/assets/6/48e9555be431461704ca83f5bdc7f9372c8a7dfd_m.gif",
          "http://25.media.tumblr.com/tumblr_maogyciqhD1r5pjkqo1_500.gif",
          "http://s3-ec.buzzfed.com/static/enhanced/webdr06/2013/6/4/9/anigif_enhanced-buzz-23935-1370351710-10.gif",
          "http://i.imgur.com/oRkl5.gif",
          "http://media.tumblr.com/tumblr_lm815a8UME1qanopl.gif",
          "http://i.imgur.com/7Yt7J.gif",
          "http://25.media.tumblr.com/e586e2d81db16705297d2b48d07f001f/tumblr_mvd1o3oE0F1s02vreo1_250.gif",
          "http://f.cl.ly/items/4104202S052a1L3f3I0f/sumo.gif",
          "http://i.imgur.com/EDqGIpG.gif",
          "https://38.media.tumblr.com/8ad4e93a85545e47341bfecc0e531b81/tumblr_n5viimEmEq1rqd0kpo1_r1_400.gif",
          "https://38.media.tumblr.com/6608ae01d2188ec2c59bf4e66b9f8603/tumblr_ngn0nytLLB1u49o7vo1_400.gif",
          "https://31.media.tumblr.com/4ef6ae0b6dffcc65ddd8e856c3ac8490/tumblr_nfnnflS4Bb1u2602to1_500.gif",
          "https://38.media.tumblr.com/42eb8aeb948d83ce44ef46d008ae1832/tumblr_ni6jemk9A71sxudx7o1_500.gif",
          "http://chicagoings.com/wp-content/uploads/2013/02/solange-afro-shake.gif"
        ]
      end
      # rubocop:enable Metrics/MethodLength
      # rubocop:enable Metrics/LineLength
    end
  end
end
