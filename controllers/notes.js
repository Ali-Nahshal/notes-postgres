const router = require('express').Router()
const { Note, User } = require('../models')
const { tokenExtractor } = require('../util/middleware')

const noteFinder = async (req, res, next) => {
  req.note = await Note.findByPk(req.params.id)
  if (!req.note) {
    return res.status(404).end()
  }
  next()
}

router.get('/', async (req, res) => {
  const notes = await Note.findAll({
    attributes: { exclude: ['userId'] },
    include: {
      model: User,
      attributes: ['name'],
    },
  })
  res.json(notes)
})

router.post('/', tokenExtractor, async (req, res) => {
  const user = await User.findByPk(req.decodedToken.id)
  if (!user) {
    return res.status(401).json({ error: 'user not found' })
  }

  const note = await Note.create({
    ...req.body,
    date: new Date(),
    userId: user.id,
  })

  res.json(note)
})

router.get('/:id', noteFinder, (req, res) => {
  res.json(req.note)
})

router.put('/:id', noteFinder, async (req, res) => {
  req.note.important = req.body.important
  await req.note.save()
  res.json(req.note)
})

router.delete('/:id', noteFinder, async (req, res) => {
  await req.note.destroy()
  res.status(204).end()
})

module.exports = router
