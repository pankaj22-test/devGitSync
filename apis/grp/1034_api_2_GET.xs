query "api/2" verb=GET {
  api_group = "grp"

  input {
  }

  stack {
    var $x1 {
      value = """
        {
          "name": "ScopeTests",
          "description": "Test scopes and permissions",
          "schema": [
            {
              "name": "firstname",
              "type": "text"
            },
            {
              "name": "lastname",
              "type": "text"
            },
            {
              "name": "dob",
              "type": "date"
            },
            {
              "name": "height",
              "type": "int"
            },
            {
              "name": "weight",
              "type": "decimal"
            },
            {
              "name": "passport",
              "type": "image"
            },
            {
              "name": "song",
              "type": "audio"
            },
            {
              "name": "aboutme",
              "type": "video"
            },
            {
              "name": "manager",
              "type": "bool"
            },
            {
              "name": "street",
              "type": "text"
            },
            {
              "name": "suburb",
              "type": "text"
            },
            {
              "name": "city",
              "type": "text"
            },
            {
              "name": "state",
              "type": "text"
            },
            {
              "name": "post_code",
              "type": "text"
            },
            {
              "name": "country",
              "type": "text"
            },
            {
              "name": "g1",
              "type": "geo_linestring"
            },
            {
              "name": "g2",
              "type": "geo_multilinestring"
            },
            {
              "name": "g3",
              "type": "geo_point"
            },
            {
              "name": "g4",
              "type": "geo_multipoint"
            },
            {
              "name": "geoarea",
              "type": "geo_polygon"
            },
            {
              "name": "g6",
              "type": "geo_multipolygon"
            },
            {
              "name": "my_uuid",
              "type": "uuid",
              "nullable": true,
              "required": false
            },
            {
              "name": "enum_col",
              "type": "enum",
              "description": "this field is internal",
              "nullable": false,
              "default": "ok",
              "required": false,
              "style": "single",
              "values": [
                "ok",
                "error"
              ]
            }
          ],
          "auth": true,
          "workspace_id": "5",
          "tag": [
            "xanomatic"
          ]
        }
        """|json_decode
    }
  
    var $x2 {
      value = $x1.tag
    }
  
    var $x3 {
      value = $x1.schema.required
    }
  
    var $x4 {
      value = $x1.description
    }
  
    var $x5 {
      value = $x2
    }
  }

  response = {result1: $x2, x3: $x3, x32: $x4, x5: $x5}

  test unittest2 {
    expect.to_equal ($response.x3) {
      value = "[{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},false,false]"|json_decode
    }
  
    expect.to_equal ($response.x32) {
      value = "Test scopes and permissions"
    }
  }

  test unit_test3 {
    expect.to_equal ($response.x3) {
      value = "[{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},false,false]"|json_decode
    }
  
    expect.to_equal ($response.x32) {
      value = "Test scopes and permissions"
    }
  
    expect.to_equal ($response.x5) {
      value = '["xanomatic"]'|json_decode
    }
  }
}