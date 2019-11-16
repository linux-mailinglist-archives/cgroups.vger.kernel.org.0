Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 596FEFEA82
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 05:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKPEiP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 23:38:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfKPEiP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Nov 2019 23:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NcGo6y3a7xQQOSK5TngZP8uR7CqYMj91tUhuMqf+9Ns=; b=KJtGujYNRdJwEveOIs3XLtio4
        XHcsmagpcP1yaA2N+7UrIE8V88n7OW4Do7IfTCYeR+d4q8v+G3r8Zir+Cp+wqGKc7HcyXxooyXm1i
        jUE+uYz62ZT+621BjFs/KBU3haXSa51WqN5sxZOr6xU5RH76Y/Sz5sUAwn8r5wYzwdM5mfHtQUUs2
        ZrfmLVkLLS3h61l7VCJuzpkz68DUwA0bDfpS9kSDMtYs2EMRC5HTkOW19cMl/t9SIEyiGCRFhHR5D
        Twd3LrtrHICHuFYKljsa+iVV+hFFYEI2DXYCf/BJPck0X727I4xYwpczptlMf5e6Dk3CiwXvaYxO3
        s/HDUXKow==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVpqY-00079E-6F; Sat, 16 Nov 2019 04:38:06 +0000
Date:   Fri, 15 Nov 2019 20:38:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191116043806.GD20752@bombadil.infradead.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
> This is the main patch to replace per node lru_lock with per memcg
> lruvec lock. It also fold the irqsave flags into lruvec.

I have to say, I don't love the part where we fold the irqsave flags
into the lruvec.  I know it saves us an argument, but it opens up the
possibility of mismatched expectations.  eg we currently have:

static void __split_huge_page(struct page *page, struct list_head *list,
			struct lruvec *lruvec, pgoff_t end)
{
...
	spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);

so if we introduce a new caller, we have to be certain that this caller
is also using lock_page_lruvec_irqsave() and not lock_page_lruvec_irq().
I can't think of a way to make the compiler enforce that, and if we don't,
then we can get some odd crashes with interrupts being unexpectedly
enabled or disabled, depending on how ->irqflags was used last.

So it makes the code more subtle.  And that's not a good thing.

> +static inline struct lruvec *lock_page_lruvec_irq(struct page *page,
> +						struct pglist_data *pgdat)
> +{
> +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
> +	spin_lock_irq(&lruvec->lru_lock);
> +
> +	return lruvec;
> +}

...

> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>  {
>  	pg_data_t *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec = lock_page_lruvec_irq(page, pgdat);
>  
> -	spin_lock_irq(&pgdat->lru_lock);
>  	if (PageLRU(page)) {
> -		struct lruvec *lruvec;
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		ClearPageLRU(page);
>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>  		*isolated = 1;
>  	} else
>  		*isolated = 0;
> +
> +	return lruvec;
>  }

But what if the page is !PageLRU?  What lruvec did we just lock?
According to the comments on mem_cgroup_page_lruvec(),

 * This function is only safe when following the LRU page isolation
 * and putback protocol: the LRU lock must be held, and the page must
 * either be PageLRU() or the caller must have isolated/allocated it.

and now it's being called in order to find out which LRU lock to take.
So this comment needs to be updated, if it's wrong, or this patch has
a race.

