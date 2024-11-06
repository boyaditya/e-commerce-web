<template>
  <router-view />
</template>

<script>
import "@/assets/css/bootstrap.min.css";
import "@/assets/css/font-awesome.min.css";
import "@/assets/css/nouislider.min.css";
import "@/assets/css/slick-theme.css";
import "@/assets/css/slick.css";
import "@/assets/css/style.css";

export default {
  name: "App",
  mounted() {
    this.initializeScripts();
  },
  methods: {
    initializeScripts() {
      (function($) {
        "use strict"

        // Mobile Nav toggle
        $(".menu-toggle > a").off("click").on("click", function (e) {
          e.preventDefault();
          $("#responsive-nav").toggleClass("active");
        });

        // Fix cart dropdown from closing
        $(".cart-dropdown").off("click").on("click", function (e) {
          e.stopPropagation();
        });

        // Products Slick
        $(".products-slick").each(function () {
          var $this = $(this),
            $nav = $this.attr("data-nav");

          if ($this.hasClass("slick-initialized")) {
            $this.slick("unslick");
          }

          $this.slick({
            slidesToShow: 4,
            slidesToScroll: 1,
            autoplay: true,
          });
        });

        // Price Slider
        // var priceSlider = document.getElementById("price-slider");
        // if (priceSlider) {
        //   if (priceSlider.noUiSlider) {
        //     priceSlider.noUiSlider.destroy();
        //   }

        //   noUiSlider.create(priceSlider, {
        //     start: [1, 999],
        //     connect: true,
        //     step: 1,
        //     range: {
        //       min: 1,
        //       max: 999,
        //     },
        //   });

        //   priceSlider.noUiSlider.on("update", function (values, handle) {
        //     var value = values[handle];
        //     handle ? (priceInputMax.value = value) : (priceInputMin.value = value);
        //   });
        // }

      })(jQuery);
    }
  },
  watch: {
    $route() {
      this.$nextTick(() => {
        this.initializeScripts();
      });
    },
  }
};
</script>