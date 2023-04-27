<template>
  <div class="create-review-column">
    <template v-if="isLoggedIn">
      <form @submit.prevent="createMovieReview">
        <div>
          <input
            placeholder="Title"
            v-model="title"
          />
        </div>
        <div>
          <textarea
            placeholder="Write a review!"
            rows="10"
            max-rows="15"
            v-model="blog"
          >
          </textarea>
        </div>
        <button type="submit" variant="primary" id="create-movie-review-submit">Submit</button>
      </form>
    </template>
    <template v-else>
      <div class="log-in">
        <router-link :to="{ name: 'login_path', params: {} }">
          Sign in to write a review!
        </router-link>
      </div>
    </template>
  </div>
</template>

<script>
import { defineComponent } from 'vue'
import { storeToRefs } from 'pinia'
import { useAuthStore } from '@/stores/auth'
import { useMovieStore } from '@/stores/movie'
import ReviewService from '@/services/review.service'

export default defineComponent({
  setup() {
    const authStore = useAuthStore()
    const movieStore = useMovieStore()

    const { username } = storeToRefs(authStore)
    const { createReview } = storeToRefs(movieStore)

    return {
      createReview,
      username,
    }
  },
  props: {
    imdbId: [Number, String],
    isLoggedIn: Boolean
  },
  data() {
    return {
      title: '',
      blog: ''
    }
  },
  methods: {
    createMovieReview() {
      let reviewObject = {
        title: this.title,
        blog: this.blog,
        imdb_id: this.imdbId
      }
      ReviewService.create(reviewObject)
        .then(response => {
          this.title = ''
          this.blog = ''
          reviewObject.id = response.data.id
          reviewObject.created_at = response.data.created_at
          reviewObject.written_by_username = this.username
          this.createReview(reviewObject)
        })
        .catch(err => console.log(err))
    }
  }
})
</script>

<style scoped>
.create-review-column {
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

.create-review-column input, .create-review-column textarea {
  margin-top: 15px;
  padding: 5px;
  width: 100%;
}

.log-in {
  line-height: 500px;
}
</style>
