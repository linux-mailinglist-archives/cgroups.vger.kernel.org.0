Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE287F92D5
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKLOip (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 09:38:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56854 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbfKLOip (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 09:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TJr4CpD0eqtU9Muj0R5+F4ADnc1Bcgs5f/lnGegH6fY=; b=LvBaEtA8ObLDwTs+cO8119grZ
        vKdfNH/5J48mGoppknvgLSkL6fiB2cW1fxkYmA8fJop7axPcEuUVeurcjtB3xJBK5pnbidyISTaoA
        IM6x5zVCPcMTgxuuq26TOcMRCirfdUTitnIqlGwwh2Pp9SMmNs9XGqbcRhZMRjwWXt7nYjzjDgEfI
        jI1b9beMvWQzUtQnEfn2Mav98rJu5d/z5KMJM491QL0M+i70wAXb0Ju+2L8GGaOdiqIzhivqqa/B1
        gG1KpJrOl6vIP1yv+OsIEwPZ7MgEIGZjzJR0PkJncm7BuntqbVatZqRD7MKhytieHYXb2VGyOFcT9
        XAXpW5F4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUXJd-0003x1-1C; Tue, 12 Nov 2019 14:38:45 +0000
Date:   Tue, 12 Nov 2019 06:38:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 6/8] mm/lru: remove rcu_read_lock to fix performance
 regression
Message-ID: <20191112143844.GB7934@bombadil.infradead.org>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573567588-47048-7-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 12, 2019 at 10:06:26PM +0800, Alex Shi wrote:
> Intel 0day report there are performance regression on this patchset.
> The detailed info points to rcu_read_lock + PROVE_LOCKING which causes
> queued_spin_lock_slowpath waiting too long time to get lock.
> Remove rcu_read_lock is safe here since we had a spinlock hold.

Argh.  You have not sent these patches in a properly reviewable form!
I wasted all that time reviewing the earlier patch in this series only to
find out that you changed it here.  FIX THE PATCH, don't send a fix-patch
on top of it!

> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/memcontrol.h | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2421b720d272..f869897a68f0 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1307,20 +1307,18 @@ static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
>  	struct pglist_data *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> -	rcu_read_lock();
> +	if (!locked_lruvec)
> +		goto lock;
> +
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
> -	if (locked_lruvec == lruvec) {
> -		rcu_read_unlock();
> +	if (locked_lruvec == lruvec)
>  		return lruvec;
> -	}
> -	rcu_read_unlock();
>  
> -	if (locked_lruvec)
> -		spin_unlock_irq(&locked_lruvec->lru_lock);
> +	spin_unlock_irq(&locked_lruvec->lru_lock);
>  
> +lock:
>  	lruvec = lock_page_lruvec_irq(page, pgdat);
> -
>  	return lruvec;
>  }
>  
> @@ -1331,21 +1329,18 @@ static inline struct lruvec *relock_page_lruvec_irqsave(struct page *page,
>  	struct pglist_data *pgdat = page_pgdat(page);
>  	struct lruvec *lruvec;
>  
> -	rcu_read_lock();
> +	if (!locked_lruvec)
> +		goto lock;
> +
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  
> -	if (locked_lruvec == lruvec) {
> -		rcu_read_unlock();
> +	if (locked_lruvec == lruvec)
>  		return lruvec;
> -	}
> -	rcu_read_unlock();
>  
> -	if (locked_lruvec)
> -		spin_unlock_irqrestore(&locked_lruvec->lru_lock,
> -							locked_lruvec->flags);
> +	spin_unlock_irqrestore(&locked_lruvec->lru_lock, locked_lruvec->flags);
>  
> +lock:
>  	lruvec = lock_page_lruvec_irqsave(page, pgdat);
> -
>  	return lruvec;
>  }
>  
> -- 
> 1.8.3.1
> 
> 
