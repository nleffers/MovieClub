import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class SearchService {
  searchMovies(query) {
    return axios.get(API_URL + '/search/movies', { params: { query } }, { headers: authHeader() })
  }

  searchMulti(query) {
    return axios.get(API_URL + '/search/multi', { params: { query } }, { headers: authHeader() })
  }

  searchPeople(query) {
    return axios.get(API_URL + '/search/people', { params: { query } }, { headers: authHeader() })
  }
}

export default new SearchService()
