<template>
  <div class="headerHomeCnt">
    <div class="headerHomeBkgImgLgHide">
      <utils-svg-cmp name="background/header-2-lg" class="headerHomeBkgImgLg" />
    </div>
    <div class="headerHomeBkgImgHide">
      <utils-svg-cmp name="background/header-2" class="headerHomeBkgImg" />
    </div>
    <div class="headerHomeContent">
      <div class="headerHomeContentWrapper">
        <div class="headerHomeNav">
          <nuxt-link to="/">
            <utils-svg-cmp name="tiki/logo" class="headerHomeLogo" />
          </nuxt-link>
          <div class="headerHomeNavRight">
            <nuxt-link to="/meet" class="headerLinkMission">Mission</nuxt-link>
            <div
              class="headerLinkFAQ"
              @click="
                faqClick(
                  $event,
                  'https://medium.com/mytiki/tiki-faqs-48c783972df1?source=friends_link&sk=2e2903eecb626bee96070739c16a474c'
                )
              "
            >
              FAQ
            </div>
            <nuxt-link
              v-scroll-to="{ el: '#signup' }"
              :to="{ path: '/', hash: 'signup' }"
              class="headerLinkSignup headerLinkSignupNav"
              >Sign up
            </nuxt-link>
          </div>
        </div>
        <div class="headerHomeText">
          <div class="headerHomeTitle">It's your data. Get paid for it.</div>
          <div class="headerHomeSubtitle">
            Your data is worth thousands a year. Why aren’t you getting your
            fair share? Take back control. Get paid. Tiki’s got your back.
          </div>
          <nuxt-link
            v-scroll-to="{ el: '#signup' }"
            :to="{ path: '/', hash: 'signup' }"
            class="headerLinkSignup"
            >Sign up
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import UtilsSvgCmp from '@/components/utils/UtilsSvgCmp.vue'

export default {
  name: 'HeaderHomeCmp',
  components: { UtilsSvgCmp },
  methods: {
    faqClick(clickEvent, href) {
      clickEvent.preventDefault()
      clickEvent.stopPropagation()
      this.$plausible.trackEvent('FAQ', {
        props: { location: 'Home' },
      })
      const win = window.open(href, '_blank')
      win.focus()
    },
  },
}
</script>

<style scoped lang="sass">
@import "../../assets/styles/mixins"

.headerHomeCnt
  background: $tan-light
  position: relative
  width: 100%

.headerHomeBkgImgLg, .headerHomeBkgImg
  position: absolute
  z-index: 1

.headerHomeContent
  position: absolute
  top: 0
  left: 0
  z-index: 2
  height: 100%
  width: 100%

.headerHomeContentWrapper
  position: relative

.headerHomeTitle
  font-family: $font-family-montserrat
  font-weight: 600

.headerHomeText
  font-family: $font-family-montserrat
  font-weight: 600

::v-deep .headerHomeBkgImgLg.svg > .layer1, ::v-deep .headerHomeBkgImgLg.svg > .lens, ::v-deep .headerHomeBkgImg.svg > .layer1, ::v-deep .headerHomeBkgImg.svg > .lens
  fill: $orange

::v-deep .headerHomeBkgImgLg.svg > .layer2, ::v-deep .headerHomeBkgImg.svg > .layer2
  fill: $yellow-xlight

::v-deep .headerHomeBkgImgLg.svg > .frames, ::v-deep .headerHomeBkgImg.svg > .frames
  fill: $black-dark

::v-deep .headerHomeBkgImgLg.svg > .pineapple, ::v-deep .headerHomeBkgImg.svg > .pineapple
  fill: $black-light

::v-deep .headerHomeLogo.svg
  fill: $black-dark

.headerHomeNav
  display: flex
  align-items: center
  justify-content: space-between

.headerHomeNavRight
  display: flex
  align-items: center

.headerLinkMission, .headerLinkFAQ
  font-family: $font-family-montserrat
  color: $black-dark
  text-decoration: none
  font-weight: 600
  cursor: pointer

.headerLinkSignup
  font-family: $font-family-montserrat
  color: $white
  text-decoration: none
  font-weight: 600
  background: $red

.headerLinkMission:hover, .headerLinkMission:visited, .headerLinkMission:link, .headerLinkMission:active, .headerLinkSignup:hover, .headerLinkSignup:visited, .headerLinkSignup:link, .headerLinkSignup:active, .headerLinkFAQ:hover, .headerLinkFAQ:visited, .headerLinkFAQ:link, .headerLinkFAQ:active
  text-decoration: none

@include for-phone
  .headerHomeCnt
    height: 145vw

  .headerLinkSignupNav
    display: none

  .headerHomeBkgImgLgHide
    display: none

  ::v-deep .headerHomeBkgImg.svg
    height: 40vw
    right: 0
    bottom: 22%

  ::v-deep .headerHomeLogo.svg
    height: 8vw

  .headerHomeContentWrapper
    padding: 4vw

  .headerHomeText
    margin: 13vw 0 0 0

  .headerHomeTitle
    font-size: 10vw
    width: 90%

  .headerHomeSubtitle
    font-size: 5vw
    margin-top: 5vw
    margin-bottom: 12vw
    font-weight: 300
    width: 90%

  .headerLinkSignup
    font-size: 5vw
    padding: 2vw 10vw
    border-radius: 2.5vw

  .headerLinkMission, .headerLinkFAQ
    font-size: 5vw
    margin-left: 4vw

@include for-tablet
  .headerHomeCnt
    height: 25vw

  .headerHomeBkgImgHide
    display: none

  ::v-deep .headerHomeBkgImgLg.svg
    height: 17vw
    right: 0
    top: 17%

  ::v-deep .headerHomeLogo.svg
    height: 2vw

  .headerHomeContentWrapper
    padding: 1.5vw

  .headerHomeText
    margin: 5vw 0 0 5vw
    width: 42%

  .headerHomeTitle
    font-size: 2.75vw

  .headerHomeSubtitle
    font-size: 1vw
    margin-top: 1vw
    margin-bottom: 3vw

  .headerLinkSignup
    font-size: 1vw
    padding: 0.5vw 1.75vw
    border-radius: 0.6vw

  .headerLinkMission, .headerLinkFAQ
    font-size: 1vw
    margin-right: 2vw
</style>
