<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet type="text/xsl" href="data-1.xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    <xsl:template match="data-1.xml">
        <html>
            <head>
                <title>Library System</title>
            </head>
            <body>
                <h1>Library System Overview</h1>
                <xsl:apply-templates select="//Library" />
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="Library">
        <h2><xsl:value-of select="Name" /></h2>
        <p><strong>Address:</strong> <xsl:value-of select="Address" /></p>
        <table>
            <thead>
                <tr>
                    <th>Book Title</th>
                    <th>Author</th>
                    <th>Publish Year</th>
                    <th>Copies Available</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="Books/Book">
                    <tr>
                        <td><xsl:value-of select="Title" /></td>
                        <td><xsl:value-of select="Author/Name" /></td>
                        <td><xsl:value-of select="PublishYear" /></td>
                        <td>
                            <xsl:choose>
                                <xsl:when test="CopiesAvailable">
                                    <xsl:value-of select="CopiesAvailable" />
                                </xsl:when>
                                <xsl:otherwise>N/A</xsl:otherwise>
                            </xsl:choose>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
