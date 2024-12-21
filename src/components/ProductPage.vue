<template>
  <BreadCrumbPage :categoryName="categoryName" :productName="product.name" />

  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->
      <div class="row" v-if="isLoading">
        <div class="col-md-12 loading-container">
          <div class="spinner"></div>
        </div>
      </div>
      <div class="row" v-else>
        <!-- Product main img -->
        <div class="col-md-5">
          <div id="product-main-img">
            <div class="product-preview">
              <img src="@/assets/img/product01.png" alt="" />
            </div>
          </div>
        </div>
        <!-- /Product main img -->

        <!-- Product thumb imgs -->
        <!-- <div class="col-md-2 col-md-pull-5">
          <div id="product-imgs">
            <div class="product-preview">
              <img src="@/assets/img/product01.png" alt="" />
            </div>

            <div class="product-preview">
              <img src="@/assets/img/product03.png" alt="" />
            </div>

            <div class="product-preview">
              <img src="@/assets/img/product06.png" alt="" />
            </div>

            <div class="product-preview">
              <img src="@/assets/img/product08.png" alt="" />
            </div>
          </div>
        </div> -->
        <!-- /Product thumb imgs -->

        <!-- Product details -->
        <div class="col-md-7">
          <div class="product-details">
            <h2 class="product-name">{{ product.name }}</h2>
            <!-- <div>
              <div class="product-rating">
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star"></i>
                <i class="fa fa-star-o"></i>
              </div>
              <a class="review-link" href="#">10 Review(s) | Add your review</a>
            </div> -->
            <div>
              <h3 class="product-price">
                {{ formattedTotalPrice }}
                <!-- <del class="product-old-price">$990.00</del> -->
              </h3>
              <span class="product-available">Stock: {{ product.stock }}</span>
            </div>

            <hr class="hr" />
            <p>
              <i class="fa fa-map-marker icon"></i> Dikirim dari
              <b>Kota Bandung</b>
            </p>
            <p><i class="fa fa-truck icon"></i> <b>Ongkir mulai Rp12.000</b></p>
            <small style="margin-left: 30px"
              >Reguler • Estimasi tiba {{ estimatedArrival }}</small
            >
            <br />
            <hr class="hr" />
            <!-- <div class="product-options">
								<label>
									Size
									<select class="input-select">
										<option value="0">X</option>
									</select>
								</label>
								<label>
									Color
									<select class="input-select">
										<option value="0">Red</option>
									</select>
								</label>
							</div> -->

            <div class="add-to-cart">
              <div class="qty-label">
                Qty
                <div class="input-number">
                  <input
                    type="number"
                    v-model.number="quantity"
                    min="1"
                    :max="product.stock"
                  />
                  <span class="qty-up" @click="increaseQuantity">+</span>
                  <span class="qty-down" @click="decreaseQuantity">-</span>
                </div>
              </div>
              <button class="add-to-cart-btn">
                <i class="fa fa-shopping-cart"></i> add to cart
              </button>
            </div>

            <ul class="product-btns">
              <li>
                <a href="#"><i class="fa fa-heart-o"></i> add to wishlist</a>
              </li>
              <!-- <li><a href="#"><i class="fa fa-exchange"></i> add to compare</a></li> -->
            </ul>

            <ul class="product-links">
              <li>Category:</li>
              <li>
                <a href="#">{{ categoryName }}</a>
              </li>
            </ul>

            <!-- <ul class="product-links">
								<li>Share:</li>
								<li><a href="#"><i class="fa fa-facebook"></i></a></li>
								<li><a href="#"><i class="fa fa-twitter"></i></a></li>
								<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
								<li><a href="#"><i class="fa fa-envelope"></i></a></li>
							</ul> -->
          </div>
        </div>
        <!-- /Product details -->

        <!-- Product tab -->
        <div class="col-md-12">
          <div id="product-tab">
            <!-- product tab nav -->
            <ul class="tab-nav">
              <li class="active">
                <a data-toggle="tab" href="#tab1">Description</a>
              </li>
              <!-- <li><a data-toggle="tab" href="#tab2">Details</a></li> -->
              <!-- <li><a data-toggle="tab" href="#tab3">Reviews (3)</a></li> -->
            </ul>
            <!-- /product tab nav -->

            <!-- product tab content -->
            <div class="tab-content">
              <!-- tab1  -->
              <div id="tab1" class="tab-pane fade in active">
                <div class="row">
                  <div class="col-md-12">
                    <p v-html="formattedDescription"></p>
                  </div>
                </div>
              </div>
              <!-- /tab1  -->

              <!-- tab2  -->
              <!-- <div id="tab2" class="tab-pane fade in">
                <div class="row">
                  <div class="col-md-12">
                    <p>
                      Lorem ipsum dolor sit amet, consectetur adipisicing elit,
                      sed do eiusmod tempor incididunt ut labore et dolore magna
                      aliqua. Ut enim ad minim veniam, quis nostrud exercitation
                      ullamco laboris nisi ut aliquip ex ea commodo consequat.
                      Duis aute irure dolor in reprehenderit in voluptate velit
                      esse cillum dolore eu fugiat nulla pariatur. Excepteur
                      sint occaecat cupidatat non proident, sunt in culpa qui
                      officia deserunt mollit anim id est laborum.
                    </p>
                  </div>
                </div>
              </div> -->
              <!-- /tab2  -->

              <!-- tab3  -->
              <!-- <div id="tab3" class="tab-pane fade in">
									<div class="row">
							
										<div class="col-md-3">
											<div id="rating">
												<div class="rating-avg">
													<span>4.5</span>
													<div class="rating-stars">
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star-o"></i>
													</div>
												</div>
												<ul class="rating">
													<li>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
														</div>
														<div class="rating-progress">
															<div style="width: 80%;"></div>
														</div>
														<span class="sum">3</span>
													</li>
													<li>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
														</div>
														<div class="rating-progress">
															<div style="width: 60%;"></div>
														</div>
														<span class="sum">2</span>
													</li>
													<li>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</div>
														<div class="rating-progress">
															<div></div>
														</div>
														<span class="sum">0</span>
													</li>
													<li>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</div>
														<div class="rating-progress">
															<div></div>
														</div>
														<span class="sum">0</span>
													</li>
													<li>
														<div class="rating-stars">
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
															<i class="fa fa-star-o"></i>
														</div>
														<div class="rating-progress">
															<div></div>
														</div>
														<span class="sum">0</span>
													</li>
												</ul>
											</div>
										</div>
				
										<div class="col-md-6">
											<div id="reviews">
												<ul class="reviews">
													<li>
														<div class="review-heading">
															<h5 class="name">John</h5>
															<p class="date">27 DEC 2018, 8:0 PM</p>
															<div class="review-rating">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o empty"></i>
															</div>
														</div>
														<div class="review-body">
															<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
														</div>
													</li>
													<li>
														<div class="review-heading">
															<h5 class="name">John</h5>
															<p class="date">27 DEC 2018, 8:0 PM</p>
															<div class="review-rating">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o empty"></i>
															</div>
														</div>
														<div class="review-body">
															<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
														</div>
													</li>
													<li>
														<div class="review-heading">
															<h5 class="name">John</h5>
															<p class="date">27 DEC 2018, 8:0 PM</p>
															<div class="review-rating">
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star-o empty"></i>
															</div>
														</div>
														<div class="review-body">
															<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</p>
														</div>
													</li>
												</ul>
												<ul class="reviews-pagination">
													<li class="active">1</li>
													<li><a href="#">2</a></li>
													<li><a href="#">3</a></li>
													<li><a href="#">4</a></li>
													<li><a href="#"><i class="fa fa-angle-right"></i></a></li>
												</ul>
											</div>
										</div>
								
										<div class="col-md-3">
											<div id="review-form">
												<form class="review-form">
													<input class="input" type="text" placeholder="Your Name">
													<input class="input" type="email" placeholder="Your Email">
													<textarea class="input" placeholder="Your Review"></textarea>
													<div class="input-rating">
														<span>Your Rating: </span>
														<div class="stars">
															<input id="star5" name="rating" value="5" type="radio"><label for="star5"></label>
															<input id="star4" name="rating" value="4" type="radio"><label for="star4"></label>
															<input id="star3" name="rating" value="3" type="radio"><label for="star3"></label>
															<input id="star2" name="rating" value="2" type="radio"><label for="star2"></label>
															<input id="star1" name="rating" value="1" type="radio"><label for="star1"></label>
														</div>
													</div>
													<button class="primary-btn">Submit</button>
												</form>
											</div>
										</div>
									
									</div>
								</div> -->
              <!-- /tab3  -->
            </div>
            <!-- /product tab content  -->
          </div>
        </div>
        <!-- /product tab -->
      </div>
      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /SECTION -->

  <!-- Section -->
  <div class="section">
    <!-- container -->
    <div class="container">
      <!-- row -->

      <!-- /row -->
    </div>
    <!-- /container -->
  </div>
  <!-- /Section -->
