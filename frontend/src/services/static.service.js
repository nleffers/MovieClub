import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class StaticService {
  get() {
    return axios.get(API_URL + '/static_info', { headers: authHeader() })
  }
}

export default new StaticService()
