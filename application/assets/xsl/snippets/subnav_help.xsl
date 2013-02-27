<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="subnav_help">
	<div class="threeColumn">
		<div class="padding15All">
			<div class="blueBar">
				<h5 class="floatLeft">
					<a href="/faq">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='faq'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>FAQ</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/about">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='about'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>About Us</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/contact">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='contact'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Contact Us</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/referral">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='referral'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Referral</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/advertise">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='advertise'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Advertise</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/terms">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='terms'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Terms</xsl:text>
					</a>
				</h5>
				<h5 class="floatLeft">
					<a href="/privacy">
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="/root/meta/controller='privacy'">
									<xsl:text>selected</xsl:text>
								</xsl:when>
							</xsl:choose>
						</xsl:attribute>
						<xsl:text>Privacy Policy</xsl:text>
					</a>
				</h5>
			</div>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>