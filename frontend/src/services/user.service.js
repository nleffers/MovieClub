import axios from 'axios'
import authHeader from './auth-header'

const API_URL = process.env.VUE_APP_API_URL

class UserService {
  login(user) {
    return axios
      .post(API_URL + '/users/login', {
        login: user
      })
  }

  get(userId) {
    return axios.get(API_URL + `/users/${userId}`, { headers: authHeader() })
  }

  create(user) {
    return axios.post(API_URL + '/users', user, { headers: authHeader() })
  }

  update(user) {
    return axios.put(API_URL + `/users/${user.id}`, user, { headers: authHeader() })
  }

  addToWatchlist(payload) {
    return axios.put(API_URL + `/users/${payload.userId}/add_to_watchlist`, {
      tmdb_movie_id: payload.tmdbMovieId,
      movie_title: payload.movieTitle,
      movie_poster_path: payload.moviePosterPath
    }, {
      headers: authHeader()
    })
  }

  removeFromWatchlist(payload) {
    return axios.put(API_URL + `/users/${payload.userId}/remove_from_watchlist`, {
      tmdb_movie_id: payload.tmdbMovieId
    }, {
      headers: authHeader()
    })
  }

  uploadAvatar(options) {
    const data = new FormData()
    data.append('avatar', options.avatar, options.avatar.name)

    return axios.put(API_URL + `/users/${options.id}/upload_avatar`, data, {
      headers: { 'Content-Type': 'multipart/form-data' },
      timeout: 30000
    }, {
      headers: authHeader()
    })
  }

  logout(id) {
    return axios.post(API_URL + `/users/${id}/logout`, { headers: authHeader() })
  }
}

export default new UserService()
