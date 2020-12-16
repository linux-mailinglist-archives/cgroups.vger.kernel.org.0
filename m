Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C22DBBFD
	for <lists+cgroups@lfdr.de>; Wed, 16 Dec 2020 08:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgLPHfx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 02:35:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPHfx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 16 Dec 2020 02:35:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608104106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i6r+QjOa5VJLHtoN/qARO5iLDlJY4rWyvupxvYJjs5Y=;
        b=rLc88kV0JCaUwwc1S8gEYimH+HZ87tj2RbeJO9Yr8OLBWHAWZ5UOAoP+6zSwYAqpdsdkpj
        H1YRTgtbGNnv8Qb7momflhyYN3BVTWpgZXHZWSSsBkrexT6cedC+PPvP7mQ5+7EkwhqziU
        ZayQBENXMHFX+7lhBelNshlmACiJrms=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22244ACF1;
        Wed, 16 Dec 2020 07:35:06 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:35:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: remove the unnecessary rcu_read_[un]lock
Message-ID: <20201216073505.GQ32193@dhcp22.suse.cz>
References: <20201216055213.GA63520@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216055213.GA63520@rlk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 16-12-20 13:52:13, Hui Su wrote:
> the rcu_read_lock and rcu_read_unlock is unnecessary in:
> 	lock_page_lruvec()
> 	lock_page_lruvec_irq()
> 	lock_page_lruvec_irqsave()

Please add an explanation why it is unnecessary.

> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/memcontrol.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e3c7ca7dc174..a19f820e8a3f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1396,10 +1396,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1411,10 +1409,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irq(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1426,10 +1422,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs
