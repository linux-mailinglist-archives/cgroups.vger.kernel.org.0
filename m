Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317C65247C
	for <lists+cgroups@lfdr.de>; Tue, 20 Dec 2022 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiLTQOu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Dec 2022 11:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiLTQOT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Dec 2022 11:14:19 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7621ADB4
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 08:14:18 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1322d768ba7so15931317fac.5
        for <cgroups@vger.kernel.org>; Tue, 20 Dec 2022 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJHuqJnIx074BMYbiEwAJgSYfRr5by7w1jzdSrWW5qI=;
        b=ibF8DFYdkfowditrzS3NSpUfJNk+8zPRcVurcCvGmvcPGh3zUg4HX1uTe1ubZ1ClG0
         7F8C7kUrzFpoJ3xsa1H1gwU+91jDaQ/kpAgBzOlWXWKn8LEA8GquTqQmSdDQgP6aWLwS
         yEfalmyzAv/GLlHCra69nz0NHpnGy7d1Nqxg4bCq7PDVK2+hTbcJqSsKZzjCwnKy3kJ1
         xo6NytgGq0LN2CJjDrict7GyNj93Zoj7lBn5FnRSMHCBMCqw+km9+rAovYkh9tTULEpV
         /WMU5mujyzR2/9jNYdt6zVwTm5n3UICIOfx0b4jqri2XjpjYXrsoVb59qMYKpANeZ1e5
         TbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJHuqJnIx074BMYbiEwAJgSYfRr5by7w1jzdSrWW5qI=;
        b=toX7sBE7RoqsPCsLy6j4B/8Hf9tjlKlBoROhwkMRIQw+090F5I2TVu5hsoZ2W6+wK2
         Mb7Cxb5CIgyAZM7NzHiR08uK5sDrmMP+XIy4TIL2Zt38gUhtbfJaXsVSOnAAh8b2pR0G
         oYQmbrQew5s/n89mdq2RvUgabfnZaX5+Qsa7dMYdYclyhW+vwDhb8EiA2ydPR8AnIiES
         UA5CcVVfKkeU5y6sN3rFExRjBHWlireP8vs8Jt2Qzn0u8zGRlpHV5qvqUmBfZJubir0W
         oofoBp89ObuzuvGx843RA8vuLmKkppFuvRMi8e8duePjWj/0qSIfG+AqS3xgXwiotKPc
         Xq6Q==
X-Gm-Message-State: AFqh2kofFoc1fXTZyK3+oHMJmhmUXnOzFEcYyNyGh8LTzJF5E89Mp6Lk
        +zukfRkNykm5G50vV5XxxQiRTpQgrYsJSEsbBA==
X-Google-Smtp-Source: AMrXdXtKiDi5p0yyexDJq+M6tUx/On1MBAShE0ElF6wYYE+tzpLHXd9C6zZtuPvpZKSGzFCe1ReP4gXZwtrecfwiWLM=
X-Received: by 2002:a05:6870:698b:b0:148:2c02:5323 with SMTP id
 my11-20020a056870698b00b001482c025323mr2897616oab.298.1671552857814; Tue, 20
 Dec 2022 08:14:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6870:5d05:b0:144:f6f0:4dc5 with HTTP; Tue, 20 Dec 2022
 08:14:17 -0800 (PST)
Reply-To: anitaphilip415@gmail.com
From:   Anita Philip <anitaphilip415@gmail.com>
Date:   Tue, 20 Dec 2022 17:14:17 +0100
Message-ID: <CAJeCp6L+QnjmdsR=hYtX=3zOcwH31RtpWKdYSw2jy8ftHc5dnQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,YOU_INHERIT
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5006]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anitaphilip415[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [anitaphilip415[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anitaphilip415[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 YOU_INHERIT Discussing your inheritance
        *  3.5 ADVANCE_FEE_3_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Good day,

My name is Miss. Anita Philip, I am 19 years old the only daughter to
my late parents. I am contacting you with tears in my eyes because I
really need your help to secure my inheritance that my late father
kept for me before he died. I really need your help to be my guardian
on this. Please can I trust you?? I wait for your reply for more
information on how you can help.

Best regards,
Miss. Anita Philip
