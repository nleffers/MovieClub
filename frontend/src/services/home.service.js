import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class HomeService {
  getHomePage() {
    return axios.get(API_URL + '/home', { headers: authHeader() })
  }
}

export  default new HomeService()
