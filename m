Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1951EC13
	for <lists+cgroups@lfdr.de>; Sun,  8 May 2022 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiEHHqZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 May 2022 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiEHHqY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 May 2022 03:46:24 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A4F655E
        for <cgroups@vger.kernel.org>; Sun,  8 May 2022 00:42:35 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id f38so19848013ybi.3
        for <cgroups@vger.kernel.org>; Sun, 08 May 2022 00:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+e6DxsGRSH2mhsXI7GeLvIZXX1m4MD4Ab6z6xzst2ho=;
        b=Z8fRoPxoRl34u1E6ujKvjI9p/sxq+c0E8VeMgI04JndtZWnKoS763gaQukp/PEDXeo
         sR87qK1Cl8SwF5UQXkul6KuHkU6zzPgluagOoMpmXjwm3q0DHHHJ9tgbRyJl8WKGQQ0f
         3jn1E1hOtzA7hQHkUT1KrxtyWV55mNwznXqdjNJHxivJzugpBfz3EW2jGLSa1CpyvEtC
         Y5ILu/Nj59ZvmRSlseh82rXBJJo6yr68RrCOsTeG2lDIydiiQLcoJ05/3+wX8qGUbjKb
         3DrfLOZ22YNU9fGAWV+4jfRRiirhLaZOYXkTSzaN01yZMlakVPZpFnnpqg3VYqFvxOqD
         oJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+e6DxsGRSH2mhsXI7GeLvIZXX1m4MD4Ab6z6xzst2ho=;
        b=Rwgf1d87TQD1IOAzjaDmPwwlc0hcEUQ7S7IaK4DE+hXdtJuQSuY/tA0OqaB3ZFOJ/r
         qnCs6ZmTr5fs+5087j7GaKerja47H/nBlNQR7RF1qYuT31Kvr/uae3T1/DM+tP0uXC6i
         kwfNyACRAPnN2oivJxaYB2fhYLmWCzEH6y2z1yFfFp2BNlk5pIQkEQJowZn6ZhWJ4iS+
         +AStC14FCsBCtV4QXZ3NhG1sMDf0cxo9rXZSt8g0P28hTiANQM4G22Rmw3FAAB1ZLIme
         yVg33gDtC22X9Qh+97/abTkY20F7hINr3dVdU+2M8BYddNNp1Kuz16scRWTG/+TPFMNi
         enDA==
X-Gm-Message-State: AOAM530+4peYSeRwxosUYlabRk71TQ65ED32IXG4TLdvu6CB4qA8I8m6
        /WYplB5KQVQhQiNA11UjHRn4Xu9jatTK0m2hR0E=
X-Google-Smtp-Source: ABdhPJw8Vio0iWIHxTAM7rqEoXl5co2DCAhL3B1j2jrr71a7pl5h2f+7CDgGqcD/nDG56GZXhsBdQaNgkzuXZMd/UgA=
X-Received: by 2002:a25:bfd0:0:b0:648:d409:10b with SMTP id
 q16-20020a25bfd0000000b00648d409010bmr7843205ybm.219.1651995754232; Sun, 08
 May 2022 00:42:34 -0700 (PDT)
MIME-Version: 1.0
Sender: mr.musa.ahmed7@gmail.com
Received: by 2002:a05:7010:4592:b0:2a8:7420:2a2e with HTTP; Sun, 8 May 2022
 00:42:33 -0700 (PDT)
From:   Aisha Al-Qaddafi <aisha.gdaff21@gmail.com>
Date:   Sun, 8 May 2022 00:42:33 -0700
X-Google-Sender-Auth: hXs8vZWrGvy5d_8f-x_QApjEYT0
Message-ID: <CAAz8YJ_apyVGJMOD1LVscpSGRHRrWF75by3wnVzxST-sL9N5wg@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.musa.ahmed7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aisha.gdaff21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.1 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh
I came across your e-mail contact prior a private search while in need
of your assistance. I am Aisha Al-Qaddafi, the only biological
Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a
single Mother and a Widow with three Children.
I have investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27.500.000.00 ) and i need a trusted
investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in
your country, may be from there, we can build business relationship in
the nearest future. I am willing to negotiate investment/business
profit sharing ratio
with you base on the future investment earning profits.
If you are willing to handle this project on my behalf kindly reply
urgent to enable me provide you more information about the investment
funds.
