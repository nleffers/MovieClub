import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class MovieService {
  new() {
    return axios.get(API_URL + '/movies/new', { headers: authHeader() })
  }

  get(id) {
    return axios.get(API_URL + `/movies/${id}`, { headers: authHeader() })
  }

  create(optionsObject) {
    return axios.post(API_URL + '/movies', { movie: optionsObject }, { headers: authHeader() })
  }


  getMovieVideos(movieId) {
    return axios.get(API_URL + `/movies/${movieId}/videos`, { headers: authHeader() })
  }
}

export default new MovieService()
