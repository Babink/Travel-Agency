defmodule TravelWeb.HomeController do
    use TravelWeb , :controller

    alias TravelWeb.Images
    alias Travel.Repo
    alias TravelWeb.Book

    import Ecto.Query, only: [from: 2]

    # plug TravelWeb.Plugs.RequireAuth when action in [:book]

    def index(conn , _params) do
        # changeset = Images.changeset(%Images{}, %{})
        urls = Repo.all(Images)
        render conn , "home.html" , images: urls
    end

    def book(conn , %{"id" => param_id}) do
        single_data = Repo.get(Images , param_id)
        changeset = Book.changeset(%Book{} , %{})

        users = conn.assigns[:user]
        render conn , "book.html" , mydata: single_data , changeset: changeset , user: users
    end

    def book_post(conn , %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message} , "id" => params_id}) do
        urls = Repo.get!(Images , params_id)
        changesets = conn.assigns[:user] 

        changeset =
            urls
            |> Ecto.build_assoc(:books)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:user , changesets)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

        case Repo.insert(changeset) do
            {:ok , _cut} ->
                conn
                |> redirect(to: Routes.home_path(conn , :index))

            {:error , changeset} ->
                render conn , "book.html" , changeset: changeset , mydata: urls
        end
    end

    def park(conn , _params) do
        urls = Repo.all(Images)
        render conn , "park.html" , images: urls
    end

    def heritage(conn , %{"id" => params_id}) do
        urls = Repo.get!(Images, params_id)
        changeset = Book.changeset(%Book{} , %{})
        render conn , "heritage.html" , images: urls , changeset: changeset
    end

    def heritage_post(conn ,  %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message} , "id" => params_id}) do
        urls = Repo.get!(Images , params_id)
        changesets = conn.assigns[:user] 

        changeset =
            urls
            |> Ecto.build_assoc(:books)
            |> Ecto.Changeset.change()
            |> Ecto.Changeset.put_assoc(:user , changesets)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

            case Repo.insert(changeset) do
                {:ok , _cut} ->
                    conn
                    |> redirect(to: Routes.home_path(conn , :index))
    
                {:error , changeset} ->
                    render conn , "bhutan.html" , images: urls , changeset: changeset
            end
        
    end

    def bhutan(conn , %{"id" => params_id}) do
        changeset = Book.changeset(%Book{} , %{});
        
        urls = Repo.get!(Images , params_id)
        render conn , "bhutan.html" , images: urls , changeset: changeset
    end

    def bhutan_post(conn , %{"book" => %{"address" => address , "contact" => contact , "name" => name , "person" => person , "message" => message }, "id" => params_id}) do
        urls = Repo.get!(Images , params_id)

        changeset = conn.assigns[:user]  
            |> Ecto.build_assoc(:books)
            |> Book.changeset(%{ address: address , contact: contact , name: name , person: person , message: message })

        case Repo.insert(changeset) do
            {:ok , _cut} ->
                conn
                |> redirect(to: Routes.home_path(conn , :index))

            {:error , changeset} ->
                render conn , "bhutan.html" , images: urls , changeset: changeset
        end
    end

    def about(conn , _params) do
        render conn , "about.html"
    end

    def trek(conn , _params) do
        urls = Repo.all(Images)
        render conn , "trek.html" , images: urls
    end

    def cancel_book(conn , %{"id" => params_id}) do
        user = conn.assigns[:user]
        user_id = user.id
        query = from b in Book , where: b.user_id == ^user_id , select: b
        user_book = Repo.all(query)
        val = Enum.map(user_book , fn x -> %{:id => x.id , :name => x.name, :person => x.person , :contact => x.contact , :address => x.address} end)

        #Deleting booked item

        new_val = Repo.get(Book , params_id)
        query = from b in Book , where: b.id == ^params_id
        result = Repo.delete_all(query)

        case result do
            {1 , nil} ->
                conn
                |> redirect(to: Routes.home_path(conn , :index))
            
            _ ->
                conn
                |> put_flash(:info , "Unable to delete charts")
                |> redirect(to: Routes.home_path(conn , :carts))
        end
    end


    def get_real_image(id) do
        books = from i in Images , where: i.id == ^id, select: i
        book_images = Repo.all(books)
        book_data = Enum.map(book_images , fn x -> %{
            :title => x.heading,
            :price => x.price,
            :days => x.days,
            :image => x.url
        } end)
    end


    def carts(conn , _params) do
        # USER DATA
        user = conn.assigns[:user]
        user_id = user.id
        query = from b in Book , where: b.user_id == ^user_id , select: b
        user_book = Repo.all(query)
        user_data = Enum.map(user_book , fn x -> %{
        :id => x.id ,
        :name => x.name,
        :person => x.person ,
        :contact => x.contact ,
        :address => x.address,
        :user_id => x.user_id,
        :images => get_real_image(x.images_id)
        }end)
        
        IO.inspect(user_data)

        render conn , "carts.html" , user_data: user_data , data_length: length(user_book)
    end
end