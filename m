Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D89B620E70
	for <lists+cgroups@lfdr.de>; Tue,  8 Nov 2022 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiKHLSM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Nov 2022 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKHLSL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Nov 2022 06:18:11 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA618385
        for <cgroups@vger.kernel.org>; Tue,  8 Nov 2022 03:18:09 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y6so11158380iof.9
        for <cgroups@vger.kernel.org>; Tue, 08 Nov 2022 03:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=jL5tGnVzrp+AqPgpmV599At3ddQxwhvPcDu54860HqlIay7+IdDcNpdXV9XTzy3gEv
         BbsQFQ/R1b+aht7OF3ko/+7HcAnXm99YaSgYjVuE2BZzE85Pua3mfBUvr/bh8UHcW+eF
         VOh04IpSAv7f02L+nG3m9FSIvc2pqjU7ob766yCkIpMCqvp452XA+jDN6+X6GTd73hii
         3o2Dh7GZSBI9PzDdzfkRD1TntFORBl0tvGwuzBHRiWBjWUfdV9578RVRAncwoZQm9C6a
         KHugwte0eU7nVCBtR2dvpAoeWJa77bgLbZ341LqJf7VCt7oO0qj/2fMgXaxuysNzm/xh
         ZIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=evbDrqAPr0Xy8iRjqyqPP9BByeUU6/uoosuPKzDcinXBBRbdDOpLnn+hh5FENeo4fF
         VBDtLIcsQovzQCN/xHpjsUHve49gskc14Nb7QA6yqH52aTQMwWSq4WvCUKO9sep6Ppqo
         1gjdqHB3YxKKMu82cPaQlTOYATOm56dEmPmgyO3nhL0nkOgj3bMuWk9U9Y71Mhp1ZflN
         ru7bnC/n7wqZURdzilYGKpG1IFBLTtTwTrbCVQAs/gBCVLtQQ7H7it+v4bMIwW+kIiwz
         LKJbq3Nl7P27Y787z93nIMJ8r22u3J6C0q/AzMX23rJZc7xE7BSGtJdv9UjUM+MDFvzK
         dreA==
X-Gm-Message-State: ACrzQf2GD7B7k2ej+GPQuK22XL7FWFaSfHX6wIb0Qc+uyH/7yZLSydDY
        b1S0m3PI9JC6tW55ugaXrz1AKDCnSKxRYFE/0Ag=
X-Google-Smtp-Source: AMsMyM6vQL77Afnd87fAq7AB3KPrajM61183G7jTcDyIVrBOgqOPm9Oum7VQOEiKtT1nrtXGMZpsQN0Mjes8ej+nIW0=
X-Received: by 2002:a05:6602:164b:b0:6cf:bc3f:fcd5 with SMTP id
 y11-20020a056602164b00b006cfbc3ffcd5mr30188664iow.119.1667906288777; Tue, 08
 Nov 2022 03:18:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:38a9:b0:375:4a9b:180d with HTTP; Tue, 8 Nov 2022
 03:18:08 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik1@gmail.com>
Date:   Tue, 8 Nov 2022 03:18:08 -0800
Message-ID: <CAKfr4JXRytK-Y5U2ZVC2irWNUbVR-Hi+cVcNAtoSUszmV3QhaA@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5072]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2d listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
Dear

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

Let me know, If you are interested for more details.....

Regards,
Andrew
