// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --
// Cypress.Commands.add('login', (email, password) => { ... })
//
//
// -- This is a child command --
// Cypress.Commands.add('drag', { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add('dismiss', { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This will overwrite an existing command --
// Cypress.Commands.overwrite('visit', (originalFn, url, options) => { ... })
// Cypress.Commands.add('login', () => {
//   cy.request('POST', '/login', {
//     email: 'test2@thatemail.com',
//     password: '123456789',
//   }).then((response) => {
//     expect(response.status).to.eq(200);
//   });

//   // Set the session manually to simulate successful login
//   cy.setCookie('session_cookie_name', 'your_session_value_here');
// });
Cypress.Cookies.debug(true)
Cypress.Commands.add('login', () => {
  // Perform a POST request to /login with the user's credentials
  cy.request({
    method: 'POST',
    url: 'http://127.0.0.1:9005/login',
    body: {
      email: 'test2@thatemail.com',
      password: '123456789',
    },
    followRedirect: true, // Follow the redirect to the main page after successful login
  }).then((response) => {

    console.log("response:",response);
    console.log("keys:", Object.keys(response));
    console.log("headers:",response.headers)
    // cy.setCookie("_new_session", 'c8KPzIyXDXHOOO62QOXCwXbwPA2sEA4mTFaaglnjj4NCx1AQdBexJDFMLyGfj%2Fncl8Nlj%2FdPi%2FbkpYRzH1k2deC7WGayKGbVcPVV3O%2BrfA%2FYYonmQyJnyKJU%2FU8Efvq4MN4o8ZglIqoxGWcpY9687c%2FywmW0JQFyZOtRFhRmRz1fGQ0IX%2BymdSmnpKHC93hqJ9kmG7XxUjgypHz6Fsz%2FiCTDeeI6WENFB5DlOlEeZoeAFLinJ5JDfYuTIqOUlXuBWbxZfTtXPT4nZEXvNAMSbFagPXDZTPo0vL9RbDskCom%2BA9TWI%2B0rhIXsDqsZzCj3Av4g6Zoa3MjFo%2B8Ymwzjoav%2BFwENulLG1pCFZzoD69OkRaI44SersqfF16%2FfaT%2BCYOSYfubNnssymlXyXDZvPLbWUqXpHDcBpsGAqbx6IhU%3D--sEUWRrrmrt8aLzzi--Xy3CubrrKlh8o2uMRJB38Q%3D%3D')
  });
});

// "_new_session=%2FWN%2B%2FxAOhYHMI1yOgAyVs3U%2B%2Fdrj5MN%2BBsHdnqmKn%2FPQgZDW5DCqG3KNnYOMg7lIUuaY9YHRng7M8viLNqLyDD7ah3YTwk631ng2CYdQFlhbougSwdhwuu4t1XBrXmevSmazbcYHmSRWAkj1ahwe1n0%2BZJFY7MradBagO8O%2FnrJ%2BK1PZ--DqEoYmhHufoTd5Kc--SNNBnwBI%2FJBsg7WsI329%2Bw%3D%3D; path=/; HttpOnly; SameSite=Lax"

