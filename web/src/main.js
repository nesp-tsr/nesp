// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueTippy from 'vue-tippy'
import autofocus from 'vue-autofocus-directive'
import UserNav from '@/components/UserNav'

Vue.directive('autofocus', autofocus)
Vue.use(VueTippy)

Vue.config.productionTip = false

Vue.component('user-nav', UserNav)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
