Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7882123A0BD
	for <lists+cgroups@lfdr.de>; Mon,  3 Aug 2020 10:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHCISR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Aug 2020 04:18:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHCISR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 Aug 2020 04:18:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B499FABA2;
        Mon,  3 Aug 2020 08:18:30 +0000 (UTC)
Date:   Mon, 3 Aug 2020 10:18:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove useless check on page->mem_cgroup
Message-ID: <20200803081815.GD5174@dhcp22.suse.cz>
References: <1596166480-22814-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200731151655.GB491801@cmpxchg.org>
 <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9338716f-ca0e-057f-8d94-03e2b3f70281@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 01-08-20 11:58:41, Alex Shi wrote:
> 
> 
> 在 2020/7/31 下午11:16, Johannes Weiner 写道:
> >>  	if (!entry.val) {
> >>  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> > Uncharged readahead pages are gone, but I'm not 100% sure uncharged
> > pages in general are gone. ISTR that the !page->mem_cgroup check in
> > mem_cgroup_uncharge() prevented a crash - although that is of course a
> > much broader interface, whereas the ones you change should only apply
> > to LRU pages (which are hopefully all charged).
> > 
> > Nevertheless, to avoid unnecessary crashes if we discover that we've
> > been wrong, how about leaving the branches for now, but adding a (new)
> > VM_WARN_ON_ONCE_PAGE() to them?

Agreed!

> Right, let's see if other unexcepted things happens, and then do actions.
> So it's the patch:
> 
> >From 28893cf8e55b98665cce58c0ba6d54aeafb63a62 Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Sat, 1 Aug 2020 10:43:55 +0800
> Subject: [PATCH] mm/memcg: warning on !memcg after readahead page charged
> 
> Since readahead page is charged on memcg too, in theory we don't have to
> check this exception now. Before safely remove them all, add a warning
> for the unexpected !memcg.

I would find it useful to mention since when this assumption holds.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmdebug.h |  8 ++++++++
>  mm/memcontrol.c         | 15 ++++++++-------
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 2ad72d2c8cc5..639e98a3384e 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -37,6 +37,13 @@
>  			BUG();						\
>  		}							\
>  	} while (0)
> +#define VM_WARN_ON_ONCE_PAGE(cond, page)				\
> +	do {								\
> +		if (unlikely(cond)) {					\
> +			dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
> +			WARN_ON_ONCE(cond);				\
> +		}							\

This is a bit strange behavior. You dump page for each occasion but warn
only once. I would expect either "once" semantic for any output or just
dump on each occasion because if the whole point is to reduce to amount
of output then the above doesn't serve the purpose.

-- 
Michal Hocko
SUSE Labs
