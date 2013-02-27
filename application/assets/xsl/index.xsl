<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" exclude-result-prefixes="date">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:variable name="PRODUCTION" select="10"/>
<xsl:variable name="STAGING" select="20"/>
<xsl:variable name="TESTING" select="30"/>
<xsl:variable name="DEVELOPMENT" select="40"/>

<xsl:include href="snippets/analytics.xsl"/>

<xsl:include href="snippets/scripts.xsl"/>

<xsl:include href="snippets/styles.xsl"/>

<xsl:include href="snippets/modal.xsl"/>

<xsl:template match="root">
<html>
    <head>
		<title><xsl:value-of select="meta/title"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<xsl:if test="/root/meta/redirect">
			<meta http-equiv="Refresh" content="{/root/meta/redirect_time}; url={/root/meta/redirect}" />
		</xsl:if>

		<xsl:apply-templates select="meta/styles"/>

		<xsl:apply-templates select="content/styles"/>

		<xsl:apply-templates select="meta/scripts"/>

		<xsl:apply-templates select="content/scripts"/>


		<script type="text/javascript">
			var geolocation = '<xsl:value-of select="meta/location"/>';
		</script>

		<link rel="shortcut icon">
			<xsl:attribute name="href">
				<xsl:text>http://static</xsl:text>
				<xsl:value-of select="(position()-1) mod 3 + 1"/>
				<xsl:text>.</xsl:text>
				<xsl:choose>
					<xsl:when test="contains(/root/meta/domain,'www.')">
						<xsl:value-of select="substring(/root/meta/domain, 5)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/root/meta/domain"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>/favicon.ico</xsl:text>
			</xsl:attribute>
		</link>
	</head>
    <body>
        <div class="wrapper" id="wrapper">
			<div class="mainWrapper">
				<div class="threeColumn">
					<div class="headerWrapper padding15All">
						<div class="header">
							<div class="headerLinks headerTopLinks floatRight">
								<ul>
									<xsl:choose>
										<xsl:when test="/root/meta/user != ''">
											<li>
												<a href="/logout">
													<xsl:text>Logout</xsl:text>
												</a>
											</li>
											<li>
												<a href="/profile">
													<xsl:value-of select="/root/meta/user/username"/>
												</a>
											</li>
										</xsl:when>
										<xsl:otherwise>
											<li>
												<a class="modalLink" href="/login">
													<xsl:text>Login</xsl:text>
												</a>
											</li>
											<li>
												<a href="/register">
													<xsl:text>Register</xsl:text>
												</a>
											</li>
										</xsl:otherwise>
									</xsl:choose>
								</ul>
								<div class="clearer"></div>
							</div>
							<h1 class="floatLeft">
								<a id="logo" href="/">Med Voyager</a>
							</h1>
							<div class="clearRight"></div>
							<a class="appStoreLink floatRight" href="http://itunes.apple.com/us/genre/mobile-software-applications/id36?mt=8">Med Voyager iPhone App</a>
							<div class="clearRight"></div>
							<div class="headerSearch floatRight">
								<div class="advancedSearch floatRight">
									<a href="/listings/advanced_search">Advanced Search</a>
								</div>
								<div class="clearer"></div>
								<div class="searchBarBackground">
									<form class="generalSearchForm" method="get" action="/listings/search">
										<span class=" floatLeft">
											<input id="searchBar" type="text" name="search_query" placeholder="Search" value="{/root/meta/query/search_query}" />
										</span>
										<span class="formSubmit floatLeft">
											<input class="topSearchSubmit" type="submit" value="" />
										</span>
									</form>
								</div>
							</div>
							<div class="clearLeft"></div>
							<div class="headerLinks headerBottomLinks">
								<ul>
									<li>
										<a href="/listings">
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="(meta/controller='listings' or
																	meta/controller='list' or
																	meta/controller='listing' or
																	meta/controller='create' or
																	meta/controller='free') and /root/meta/directory != 'profile'">
														<xsl:text>selected</xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:attribute>
											<xsl:text>Categories</xsl:text>
										</a>
									</li>
									<li>
										<a href="/profile">
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="/root/meta/directory='profile'">
														<xsl:text>selected</xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:attribute>
											<xsl:text>Profile</xsl:text>
										</a>
									</li>
									<li>
										<a href="/faq">
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="meta/controller='faq' or
																	meta/controller='contact' or
																	meta/controller='about' or
																	meta/controller='terms' or
																	meta/controller='privacy' or
																	meta/controller='referral' or
																	meta/controller='advertise'">
														<xsl:text>selected</xsl:text>
													</xsl:when>
												</xsl:choose>
											</xsl:attribute>
											Help
										</a>
									</li>
									<!--
									<li>
										<a href="/blog">
											Blog
										</a>
									</li>
									-->
								</ul>
								<div class="clearer"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="clearer"></div>
				<div class="contentWrapper">
					<xsl:apply-templates select="content"/>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
				<div class="threeColumn">
					<div class="footerContentWrapper">
						<div class="footerColumn footerLeft floatLeft">
							<div class="quickBlurb">
								<h6>Mission Statement</h6>
								<p style="text-align: justify;">Life Care Planning Solutions is committed to providing our customers with the peace of mind that comes from effective and efficient care planning. Our goal is to provide immediate access to accurate and relevant healthcare and nonhealthcare resources based on location to assist in making the care planning process easier and less stressful.</p>
							</div>
						</div>
						<div class="footerColumn footerCenter floatLeft">
							<div class="footerCenterList floatLeft">
								<h6>Help</h6>
								<ul>
									<li><a href="/about">About Us</a></li>
									<li><a href="/faq">FAQ</a></li>
									<li><a href="/terms">Terms Of Use</a></li>
									<li><a href="/privacy">Privacy Policy</a></li>
									<li><a href="/contact">Contact</a></li>
								</ul>
							</div>
							<div class="footerCenterList floatLeft">
								<h6>Actions</h6>
								<ul>
									<li><a href="/advertise">Advertise With Us</a></li>
									<li><a href="/list">List On MedVoyager</a></li>
								</ul>
							</div>
							<div class="footerCredits">
								<xsl:text>MedVoyager copyrighted &#xA9; </xsl:text>
								<xsl:value-of select="date:year(date:date-time())" />
							</div>
						</div>
						<div class="footerColumn footerRight floatLeft">
							<div class="footerRightTop">
								<h6>Profile</h6>
								<ul>
									<xsl:choose>
										<xsl:when test="/root/meta/user != ''">
											<li>
												<a href="/profile">
													<xsl:value-of select="/root/meta/user/username"/>
												</a>
											</li>
											<li>
												<a href="/logout">
													<xsl:text>Logout</xsl:text>
												</a>
											</li>
										</xsl:when>
										<xsl:otherwise>
											<li>
												<a class="modalLink" href="/login">
													<xsl:text>Login</xsl:text>
												</a>
											</li>
											<li>
												<a href="/register">
													<xsl:text>Register</xsl:text>
												</a>
											</li>
											<li>
												<a class="modalLink" href="/login/forgot">
													<xsl:text>Forgot Password?</xsl:text>
												</a>
											</li>
										</xsl:otherwise>
									</xsl:choose>
								</ul>
							</div>
							<div class="footerRightBottom">
								<h6>Find Us On</h6>
								<a class="footerSocialMedia facebook floatLeft" href="http://www.facebook.com/medvoyager" target="_blank"></a>
								<a class="footerSocialMedia twitter" href="http://twitter.com/medvoyager" target="_blank"></a>
							</div>
							<div class="footerCredits">
								<xsl:text>Web Design by </xsl:text>
								<a href="http://colorfulstudio.com/">Colorful Studio</a>
							</div>
						</div>
						<div class="clearer"></div>
					</div>
				</div>
			</div>
		</div>
		<xsl:choose>
			<xsl:when test="meta/environment = $PRODUCTION">
				<xsl:call-template name="analytics" />
			</xsl:when>
			<xsl:when test="meta/environment = $STAGING">
				<xsl:call-template name="analytics" />
			</xsl:when>
			<xsl:when test="meta/environment = $TESTING">
				<xsl:value-of select="/root/meta/profile" disable-output-escaping="yes"/>
			</xsl:when>
			<xsl:when test="meta/environment = $DEVELOPMENT">
				<xsl:value-of select="/root/meta/profile" disable-output-escaping="yes"/>
			</xsl:when>
		</xsl:choose>
	</body>
</html>
</xsl:template>

<xsl:template match="text()"></xsl:template>

</xsl:stylesheet>