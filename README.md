# RESTful API backend for Job Application Wrangler

## Notes

- Rack set to serve to port 3005 to not conflict with create-react-app front-end
- Uses jwt gem to manage sessions (`JWT_SECRET` key is stored in .env that needs to be created at root level)
- Uses postgresql
- Uses JSONAPI-Serializer (serializers found in app/serializers)
- Custom rake task, `rebuild_db` aggregates `db:drop`, `db:create`, `db:migrate`, and `db:seed` to speed model development cycle.

## TODO

- sanitize HTML on job.notes, job.description, and contact.notes
  - Limit to GFM rendered elements: no script, iframe, etc
  - Exclude inline pictures.
