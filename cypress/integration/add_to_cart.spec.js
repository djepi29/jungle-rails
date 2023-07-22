
describe('add to cart', () => {
  beforeEach(() => {
    cy.login();
  });

  it('should visit the home page', () => {
    // The user is already logged in due to the login command, so visit the home page directly
    cy.visit('/');
  });

  it('add an item to the cart', () => {

    // Click the 'Add to Cart' button for the first product
    cy.get('button.btn').first().click();

// Wait for the cart count to update
cy.wait(1000); // You may need to adjust this wait time based on the application behavior


cy.get('a.nav-link[href="/cart"]').should('contain.text', ' \n            My Cart (1) ');
  });

  
});