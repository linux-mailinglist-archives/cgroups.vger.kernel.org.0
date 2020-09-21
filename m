Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044032734FA
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 23:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIUVhJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 17:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgIUVhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 17:37:09 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD1C061755
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 14:37:09 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n61so13720334ota.10
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 14:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=YEHhXiwYGhR5s4kQG6zgTm8dChdzwLCMqEBAcwVay/I=;
        b=FHdmoZMn2GtG6M6npCvulWXP2W6zbv9j1/3z4NpqqPF4CZZIAljfJOMpLr/AU2uRnh
         MLdveaSRjUzPSvkKU/DlErd+prAWEQjXExuohssIxy9UltoW3ysPdWIcSIUp4LyWW1Jw
         f9iXMdTfFs8PZRMKMKNmrEqTZxqpk0pSNflZqnROIW4x8CU5+zxWAyPrd0JTK2S8usf5
         cPqbz7Dc5xC0sbOIcjVCnLcaK19VJiXht1ypF+z6GM1rUOhGT94Xfp0glBhXVfcUjwkE
         e+DCEVKAkYABqQqwtM6XQipNbujsVCq/177MSRg4OGLiC12Cy+yZJVoAvFcWKn21ctnh
         nh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=YEHhXiwYGhR5s4kQG6zgTm8dChdzwLCMqEBAcwVay/I=;
        b=NFoNPUQ9exWUtAVv6b3m7UQWeu2QQv9f57hTvrZ6VSZVQLXzx19CYSrtNBJ5N+FqlE
         aqf6H4EOopbiN3bV0Ve/CkujwDGh45ldIzsTdJof7A0k3qNkuNBy9RGgRQmFJ0BSz1rb
         VBihwFgLjKoZuG7d1T4/R8wQsdmyRRtvFA5reS5Wfv2E5z9MqvWGKkKRRZHllqDU9oZO
         3xRMF2jnaT8tiSsZ4AxSKaLDbR4WoA/+MAuC1E11llIUgBWawpUldu5Vt2prCthcmyWn
         uo5lHx0H5eg/daB+55dFIrXu9KfvDLIr4RewdgIy1c5d3SUrhbIWaI/uy6gvKTHRbI0P
         0r5g==
X-Gm-Message-State: AOAM531pgpA6o/tBrLphB1vkjBeuPYXeekFWDfmZomFXE5S64T51Mm07
        Wvb8gfPqkf1WmhOqpMg3pFzyZA==
X-Google-Smtp-Source: ABdhPJw3dJbOp8ktACPzr4lIDA10Ki7bwAn+SWgjbJ9QhO4ybGwe635VGxBCg0DmOLYWn9JLX87owg==
X-Received: by 2002:a05:6830:2104:: with SMTP id i4mr946818otc.266.1600724228018;
        Mon, 21 Sep 2020 14:37:08 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a20sm7573611oos.13.2020.09.21.14.37.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 14:37:06 -0700 (PDT)
Date:   Mon, 21 Sep 2020 14:36:52 -0700 (PDT)
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
In-Reply-To: <1598273705-69124-16-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-16-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> We have to move lru_lock into lru_note_cost, since it cycle up on memcg
> tree, for future per lruvec lru_lock replace. It's a bit ugly and may
> cost a bit more locking, but benefit from multiple memcg locking could
> cover the lost.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

Acked-by: Hugh Dickins <hughd@google.com>

In your lruv19 github tree, you have merged 14/32 into this one: thanks.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/swap.c   | 5 +++--
>  mm/vmscan.c | 4 +---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 906255db6006..f80ccd6f3cb4 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -269,7 +269,9 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  {
>  	do {
>  		unsigned long lrusize;
> +		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  
> +		spin_lock_irq(&pgdat->lru_lock);
>  		/* Record cost event */
>  		if (file)
>  			lruvec->file_cost += nr_pages;
> @@ -293,15 +295,14 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
>  			lruvec->file_cost /= 2;
>  			lruvec->anon_cost /= 2;
>  		}
> +		spin_unlock_irq(&pgdat->lru_lock);
>  	} while ((lruvec = parent_lruvec(lruvec)));
>  }
>  
>  void lru_note_cost_page(struct page *page)
>  {
> -	spin_lock_irq(&page_pgdat(page)->lru_lock);
>  	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
>  		      page_is_file_lru(page), thp_nr_pages(page));
> -	spin_unlock_irq(&page_pgdat(page)->lru_lock);
>  }
>  
>  static void __activate_page(struct page *page, struct lruvec *lruvec)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ffccb94defaf..7b7b36bd1448 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1971,19 +1971,17 @@ static int current_may_throttle(void)
>  				&stat, false);
>  
>  	spin_lock_irq(&pgdat->lru_lock);
> -
>  	move_pages_to_lru(lruvec, &page_list);
>  
>  	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
> -	lru_note_cost(lruvec, file, stat.nr_pageout);
>  	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
>  	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>  	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
> -
>  	spin_unlock_irq(&pgdat->lru_lock);
>  
> +	lru_note_cost(lruvec, file, stat.nr_pageout);
>  	mem_cgroup_uncharge_list(&page_list);
>  	free_unref_page_list(&page_list);
>  
> -- 
> 1.8.3.1
> 
> 
