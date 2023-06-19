Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1AD734D4E
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjFSIO1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFSIO0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 04:14:26 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DB294
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 01:14:25 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-38e04d1b2b4so2344235b6e.3
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687162465; x=1689754465;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=ZowKDbDQjwBipIT0TC2V9B+J/5YkfZmS/2MCDIVjPA7RqjkD/l5mZtbNAYN6YqG+hE
         kTUBBRtNTmVSRw0dm8e5IL4pqsOq9D/sWbH1Arbj5Ww3AXt88jM/IYx5knOw4oInPTqh
         Ou4PmPTkWhcMUGb2YNasns3HNUqsOQwA0eLRZ9EhzxsoAyHA+oixi7vCoC3oaN5Ou2sS
         i1KDWmCV4qu2xzjId6n816nTC1Fsed0Ia9MR7IfBwWi1n7CbYI4AYrYwUmYbtf/AWrNd
         lmDnxj5x2XjUawqx8f9kyXVOBEkCztrf9CLKUUbzQUEx9YAjz+HxLFMJfVyz6U6NMLIv
         hh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162465; x=1689754465;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=BT2/vBn7ykbLTfpVb2Pvxb5SOaF7QfgSQDhr+/8vEM5HOO6/sihttUtYuydUetIqBb
         Dqghj8r7xEruWVCOP0uK+wRCrdTW6RmZ9dJWfqGxbrxRj0w1ANPdzaV4DQOhempTXcCf
         N3/1i5WdPVSHxDxhTGIPxd4ygnHyxYpt2CMFmSZs7g5/WmdyPeWkYIxwgyIfSucgyT1Z
         eskCtN+Pz/qYLmRciQFsjx0QzED3r2y+NqihgyETOnGS4aiw7lNmlXZj7Xuam+/9/duV
         isLRhWh+z9F6AuE5wm16DxMbI6GO0tFBKuCj0VlEOtBqDDlxt8o4oxWFd12Q0y6hk0xo
         pyaA==
X-Gm-Message-State: AC+VfDwWbYydnJPlVa6qtTCOQIT8iTaNedNmqIDqvR+hAZqamyrkkkKw
        WXIypPruZ9m4xvP+NNu3Q3xGwPV0905RHGV+fKQ=
X-Google-Smtp-Source: ACHHUZ4wwUfEa4unpL4C6xyRI6i3itzvuZSzUOAuz71yEYH95atKfPDtc6ZV5QwAwmxdlGvmJzoUzQTMoLEM9Be5jCs=
X-Received: by 2002:a05:6808:1385:b0:39e:ceaa:92ee with SMTP id
 c5-20020a056808138500b0039eceaa92eemr5338184oiw.31.1687162465078; Mon, 19 Jun
 2023 01:14:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6359:6e83:b0:127:8127:f692 with HTTP; Mon, 19 Jun 2023
 01:14:24 -0700 (PDT)
From:   OFFER <diazanna810@gmail.com>
Date:   Sun, 18 Jun 2023 20:14:24 -1200
Message-ID: <CAO6W-Y+CX2GgN_x5xTnyim4Cc9RhGGV2TdkL2c=+G08pamp+Jg@mail.gmail.com>
Subject: Greetings From Saudi Arabia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dear Sir,

Need funding for your project or your business ? We are looking for
foreign direct investment partners in any of the sectors stated below and we are
willing to provide financing for up to US$ ten Billion to corporate
bodies, companies, industries and entrepreneurs with profitable
business ideas and investment projects that can generate the required
ROI, so you can draw from this opportunity. We are currently providing
funds in any of the sectors stated below. Energy & Power,
construction, Agriculture, Acquisitions, Healthcare or Hospital, Real
Estate, Oil & Gas, IT, technology, transport, mining,marine
transportation and manufacturing, Education, hotels, etc. We are
willing to finance your projects. We have developed a new funding
method that does not take longer to receive funding from our
customers. If you are seriously pursuing Foreign Direct Investment or
Joint Venture for your projects in any of the sectors above or are you
seeking a Loan to expand your Business or seeking funds to finance
your business or project ? We are willing to fund your business and we
would like you to provide us with your comprehensive business plan for
our team of investment experts to review. Kindly contact me with below
email: yousefahmedalgosaibi@consultant.com

Regards
Mr. Yousef Ahmed
