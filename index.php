<!--
AUTHOR: Christopher Nutter
-->

<!DOCTYPE html>
<html>

<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css"></link>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="preconnect" href="https://fonts.gstatic.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;700&display=swap" rel="stylesheet">	
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <title>Tuffix Homepage</title>
</head>

<body>
		<br>
	<div class="tab no-bullets">
		<center>
			<button><a href="https://github.com/mshafae/tuffix/wiki">About</a></button>
			<button class="invoke-contributors" data-toggle="modal" data-target="#AboutDialog" href="index.html#">Contributors</button>
			<button><a href="https://github.com/mshafae/tuffix/tree/TuffixLib">Source Code</a></button>
            <!--not sure if we need this link to the school's website-->
			<!--<button><a href="http://www.fullerton.edu/">CSUF Website</a></button>-->
		<center>
	</div>
		<br><br>
	<center>
		<div>
			<h1 style="font-size: 85px">Tuffix</h1>
				<br>
			<div style="font-size: 32px">Official Linux environment for California State University, Fullerton.</div>
				<br><br>
			<img src="assets/tuffix-animation.gif" alt="tuffix animation" style="filter: invert(0.75);"  width=300/>
				<br><br>
			<p>
				Lorem ipsum dolor sit amet, consectetaur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
			<br><br>
				Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?
			</p>
				<br>
			<button class="btn-primary btn-lg dl-button">
                <?php include 'php_includes/retriever.php';?>
                <?php echo get_latest_version(); ?>
            </button>
            &nbsp;
            &nbsp;
            &nbsp;
			<button class="btn-primary btn-lg dl-button">
                <a class="no-underline" href="repo/amd64/builds/">Previous Builds</a>
            </button>
            <br/>
            <br/>
            <br/>
            <br/>
		</div>
	</center>

	<!-- Modal -->
	<div class="modal fade" id="AboutDialog" role="dialog">
		<div class="modal-dialog">

		  <!-- Modal content-->
		  <div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal">&times;</button>
			  <h4 class="modal-title">
				Contributors</h4>
			</div>
			<div class="modal-body">
				<center>
					<ul class="no-bullets">
						<li>Michael Shafae</li>
						<li>Kevin Wortman</li>
						<li>Jared Dyreson</li>
						<li>Chris Nutter</li>
						<li>Paul Inventado</li>
					</ul>
				</center>
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		  </div>
		  
		</div>

	</div>

</body>
</html>
