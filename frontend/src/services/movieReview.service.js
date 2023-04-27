import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class MovieReviewService {
  create(reviewObject) {
    return axios.post(API_URL + '/movie_reviews', { movie_review: reviewObject }, { headers: authHeader() })
  }

  update(reviewObject) {
    return axios.put(API_URL + `/movie_reviews/${reviewObject.id}`, { movie_review: reviewObject }, { headers: authHeader() })
  }
}

export default new MovieReviewService()
