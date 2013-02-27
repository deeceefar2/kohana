<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_help.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax != ''">
			<xsl:apply-templates select="/root/content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<xsl:call-template name="subnav_help" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>Terms of Use</h3>
					<div>
						<h4>The Site Does Not Provide Medical Advice</h4><br />
						<p>The contents of the Medvoyager Site, such as text, graphics, images, information obtained from Medvoyager's licensors, and other material contained on the Medvoyager Site ("Content") are for informational purposes only. The Content is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition. Never disregard professional medical advice or delay in seeking it because of something you have read on the Medvoyager site.</p>
						<p>If you think you may have a medical emergency, call your doctor or 911 immediately. Medvoyager does not recommend or endorse any specific tests, physicians, products, procedures, opinions, or other information that may be mentioned on the Site. Reliance on any information provided by Medvoyager, employees, others appearing on the Site at the invitation of Medvoyager, or other visitors to the Site is solely at your own risk.</p>
						<h4>Use of Content</h4><br />
						<p>Medvoyager authorizes you to view or download a single copy of the material on the Medvoyager Site solely for your personal, noncommercial use. All rights reserved" and other copyright and proprietary rights notices that are contained in the Content. Any special rules for the use of certain software and other items accessible on the Medvoyager Site may be included elsewhere within the Site and are incorporated into these Terms and Conditions by reference.</p>
						<p>The Content is protected by patent and copyright under both United States and foreign laws. Title to the Content remains with Medvoyager or its licensors. Any use of the Content not expressly permitted by these Terms and Conditions is a breach of these Terms and Conditions and may violate copyright, trademark, and other laws. Content and features are subject to change or termination without notice in the editorial discretion of Medvoyager. All rights not expressly granted herein are reserved to Medvoyager and its licensors.</p>
						<p>If you violate any of these Terms and Conditions, your permission to use the Content automatically terminates and you must immediately destroy any copies you have made of any portion of the Content.</p>
						<h4>Liability of Medvoyager and Its Licensors</h4><br />
						<p>The use of the Medvoyager Site and the Content is at your own risk.</p>
						<p>When using the Medvoyager Site, information will be transmitted over a medium that may be beyond the control and jurisdiction of Medvoyager and its suppliers. Accordingly, Medvoyager assumes no liability for or relating to the delay, failure, interruption, or corruption of any data or other information transmitted in connection with use of the Medvoyager Site.</p>
						<p>The Medvoyager Site and the content are provided on an "as is" basis. MEDVOYAGER, ITS LICENSORS, AND ITS SUPPLIERS, TO THE FULLEST EXTENT PERMITTED BY LAW, DISCLAIM ALL WARRANTIES, EITHER EXPRESS OR IMPLIED, STATUTORY OR OTHERWISE, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT OF THIRD PARTIES' RIGHTS, AND FITNESS FOR PARTICULAR PURPOSE. Without limiting the foregoing, Medvoyager, its licensors, and its suppliers make no representations or warranties about the following:</p>
						<ol class="termsList" style="font-size:16px;">
							<li>The accuracy, reliability, completeness, currentness, or timeliness of the Content, software, text, graphics, links, or communications provided on or through the use of the Medvoyager Site or Medvoyager.</li>
							<li>The satisfaction of any government regulations requiring disclosure of information on prescription drug products or the approval or compliance of any software tools with regard to the Content contained on the Medvoyager Site.</li>
						</ol>
						<br />
						<p>In no event shall Medvoyager, its licensors, its suppliers, or any third parties mentioned on the Medvoyager Site be liable for any damages (including, without limitation, incidental and consequential damages, personal injury/wrongful death, lost profits, or damages resulting from lost data or business interruption) resulting from the use of or inability to use the Medvoyager Site or the Content, whether based on warranty, contract, tort, or any other legal theory, and whether or not Medvoyager, its licensors, its suppliers, or any third parties mentioned on the Medvoyager Site are advised of the possibility of such damages. Medvoyager, its licensors, its suppliers, or any third parties mentioned on the Medvoyager Site shall NOT be liable to the extent of actual damages incurred by you. Medvoyager, its licensors, its suppliers, or any third parties mentioned on the Medvoyager Site are not liable for any personal injury, including death, caused by your use or misuse of the Site, Content, or Public Areas (as defined below). Any claims arising in connection with your use of the Site, any Content, or the Public Areas must be brought within one (1) month of the date of the event giving rise to such action occurred. Remedies under these Terms and Conditions are exclusive and are limited to those expressly provided for in these Terms and Conditions.</p>
						<h4>User Submissions</h4><br />
						<p>The personal information you submit to Medvoyager is governed by the Medvoyager Privacy Policy. To the extent there is an inconsistency between this Agreement and the Medvoyager Privacy Policy, this Agreement shall govern.</p>
						<p>You agree that you will not upload or transmit any communications or content of any type to the Public Areas (including customer reviews or ratings, etc.) that infringe or violate any rights of any party. By submitting communications or content to the Public Areas, you agree that such submission is non-confidential for all purposes.</p>
						<p>If you make any such submission you agree that you will not send or transmit to Medvoyager by email, (including through the email addresses listed on the "Contact Us" page) any communication or content that infringes or violates any rights of any party. If you submit any business information, idea, concept or invention to Medvoyager by email, you agree such submission is non-confidential for all purposes.</p>
						<p>If you make any submission to a Public Area or if you submit any business information, idea, concept or invention to Medvoyager by email, you automatically grant-or warrant that the owner of such content or intellectual property has expressly granted-Medvoyager a royalty-free, perpetual, irrevocable, world-wide nonexclusive license to use, reproduce, create derivative works from, modify, publish, edit, translate, distribute, perform, and display the communication or content in any media or medium, or any form, format, or forum now known or hereafter developed. Medvoyager may sublicense its rights through multiple tiers of sublicenses. If you wish to keep any business information, ideas, concepts or inventions private or proprietary, do not submit them to the Public Areas or to Medvoyager by email. We try to answer every email in a timely manner, but are not always able to do so.</p>
						<h4>Passwords</h4><br />
						<p>Medvoyager has several tools that allow you to record and store information. You are responsible for taking all reasonable steps to ensure that no unauthorized person shall have access to your Medvoyager passwords or accounts. It is your sole responsibility to (1) control the dissemination and use of activation codes and passwords; (2) authorize, monitor, and control access to and use of your Medvoyager account and password; (3) promptly inform Medvoyager of any need to deactivate a password. You grant Medvoyager and all other persons or entities involved in the operation of the Site the right to transmit, monitor, retrieve, store, and use your information in connection with the operation of the Site. Medvoyager cannot and does not assume any responsibility or liability for any information you submit, or your or third parties' use or misuse of information transmitted or received using Medvoyager tools and services.</p>
						<h4>Medvoyager ("Public Areas")</h4><br />
						<p>If you use a Public Area, such as customer reviews and ratings you are solely responsible for your own communications, the consequences of posting those communications, and your reliance on any communications found in the Public Areas. Medvoyager and its licensors are not responsible for the consequences of any communications in the Public Areas. In cases where you feel threatened or believe someone else is in danger, you should contact your local law enforcement agency immediately. If you think you may have a medical emergency, call your doctor or 911 immediately.</p>
						<p>In consideration of being allowed to use the Public Areas, you agree that the following actions shall constitute a material breach of these Terms and Conditions:</p>
						<ol class="termsList" style="font-size:16px;">
							<li>Using a Public Area for any purpose in violation of local, state, national, or international laws;</li>
							<li>Posting material that infringes on the intellectual property rights of others or on the privacy or publicity rights of others;</li>
							<li>Posting material that is unlawful, obscene, defamatory, threatening, harassing, abusive, slanderous, hateful, or embarrassing to any other person or entity as determined by Medvoyager in its sole discretion;</li>
							<li>Posting advertisements or solicitations of business;</li>
							<li>After receiving a warning, continuing to disrupt the normal flow of dialogue, or posting comments that are not related to the topic being discussed (unless it is clear the discussion is free-form);</li>
							<li>Posting chain letters or pyramid schemes;</li>
							<li>Impersonating another person;</li>
							<li>Distributing viruses or other harmful computer code;</li>
							<li>Harvesting or otherwise collecting information about others, including email addresses, without their identification for posting or viewing comments;</li>
							<li>Allowing any other person or entity to use your identification for posting or viewing comments</li>
							<li>Posting the same note more than once or "spamming"; or</li>
							<li>Engaging in any other conduct that restricts or inhibits any other person from using or enjoying the Public Area or the Site, or which, in the judgment of Medvoyager, exposes Medvoyager or any of its customers or suppliers to any liability or detriment of any type.</li>
						</ol>
						<br />
						<h5>Medvoyager Reserves the Right (but is Not Obligated) to Do any or All of the Following:</h5>
						<ol class="termsList" style="font-size:16px;">
							<li>Record the dialogue in public areas.</li>
							<li>Investigate an allegation that a communication(s) do(es) not conform to the terms of this section and determine in its sole discretion to remove or request the removal of the communication(s).</li>
							<li>Remove communications which are abusive, illegal, or disruptive, or that otherwise fail to conform with these Terms and Conditions.</li>
							<li>Terminate a user's access to any or all Public Areas and/or the Medvoyager Site upon any breach of these Terms and Conditions.</li>
							<li>Monitor, edit, or disclose any communication in the Public Areas.</li>
							<li>Edit or delete any communication(s) posted on the Medvoyager Site, regardless of whether such communication(s) violate these standards.</li>
						</ol><br />
						<p>Medvoyager or its licensors have no liability or responsibility to users of the Medvoyager Site or any other person or entity for performance or nonperformance of the aforementioned activities.</p>
						<h5>Advertisements, Searches, and Links to Other Sites</h5><br />
						<p>Medvoyager may provide links to third-party web sites. Medvoyager also may select certain sites as priority responses to search terms you enter and Medvoyager may agree to allow advertisers to respond to certain search terms with advertisements or sponsored content. Medvoyager does not recommend and does not endorse the content on any third-party websites. Medvoyager is not responsible for the content of linked third-party sites, sites framed within the Medvoyager Site, third-party sites provided as search results, or third-party advertisements, and does not make any representations regarding their content or accuracy. Your use of third-party websites is at your own risk and subject to the terms and conditions of use for such sites. Medvoyager does not endorse any product, service, or treatment advertised on the Medvoyager Site.</p>
						<h5>Indemnity</h5><br />
						<p>You agree to defend, indemnify, and hold Medvoyager, its officers, directors, employees, agents, licensors, and suppliers, harmless from and against any claims, actions or demands, liabilities and settlements including without limitation, reasonable legal and accounting fees, resulting from, or alleged to result from, your violation of these Terms and Conditions.</p>
						<h5>Jurisdiction</h5><br />
						<p>You expressly agree that exclusive jurisdiction for any dispute with Medvoyager (Lifecare Planning Solutions, LLC), or in any way relating to your use of the Medvoyager Site, resides in the courts of the State of Oklahoma and you further agree and expressly consent to the exercise of personal jurisdiction in the courts of the State of Oklahoma, in the County of Tulsa, in connection with any such dispute including any claim involving Medvoyager or its affiliates, subsidiaries, employees, contractors, officers, directors, telecommunication providers, and content providers.</p>
						<p>These Terms and Conditions are governed by the internal substantive laws of the State of Oklahoma, without respect to its conflict of laws principles. If any provision of these Terms and Conditions is found to be invalid by any court having competent jurisdiction, the invalidity of such provision shall not affect the validity of the remaining provisions of these Terms and Conditions, which shall remain in full force and effect. No waiver of any of these Terms and Conditions shall be deemed a further or continuing waiver of such term or condition or any other term or condition.</p>
						<h5>Complete Agreement</h5><br />
						<p>Except as expressly provided in a particular "legal notice" on the Medvoyager Site, these Terms and Conditions and the Medvoyager Privacy Policy constitute the entire agreement between you and Medvoyager with respect to the use of the Medvoyager Site, and Content.</p>
						<p><b>Thank you for your cooperation. We hope you find the Medvoyager.com Site helpful and convenient to use! Questions or comments regarding this website, including any reports of non-functioning links, should be submitted using our Contact Us Form or via U.S. mail to: Medvoyager, Life Care Planning Solutions, LLC, Office of Privacy, P.O. Box 1102, Jenks, OK 74037-1102.</b></p>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
					<!--
					<form class="termsOfUseForm" method="put" action="/terms">
						<div class="acceptTerms">
							<a class="formButton floatRight">Accept Terms of Use</a>
						</div>
					</form> -->
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates />
	</div>
</xsl:template>
<xsl:template match="text()"/>
</xsl:stylesheet>