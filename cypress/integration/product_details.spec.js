describe('Product Details', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('/');
  });

  it('should navigate to the product detail page when clicking on a product', () => {
    // Find a product on the home page and click on its link to navigate to the product detail page
    cy.get(".products article").first().find("a").click();

    // Assert that the URL has changed to the product detail page
    cy.url().should('include', '/products/');
  });
});