package backend
import (
    "appengine/datastore"
    "time"
    "github.com/GoogleCloudPlatform/go-endpoints/endpoints"
    "log"
)

type Greeting struct {
    Key     *datastore.Key `json:"id" datastore:"-"`
    Author  string         `json:"author"`
    Content string         `json:"content" datastore:",noindex" endpoints:"req"`
    Date    time.Time      `json:"date"`
}

type GreetingsList struct {
    Items []*Greeting `json:"items"`
}

type GreetingsListReq struct {
    Limit int `json:"limit" endpoints:"d=10"`
}

type GreetingService struct {
}

func (gs *GreetingService) List(c endpoints.Context, r *GreetingsListReq) (*GreetingsList, error) {
    if r.Limit <= 0 {
        r.Limit = 10
    }

    q := datastore.NewQuery("Greeting").Order("-Date").Limit(r.Limit)
    greets := make([]*Greeting, 0, r.Limit)
    keys, err := q.GetAll(c, &greets)
    if err != nil {
        return nil, err
    }

    for i, k := range keys {
        greets[i].Key = k
    }
    return &GreetingsList{greets}, nil
}

func (gs *GreetingService) Add(c endpoints.Context, g *Greeting) error {
    k := datastore.NewIncompleteKey(c, "Greeting", nil)
    _, err := datastore.Put(c, k, g)
    return err
}

type Count struct {
    N int `json:"count"`
}

func (gs *GreetingService) Count(c endpoints.Context) (*Count, error) {
    n, err := datastore.NewQuery("Greeting").Count(c)
    if err != nil {
        return nil, err
    }
    return &Count{n}, nil
}

func init() {
    greetService := &GreetingService{}
    api, err := endpoints.RegisterService(greetService,
    "greeting", "v1", "Greetings API", true)
    if err != nil {
        log.Fatalf("Register service: %v", err)
    }

    register := func(orig, name, method, path, desc string) {
        m := api.MethodByName(orig)
        if m == nil {
            log.Fatalf("Missing method %s", orig)
        }
        i := m.Info()
        i.Name, i.HTTPMethod, i.Path, i.Desc = name, method, path, desc
    }

    register("List", "greets.list", "GET", "greetings", "List most recent greetings.")
    register("Add", "greets.add", "PUT", "greetings", "Add a greeting.")
    register("Count", "greets.count", "GET", "greetings/count", "Count all greetings.")
    endpoints.HandleHTTP()
}