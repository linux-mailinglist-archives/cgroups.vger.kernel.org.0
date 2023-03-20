Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A306C0CC8
	for <lists+cgroups@lfdr.de>; Mon, 20 Mar 2023 10:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjCTJIF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Mar 2023 05:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCTJIE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Mar 2023 05:08:04 -0400
X-Greylist: delayed 646 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 02:08:02 PDT
Received: from mail.arnisdale.pl (mail.arnisdale.pl [151.80.133.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0B11E86
        for <cgroups@vger.kernel.org>; Mon, 20 Mar 2023 02:08:02 -0700 (PDT)
Received: by mail.arnisdale.pl (Postfix, from userid 1002)
        id 8FB68273B4; Mon, 20 Mar 2023 08:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=arnisdale.pl; s=mail;
        t=1679302544; bh=6DhEsVYOGxxfetVY3oiVeew+7Cm34ArcvgDq2WQYIRw=;
        h=Date:From:To:Subject:From;
        b=DDLkr9cLV7dJzFBWL1skjIlft4wzKvlq4kf2jtjyCRYz9Zr5FsVEObo734pRwBnUQ
         k60IZS41t7lIFD+gNZ7hRRKhUtFhQsOaO/JPvHghHGVf5fiTsNHWa5aSEbjoI6ujSv
         xRd66xdrNS+wU1DX5NVmlwdqgcsK7v2gsAdfLmYDQPzjI6NO8X50PjJjMOKvheG5pb
         CZpwzKFKyk3PzAs3QHq6Z8tted443PAugeoEGvJW2jxK9GpZsIizm/ROdBqZEw+cAT
         pEPvIwzfP3tfqzVLKxpzjDJ2EDQBjfT+nVn2OTq+48pmKDHCKvozURPeymxJhczzTk
         ov/Rbh9JOiC4w==
Received: by mail.arnisdale.pl for <cgroups@vger.kernel.org>; Mon, 20 Mar 2023 08:55:13 GMT
Message-ID: <20230320071612-0.1.3f.12vzm.0.5y87gmc75s@arnisdale.pl>
Date:   Mon, 20 Mar 2023 08:55:13 GMT
From:   "Maciej Telka" <maciej.telka@arnisdale.pl>
To:     <cgroups@vger.kernel.org>
Subject: =?UTF-8?Q?Nawi=C4=85zanie_wsp=C3=B3=C5=82pracy?=
X-Mailer: mail.arnisdale.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: arnisdale.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [151.80.133.87 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: arnisdale.pl]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4337]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: ******
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


Pozdrawiam serdecznie
Maciej Telka
