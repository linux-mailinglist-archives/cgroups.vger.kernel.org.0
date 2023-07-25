Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6D761AE5
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjGYOEm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 10:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGYOEl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 10:04:41 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35157106
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 07:04:37 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-63c70dc7ed2so41537076d6.0
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690293876; x=1690898676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L6q2fbSEUaRmabz4YeOC1QVhb19awtdwyXc9KAJHQSg=;
        b=NhRu+ZEBbGmHUyV23DWyyUEl6Nq9VUT++p+9QWJdkAJ01svswkr1clQ+XgDEJoKZlu
         Weht+NskAhuvf8tGjjG2GgCJMoox5KBq9h7cac9rQqrC1vpsp28oMsNe9KY4CjN98NgM
         2onTXCyaJs2t96h7XB5cCypHFdWg+fwb65PFB8O3ZrvuiaJHuzW2QZDMOqGry5xTxZnL
         a0LtNC5vIK9Xsexs+3OgGgt5bslUleSsJtnl1gA4F45g2Ko2FIGEpl62me3wUqr1jORf
         2aM4RpjbPng4AlA4q3lBQwcuniuBSVYARmbS0pCKD+STkQGtoiTn6CFXFLVdidVlar95
         wCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293876; x=1690898676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6q2fbSEUaRmabz4YeOC1QVhb19awtdwyXc9KAJHQSg=;
        b=jevnIyYtIYdmUYWq1edIA6wfyiK+y4lpC3qigl1jeYFQFcSEyWsJsi/vFGmyiGxSUL
         lKjaCxvjRDGvDBvBUltB2Lh/xjRhsqkIK5FH1qxkfIPzu6WwBnYqwEOcM0VSqeBba8l+
         jwMvglnzq+UYcv6OLuOxQWt1b/S7uf+BIpTj0hSMeEkxYPRk6OGZ7iWjjMmEYuoQ26x/
         bXJ8R7ihzfV/ybSIGM3zuhz8C2kkIBjaqKuP9WDm/hejUZD10+PQyipvlUi05IrZMiO8
         NaY+FnzDF7p6wje28mXM63oierndwDeCo7UItBOoCCfpQs29gr+iXjm1GwDhvboyCYrw
         7ZiA==
X-Gm-Message-State: ABy/qLb25Bjn+CNkY14nw2sQr5xGdKvTUhQH8ZZBaA+JQ4Wyl+l6YR2m
        A6GUHwAP1CzstV5Y60HJRtMnaXxHCUEaPsgGjHBDmQ==
X-Google-Smtp-Source: APBJJlG3KOFzO2JnzeEJGbYDiAU3LPsExxVCfBgtf0f78SLJnPjtuVXjAyD32F9FLeYCbgmlt2ReZA==
X-Received: by 2002:a0c:9a4f:0:b0:628:8185:bd6e with SMTP id q15-20020a0c9a4f000000b006288185bd6emr2524662qvd.5.1690293876314;
        Tue, 25 Jul 2023 07:04:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id q4-20020a0cf5c4000000b00636047c276csm1368975qvm.126.2023.07.25.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:04:36 -0700 (PDT)
Date:   Tue, 25 Jul 2023 10:04:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <20230725140435.GB1146582@cmpxchg.org>
References: <20230719174613.3062124-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719174613.3062124-1-yosryahmed@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 19, 2023 at 05:46:13PM +0000, Yosry Ahmed wrote:
> Currently, memcg uses rstat to maintain hierarchical stats. The rstat
> framework keeps track of which cgroups have updates on which cpus.
> 
> For non-hierarchical stats, as memcg moved to rstat, they are no longer
> readily available as counters. Instead, the percpu counters for a given
> stat need to be summed to get the non-hierarchical stat value. This
> causes a performance regression when reading non-hierarchical stats on
> kernels where memcg moved to using rstat. This is especially visible
> when reading memory.stat on cgroup v1. There are also some code paths
> internal to the kernel that read such non-hierarchical stats.

It's actually not an rstat regression. It's always been this costly.

Quick history:

We used to maintain *all* stats in per-cpu counters at the local
level. memory.stat reads would have to iterate and aggregate the
entire subtree every time. This was obviously very costly, so we added
batched upward propagation during stat updates to simplify reads:

commit 42a300353577ccc17ecc627b8570a89fa1678bec
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue May 14 15:47:12 2019 -0700

    mm: memcontrol: fix recursive statistics correctness & scalabilty

However, that caused a regression in the stat write path, as the
upward propagation would bottleneck on the cachelines in the shared
parents. The fix for *that* re-introduced the per-cpu loops in the
local stat reads:

commit 815744d75152078cde5391fc1e3c2d4424323fb6
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu Jun 13 15:55:46 2019 -0700

    mm: memcontrol: don't batch updates of local VM stats and events

So I wouldn't say it's a regression from rstat. Except for that short
period between the two commits above, the read side for local stats
was always expensive.

rstat promises a shot at finally fixing it, with less risk to the
write path.

> It is inefficient to iterate and sum counters in all cpus when the rstat
> framework knows exactly when a percpu counter has an update. Instead,
> maintain cpu-aggregated non-hierarchical counters for each stat. During
> an rstat flush, keep those updated as well. When reading
> non-hierarchical stats, we no longer need to iterate cpus, we just need
> to read the maintainer counters, similar to hierarchical stats.
> 
> A caveat is that we now a stats flush before reading
> local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> or memcg_events_local(), where we previously only needed a flush to
> read hierarchical stats. Most contexts reading non-hierarchical stats
> are already doing a flush, add a flush to the only missing context in
> count_shadow_nodes().
> 
> With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> machine with 256 cpus on cgroup v1:
>  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
>  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
>  real	 0m0.125s
>  user	 0m0.005s
>  sys	 0m0.120s
> 
> After:
>  real	 0m0.032s
>  user	 0m0.005s
>  sys	 0m0.027s
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

But I want to be clear: this isn't a regression fix. It's a new
performance optimization for the deprecated cgroup1 code. And it comes
at the cost of higher memory footprint for both cgroup1 AND cgroup2.

If this causes a regression, we should revert it again. But let's try.
