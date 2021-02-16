Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30A31CF09
	for <lists+cgroups@lfdr.de>; Tue, 16 Feb 2021 18:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBPR3M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Feb 2021 12:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhBPR2r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Feb 2021 12:28:47 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D9C06174A
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 09:28:07 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id b24so7551958qtp.13
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 09:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aj39bprl00uaR4PQZ10YyZf7Ojk1u6xUF8hobhBWb4s=;
        b=ELksuc2ItlzB7BWl2trs4DYSQVkq1eOfCU21Om21ZFjRufw+7yXeDuY8QZ03y9s+Vg
         t9KMsDJX+i72U890Vl/ZqfpZpBEm3DRIeL/uoeXnUYQStpX5tBoiRY1n745UTXa7FPfW
         B8UzHg3sqazyeQ+5wWXsfzuAljhT7mzyrwostbTT7OZgs41ChW7pxJu+zBkwIsUCSqmO
         OvImI9+qd05rLWMHWQX3UVI8RSC4+m2FpQyLF4MyJ9Fb+iMOzZP3ZM4qORmatwMbPZZS
         oD1WpJ1yJFa893vm8TLeyjVH13Im8FT7QBYnwgC3Md50A8QTapaHmQC+4Yc8oJu89AF7
         XrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aj39bprl00uaR4PQZ10YyZf7Ojk1u6xUF8hobhBWb4s=;
        b=XQwFj3OwimiI4BPyWMqavM8oDW0tEyCy/fReoi42HUiWJqwnmBj7BiEs2ao3ZxLSLU
         uTeURf+Qop91Sswdwmsea0FoKF5xX0E+hZJLGsW6hmtLoyBVVckghy8xVzE7xM457svc
         ZvvUwc+S7mESbzEJYDKL98AOeya7E3RLUEhlwhkQRFbXl+CzD3NmsvKxShLf89Osllll
         kUc5yv+A6DK2qqzXC2w6isMTaSmi1g04nd0xvjwl81XKdB8a7qZgUPCHrUtuvJY4FiYM
         qDDbCS1tM2eQOqSAW4XG7Pf5rhfzJX0nQGRzx3hkOLimvoTIvTpwP+nNcYq0UYPrAXbc
         gxVQ==
X-Gm-Message-State: AOAM530YtDXwe3R/Vat+vnjI7jDujho3rbk3p8f0t+BneQ8FdQwAjj1U
        5Lj1OAJcconOJRLHaT97ytpv4g==
X-Google-Smtp-Source: ABdhPJwkc9kQvsGcbpFVdtG0u9K4tqEazXZlgluZHjuGd6/Tdr7SuVONrGHuMzXDeQZTvM+BdSLP0Q==
X-Received: by 2002:ac8:6915:: with SMTP id e21mr13504073qtr.120.1613496486649;
        Tue, 16 Feb 2021 09:28:06 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 18sm13021942qtw.70.2021.02.16.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 09:28:06 -0800 (PST)
Date:   Tue, 16 Feb 2021 12:28:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
Message-ID: <YCwApSWpgOTOZEMx@cmpxchg.org>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com>
 <YCv51LgGIWxVjLHT@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCv51LgGIWxVjLHT@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 16, 2021 at 11:59:01AM -0500, Johannes Weiner wrote:
> Hello Muchun,
> 
> On Sat, Feb 13, 2021 at 01:01:59AM +0800, Muchun Song wrote:
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
> 
> The patch makes sense to me. But this code is a bit tricky, we should
> add more documentation to how it works and what the problem is.
> 
> How about this for the changelog?
> 
> ---
> mm: memcontrol: fix swap undercounting for shared pages in cgroup2

Coming to think of it, this isn't just for shared pages. We also hold
on to the swap slot as long as the page is read-only, not mlocked, and
swap isn't full. So scratch "for shared pages" here.

> When shared pages are swapped in partially, we can have some page
> tables referencing the in-memory page and some referencing the swap
> slot. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
> differently due to the nature of how they account memory and swap:

Correction:

When pages are swapped in, the VM may retain the swap copy to avoid
repeated writes in the future. It's also retained if shared pages are
faulted back in some processes, but not in others. During that time we
have an in-memory copy of the page, as well as an on-swap
copy. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
differently due to the nature of how they account memory and swap:

> Cgroup1 has a unified memory+swap counter that tracks a data page
> regardless whether it's in-core or swapped out. On swapin, we transfer
> the charge from the swap entry to the newly allocated swapcache page,
> even though the swap entry might stick around for a while. That's why
> we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().
> 
> Cgroup2 tracks memory and swap as separate, independent resources and
> thus has split memory and swap counters. On swapin, we charge the
> newly allocated swapcache page as memory, while the swap slot in turn
> must remain charged to the swap counter as long as its allocated too.
> 
> The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
> make swap tracking an integral part of memory control"), because it
> accidentally removed the do_memsw_account() check in the branch inside
> mem_cgroup_uncharge() that was supposed to tell the difference between
> the charge transfer in cgroup1 and the separate counters in cgroup2.
> 
> As a result, cgroup2 currently undercounts consumed swap when shared
> pages are partially swapped back in. This in turn allows a cgroup to
> consume more swap than its configured limit intends.

Correction:

As a result, cgroup2 currently undercounts retained swap to varying
degrees: swap slots are cached up to 50% of the configured limit or
total available swap space; partially faulted back shared pages are
only limited by physical capacity. This in turn allows cgroups to
significantly overconsume their alloted swap space.

> Add the do_memsw_account() check back to fix this problem.
> ---
> 
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

I also think we should tag stable on this one. The potential
accounting error is quite large and, even without concrete examples,
is likely to cause problems for swap management in the real world.

Cc: stable@vger.kernel.org # 5.8+

> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c737c8f05992..be6bc5044150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >  	memcg_check_events(memcg, page);
> >  	local_irq_enable();
> >  
> > -	if (PageSwapCache(page)) {
> > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
> 
> It's more descriptive to use do_memsw_account() here, IMO.
> 
> We should also add a comment. How about this above the branch?
> 
> 	/*
> 	 * Cgroup1's unified memory+swap counter has been charged with the
> 	 * new swapcache page, finish the transfer by uncharging the swap
> 	 * slot. The swap slot would also get uncharged when it dies, but
> 	 * for shared pages it can stick around indefinitely and we'd count
> 	 * the page twice the entire time.

-for shared pages

> 	 * Cgroup2 has separate resource counters for memory and swap,
> 	 * so this is a non-issue here. Memory and swap charge lifetimes
> 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
> 	 * page to memory here, and uncharge swap when the slot is freed.
> 	 */
