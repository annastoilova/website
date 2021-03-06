<template>
  <div class="socialShareCnt">
    <utils-svg-cmp name="sketch/share" class="socialShareSketchShare" />
    <div class="socialShareFight">
      Together we can fight back against creepy tech.
    </div>
    <div class="socialShareBtnGroup">
      <div class="socialShareBtnRow1">
        <div class="socialShareBtnWrapper" @click="socialTrack('Twitter')">
          <share-network
            network="twitter"
            :url="currentUrl"
            :title="twitter.title"
            :description="twitter.description"
            :hashtags="twitter.hashtags"
          >
            <utils-svg-cmp
              name="button/twitter"
              class="socialShareBtn socialShareBtnTwt"
            />
          </share-network>
        </div>
        <a class="socialShareBtnIgShare" @click="igShare">
          <utils-svg-cmp
            name="button/instagram"
            class="socialShareBtn socialShareBtnIg"
          />
        </a>
      </div>
      <div class="socialShareBtnWrapper" @click="socialTrack('Facebook')">
        <share-network
          network="facebook"
          :url="currentUrl"
          :title="facebook.title"
          :description="facebook.description"
          :hashtags="facebook.hashtags"
          class="socialShareBtnRow2"
        >
          <utils-svg-cmp
            name="button/facebook"
            class="socialShareBtn socialShareBtnFb"
          />
        </share-network>
      </div>
      <div class="socialShareBtnRow3">
        <a class="socialShareBtnWebShare" @click="webShare">
          <utils-svg-cmp
            name="button/share"
            class="socialShareBtn socialShareBtnSh"
          />
          <utils-svg-cmp
            name="button/share-lg"
            class="socialShareBtn socialShareBtnShLg"
          />
        </a>
        <div class="socialShareBtnWrapper" @click="socialTrack('LinkedIn')">
          <share-network
            network="linkedin"
            :url="currentUrl"
            :title="linkedin.title"
            :description="linkedin.description"
            :hashtags="linkedin.hashtags"
          >
            <utils-svg-cmp
              name="button/linkedin"
              class="socialShareBtn socialShareBtnLi"
            />
            <utils-svg-cmp
              name="button/linkedin-lg"
              class="socialShareBtn socialShareBtnLiLg"
            />
          </share-network>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UtilsSvgCmp from '@/components/utils/UtilsSvgCmp'

const TITLE = "It's your data. Get paid for it."
const DESCRIPTION =
  'TIKI helps you take back control of your online data and privacy and get paid for it. With TIKI, you can see, control and monetize your online data.'
const HASHTAGS = 'TIKI'

export default {
  name: 'SocialShareCmp',
  components: { UtilsSvgCmp },
  data() {
    return {
      facebook: {
        title: TITLE,
        description: DESCRIPTION,
        hashtags: HASHTAGS,
      },
      instagram: {
        title: TITLE,
        description: DESCRIPTION,
        hashtags: HASHTAGS,
        profile: 'https://instagram.com/my.tiki',
      },
      twitter: {
        title: TITLE,
        description: DESCRIPTION,
        hashtags: HASHTAGS,
      },
      linkedin: {
        title: TITLE,
        description: DESCRIPTION,
        hashtags: HASHTAGS,
      },
      web: {
        title: TITLE,
        description: DESCRIPTION,
        hashtags: HASHTAGS,
      },
    }
  },
  computed: {
    currentUrl() {
      return 'https://mytiki.com' + this.$route.fullPath
    },
  },
  methods: {
    copy(url) {
      this.$toast.clear()
      const input = document.createElement('textarea')
      input.innerHTML = url
      document.body.appendChild(input)
      input.select()
      document.execCommand('copy')
      document.body.removeChild(input)
      this.shownToast = this.$toast
        .show('Link copied, now share.', {
          position: 'bottom-right',
        })
        .goAway(5000)
    },
    share(title, url, description, hashtags) {
      let text = description
      if (hashtags) text = description + ' #' + hashtags.replace(' ', ' #')
      navigator.share({ title, url, text })
    },
    canShare() {
      return !!(process.client && navigator && navigator.share)
    },
    webShare(clickEvent) {
      clickEvent.preventDefault()
      this.socialTracK('Link')
      if (process.client) {
        if (navigator && navigator.share)
          this.share(
            this.web.title,
            this.currentUrl,
            this.web.description,
            this.web.hashtags
          )
        else this.copy(this.currentUrl)
      }
    },
    igShare(clickEvent) {
      clickEvent.preventDefault()
      this.socialTrack('Instagram')
      if (process.client) {
        if (navigator && navigator.share)
          this.share(
            this.instagram.title,
            this.currentUrl,
            this.instagram.description,
            this.instagram.hashtags
          )
        else window.location.href = this.instagram.profile
      }
    },
    socialTrack(platform) {
      this.$plausible.trackEvent('Share', {
        props: { location: 'Component', platform },
      })
    },
  },
}
</script>

