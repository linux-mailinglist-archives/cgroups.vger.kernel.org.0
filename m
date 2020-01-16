Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6E13FBBA
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 22:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgAPVw2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jan 2020 16:52:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbgAPVw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jan 2020 16:52:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id w30so20171757qtd.12
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2020 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1EPeaAWRHa3RqqVLE9V4P9RIEcd6DQc7GzxP/f3LSY8=;
        b=pvoJqtb58UypA494k7e14Z/xF8dKTjCFQB5xrlRUEpMWeAvPGdidXZ3yHaXcT0YpKu
         v2V/e0BD9I8DY8puJ2BDqEqX1ja8rDobR9dLaheJPHxT4kHLBYfzbLa9mzRR5IUwpF8g
         Q3by2hhrdMs233i0rjpLcHSobd+mwy1pPHZHrnJWx5YXCTRCp8TXO7RO25gKDbg3XCFT
         37sWyUI7eYw7asc4Ydg04fWVmbfWhMhPsx1G83m87eBEjno02m/tQ8faZ8RAWUixevG8
         Kbsg6XSwa/9JLxJDte8JUiODB4Puy4/a3z0aYgt9LotNGmjGkAupnUIL+b4bgLewYoAe
         hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1EPeaAWRHa3RqqVLE9V4P9RIEcd6DQc7GzxP/f3LSY8=;
        b=gxMt0MEnqyBPVVZUtR3qFgWw495VVs4G4xDjgXLWzhgMs1o1KaYb3o2TUiRNWoM+jp
         fC1aWbkOe3FmrTJr2FCuhg53SG7GWoB0hsCNTPfWbrDWVkfGyuS2eoqDU/3owds3bFZg
         VNQ1qq860XSf2lVIF9xSUxj7zp5G1oheojPlzkzSgLTvcU0Ga2TDIybFDvzD+g2v0FlV
         6fFUL5LSQjKsQyOmmgm8gAxfkVI4S2KL//FVdG5o81dFY/kN8U3WlrgVaLqe93ms7c3l
         lzyOfwNIu4jL5tYQzzqm5KQfk15svRtMTiJgNYSKDlLfnn0JSVYwiigDo1w+ZI9MKwKN
         /qng==
X-Gm-Message-State: APjAAAXBTSA5jJqvHBvPei8IqwYipK908xXGfiYQydW1jFHwYPneP4t9
        v+PFnNyPkc1I1RkJ6dSjatB+4w==
X-Google-Smtp-Source: APXvYqwdiK5kPAwKKwtquFeHOhHDxJ/ciVj0Toj/HU7dSRU5hDED+afwb10tRc0rfRHmciYc+V3+fg==
X-Received: by 2002:ac8:4050:: with SMTP id j16mr4499483qtl.171.1579211545067;
        Thu, 16 Jan 2020 13:52:25 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id h1sm12179841qte.42.2020.01.16.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:52:23 -0800 (PST)
Date:   Thu, 16 Jan 2020 16:52:22 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200116215222.GA64230@cmpxchg.org>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 16, 2020 at 11:05:02AM +0800, Alex Shi wrote:
> @@ -948,10 +956,20 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  		if (!(cc->gfp_mask & __GFP_FS) && page_mapping(page))
>  			goto isolate_fail;
>  
> +		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
>  		/* If we already hold the lock, we can skip some rechecking */
> -		if (!locked) {
> -			locked = compact_lock_irqsave(&pgdat->lru_lock,
> -								&flags, cc);
> +		if (lruvec != locked_lruvec) {
> +			struct mem_cgroup *memcg = lock_page_memcg(page);
> +
> +			if (locked_lruvec) {
> +				unlock_page_lruvec_irqrestore(locked_lruvec, flags);
> +				locked_lruvec = NULL;
> +			}
> +			/* reget lruvec with a locked memcg */
> +			lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
> +			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> +			locked_lruvec = lruvec;
>  
>  			/* Try get exclusive access under lock */
>  			if (!skip_updated) {

In a previous review, I pointed out the following race condition
between page charging and compaction:

compaction:				generic_file_buffered_read:

					page_cache_alloc()

!PageBuddy()

lock_page_lruvec(page)
  lruvec = mem_cgroup_page_lruvec()
  spin_lock(&lruvec->lru_lock)
  if lruvec != mem_cgroup_page_lruvec()
    goto again

					add_to_page_cache_lru()
					  mem_cgroup_commit_charge()
					    page->mem_cgroup = foo
					  lru_cache_add()
					    __pagevec_lru_add()
					      SetPageLRU()

if PageLRU(page):
  __isolate_lru_page()

As far as I can see, you have not addressed this. You have added
lock_page_memcg(), but that prevents charged pages from moving between
cgroups, it does not prevent newly allocated pages from being charged.

It doesn't matter how many times you check the lruvec before and after
locking - if you're looking at a free page, it might get allocated,
charged and put on a new lruvec after you're done checking, and then
you isolate a page from an unlocked lruvec.

You simply cannot serialize on page->mem_cgroup->lruvec when
page->mem_cgroup isn't stable. You need to serialize on the page
itself, one way or another, to make this work.


So here is a crazy idea that may be worth exploring:

Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
linked list.

Can we make PageLRU atomic and use it to stabilize the lru_lock
instead, and then use the lru_lock only serialize list operations?

I.e. in compaction, you'd do

	if (!TestClearPageLRU(page))
		goto isolate_fail;
	/*
	 * We isolated the page's LRU state and thereby locked out all
	 * other isolators, including cgroup page moving, page reclaim,
	 * page freeing etc. That means page->mem_cgroup is now stable
	 * and we can safely look up the correct lruvec and take the
	 * page off its physical LRU list.
	 */
	lruvec = mem_cgroup_page_lruvec(page);
	spin_lock_irq(&lruvec->lru_lock);
	del_page_from_lru_list(page, lruvec, page_lru(page));

Putback would mostly remain the same (although you could take the
PageLRU setting out of the list update locked section, as long as it's
set after the page is physically linked):

	/* LRU isolation pins page->mem_cgroup */
	lruvec = mem_cgroup_page_lruvec(page)
	spin_lock_irq(&lruvec->lru_lock);
	add_page_to_lru_list(...);
	spin_unlock_irq(&lruvec->lru_lock);

	SetPageLRU(page);

And you'd have to carefully review and rework other sites that rely on
PageLRU: reclaim, __page_cache_release(), __activate_page() etc.

Especially things like activate_page(), which used to only check
PageLRU to shuffle the page on the LRU list would now have to briefly
clear PageLRU and then set it again afterwards.

However, aside from a bit more churn in those cases, and the
unfortunate additional atomic operations, I currently can't think of a
fundamental reason why this wouldn't work.

Hugh, what do you think?
