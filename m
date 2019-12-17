Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0D091221E8
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 03:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfLQCQV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Dec 2019 21:16:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfLQCQV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Dec 2019 21:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=siGlAtwbpMtn2+e/O7hKM+nw0EWpzij1iF2dGkh6S28=; b=fMahm2K5a4Q9AU7WAk02csbb8w
        kPQUQkYGI1oxLG13qBOQYj40/hcOw6UrbIKgqlWAymUgbivUWBlJBr0EBJQYEtGKsLM8iyozgPkhR
        FPjoylR+LfIYOO09S4gFDvvCUKRYE/fh7bNn6HwUfg9TmcvJAjXXkTRfLfGT0whTBbTyUtZUxfZag
        +0zeiBvJK7mPFXM2IspiWLrfiiZq7641o5OVTZLszsOX8JG98YfVlKnY82iYtBwOt/maBbZGdzFdP
        e1qJxVzjYr8raPVoeo/pMmCTp9aG32t41zTdk8q0B6hkXf3iUmfVdwvYGFDRVoEXOHUOfvmsgjjNm
        v/67Uo4A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih2PF-0007pq-5W; Tue, 17 Dec 2019 02:16:13 +0000
Date:   Mon, 16 Dec 2019 18:16:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: [PATCH v6 02/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191217021613.GB32169@bombadil.infradead.org>
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
 <1576488386-32544-3-git-send-email-alex.shi@linux.alibaba.com>
 <20191216121427.GZ32169@bombadil.infradead.org>
 <286c11c2-480f-37d6-e9fe-91822f862cd6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <286c11c2-480f-37d6-e9fe-91822f862cd6@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 17, 2019 at 09:30:13AM +0800, Alex Shi wrote:
> 在 2019/12/16 下午8:14, Matthew Wilcox 写道:
> > On Mon, Dec 16, 2019 at 05:26:18PM +0800, Alex Shi wrote:
> >> -static void lock_page_lru(struct page *page, int *isolated)
> >> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
> >>  {
> >> -	pg_data_t *pgdat = page_pgdat(page);
> >> +	struct lruvec *lruvec = lock_page_lruvec_irq(page);
> >>  
> >> -	spin_lock_irq(&pgdat->lru_lock);
> >>  	if (PageLRU(page)) {
> >> -		struct lruvec *lruvec;
> >>  
> >> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >>  		ClearPageLRU(page);
> >>  		del_page_from_lru_list(page, lruvec, page_lru(page));
> >>  		*isolated = 1;
> >>  	} else
> >>  		*isolated = 0;
> >> +
> >> +	return lruvec;
> >>  }
> > 
> > You still didn't fix this function.  Go back and look at my comment from
> > the last time you sent this patch set.
> > 
> 
> Sorry for the misunderstanding. I guess what your want is fold the patch 9th into this, is that right?
> Any comments for the 9th patch?

I didn't get as far as looking at the ninth patch because I saw this
one was wrong and stopped looking.  This is not the first time *with
this patch set* that you've been told to *fix the patch*, not submit
something that's broken and fix it in a later patch.

I'll look at patch 9 later.
