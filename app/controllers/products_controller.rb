class ProductsController < ApplicationController
    def index
        @products = Product.all.with_attached_image
    end

    def show
        product
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        
        if @product.save
            redirect_to products_path, notice: 'El producto fue publicado con éxito'
        else
            render :new, status: :unprocessable_entity, alert: 'El producto no pudo ser publicado'
        end
    end

    def edit
        product
    end

    def update
        if product.update(product_params)
            redirect_to product_path, notice: 'El producto fue actualizado con éxito'
        else
            render :edit, status: :unprocessable_entity, alert: 'El producto no pudo ser actualizado'
        end
    end

    def destroy 
        product.destroy

        redirect_to products_path, notice: 'El producto fue eliminado con éxito', status: :see_other
    end

    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :image)
    end

    def product
        @product ||= Product.find(params[:id])
    end

end