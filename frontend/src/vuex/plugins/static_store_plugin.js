// Plugin to handle retrieving static info on refresh

export const staticStorePlugin = (store) => {
  if (store.getters['AuthStore/isLoggedIn']) { store.dispatch('StaticStore/getStaticInfo') }
}
