context("ped relatives")


test_that("father() and mother() works", {
  x = nuclearPed(father="fa", mother="mo", child="ch")
  expect_equal(father(x, "ch"), "fa")
  expect_equal(mother(x, "ch"), "mo")

  expect_equal(father(x, "fa"), character(0))
  expect_equal(mother(x, "fa"), character(0))

  expect_equal(father(x, 3, internal=T), 1)
  expect_equal(mother(x, 3, internal=T), 2)

  # TODO: these are not consistent with internal=F
  expect_equal(father(x, 1, internal=T), 0)
  expect_equal(mother(x, 1, internal=T), 0)
})


test_that("offspring are correct in nuclear", {
  x = nuclearPed(4)
  true_offs = as.character(3:6)
  expect_setequal(offspring(x, 1), true_offs)
  expect_setequal(offspring(x, 2), true_offs)
})

test_that("offspring are correct after reorder", {
  x = reorderPed(nuclearPed(4), 6:1)
  true_offs = as.character(3:6)
  expect_setequal(offspring(x, 1), true_offs)
  expect_setequal(offspring(x, 2), true_offs)
})


test_that("spouses are correct in nuclear", {
  x = nuclearPed(4)
  expect_equal(spouses(x,1), "2")
  expect_equal(spouses(x,2), "1")
  expect_equal(spouses(x,3), character(0))
  expect_equal(spouses(x,3, internal=T), numeric(0))
})

test_that("spouses are correct after reorder", {
  x = reorderPed(nuclearPed(4), 6:1)
  expect_equal(spouses(x,1), "2")
  expect_equal(spouses(x,2), "1")
  expect_equal(spouses(x,3), character(0))
  expect_equal(spouses(x,3, internal=T), numeric(0))
})

test_that("internal = TRUE results in integer output", {
  x = singleton(1)
  expect_type(father(x, 1, internal = T), "integer")
  expect_type(mother(x, 1, internal = T), "integer")
  expect_type(parents(x, 1, internal = T), "integer")
  expect_type(children(x, 1, internal = T), "integer")
  expect_type(cousins(x, 1, internal = T), "integer")
  expect_type(ancestors(x, 1, internal = T), "integer")
  expect_type(descendants(x, 1, internal = T), "integer")
  expect_type(unrelated(x, 1, internal = T), "integer")
})