</template>

<script>
import BreadCrumbPage from "@/components/templates/BreadCrumbPage.vue";
import { fetchProductById, fetchCategoryById } from "@/api/api.js";
import "@/assets/css/loading.css"; // Impor file CSS

export default {
  name: "ProductPage",
  components: {
    BreadCrumbPage,
  },
  data() {
    return {
      product: {},
      productPrice: 0,
      isLoading: true, // Tambahkan properti isLoading
      shippingDuration: { min: 3, max: 5 }, // Estimated shipping duration in days
      quantity: 1, // Default quantity
    };
  },
  computed: {
    formattedTotalPrice() {
      return new Intl.NumberFormat("id-ID", {
        style: "currency",
        currency: "IDR",
        minimumFractionDigits: 0,
        maximumFractionDigits: 0,
      })
        .format(this.productPrice)
        .replace(/\s/g, "");
    },

    estimatedArrival() {
      const today = new Date();
      const minArrival = new Date(today);
      const maxArrival = new Date(today);
      minArrival.setDate(today.getDate() + this.shippingDuration.min);
      maxArrival.setDate(today.getDate() + this.shippingDuration.max);
      const options = { day: "numeric", month: "short" }; // Format options
      return `${minArrival.toLocaleDateString(
        "id",
        options
      )} - ${maxArrival.toLocaleDateString("id", options)}`;
    },

    formattedDescription() {
      return this.product.description.replace(/\n/g, "<br>");
    },
  },

  async created() {
    await this.fetchProduct();
  },
  methods: {
    async fetchProduct() {
      const productId = this.$route.params.id;
      try {
        const product = await fetchProductById(productId);
        this.product = product;
        this.productPrice = product.price;
        await this.fetchCategory(product.category_id); // Fetch category name based on category_id
      } catch (error) {
        console.error("Failed to fetch product:", error);
      } finally {
        this.isLoading = false;
      }
    },
    async fetchCategory(categoryId) {
      try {
        const category = await fetchCategoryById(categoryId);
        this.categoryName = category.name;
      } catch (error) {
        console.error("Failed to fetch category:", error);
      }
    },
    increaseQuantity() {
      if (this.quantity < this.product.stock) {
        this.quantity++;
      }
    },
    decreaseQuantity() {
      if (this.quantity > 1) {
        this.quantity--;
      }
    },
    addToCart() {
      // Implement the add-to-cart functionality here
      // For example, you can emit an event or call an API to add the product to the cart
      console.log(`Added ${this.quantity} items to the cart`);
    },
  },
    watch: {
    quantity(newQuantity) {
      if (newQuantity > this.product.stock) {
        this.quantity = this.product.stock;
      } else if (newQuantity < 1) {
        this.quantity = 1;
      }
    },
  },
};
</script>

<style scoped>
.product-name {
  font-size: 24px; /* Adjust the value as needed */
}

.product-price {
  font-size: 36px; /* Adjust the value as needed */
}

.icon {
  width: 20px; /* Set a consistent width for the icons */
  text-align: center; /* Center align the icons */
  margin-right: 5px; /* Add some space between the icon and the text */
}

p {
  white-space: pre-line; /* Preserve new lines */
}
</style>