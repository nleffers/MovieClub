<template>
  <div class="reviews-column">
    <template v-if="reviews.length > 0">
      <template v-for="(review, index) in reviews">
        <review-form
          :key="index"
          :currentUserId="currentUserId"
          :review="review"
        />
      </template>
      <hr>
    </template>
    <template v-else>
      <div class="no-reviews">
        <template v-if="currentUserId">
          Be the first to write a review!
        </template>
        <template v-else>
          <router-link :to="{ name: 'login_path', params: {} }">
            Sign in to be the first to write a review!
          </router-link>
        </template>
      </div>
    </template>
  </div>
</template>

<script>
import { defineComponent } from 'vue';
import ReviewForm from './ReviewForm.vue'

export default defineComponent({
  props: {
    currentUserId: [Number, String],
    reviews: Array
  },
  components: {
    ReviewForm
  },
  methods: {
    reviewWrittenByUser(userId) {
      this.currentUserId === userId
    }
  }
})
</script>

<style scoped>
.reviews-column {
  background-color: #fafafa;
  border: 1px solid black;
  border-radius: 5px;
  height: 500px;
  margin-left: 1.5%;
  margin-right: 1.5%;
  overflow-y: scroll;
  padding: 15px;
  width: 30%;
}

.no-reviews {
  line-height: 500px;
}
</style>
