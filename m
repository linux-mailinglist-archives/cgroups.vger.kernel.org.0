Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 227F4F92CA
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 15:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKLOg2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 09:36:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfKLOg2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 09:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=briRr4penNer7yCYr1Mz18mrOJd7t7axFykNNy0cVvo=; b=cG9StvAycZrwX1J4Ja3+Z6jYV
        tcfKr2cRY7ZGVp+FomV0iqbUppusSjTls6D/m9+RTPA3fK+wP06Cd6zk+K/aI5h1y0JtPJz7SWyG+
        xXqea+So7oSWXdyBKTz6/m/JsvAo/DBs08+WXR1+fXt3nzcGd/YIt21ot1wGQo+2YyiDITwzOCcse
        Ntkql+CKhptFoHDmTuYq836CaADrp8rPq274uBAd6AjXxdQRaK5z3VjdFXuf2IV+suIqodllLvMGW
        W+6ocEpOYON4EMjkJv4J6ne+duU0fMl4xIPs8F2ggb1NempYKzKSFUnTZggA7BFuq8ufDJO+KQJmd
        6/ozJLeRA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUXHN-0003KB-1E; Tue, 12 Nov 2019 14:36:25 +0000
Date:   Tue, 12 Nov 2019 06:36:24 -0800
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
Message-ID: <20191112143624.GA7934@bombadil.infradead.org>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 10:06:24PM +0800, Alex Shi wrote:
> +/* Don't lock again iff page's lruvec locked */
> +static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> +					struct lruvec *locked_lruvec)
> +{
> +	struct pglist_data *pgdat = page_pgdat(page);
> +	struct lruvec *lruvec;
> +
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +
> +	if (locked_lruvec == lruvec) {
> +		rcu_read_unlock();
> +		return lruvec;
> +	}
> +	rcu_read_unlock();

Why not simply:

	rcu_read_lock();
	lruvec = mem_cgroup_page_lruvec(page, pgdat);
	rcu_read_unlock();

	if (locked_lruvec == lruvec)
		return lruvec;

Also, why are you bothering to re-enable interrupts here?  Surely if
you're holding lock A with interrupts disabled , you can just drop lock A,
acquire lock B and leave the interrupts alone.  That way you only need
one of this variety of function, and not the separate irq/irqsave variants.
