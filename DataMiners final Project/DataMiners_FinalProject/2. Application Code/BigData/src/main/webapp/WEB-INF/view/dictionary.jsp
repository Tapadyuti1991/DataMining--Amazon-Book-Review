<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en-US" xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
<title>Book Reviews By Data Miners</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<link rel="shortcut icon" href="resources/css/images/favicon.ico" />
<link rel="stylesheet" href="resources/css/style.css" type="text/css"
	media="all" />
<script type="text/javascript"
	src="resources/js/libs/jquery-1.6.2.min.js"></script>
<script type="text/javascript"
	src="resources/js/libs/jquery.jcarousel.min.js"></script>
<!--[if IE 6]>
		<script type="text/javascript" src="js/png-fix.js"></script>
	<![endif]-->
<script type="text/javascript" src="resources/js/libs/functions.js"></script>
</head>
<body>
	<!-- Header -->
	<div id="header" class="shell">
		<div id="logo">
			<h1>
				<a href="#">Data Miner</a>
			</h1>
			<span><a href="dictionary">Complete Dashboard for
					Publishers</a></span>
		</div>
		<!-- Navigation -->
		<div id="navigation">
			<ul>
				<li style=""><a href="dictionary" class="active">Home</a></li>
				<li><a
					href="https://public.tableau.com/profile/publish/AmazonBookReview/GenreBasedRatings#!/publish-confirm"
					target="_blank">Metrics</a></li>
				
			</ul>
		</div>
		<!-- End Navigation -->
		<div class="cl">&nbsp;</div>
		<!-- Login-details -->

		<!-- End Login-details -->
	</div>
	<!-- End Header -->
	<!-- Slider -->
	<div id="slider">
		<div class="shell">
			<ul>
				<li>
					<div class="image">
						<img src="resources/css/images/books.png" alt="" />
					</div>
					<div class="details">
						<h3>Data Miner</h3>
						<h3>Featured Books</h3>
						<p class="title">This website is for Publisher's Use Only</p>
						<p class="description">Featured Products are the top 8 books
							on the basis of ratings</p>
						<p class="description">Bestsellers are the top 8 books on the
							basis of each years bestsellers</p>
						<p class="description">This page is showing the results
							constructed using MongoDB</p>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<!-- End Slider -->
	<!-- Main -->
	<div id="main" class="shell">
		<!-- Sidebar -->
		<div id="sidebar">
			<ul class="categories">
				<li>
					<h4>Genre</h4>
					<ul>
						<c:forEach items="${genre}" var="gen">
							<li><a href="#"> ${gen} </a></li>
						</c:forEach>
					</ul>
				</li>
				<li>
					<h4>Authors</h4>
					<ul>
						<c:forEach items="${author}" var="aut">
							<li><a href="#"> ${aut} </a></li>
						</c:forEach>
					</ul>
				</li>
			</ul>
		</div>
		<!-- End Sidebar -->
		<!-- Content -->
		<div id="content">
			<!-- Products -->
			<div class="products">
				<h3>Featured Products</h3>
				<ul>
					<c:forEach items="${image}" var="img" begin="1" end="8">
						<li>
							<div class="product">
								<a href="#" class="info"> <span class="holder"> <img
										src="${img.getStringResult()}"></img> <span class="price"><span
											class="low"></span>${img.getStringrating()}<span class="high"></span></span>
								</span>
								</a>
								<!-- 	<a href="#" class="buy-btn">Read Reviews<span class="price"><sBUYpan class="low">+</span><span class="high"></span></span></a> -->
							</div>
						</li>
					</c:forEach>






				</ul>
				<!-- End Products -->
			</div>
			<div class="cl">&nbsp;</div>
			<!-- Best-sellers -->


			<!-- End Best-sellers -->
		</div>
		<!-- End Content -->
		<div class="cl">&nbsp;</div>
	</div>
	<!-- End Main -->
	<!-- Footer -->

	<!-- End Footer -->
</body>
</html>