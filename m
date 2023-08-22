Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A1784B8E
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjHVUlq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Aug 2023 16:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHVUlp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Aug 2023 16:41:45 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 13:41:42 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBFFA8
        for <cgroups@vger.kernel.org>; Tue, 22 Aug 2023 13:41:42 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-4f-64e5051846cb
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id A7.35.10987.81505E46; Tue, 22 Aug 2023 23:57:28 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=PA4cwdsEeVC8RwLJc24b24SiRMirA4K21lPnG6EdElyLlzQQaJXGS4TJ7w7hiNuIg
          C6lTDtxNW7Q8I6MWj/jywtGvKlzorvKx0fjQS4k7WcWiudjX+/gm0whsIaHWs8uku
          XZBx3U3dnB65HUP6cEYBExJqi8mqfKHbLSYzvl7oY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=eZivOajqjBk7W7o6CPdZmM9rxlcWsXbU2w35HSCUZ+a4/p9SyUNkXnZ+djfZjX3W1
          vYDeDDMQRRzxxJ842WqSIgEpEKiSNbSU40lJgDBgh6yle+xcWjhzWGcX4IAeFgyPC
          WB9HXoVr5XZpkDn/OfcWoTjv72Mw3OilEkl64bCbY=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 00:29:14 +0500
Message-ID: <A7.35.10987.81505E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     cgroups@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 12:29:28 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW1eC9WmKwcGtIhY3ls9gcWD0+LxJ
        LoAxissmJTUnsyy1SN8ugStjyboLLAW7mSva+hexNDA+Zupi5OCQEDCReNoEZHJxCAnsYZI4
        OvsHI4jDIrCaWWLBz1VQzkNmiU/PJ7B1MXIClTUzSnw45wpi8wpYSxw7+YQZxGYW0JO4MXUK
        G0RcUOLkzCcsEHFtiWULXzODbGMWUJP42lUCEhYWEJP4NG0ZO4gtIiAt0f51OpjNJqAvseJr
        MyOIzSKgKtF26wkTxFopiY1X1rNNYOSfhWTbLCTbZiHZNgth2wJGllWMEsWVuYnAQEs20UvO
        zy1OLCnWy0st0SvI3sQIDMLTNZpyOxiXXko8xCjAwajEw/tz3ZMUIdbEMqCuQ4wSHMxKIrzS
        3x+mCPGmJFZWpRblxxeV5qQWH2KU5mBREue1FXqWLCSQnliSmp2aWpBaBJNl4uCUamBsSKgV
        aQt8MVlmz17GYyKzWXKlk+yeSU4x+PpTPmmqqHvKimtqsjlJUdqLvuXGJWZraxtzdr9+l/Tl
        4e9DTTd9loQ2it+In7PuEb9WdObihklPLDjr3Yx4bn9wuK8gzXroid7pEB6ludcneHk8WSr7
        53Rx1eFZUZt81Opf6mxayP/h9jv71GtKLMUZiYZazEXFiQDG+D7rPgIAAA==
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

