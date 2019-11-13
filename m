Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F529FB1A7
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2019 14:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfKMNpG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Nov 2019 08:45:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfKMNpG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Nov 2019 08:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zRi6DLbBkEdEozkjZm98oVK/x7aADkM+iJVk1EnTFWk=; b=eLUpbLpu+7Mqv1XqZbOAstW1Xr
        s3S9M4qabuNrKeHjr+aMtQQTUqyJI+s3ZAcWxGGHoOLFIGkzrOpj7FV2i53sWElgDVbC8aR6ahCw4
        RBdV5TnpKLElNuiyfEOEHdptZ1Paw4v6/YHhRda6W3KlU4ay0toajZfXkccooGszCUXu/yLxgAaC/
        pFK9jKjJHT0Yqv57ZjYInT11Yq0q2yNowES80QxjYTVAK0ETrYGnpDUU1t5IkbFEWy6JC/g55VRZ8
        Y+YCQRbkdtBuG2DTLd8Fj+26ap7yNVh1HvvGzY2S79eh+sc42JHFGRS0kewhOnmDsZICEEYfZx3N+
        TuByAZvw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUsxC-0003wY-TT; Wed, 13 Nov 2019 13:45:02 +0000
Date:   Wed, 13 Nov 2019 05:45:02 -0800
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
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 4/8] mm/lru: only change the lru_lock iff page's
 lruvec is different
Message-ID: <20191113134502.GD7934@bombadil.infradead.org>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143624.GA7934@bombadil.infradead.org>
 <297ad71c-081c-f7e1-d640-8720a0eeeeba@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297ad71c-081c-f7e1-d640-8720a0eeeeba@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 13, 2019 at 10:26:24AM +0800, Alex Shi wrote:
> 在 2019/11/12 下午10:36, Matthew Wilcox 写道:
> > On Tue, Nov 12, 2019 at 10:06:24PM +0800, Alex Shi wrote:
> >> +/* Don't lock again iff page's lruvec locked */
> >> +static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> >> +					struct lruvec *locked_lruvec)
> >> +{
> >> +	struct pglist_data *pgdat = page_pgdat(page);
> >> +	struct lruvec *lruvec;
> >> +
> >> +	rcu_read_lock();
> >> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >> +
> >> +	if (locked_lruvec == lruvec) {
> >> +		rcu_read_unlock();
> >> +		return lruvec;
> >> +	}
> >> +	rcu_read_unlock();
> > 
> > Why not simply:
> > 
> > 	rcu_read_lock();
> > 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > 	rcu_read_unlock();
> > 
> > 	if (locked_lruvec == lruvec)
> 
> The rcu_read_unlock here is for guarding the locked_lruvec/lruvec comparsion.
> Otherwise memcg/lruvec maybe changed, like, from memcg migration etc. I guess.

How does holding the RCU lock guard the comparison?  You're comparing two
pointers for equality.  Nothing any other CPU can do at this point will
change the results of that comparison.

> > Also, why are you bothering to re-enable interrupts here?  Surely if
> > you're holding lock A with interrupts disabled , you can just drop lock A,
> > acquire lock B and leave the interrupts alone.  That way you only need
> > one of this variety of function, and not the separate irq/irqsave variants.
> > 
> 
> Thanks for the suggestion! Yes, if only do re-lock, it's better to leave the irq unchanging. but, when the locked_lruvec is NULL, it become a first time lock which irq or irqsave are different. Thus, in combined function we need a nother parameter to indicate if it do irqsaving. So comparing to a extra/indistinct parameter, I guess 2 inline functions would be a bit more simple/cleary? 

Ah, right, I missed the "if it's not held" case.
