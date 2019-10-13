--------------------------------------------------------------------------------
-- Owner
--------------------------------------------------------------------------------
describe('Owner', function(it)

  it('has character', function (assert)
    local character = "Lammiwinks"
    local owner = Owner({ character = character })
    assert:Equals(owner.character, character)
  end)

  it('has realm', function (assert)
    local realm = "Felstrikers"
    local owner = Owner({ realm = realm })
    assert:Equals(owner.realm, realm)
  end)

end)

--------------------------------------------------------------------------------
-- Timestamp
--------------------------------------------------------------------------------
describe('Timestamp', function(it)

  it('has hours', function (assert)
    local hours = 16
    local owner = Timestamp({ hours = hours })
    assert:Equals(owner.hours, hours)
  end)

  it('has minutes', function (assert)
    local minutes = 54
    local owner = Timestamp({ minutes = minutes })
    assert:Equals(owner.minutes, minutes)
  end)

end)

--------------------------------------------------------------------------------
-- Location
--------------------------------------------------------------------------------
describe('Location', function(it)

  it('has name', function (assert)
    local name = "Eastern Kingdoms"
    local location = Location({ name = name })
    assert:Equals(location.name, name)
  end)

  it('has isInstance', function (assert)
    local isInstance = true
    local location = Location({ isInstance = isInstance })
    assert:Equals(location.isInstance, isInstance)
  end)

end)
