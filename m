Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22259552E6D
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348993AbiFUJec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348964AbiFUJea (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 05:34:30 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEDE25E83
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 02:34:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r3so23480165ybr.6
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=TGKGtvXFzX943S3t2fE/QTFCiES2rfAkp4/8PK0Evuh6gxlBGfgvSXb2d0Aj7N3SFV
         3RSjxh5DOJV0jmXwuEbqZiB4hfTWlFVTIyp8X/Zc3RLtbaBeNUXcNvoqxeLVAdQ/x0oF
         NZprQ2OrRJoH4WtIh2yTlndSaiLEqAvQWbhYFk6FWnGgJQp79HG59IfbCch3EFV3b4a9
         agHy6xtKPqYNDyPu0nL/sFBSr7jBokoLoE+/btQr9tHsY5HwR4V6rEJ3qHdt97pUrhmn
         D2zgtntMNQr3BedvC/sl33fIxg/XSkOjdVFs8IHTezIi5WNwUn/p9QlwrDpeeMggwm7w
         6OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/0bRExIb6Mv4sy5raFRmeQINC+UUx7zEZcUUOWWOPJg=;
        b=1na+xSAwUS7zkjADlGRAY3I+L7PqwC33BMbs2KlsFM3Jg1GTQ1aBbLuyGAzEqtZJ57
         xwsS2QZnIWdOwaV3pAugU9mju+qnygFAIZ4IRcH/4hjC7YJXG4Z1NcVozGcLuofEJzOw
         DdmdlxPy9spwdBd811R/qsIDtRn2VsT+48njYjCL+ix9zLZrUqmQTr9DTLRISJsPOppO
         hN+gij2MxyJeOFCrfmkNBw3d6mCekfJpBkoRCU38jmrw8qb8iGUhwEGFMQLcTqAKf6mU
         KXB6JW3kvVIActItbGT3FHx0hxOuimOmWEh/oJ5idgigGndZH5SyJuaXxZRWvFs4unog
         uzog==
X-Gm-Message-State: AJIora+c7Pwof+xBJdwyzcfU49K/UDyVoU8fvrbfkgXNDzm80dWnSTj5
        qOgEFIYw28m6QOUZmE7BqCEdOmsR+xM4zYXMUCA=
X-Google-Smtp-Source: AGRyM1vH0iOPKx7+Q75J23TVZ2dG7fpvKqOKC9BhDPlf4SXyt7YNCoy6Uw2K1GV77qaZ4qmRJ0kxvBBnwaYfcVhV1p0=
X-Received: by 2002:a5b:b0f:0:b0:668:d864:ea12 with SMTP id
 z15-20020a5b0b0f000000b00668d864ea12mr15196736ybp.25.1655804062762; Tue, 21
 Jun 2022 02:34:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:e10a:b0:2d9:e631:94d0 with HTTP; Tue, 21 Jun 2022
 02:34:22 -0700 (PDT)
Reply-To: dimitryedik@gmail.com
From:   Dimitry Edik <lsbthdwrds@gmail.com>
Date:   Tue, 21 Jun 2022 02:34:22 -0700
Message-ID: <CAGrL05Z7oR_hhk+jooLqL3OLCZVoq1g4RUkctpNcQNayZGBVJg@mail.gmail.com>
Subject: Dear Partner,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b29 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lsbthdwrds[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Dear,

My Name is Dimitry Edik from Russia A special assistance to my Russia
boss who deals in oil import and export He was killed by the Ukraine
soldiers at the border side. He supplied
oil to the Philippines company and he was paid over 90 per cent of the
transaction and the remaining $18.6 Million dollars have been paid into a
Taiwan bank in the Philippines..i want a partner that will assist me
with the claims. Is a (DEAL ) 40% for you and 60% for me
I have all information for the claims.
Kindly read and reply to me back is 100 per cent risk-free

Yours Sincerely
Dimitry Edik
