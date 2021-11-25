Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6145D7E6
	for <lists+cgroups@lfdr.de>; Thu, 25 Nov 2021 11:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhKYKGP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Nov 2021 05:06:15 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57502 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352062AbhKYKEP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Nov 2021 05:04:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1F71D1FDF1;
        Thu, 25 Nov 2021 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637834463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDao5Uj7VLYykb6Y3tp26FDvmlB7o30IJq32LNzDcvE=;
        b=cF5qiPge3nbtLonjszirVVzAfOOf80TJ8jd4mY6IAGrw/kuhRAdNhpQSn3WTIr/gmR+k6K
        fWy4f7hFcQKtaEnz30Le2tFiraB5d296//9j4p8zXpXKe6jEqDJFutqjOP2hKb9nEXx2VG
        w6pjkdVPw7GzfEqlsNX3UZ+NKwznq0o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C4469A3B8A;
        Thu, 25 Nov 2021 10:01:02 +0000 (UTC)
Date:   Thu, 25 Nov 2021 11:01:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
References: <20211124151915.GA6163@haolee.io>
 <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125080238.GA7356@haolee.io>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 25-11-21 08:02:38, Hao Lee wrote:
> On Thu, Nov 25, 2021 at 03:30:44AM +0000, Matthew Wilcox wrote:
> > On Thu, Nov 25, 2021 at 11:24:02AM +0800, Hao Lee wrote:
> > > On Thu, Nov 25, 2021 at 12:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > We do batch currently so no single task should be
> > > > able to monopolize the cpu for too long. Why this is not sufficient?
> > > 
> > > uncharge and unref indeed take advantage of the batch process, but
> > > del_from_lru needs more time to complete. Several tasks will contend
> > > spinlock in the loop if nr is very large.
> > 
> > Is SWAP_CLUSTER_MAX too large?  Or does your architecture's spinlock
> > implementation need to be fixed?
> > 
> 
> My testing server is x86_64 with 5.16-rc2. The spinlock should be normal.
> 
> I think lock_batch is not the point. lock_batch only break spinning time
> into small parts, but it doesn't reduce spinning time. The thing may get
> worse if lock_batch is very small.
> 
> Here is an example about two tasks contending spinlock. Let's assume each
> task need a total of 4 seconds in critical section to complete its work.
> 
> Example1:
> 
> lock_batch = x
> 
> task A      taskB
> hold 4s     wait 4s
>             hold 4s
> 
> total waiting time is 4s.

4s holding time is _way_ too long and something that this path should
never really reach. We are talking about SWAP_CLUSTER_MAX worth of LRU
pages. Sure there might be a bunch of pages freed that are not on LRU
but those are only added to a list. So again what is the actual problem?

[...]

> If cond_reched() will break the task fairness, the only way I can think
> of is doing uncharge and unref if the current task can't get the
> spinlock. This will reduce the wasted cpu cycles, although the
> performance gain is still small (about 4%). However, this way will hurt
> batch processing in uncharge(). Maybe there exist a better way...
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index e8c9dc6d0377..8a947f8d0aaa 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -960,8 +960,16 @@ void release_pages(struct page **pages, int nr)
>  		if (PageLRU(page)) {
>  			struct lruvec *prev_lruvec = lruvec;
>  
> -			lruvec = folio_lruvec_relock_irqsave(folio, lruvec,
> +			lruvec = folio_lruvec_tryrelock_irqsave(folio, lruvec,
>  									&flags);
> +			if (!lruvec) {
> +				mem_cgroup_uncharge_list(&pages_to_free);
> +				free_unref_page_list(&pages_to_free);
> +				INIT_LIST_HEAD(&pages_to_free);
> +				lruvec = folio_lruvec_relock_irqsave(folio,
> +							lruvec, &flags);
> +			}
> +
>  			if (prev_lruvec != lruvec)
>  				lock_batch = 0;

Aren't you sacrificing one batching over the other and the net result
will really depend on particullar workload. This will effectivelly throw
away any lruvec batching out of window in presence of contention even if
there are no pages to be freed (or only very few of them).

TBH I really have hard time to see how 32 LRU pages handling in a single
lock batch can be harmfull. Maybe if there are gazillions of non-lru
pages where holding the lock is clearly pointless but that shouldn't
really happen most of the time.
-- 
Michal Hocko
SUSE Labs
