## Not very meaningful tests. They good for testing that the
## functions run, but not much more

test_that("sample_correlated_gnp works", {
  set.seed(42)

  g <- erdos.renyi.game(10, .1)
  g2 <- sample_correlated_gnp(g, corr = 1, p = g$p, permutation = NULL)
  expect_that(g[], equals(g2[]))

  g3 <- sample_correlated_gnp(g, corr = 0, p = g$p, permutation = NULL)
  c3 <- cor(as.vector(g[]), as.vector(g3[]))
  expect_true(abs(c3) < .3)
})

test_that("sample_correlated_gnp works when p is not given", {
  set.seed(42)

  g <- erdos.renyi.game(10, .1)
  g2 <- sample_correlated_gnp(g, corr = 1)
  expect_that(g[], equals(g2[]))

  g3 <- sample_correlated_gnp(g, corr = 0)
  c3 <- cor(as.vector(g[]), as.vector(g3[]))
  expect_true(abs(c3) < .3)
})

test_that("sample_correlated_gnp works even for non-ER graphs", {
  set.seed(42)

  g <- grg.game(100, 0.2)
  g2 <- sample_correlated_gnp(g, corr = 1)
  expect_that(g[], equals(g2[]))

  g3 <- sample_correlated_gnp(g, corr = 0)
  c3 <- cor(as.vector(g[]), as.vector(g3[]))
  expect_true(abs(c3) < .3)
})

test_that("sample_correlated_gnp_pair works", {
  set.seed(42)

  gp <- sample_correlated_gnp_pair(10, corr = .95, p = .1, permutation = NULL)
  expect_true(abs(ecount(gp[[1]]) - ecount(gp[[2]])) < 3)
})

## Some corner cases

test_that("sample_correlated_gnp corner cases work", {
  set.seed(42)

  is.full <- function(g) {
    g2 <- graph.full(vcount(g), directed = is.directed(g))
    graph.isomorphic(g, g2)
  }

  g <- erdos.renyi.game(10, .3)
  g2 <- sample_correlated_gnp(g, corr = 0.000001, p = .99999999)
  expect_true(is.full(g2))

  g3 <- sample_correlated_gnp(g, corr = 0.000001, p = 0.0000001)
  expect_that(ecount(g3), equals(0))
  expect_that(vcount(g3), equals(10))

  gg <- erdos.renyi.game(10, .3, directed = TRUE)
  gg2 <- sample_correlated_gnp(gg, corr = 0.000001, p = .99999999)
  expect_true(is.full(gg2))

  gg3 <- sample_correlated_gnp(gg, corr = 0.000001, p = 0.0000001)
  expect_that(ecount(gg3), equals(0))
  expect_that(vcount(gg3), equals(10))
})

test_that("permutation works for sample_correlated_gnp", {
  set.seed(42)

  g <- erdos.renyi.game(10, .3)
  perm <- sample(vcount(g))
  g2 <- sample_correlated_gnp(g, corr = .99999, p = .3, permutation = perm)
  g <- permute.vertices(g, perm)
  expect_that(g[], equals(g2[]))

  g <- erdos.renyi.game(10, .3)
  perm <- sample(vcount(g))
  g2 <- sample_correlated_gnp(g, corr = 1, p = .3, permutation = perm)
  g <- permute.vertices(g, perm)
  expect_that(g[], equals(g2[]))
})
