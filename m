Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2270127356C
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgIUWDa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgIUWDa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 18:03:30 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F51C0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 15:03:29 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r10so3657834oor.5
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=i9wIfsv5rz4rfrgx+xfjmFTxPq64qmLCQPg3J+waEbE=;
        b=DdepaFHP5SGw8u3Jxxrft7G4MFxCoXyObylHPKbacrL+cHB16NaAJhD5pIbYyNVpQd
         Klaaxa9m+XOEu8WCDI2BGJEh9xJjFu6wVMkxYCQs/wHlhajC7H1OK0C8z3pKFLSUutfo
         /O7veoCMTReFJMDGKLzCE0pM1GtuT8DTXG6yGto0omKozwErUb6rkpUMzjHeaV+XrD0t
         iAJga/vtnJp+LqFmK+3cqp4Jaa+9OIekQDdDnAxNz5daBoxRoUmhzN96QuWg4gkx+svY
         3JdEGi8JFhwQzUsY/o2RfnpeJ3ffX8rby7q+sqiHf2n3DKWczyN8EYsw8pxVOvxpV03m
         UyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=i9wIfsv5rz4rfrgx+xfjmFTxPq64qmLCQPg3J+waEbE=;
        b=Yz0gdVBgquDaqN3ikde/lnr8ROxWzaJO0FbWagibiK+XrxieOszkIK8Xli3F0Hopze
         TpTvJqbxLeViDBi/tQaplQ0wI9HQAPtefTGx8hx0AsN4GX9IB2kuA1rGkQxDf6ezAwJ3
         V8YFI0dfMJO0giZTy7N4B0y20hsXRsE/sKrSoaeddf3zFaAgG7s2k5eSmGPTQGBwXxwZ
         mNI4oCNKS3y17l120QsKKWzFvx9oJzTqTcLn2mOpGYC/bjPN3Q/3dd9HMzzt/h/KFO5v
         9Z42Rn+dEmRveph+7mqhDpwUfCIOATQl8oZ0gF/dabSgye2UvBvUpIPJoip6aX4TWPK6
         /7+w==
X-Gm-Message-State: AOAM530p9WelGKIBjjQXRyMWMRyYPoMeYu2glZkr6D4kYLGpcNREs4ri
        5GjE1HwcpujV/h9xy6+2Ivm8Kg==
X-Google-Smtp-Source: ABdhPJzeWJ4rwPj2Cwauo8tZscTlT1Kyhg81tkk759dQqFBpbkcFmtijVxaaNg1MA8kUUBfkJNG63Q==
X-Received: by 2002:a4a:bc90:: with SMTP id m16mr1015628oop.12.1600725808483;
        Mon, 21 Sep 2020 15:03:28 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b14sm452685oii.52.2020.09.21.15.03.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 15:03:27 -0700 (PDT)
Date:   Mon, 21 Sep 2020 15:03:24 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: Re: [PATCH v18 15/32] mm/lru: move lock into lru_note_cost
In-Reply-To: <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2009211440570.5214@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-16-git-send-email-alex.shi@linux.alibaba.com> <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 21 Sep 2020, Hugh Dickins wrote:
> On Mon, 24 Aug 2020, Alex Shi wrote:
> 
> > We have to move lru_lock into lru_note_cost, since it cycle up on memcg
> > tree, for future per lruvec lru_lock replace. It's a bit ugly and may
> > cost a bit more locking, but benefit from multiple memcg locking could
> > cover the lost.
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> In your lruv19 github tree, you have merged 14/32 into this one: thanks.

Grr, I've only just started, and already missed some of my notes.

I wanted to point out that this patch does introduce an extra unlock+lock
in shrink_inactive_list(), even in a !CONFIG_MEMCG build.  I think you've
done the right thing for now, keeping it simple, and maybe nobody will
notice the extra overhead; but I expect us to replace lru_note_cost()
by lru_note_cost_unlock_irq() later on, expecting the caller to do the
initial lock_irq().

lru_note_cost_page() looks redundant to me, but you're right not to
delete it here, unless Johannes asks you to add that in: that's his
business, and it may be dependent on the XXX at its callsite.

> 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/swap.c   | 5 +++--
> >  mm/vmscan.c | 4 +---
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 906255db6006..f80ccd6f3cb4 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -269,7 +269,9 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
> >  {
> >  	do {
> >  		unsigned long lrusize;
> > +		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >  
> > +		spin_lock_irq(&pgdat->lru_lock);
> >  		/* Record cost event */
> >  		if (file)
> >  			lruvec->file_cost += nr_pages;
> > @@ -293,15 +295,14 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
> >  			lruvec->file_cost /= 2;
> >  			lruvec->anon_cost /= 2;
> >  		}
> > +		spin_unlock_irq(&pgdat->lru_lock);
> >  	} while ((lruvec = parent_lruvec(lruvec)));
> >  }
> >  
> >  void lru_note_cost_page(struct page *page)
> >  {
> > -	spin_lock_irq(&page_pgdat(page)->lru_lock);
> >  	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
> >  		      page_is_file_lru(page), thp_nr_pages(page));
> > -	spin_unlock_irq(&page_pgdat(page)->lru_lock);
> >  }
> >  
> >  static void __activate_page(struct page *page, struct lruvec *lruvec)
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index ffccb94defaf..7b7b36bd1448 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1971,19 +1971,17 @@ static int current_may_throttle(void)
> >  				&stat, false);
> >  
> >  	spin_lock_irq(&pgdat->lru_lock);
> > -
> >  	move_pages_to_lru(lruvec, &page_list);
> >  
> >  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> > -	lru_note_cost(lruvec, file, stat.nr_pageout);
> >  	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> >  	if (!cgroup_reclaim(sc))
> >  		__count_vm_events(item, nr_reclaimed);
> >  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
> >  	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> > -
> >  	spin_unlock_irq(&pgdat->lru_lock);
> >  
> > +	lru_note_cost(lruvec, file, stat.nr_pageout);
> >  	mem_cgroup_uncharge_list(&page_list);
> >  	free_unref_page_list(&page_list);
> >  
> > -- 
> > 1.8.3.1
> > 
> > 
> 
