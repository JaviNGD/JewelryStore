require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest

    test 'render a list of products' do
        get product_path

        assert_response :success
        assert_select '.product', 2
        assert_select '.category', 3
    end

    test 'render a list of products filtered by category' do
        get product_path(category_id: categories(:one).id)

        assert_response :success
        assert_select '.product', 1
    end

    test 'render the product page' do
        get product_path(products(:one))

        assert_response :success
        assert_select '.title', 'MyString'
        assert_select '.price', '1'
    end

    test 'render the new product form' do
        get new_product_path

        assert_response :success
        assert_select 'form'
    end

    test 'create a new product' do
        post products_path, params: { 
            product: { 
                title: 'MyString', 
                description: 'MyText',
                category_id: categories(:one).id,
                price: 1 
            } 
        }
        
        assert_redirected_to products_path
        assert_equal 'El producto fue publicado con éxito', flash[:notice]
    end

    test 'render an edit product form' do
        get edit_product_path(products(:one))

        assert_response :success
        assert_select 'form'
    end

    test 'allows to update a product' do
        patch product_path(products(:one)), params: {
            product: {
                price: 100
            }
        }
        assert_redirected_to product_path(products(:one))
        assert_equal flash[:notice], 'El producto fue actualizado con éxito'
    end

    test 'should not create a new product with invalid params' do
        post products_path, params: { 
            product: { 
                title: '', 
                description: '', 
                price: '' 
            } 
        }
        
        assert_response :unprocessable_entity
    end

    test 'should not update a product with invalid params' do
        patch product_path(products(:one)), params: {
            product: {
                price: nil
            }
        }
        assert_response :unprocessable_entity
    end
    
    test 'should destroy a product' do
       assert_difference('Product.count', -1) do
            delete product_path(products(:one))
       end

       assert_redirected_to products_path
       assert_equal 'El producto fue eliminado con éxito', flash[:notice]
    end

end