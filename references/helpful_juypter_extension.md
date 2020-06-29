```jupyterpython
%load_ext sql
%config SqlMagic.displaylimit = 10
%config SqlMagic.displaycon = False
%config SqlMagic.feedback = False

connect_to_db = 'postgresql+psycopg2://[...]' 
%sql $connect_to_db
```


```jupyterpython
%load_ext autoreload
%autoreload 2
```


