module SchemaHelper
  def self.showInitial(request)
    data = {
      'type'  => 'collection',
      'links' => {
        'self' => "#{request.url}",
        'schemas' => "#{request.url}schemas" },
      'data' => [
        'id' => 'v1',
        'type' => 'api_version',
        'links' => {
          'self' => "#{request.url}v1",
          'schemas' => "#{request.url}schemas"
        }
      ]
    }.to_json
    return data
  end

  def self.showSchemas(requestObject)
    data = {
      'type'  => 'collection',
      'links' => {'self' => "#{requestObject.url}"},
      'data'  => [{
          'id'              => 'importByType',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/importByType"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => { 
            'type' => { 'type' => 'string', 'required' => true },
          
          }
        },{
          'id'              => 'importAll',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/importAll"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => {}
        },{
          'id'              => 'loadChecks',
          'type'            => 'schema',
          'links'           => {'self' => "#{requestObject.url}/loadChecks"},
          'resourceMethods' => ['GET'],
          'resourceFields'  => {}
        }]
    }.to_json
    return data
  end

  def self.schemaDetails(method,schemaObject)
  end
end