Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E281706249
	for <lists+cgroups@lfdr.de>; Wed, 17 May 2023 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjEQIKM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 May 2023 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQIKL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 May 2023 04:10:11 -0400
X-Greylist: delayed 554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 01:10:08 PDT
Received: from mail.startuplaunchpadpro.pl (mail.startuplaunchpadpro.pl [217.61.112.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8410EF
        for <cgroups@vger.kernel.org>; Wed, 17 May 2023 01:10:08 -0700 (PDT)
Received: by mail.startuplaunchpadpro.pl (Postfix, from userid 1002)
        id ECE4282A7A; Wed, 17 May 2023 10:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=startuplaunchpadpro.pl; s=mail; t=1684310451;
        bh=oZTeICgx2X9EeHQQOCJSHYKJVJOCiOs1n/VaxwVhO9Y=;
        h=Date:From:To:Subject:From;
        b=EGoXKUYluFNuIW4Xvkie+wM9wz8mYXVOqpTlg3W3KBimPDs7kpN0JXzJthf1dh7uM
         F1UMiiFRAMDrUNiFHHa09B8/iArTJe+AWnHHOpGo3XEWrWXH7GLF7fiLhO5npcLrS6
         dmgPVNhxrOUbcapK1EtwSJ91E3E4wfrCGaXTFAqC4oEUgtnPfICxQWGY23IEiS3Ebj
         hGSfsapUn0Vq9znZpp33CrdStx9bjEzrDqHR6tZ8muSMq/xboImJwX14kalfCyuz0r
         3bQhIvfLi1omtT0PmIimJYD0U1m7n0LhvbZZFdZ2HIDaMxxNccQvYWcxBhAWSq2f3s
         DS0CBnYt4+TiQ==
Received: by mail.startuplaunchpadpro.pl for <cgroups@vger.kernel.org>; Wed, 17 May 2023 08:00:45 GMT
Message-ID: <20230517084500-0.1.7.8cp.0.ioy7q1igeq@startuplaunchpadpro.pl>
Date:   Wed, 17 May 2023 08:00:45 GMT
From:   "Marcin Wojciechowski" <marcin.wojciechowski@startuplaunchpadpro.pl>
To:     <cgroups@vger.kernel.org>
Subject: =?UTF-8?Q?Prosz=C4=99_o_kontakt?=
X-Mailer: mail.startuplaunchpadpro.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URIBL_CSS_A,URIBL_DBL_SPAM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0264]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: startuplaunchpadpro.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [217.61.112.231 listed in zen.spamhaus.org]
        *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: startuplaunchpadpro.pl]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: startuplaunchpadpro.pl]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dzie=C5=84 dobry,

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam
Marcin Wojciechowski
