Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D324595156
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 06:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiHPE4b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 00:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiHPEyk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 00:54:40 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0071A6CCC
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 13:53:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g16so4304035qkl.11
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=D1FeCaMz7nA4+mXWTiLJNZGsM0GYC5RqkboS4hyipJF5qWe15L7h4VEv79qdRdPXZd
         XMLX7gSYQiXupQnRk3v1ylBIc1G2NZiA/aDebM/xZja/YCBoUvj5NGwF7mPDywLSvcZf
         34m+/HO4Zi7TPc7ktxkRuVamuwUXU3wSFyt7tpjqLQgSWasm9+rtYElO8d3cONdA2FgT
         mutsApmf2dbc5VaEyCNygOYDUyt1L/tdgcxz1CCIlL6UtxToPGYajkShZg2KSjULrwHE
         I/QcK3JdlrJNn4QZiDNoGnyfDzTGcOJ7MXeUcZEhf9byhRfWXO0z8LkecLR5VVhpo/4k
         Ld9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ej3T27wdcOl5hgxFKEEvscpLUDARFbq7IX1O4+1Fbq8=;
        b=tWpxEvZH9BWVJ/k7ducixGGgdoK2M7wsAredsOkWTEX2XgS2ReAT3egfCjHZbnXUaa
         teGN5dFehlJ0ziTWqSMqRnANwD5Sme8b6WHr0cl2fldsB6SdrQctLnsh3ZBO4RtJw4nG
         P5MHlhxA5pVTyOtKcwrgPsCtvPLStrPJ0l/ig7Xn8KvcmmpLq4b0rGa/3An72RgnpIf8
         ErbU0kSVmgGTG3tYQLnyLDOLgquhoN/7GVG2WSravCHcQ6FhdtxaL/aaCtgbj+V4KFsq
         l09BeBO6AZ5S5mjqWeEUIZeHKF/1LINv0F7x5a1x+JETteFDupY+Hnu/8KrtJGL8hzcn
         tSGQ==
X-Gm-Message-State: ACgBeo0n7/C6m0ugpmKtsROPp6Tt/SScbcsOpYD2kCAWR1nJgro5nFJf
        Qfk2SERzKKLk7jWCcdGmqktkb9Wc8LLUaoKGDwM=
X-Google-Smtp-Source: AA6agR7kaA5dYnHibd6JhOYmNRaDZcAAkknb1ao/4FpYnQkvjzm1WMC3vkVYCaERBCo+VY8fb6g9saFj8NWbliVjViM=
X-Received: by 2002:a05:620a:126c:b0:6bb:29b6:e309 with SMTP id
 b12-20020a05620a126c00b006bb29b6e309mr4915855qkl.516.1660596793897; Mon, 15
 Aug 2022 13:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:ef88:0:b0:46d:3a61:256e with HTTP; Mon, 15 Aug 2022
 13:53:13 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Prof. Chin Guang" <dmitrybogdanv07@gmail.com>
Date:   Mon, 15 Aug 2022 13:53:13 -0700
Message-ID: <CAPi14yJdzgN96+k0HsCyo_FoQrYX7vGgdDufFziwOX9rqeC6-Q@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:736 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5058]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wijh555[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dmitrybogdanv07[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dmitrybogdanv07[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

-- 
Hello,
We the Board Directors believe you are in good health, doing great and
with the hope that this mail will meet you in good condition, We are
privileged and delighted to reach you via email" And we are urgently
waiting to hear from you. and again your number is not connecting.

Sincerely,
Prof. Chin Guang
