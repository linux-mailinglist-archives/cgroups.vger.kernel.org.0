Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1E14DA1F
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2020 12:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgA3Lte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Jan 2020 06:49:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37394 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3Ltd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Jan 2020 06:49:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so3886527wmf.2;
        Thu, 30 Jan 2020 03:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0DGyowi/moe2M5f0IvqDhbvcNuqghnLVwAZy+aaGKZo=;
        b=Vsfa910f1mSvF0dngaJb6q7HOcrK4+smQNSgFBc/cwKyzTN3kdiHMpsBO45yi/qlXk
         F4TGT2QX8/6if6Mz5oPRv4Sj9qIyVH6WoPbwysbhowDDdRUlM6WJ/AH3ZZUIT2iYLYH8
         WDYZlpmRX2bZ4wIuaELUCZFAbuvW+rZYnDV0b47J5gGCEbpm7M4UmpbpN7o7F1gk9G/i
         oBbMd7gh/iFg+qG+71LXROJkX2VvTG/CoAI/7+SvJ8USFKjyHvoZRnLfCIdrgfb7HHR9
         BrwckJLkUukAcgE264YjbIGzpuSZwuKtQKkPPiCfduQxUfT5bHmz5Tu00ArsSCFUAhh7
         wZuw==
X-Gm-Message-State: APjAAAXunuao1rd+/MKRcRPXeBc/rF5mxnzj3P43YpVSbMnkEyDvlb1y
        JyX7dNARgChxa2rVc94q5l0=
X-Google-Smtp-Source: APXvYqxZee1npxEwnMuIyR9BDYV6k6uhssSxG1BQ827JfU+Ndamoj69fCOddTJZLsDObVYDFuAsBuA==
X-Received: by 2002:a7b:ce98:: with SMTP id q24mr5057114wmj.41.1580384970443;
        Thu, 30 Jan 2020 03:49:30 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d23sm7056212wra.30.2020.01.30.03.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:49:29 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:49:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/3] mm: memcontrol: fix memory.low proportional
 distribution
Message-ID: <20200130114929.GT24244@dhcp22.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219200718.15696-2-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 19-12-19 15:07:16, Johannes Weiner wrote:
> When memory.low is overcommitted - i.e. the children claim more
> protection than their shared ancestor grants them - the allowance is
> distributed in proportion to how much each sibling uses their own
> declared protection:

Has there ever been any actual explanation why do we care about
overcommitted protection? I have got back to email threads when
the effective hierarchical protection has been proposed.
http://lkml.kernel.org/r/20180320223353.5673-1-guro@fb.com talks about
some "leaf memory cgroups are more valuable than others" which sounds ok
but it doesn't explain why children have to overcommit parent in the
first place. Do we have any other documentation to explain the usecase?

