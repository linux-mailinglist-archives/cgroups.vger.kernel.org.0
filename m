Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F099F31CE8F
	for <lists+cgroups@lfdr.de>; Tue, 16 Feb 2021 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhBPQ7p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Feb 2021 11:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhBPQ7m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Feb 2021 11:59:42 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD4C061574
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 08:59:02 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b14so10082755qkk.0
        for <cgroups@vger.kernel.org>; Tue, 16 Feb 2021 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Sbc+/7yHkx+7SnjvZzsa9ETiyUzFfwyyH3lcCN73/I=;
        b=QcYThMMEVLZEm7VRmsM12lMG8ZDFYS88jVBFd9Z67UWfpdmyePvN+QkKDAKq3kRSIH
         dT4jdVZPlMZPWZg0Llj4TOx6NJWY0qbNUcZsx5ciWu7MNSKKlK4y4wXs0KmwHZZGjHFt
         DLwXH+6VOSHgIPGNOVUJPLSqiiXkqe62CQYLohD4C8Ojp89gxsduXZpeeyr404CO/cwm
         /btydGUcbGStYIzkl/TPAGiZTGJbhC5KYmqo3pe/CabYp0YnhLT8nLeX4MR7qc5/yscQ
         YFbDP8zkkOL/UrZSrJpS5A/Jlc+/mgT+srW/uf4YPa9qIbeiSpupCbcbdQQoD8ITU4sW
         4jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Sbc+/7yHkx+7SnjvZzsa9ETiyUzFfwyyH3lcCN73/I=;
        b=Z8zdAARHdxIO/90hma6Tz+EetY1+E+1B76yHgj07QRd4i17+JAYtwYXL5Ipbu6ylyS
         Fy1m4odTPJJ1OtzVJUE8irKm5CBLgWU5pEqrpuQEA5KvdlIBnbjrr3AHLtcbacFjOWon
         4sg+tTS732dlivGaq/27HDj8R61MRkfLoAG3QvgAA6CW2w7oHHqPxeb0jcblWzNVIUy1
         9iTo8XtkzyWwMyULWuK2xC56wDtF/teTDpU19yVQrOuno15C9aX1tp99HVSzcfbH+IFf
         dB/0qLh6H2uin4BYuXuC/YDXwKFTFHMhjlp/KjHRP2c3jpitCNnbPuerhGPHJOz5j1FD
         vyRA==
X-Gm-Message-State: AOAM530K8bporlVVXbazgdsIKDa77Kss3Zith7II8n2RAg20CZUrl3Pb
        gv9ALK1iCEE30LW3W1I1WgI1Sw==
X-Google-Smtp-Source: ABdhPJxC5HWoRm7IEnPC6r53eTdFdTHnW0AZjQk6Jc2GQkHX3Cxml4Hkq9oeYehom45Pg7eqqCwSWg==
X-Received: by 2002:a05:620a:148c:: with SMTP id w12mr18486430qkj.186.1613494741630;
        Tue, 16 Feb 2021 08:59:01 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q12sm7798492qki.91.2021.02.16.08.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:59:00 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:59:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
Message-ID: <YCv51LgGIWxVjLHT@cmpxchg.org>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212170159.32153-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Muchun,

On Sat, Feb 13, 2021 at 01:01:59AM +0800, Muchun Song wrote:
> The swap charges the actual number of swap entries on cgroup v2.
> If a swap cache page is charged successful, and then we uncharge
> the swap counter. It is wrong on cgroup v2. Because the swap
> entry is not freed.

The patch makes sense to me. But this code is a bit tricky, we should
add more documentation to how it works and what the problem is.

How about this for the changelog?

---
mm: memcontrol: fix swap undercounting for shared pages in cgroup2

When shared pages are swapped in partially, we can have some page
tables referencing the in-memory page and some referencing the swap
slot. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
differently due to the nature of how they account memory and swap:

Cgroup1 has a unified memory+swap counter that tracks a data page
regardless whether it's in-core or swapped out. On swapin, we transfer
the charge from the swap entry to the newly allocated swapcache page,
even though the swap entry might stick around for a while. That's why
we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().

Cgroup2 tracks memory and swap as separate, independent resources and
thus has split memory and swap counters. On swapin, we charge the
newly allocated swapcache page as memory, while the swap slot in turn
must remain charged to the swap counter as long as its allocated too.

The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
make swap tracking an integral part of memory control"), because it
accidentally removed the do_memsw_account() check in the branch inside
mem_cgroup_uncharge() that was supposed to tell the difference between
the charge transfer in cgroup1 and the separate counters in cgroup2.

As a result, cgroup2 currently undercounts consumed swap when shared
pages are partially swapped back in. This in turn allows a cgroup to
consume more swap than its configured limit intends.

Add the do_memsw_account() check back to fix this problem.
---

> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c737c8f05992..be6bc5044150 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>  	memcg_check_events(memcg, page);
>  	local_irq_enable();
>  
> -	if (PageSwapCache(page)) {
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {

It's more descriptive to use do_memsw_account() here, IMO.

We should also add a comment. How about this above the branch?

	/*
	 * Cgroup1's unified memory+swap counter has been charged with the
	 * new swapcache page, finish the transfer by uncharging the swap
	 * slot. The swap slot would also get uncharged when it dies, but
	 * for shared pages it can stick around indefinitely and we'd count
	 * the page twice the entire time.
	 *
	 * Cgroup2 has separate resource counters for memory and swap,
	 * so this is a non-issue here. Memory and swap charge lifetimes
	 * correspond 1:1 to page and swap slot lifetimes: we charge the
	 * page to memory here, and uncharge swap when the slot is freed.
	 */
