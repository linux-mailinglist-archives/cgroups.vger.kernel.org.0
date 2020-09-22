Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5CA273A65
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 07:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgIVFxO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 01:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIVFxO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 01:53:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28E7C0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:53:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w16so19782222oia.2
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 22:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rj2KbrP8wDZHh7cva4yvY3TOcqZLJGweHnZrrr56Tas=;
        b=u+iUdxziFYUXXIs1aAqLKK5bC0JUncRoDRqo+fL11mZ37Ha6MX72UFkY+p4FBfLyxh
         zc00OHlQ+bY0vgqZB3XzRj+CyCwhquUofnrXhKsX1S9T4TGV313nL6TGQUrf9iB+4y0L
         qKilbf2LjFsSE+GBXwLaCPPWfaPIz+XwsVZW+erBJJJCxCyW0orCiGUR+rVyLV9p6ngN
         ruJWdxUGqQqpjFrm3baZ2BUfkIFeFHvnOlilwP0WSuWAvU/ObFzb1qIUAza1heNknuAp
         m/eSdALJmQq9lY6eqfsyysc0OvHuFaKfoqDoa1UnNwMlplj+jY2SFo43oDxYG3zQvblU
         7P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rj2KbrP8wDZHh7cva4yvY3TOcqZLJGweHnZrrr56Tas=;
        b=WuhjqSq3c497s+bG0BIGGrFvZCXoAxE3kCyE5Jo0H7db0kNsFI+SWPAR3bcvCIzjAU
         FXhqo4NomRo9OoV3tOyZGcm3YiANskvb9HogzEPl0tTfMd1iYlz2+odDq+EwdIEWuf+C
         Srr2VHzw1yAVJ0eSa2wSgJ1hIxVYd1j4gzrD9asDXzu3T3WKkDVuzFETjEd5sUC5MyJ1
         X4ouGIJ8fEXbucBshBxa5D2RV+YSv/UCr2c2yby+Axw//x0hkysM7ZpilsYIwEK6RhhS
         4+itbzvSaHak6u8c3t61a3U5pxnekq/guZ75RC1ZcXsGe8MK7vzIIBwThDi5jlAuqyuF
         v3Fg==
X-Gm-Message-State: AOAM531noBxhnFIId/c7duaGw/Nrj3bJkgIuIVIxcW59sNoFM3TqDURV
        K19t+TRmfcshTe5mptNJAXJv9g==
X-Google-Smtp-Source: ABdhPJwZijAs4pF+sGPJJ3xNkD1kodRHEYO50xvVByHQ87LR9vg0dhPsrsUYCRvTKbSIyxva3wEJMw==
X-Received: by 2002:aca:55c5:: with SMTP id j188mr1749314oib.138.1600753992827;
        Mon, 21 Sep 2020 22:53:12 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f50sm6777567otf.47.2020.09.21.22.53.10
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 22:53:11 -0700 (PDT)
Date:   Mon, 21 Sep 2020 22:53:09 -0700 (PDT)
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
Subject: Re: [PATCH v18 24/32] mm/pgdat: remove pgdat lru_lock
In-Reply-To: <1598273705-69124-25-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009212248350.6434@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-25-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> Now pgdat.lru_lock was replaced by lruvec lock. It's not used anymore.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

I don't take pleasure in spoiling your celebrations and ceremonies,
but I strongly agree with AlexD that this should simply be merged
into the big one, 20/32.  That can be ceremony enough.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> ---
>  include/linux/mmzone.h | 1 -
>  mm/page_alloc.c        | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index f0596e634863..0ed520954843 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -758,7 +758,6 @@ struct deferred_split {
>  
>  	/* Write-intensive fields used by page reclaim */
>  	ZONE_PADDING(_pad1_)
> -	spinlock_t		lru_lock;
>  
>  #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
>  	/*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97dc9ca..775120fcc869 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6733,7 +6733,6 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  	init_waitqueue_head(&pgdat->pfmemalloc_wait);
>  
>  	pgdat_page_ext_init(pgdat);
> -	spin_lock_init(&pgdat->lru_lock);
>  	lruvec_init(&pgdat->__lruvec);
>  }
>  
> -- 
> 1.8.3.1
