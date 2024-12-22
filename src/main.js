import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import jQueryPlugin from "./assets/js/jquery-plugin";

import "./assets/js/main";
import "./assets/js/slick.min";

const app = createApp(App);

app.use(router);
app.use(jQueryPlugin);
app.mount("#app");