> 
> 	low_usage = min(memory.low, memory.current)
> 	elow = parent_elow * (low_usage / siblings_low_usage)
> 
> However, siblings_low_usage is not the sum of all low_usages. It sums
> up the usages of *only those cgroups that are within their memory.low*
> That means that low_usage can be *bigger* than siblings_low_usage, and
> consequently the total protection afforded to the children can be
> bigger than what the ancestor grants the subtree.
> 
> Consider three groups where two are in excess of their protection:
> 
>   A/memory.low = 10G
>   A/A1/memory.low = 10G, memory.current = 20G
>   A/A2/memory.low = 10G, memory.current = 20G
>   A/A3/memory.low = 10G, memory.current =  8G
>   siblings_low_usage = 8G (only A3 contributes)
> 
>   A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
>   A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(8G) = 12.5G -> 10G
>   A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(8G) = 10.0G
> 
>   (the 12.5G are capped to the explicit memory.low setting of 10G)
> 
> With that, the sum of all awarded protection below A is 30G, when A
> only grants 10G for the entire subtree.
> 
> What does this mean in practice? A1 and A2 would still be in excess of
> their 10G allowance and would be reclaimed, whereas A3 would not. As
> they eventually drop below their protection setting, they would be
> counted in siblings_low_usage again and the error would right itself.
> 
> When reclaim was applied in a binary fashion (cgroup is reclaimed when
> it's above its protection, otherwise it's skipped) this would actually
> work out just fine. However, since 1bc63fb1272b ("mm, memcg: make scan
> aggression always exclude protection"), reclaim pressure is scaled to
> how much a cgroup is above its protection. As a result this
> calculation error unduly skews pressure away from A1 and A2 toward the
> rest of the system.

Just to make sure I fully follow. The overall excess over protection is
38G in your example (for A) while the reclaim would only scan 20G for
this hierarchy until the error starts to fixup because
siblings_low_usage would get back into sync, correct?

> But why did we do it like this in the first place?
> 
> The reasoning behind exempting groups in excess from
> siblings_low_usage was to go after them first during reclaim in an
> overcommitted subtree:
> 
>   A/memory.low = 2G, memory.current = 4G
>   A/A1/memory.low = 3G, memory.current = 2G
>   A/A2/memory.low = 1G, memory.current = 2G
> 
>   siblings_low_usage = 2G (only A1 contributes)
>   A1/elow = parent_elow(2G) * low_usage(2G) / siblings_low_usage(2G) = 2G
>   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G
> 
> While the children combined are overcomitting A and are technically
> both at fault, A2 is actively declaring unprotected memory and we
> would like to reclaim that first.
> 
> However, while this sounds like a noble goal on the face of it, it
> doesn't make much difference in actual memory distribution: Because A
> is overcommitted, reclaim will not stop once A2 gets pushed back to
> within its allowance; we'll have to reclaim A1 either way. The end
> result is still that protection is distributed proportionally, with A1
> getting 3/4 (1.5G) and A2 getting 1/4 (0.5G) of A's allowance.
> 
> [ If A weren't overcommitted, it wouldn't make a difference since each
>   cgroup would just get the protection it declares:
> 
>   A/memory.low = 2G, memory.current = 3G
>   A/A1/memory.low = 1G, memory.current = 1G
>   A/A2/memory.low = 1G, memory.current = 2G
> 
>   With the current calculation:
> 
>   siblings_low_usage = 1G (only A1 contributes)
>   A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G
>   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(1G) = 2G -> 1G
> 
>   Including excess groups in siblings_low_usage:
> 
>   siblings_low_usage = 2G
>   A1/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G
>   A2/elow = parent_elow(2G) * low_usage(1G) / siblings_low_usage(2G) = 1G -> 1G ]
> 
> Simplify the calculation and fix the proportional reclaim bug by
> including excess cgroups in siblings_low_usage.

I think it would be better to also show the initial example with the
overcommitted protection because this is the primary usecase this patch
is targeting in the first place.
   A/memory.low = 10G
   A/A1/memory.low = 10G, memory.current = 20G
   A/A2/memory.low = 10G, memory.current = 20G
   A/A3/memory.low = 10G, memory.current =  8G
   siblings_low_usage = 28G
 
   A1/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
   A2/elow = parent_elow(10G) * low_usage(10G) / siblings_low_usage(28G) = 3.5G
   A3/elow = parent_elow(10G) * low_usage(8G) / siblings_low_usage(28G) = 2.8G

so wrt the global reclaim we have 38G of reclaimable memory with 38G
excess over A's protection. It is true that A3 will get reclaimed way
before A1, A2 reach their protection which might be just good enough to
satisfy the external memory pressure because it is not really likely
that the global pressure would require more than 20G dropped all at
once, right?

That being said I can see the problem with the existing implementation
and how you workaround it. I am still unclear about why should we care
about overcommit on the protection that much and in that light the patch
makes more sense because it doesn't overflow the memory pressure to
outside.
Longer term, though, do we really have to care about this scenario? If
yes, can we have it documented?

Do we want a fixes tag here? There are two changes that need to be
applied together to have a visible effect.

Fixes: 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
Fixes: 230671533d64 ("mm: memory.low hierarchical behavior")

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c   |  4 +---
>  mm/page_counter.c | 12 ++----------
>  2 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c5b5f74cfd4d..874a0b00f89b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6236,9 +6236,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
>   * elow = min( memory.low, parent->elow * ------------------ ),
>   *                                        siblings_low_usage
>   *
> - *             | memory.current, if memory.current < memory.low
> - * low_usage = |
> - *	       | 0, otherwise.
> + * low_usage = min(memory.low, memory.current)
>   *
>   *
>   * Such definition of the effective memory.low provides the expected
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index de31470655f6..75d53f15f040 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -23,11 +23,7 @@ static void propagate_protected_usage(struct page_counter *c,
>  		return;
>  
>  	if (c->min || atomic_long_read(&c->min_usage)) {
> -		if (usage <= c->min)
> -			protected = usage;
> -		else
> -			protected = 0;
> -
> +		protected = min(usage, c->min);
>  		old_protected = atomic_long_xchg(&c->min_usage, protected);
>  		delta = protected - old_protected;
>  		if (delta)
> @@ -35,11 +31,7 @@ static void propagate_protected_usage(struct page_counter *c,
>  	}
>  
>  	if (c->low || atomic_long_read(&c->low_usage)) {
> -		if (usage <= c->low)
> -			protected = usage;
> -		else
> -			protected = 0;
> -
> +		protected = min(usage, c->low);
>  		old_protected = atomic_long_xchg(&c->low_usage, protected);
>  		delta = protected - old_protected;
>  		if (delta)
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