<style scoped lang="sass">
@import "../../assets/styles/mixins"

.socialShareCnt
  width: 100%

.socialShareSketchShare
  margin: 0 auto

.socialShareFight
  font-family: $font-family-koara
  color: $purple
  font-weight: bold
  text-align: center

.socialShareBtnWrapper, .socialShareBtnIgShare, .socialShareBtnWebShare
  cursor: pointer

.socialShareBtnFb
  margin: 0 auto

::v-deep .socialShareBtn.svg > .bkg
  fill: $blue-light

::v-deep .socialShareBtn.svg > .ico
  fill: $blue-dark

.socialShareBtn:hover
  animation: wiggle 0.75s infinite

::v-deep .socialShareBtn:hover.svg > .bkg
  fill: $yellow-light

@keyframes wiggle
  0%
    transform: rotate(0deg)
  80%
    transform: rotate(0deg)
  85%
    transform: rotate(10deg)
  95%
    transform: rotate(-10deg)
  100%
    transform: rotate(0deg)

.socialShareBtnRow1
  display: flex
  align-items: center
  justify-content: space-between

.socialShareBtnRow3
  display: flex
  align-items: center
  justify-content: space-between

@include for-phone
  ::v-deep .socialShareSketchShare.svg
    height: 13vw

  .socialShareFight
    font-size: 5vw
    margin: 6vw auto 0 auto
    width: 80%

  ::v-deep .socialShareBtnTwt.svg
    height: 30vw

  ::v-deep .socialShareBtnIg.svg
    height: 30vw

  ::v-deep .socialShareBtnFb.svg
    height: 30vw

  ::v-deep .socialShareBtnSh.svg
    height: 50vw

  ::v-deep .socialShareBtnShLg.svg
    display: none
    height: 0

  ::v-deep .socialShareBtnLi.svg
    height: 35vw

  ::v-deep .socialShareBtnLiLg.svg
    display: none
    height: 0

  .socialShareBtnRow3
    margin-top: -10vw

  .socialShareBtnGroup
    margin-top: 10vw
@include for-tablet
  ::v-deep .socialShareSketchShare.svg
    height: 4vw

  .socialShareFight
    font-size: 1.25vw
    margin: 2vw auto 0 auto
    width: 80%

  ::v-deep .socialShareBtnTwt.svg
    height: 6vw

  ::v-deep .socialShareBtnIg.svg
    height: 6vw

  ::v-deep .socialShareBtnFb.svg
    height: 6vw

  ::v-deep .socialShareBtnSh.svg
    height: 0
    display: none

  ::v-deep .socialShareBtnShLg.svg
    display: unset
    height: 10vw

  ::v-deep .socialShareBtnLi.svg
    height: 0
    display: none

  ::v-deep .socialShareBtnLiLg.svg
    display: unset
    height: 7vw

  .socialShareBtnRow1, .socialShareBtnRow2, .socialShareBtnRow3
    width: 33%

  .socialShareBtnGroup
    display: flex
    align-items: center
    justify-content: space-between
    width: 60%
    margin: 3vw auto 0 auto
    padding-bottom: 2vw
</style>
