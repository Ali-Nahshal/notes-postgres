const Membership = require('./membership')
const Note = require('./note')
const Team = require('./team')
const User = require('./user')
const UserNotes = require('./userNotes')

Note.belongsTo(User)
User.hasMany(Note)

User.belongsToMany(Team, { through: Membership })
Team.belongsToMany(User, { through: Membership })

User.belongsToMany(Note, { through: UserNotes, as: 'markedNotes' })
Note.belongsToMany(User, { through: UserNotes, as: 'usersMarked' })

module.exports = {
  Note,
  User,
  Team,
  Membership,
  UserNotes,
}
