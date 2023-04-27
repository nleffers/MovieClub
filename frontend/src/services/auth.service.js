import axios from 'axios'

const API_URL = process.env.VUE_APP_API_URL

class AuthService {
  postSessionId(requestToken) {
    return axios
      .post(API_URL + '/auth/session_id', {
        request_token: requestToken
      })
  }
}

export default new AuthService()
