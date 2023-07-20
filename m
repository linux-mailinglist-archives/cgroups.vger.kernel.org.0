Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847175BAA5
	for <lists+cgroups@lfdr.de>; Fri, 21 Jul 2023 00:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjGTWbG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 18:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGTWbF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 18:31:05 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21D810A;
        Thu, 20 Jul 2023 15:31:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66f3fc56ef4so1697025b3a.0;
        Thu, 20 Jul 2023 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689892264; x=1690497064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZpl8s75HuZGEhNzUvLR3L4qywqf/Lpjo/SjREf5tA4=;
        b=ghf2BigSLopuzIAO9mo5bilaWUW4pw/MFFRLacsY7gWLDlVj9giiAM8MRIJR4yUUN1
         0eZXp+66XIpghEylgvGqAISiRJtWYiAeKFk7WqWG9YoONhzF7W8uockvwN6JHX9P2ZkX
         1WQhxBW7HjKnkQF7XhjgGOYKP2fXw2EG0F8J+r2UjwCm20cngLNEKgvq2w+1/xMghmP4
         0F1mD2djp/qp+HRvQPIcmx4EbINiffoW4s2adiKXZS/QnQC/F3zsDi5AZw11mkZQfaLw
         JFzkRMQNS3a5BSHUM/Gm5XZF6bkZeN/kuIDV0MNaB/JLMC1CDfRMDUaljWa1nfZfBNCU
         Dtbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892264; x=1690497064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZpl8s75HuZGEhNzUvLR3L4qywqf/Lpjo/SjREf5tA4=;
        b=fBP2iO6r/eY0GUu7m1CiKqzT6MMiwMMzubKuro+J8CCtXbjKhLerg+LBXg0KelEpXQ
         0ylcAmkAHzUoqk5O30W5xa1rwE72J6AjL4tXxrBx8LJpZH7LB+mqtIA1vGPAic82z28U
         1qyeqvj5/Cp0zRTxaVIWkPZ4Bn+CerI+3lM+W+JQ5DGivUkAzyn/OXEfuC+1RAd18ugU
         Tno4p0mHFGcK6PUu9psmBy5qUxYIlkgmWR5M6REP2vmPtwozS5TFCgs7wuLDE+KgKxea
         Nh+FlkeftNhDA58mMxLigyzjLud/uAKspyfu2jBriRm7N6ioAPB7OocMuG2pfmXbSZh8
         5ZRQ==
X-Gm-Message-State: ABy/qLaQvBJU/2Zknl7RgRCwcEDYVS/oo+SW8PiDuyq58BbI/muOY+m9
        2ZLiLQJ6qPpgsgGse2hfKxo=
X-Google-Smtp-Source: APBJJlEzg0Yil3Q92R9mP6SC1Y2AeH6CTu+qTw9rhX9Zts56WnHzBb54bFsTGCD2r51MF7MGt0yucQ==
X-Received: by 2002:a05:6a20:8401:b0:132:7d91:aadb with SMTP id c1-20020a056a20840100b001327d91aadbmr381237pzd.6.1689892264054;
        Thu, 20 Jul 2023 15:31:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id d20-20020aa78154000000b00682a8e600f0sm1684817pfn.35.2023.07.20.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:31:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 12:31:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZLm1ptOYH6F8fGHT@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
 <ZLmRlTej8Tm82kXG@slm.duckdns.org>
 <CAJD7tkYhu3g9u7HkUTFBtT3Q4edVZ2g1TWV1FDcyM9srrYCBLg@mail.gmail.com>
 <ZLmxLUNdxMi5s2Kq@slm.duckdns.org>
 <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZKo_oSZ-mQc-knMELP8kiY1N7taQhdV6tPsqN0tg=gog@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 20, 2023 at 03:23:59PM -0700, Yosry Ahmed wrote:
> > On its own, AFAICS, I'm not sure the scope of problems it can actually solve
> > is justifiably greater than what can be achieved with simple nesting.
> 
> In our use case nesting is not a viable option. As I said, in a large
> fleet where a lot of different workloads are dynamically being
> scheduled on different machines, and where there is no way of knowing
> what resources are being shared among what workloads, and even if we
> do, it wouldn't be constant, it's very difficult to construct the
> hierarchy with nesting to keep the resources confined.

Hmm... so, usually, the problems we see are resources that are persistent
across different instances of the same application as they may want to share
large chunks of memory like on-memory cache. I get that machines get
different dynamic jobs but unrelated jobs usually don't share huge amount of
memory at least in our case. The sharing across them comes down to things
like some common library pages which don't really account for much these
days.

> Keep in mind that the environment is dynamic, workloads are constantly
> coming and going. Even if find the perfect nesting to appropriately
> scope resources, some rescheduling may render the hierarchy obsolete
> and require us to start over.

Can you please go into more details on how much memory is shared for what
across unrelated dynamic workloads? That sounds different from other use
cases.

Thanks.

-- 
tejun
