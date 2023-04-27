import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class PersonService {
  get(personId) {
    return axios.get(API_URL + `/people/${personId}`, { headers: authHeader() })
  }
}

export default new PersonService()
