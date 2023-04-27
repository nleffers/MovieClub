import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class ReviewService {
  create(optionsObject) {
    return axios.post(API_URL + `/reviews`, { review: optionsObject }, { headers: authHeader() })
  }

  update(optionsObject) {
    return axios.put(API_URL + `/reviews/${optionsObject.id}`, { review: optionsObject }, { headers: authHeader() })
  }

  delete(id) {
    return axios.delete(API_URL + `/reviews/${id}`, { headers: authHeader() })
  }
}

export default new ReviewService()
