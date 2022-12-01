Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80B63FA51
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiLAWKw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 17:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLAWKv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 17:10:51 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E17A43848
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 14:10:50 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id k185so3022395vsc.2
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 14:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rf84obAKN/8ruolDjM0pM28OtudVnfPduob08XaAHeM=;
        b=C5A/tE+OvI+/icvXdhe39VigA0TTbTY4PJd9mnXEXbnfkr0SrvZc1sS0BhKGJ9tFbH
         VrlF6IzPg1aqf/aWu55hvBF9KZc12XIGaiyBaaWM8tzg9pEnKuCYLKsOWIO9iIRoq6fN
         h+9U6WOdvTl4++/BjtWYxzFMTOs+g5fd6qJ/zeLOaxZ5HqfmU3EFndAxTDwLIhOvufRg
         lz9HYLOosZUavj+NWHAmwUBmjsPobyVqbSeR7xoIPkhsfX+u6FQFeFXf4lUXDXHETkX+
         aOg84lpe1797MkZHvW3Z/yK8LBKC0vRON342vgsQ0hEFEvXwFpzRCnmNE0JkU96V1fXe
         hHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rf84obAKN/8ruolDjM0pM28OtudVnfPduob08XaAHeM=;
        b=PWfzFyeJdGUhthAZv1iqi80J7umBcc3pbn9JLftbsxsfb1l4RrGtlBTr95mI8Pj+Rx
         trm2uPJ010/SkoVubB1aatY057HMEOk6hKSjKwJfZ7OX7tjoMTysJiMHDpqI31pIO2sj
         ARfNeOKeE+NCaag4OJJIRMDIoiBU6X65I3iThKF66n8K92lNHFwmr1qXbJL9FFfvFmfY
         eGXdoRIyW9C9pAh3InC/A6r5tMyxZ/YRLaacgfCNUBsSY8Zo0ySEeVm3m1rov61D/XYO
         QEczgRFrVTaYdH22IET8VE1cYPQ+iAiEcME/qIg+02wvovJ+ZYmV9tl6bpsScT6oeMJy
         0cwg==
X-Gm-Message-State: ANoB5pnDaf2NFcWeC+uqH8MqrZY7ECLwFzLmUI2o0UEUVM3D8RmKwE9Y
        xqiOEP4DwY2/WKhWnTfYx0wRXmTqegTTvipWsTv/JA==
X-Google-Smtp-Source: AA0mqf7+zcrz2gPmzIkscfmr5SMSSgOcjkv+7kg2SOfHpFg5FBWFgEZt95ZGmuZG032Oshqx0NMxe3bwoGr4Onh742g=
X-Received: by 2002:a05:6102:cd1:b0:3aa:1bff:a8a5 with SMTP id
 g17-20020a0561020cd100b003aa1bffa8a5mr39103278vst.67.1669932649473; Thu, 01
 Dec 2022 14:10:49 -0800 (PST)
MIME-Version: 1.0
References: <20221130020328.1009347-1-almasrymina@google.com> <20221201213202.ycdaymwojd5plyrk@google.com>
In-Reply-To: <20221201213202.ycdaymwojd5plyrk@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 1 Dec 2022 14:10:37 -0800
Message-ID: <CAHS8izOn3Kr8vqxHYxEoGVoCXKmysRKNsvXpJ2EumxDU6JfSDQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        gthelen@google.com, fvdl@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 1, 2022 at 1:32 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Nov 29, 2022 at 06:03:27PM -0800, Mina Almasry wrote:
> [...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 7b8e8e43806b..23fc5b523764 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >                                          unsigned long nr_pages,
> >                                          gfp_t gfp_mask,
> > -                                        unsigned int reclaim_options)
> > +                                        unsigned int reclaim_options,
> > +                                        nodemask_t nodemask)
>
> Can you please make this parameter a nodemask_t* and pass NULL instead
> of NODE_MASK_ALL?

Thank you very much for the review. I sure can in the next version. To
be honest I thought about that and made the parameter nodemask_t
because I thought the call sites would be more readable. I.e. this:

    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
MEMCG_RECLAIM_MAY_SWAP,  NODE_MASK_ALL);

Would be more readable than this:

    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
MEMCG_RECLAIM_MAY_SWAP,  NULL);

But the tradeoff is that the callers need include/linux/nodemask.h.
But yes I can fix in the next version.
