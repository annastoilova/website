<template>
  <div class="formSimpleCmpContactCnt">
    <div v-if="errorMessage !== null" class="formSimpleCmpContactError">
      {{ errorMessage }}
    </div>
    <div class="formSimpleCmpContactField">
      <input
        type="text"
        placeholder="Your email or phone #"
        autocomplete="off"
        autocapitalize="none"
        class="formSimpleCmpContactInput"
        :class="{ formSimpleCmpContactInputError: errorMessage !== null }"
        @input="onInput"
        @keypress.enter="onSubmit"
      />
      <div
        class="formSimpleCmpContactSend"
        :class="{
          formSimpleCmpContactSendReady: isReady,
          formSimpleCmpContactSendNotReady: !isReady,
        }"
        @click="onSubmit"
      >
        {{ cta }}
      </div>
    </div>
    <form-simple-cmp-secure v-if="how" class="formSimpleCmpSecure" />
  </div>
</template>

<script>
import FormSimpleCmpSecure from '@/components/form_simple/FormSimpleCmpSecure'
import { signUp } from '@/libs/api'

export default {
  name: 'FormSimpleCmpContact',
  components: { FormSimpleCmpSecure },
  props: {
    cta: {
      type: String,
      required: true,
    },
    how: {
      type: Boolean,
      required: false,
      default: true,
    },
  },
  data() {
    return {
      contact: '',
      errorMessage: null,
    }
  },
  computed: {
    isReady() {
      return (
        /\S+@\S+\.\S+/.test(this.contact) ||
        /^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$/.test(
          this.contact
        )
      )
    },
  },
  methods: {
    onInput(inputEvent) {
      this.contact = inputEvent.target.value
    },
    async onSubmit(submitEvent) {
      submitEvent.preventDefault()
      if (this.isReady) {
        this.errorMessage = null
        this.$store.commit('form_signup/setContact', this.contact)
        this.$store.commit('form_signup/setPosOpt')
        const rsp = await signUp(
          this.$axios,
          this.contact,
          this.$store.state.code
        ).then(function (data) {
          return data.success
        })
        if (!rsp) {
          this.errorMessage =
            "Uh oh, something went wrong. Send us a note, we'll fix it!"
          this.$plausible.trackEvent('Signup', {
            props: { affiliate: this.$store.state.code, error: true },
          })
        } else {
          this.$plausible.trackEvent('Signup', {
            props: { affiliate: this.$store.state.code },
          })
        }
      } else this.errorMessage = 'Uh oh, we need a valid email to notify you :)'
    },
  },
}
</script>

<style scoped lang="sass">
@import "../../assets/styles/mixins"

.formSimpleCmpContactInput, .formSimpleCmpContactSend
  background: $white
  display: block
  border-style: solid
  border-color: $gray
  font-family: $font-family-montserrat
  font-weight: 600

.formSimpleCmpContactInput
  color: $blue
  margin: 0 auto

.formSimpleCmpContactSend
  color: $black-dark

.formSimpleCmpContactSend
  font-family: $font-family-montserrat
  color: $white

.formSimpleCmpContactField
  width: 100%
  margin: 0 auto

.formSimpleCmpContactInput::placeholder
  color: $gray

.formSimpleCmpContactInput:focus
  outline: 0
  border-color: $blue

.formSimpleCmpContactInputError, .formSimpleCmpContactInputError:focus
  border-color: $orange

.formSimpleCmpContactSend
  cursor: pointer

.formSimpleCmpContactSendReady
  background: $green
  border-color: $green

.formSimpleCmpContactSendNotReady
  background: $blue-dark
  border-color: $blue-dark

.formSimpleCmpContactError
  font-family: $font-family-montserrat
  font-weight: 600
  color: $orange
  text-align: center

@include for-phone
  .formSimpleCmpContactCnt
    width: 100%

  .formSimpleCmpContactInput, .formSimpleCmpContactSend
    height: 15vw
    border-radius: 4vw
    font-size: 6vw
    text-indent: 4vw
    width: 88%

  .formSimpleCmpContactInput:focus
    border-radius: 4vw

  .formSimpleCmpContactSend
    margin: 5vw auto 0 auto
    line-height: 15vw

  .formSimpleCmpSecure
    margin-top: 5vw

  .formSimpleCmpContactError
    margin-bottom: 2vw
    font-size: 3.5vw

@include for-tablet
  .formSimpleCmpContactCnt
    margin: 1vw auto 0 auto
    width: 33%

  .formSimpleCmpContactInput, .formSimpleCmpContactSend
    height: 3vw
    border-radius: 0.5vw
    font-size: 1.5vw
    text-indent: 0.75vw
    width: 95%

  .formSimpleCmpContactInput:focus
    border-radius: 0.5vw

  .formSimpleCmpContactSend
    margin: 1.25vw auto 0 auto
    line-height: 3vw

  .formSimpleCmpSecure
    margin-top: 1.25vw

  .formSimpleCmpContactError
    margin-bottom: 0.5vw
    font-size: 1.1vw
</style>
