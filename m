Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84C1CBA2B
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEHVvm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 17:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgEHVvl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 17:51:41 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF5C061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 14:51:41 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id c4so1079330qvi.6
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKXRONb+n2QBaUWyV/lYpYzKCQdxSGuUXqvfdv5OsKY=;
        b=rSGufhOWI5GJ6rCz1J39rS/t2dS6ZoQ36aA2y3RXn5bAZ7046RBX6rQnu8ISFEZaMD
         MH3QH8Zj79L5MHtEygX2sQIkEpEfpHec8ju4KgtrK9eU1RZhdZ2ADOsWM9iz88vgttuh
         lIhGIaHkK5GccMZd4UVybv9snSfren/bg4uecEExUUcmw5JEP2cbA+xbtKbRVjuz2FQ4
         5zJAHOSx0PxNJo9D0F6/NfqJoHwOJJQB/+dObv66HynblLg5aIM6hTSAhuPo4+e/VtTq
         KBTGSBVIHMtUAqfiBAW8agqP824GFhS2GZ9MnXXsirMXAHLSoEyNDOrCQaUbdjxmCZw+
         Susw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKXRONb+n2QBaUWyV/lYpYzKCQdxSGuUXqvfdv5OsKY=;
        b=lGUQi4c31HQ08NTF/GfwybnDhy5gJRaCTzWYT0BBJVcN/2QDIWS43Am9q3jRZNdgAl
         t6lVJQG37u39jMUZjLst5gKWEClBRbe6rSKLywOQb6lGVkkNG+9CYWOEsAHQW6st97hf
         cS/d9ulS6HVPYdOzOxD1fsCxTUjZa57ssKFzbVNcHBW6rGFVHWLoPRhEXQY3q8QCb47p
         OBl9lXq/hI5vagtoGfrHcl7eXIBcOZAPOhwhQX9gmVahaajMXwNolJHoN0wwoUERB1n1
         /8J1k6KtC4Kq0VG23IymIs39ervSTMMc2jseHl/RrtijWMeeMz8vSyY4e39Kph1xs6dg
         DM7A==
X-Gm-Message-State: AGi0Pua2cHgdL3jz+BGH5q3Hj2XqA51pznHTmBUpsgotaGhvR4OzBsgm
        lSo7/AuVJ2jvTJO1nU2EceHytA==
X-Google-Smtp-Source: APiQypL2QQXpmSyCMyeb86k1mqtxlrryhZ7iuR/Zzeb58Ec8aokdSWY0L39I7tQhUSNR2pzmPjJlSQ==
X-Received: by 2002:a0c:e549:: with SMTP id n9mr4873559qvm.214.1588974700726;
        Fri, 08 May 2020 14:51:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id g16sm2123740qkk.122.2020.05.08.14.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:51:40 -0700 (PDT)
Date:   Fri, 8 May 2020 17:51:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: swap: fix update_page_reclaim_stat for huge pages
Message-ID: <20200508215122.GB226164@cmpxchg.org>
References: <20200508212215.181307-1-shakeelb@google.com>
 <20200508212215.181307-3-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508212215.181307-3-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 02:22:15PM -0700, Shakeel Butt wrote:
> Currently update_page_reclaim_stat() updates the lruvec.reclaim_stats
> just once for a page irrespective if a page is huge or not. Fix that by
> passing the hpage_nr_pages(page) to it.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

https://lore.kernel.org/patchwork/patch/685703/

Laughs, then cries.

> @@ -928,7 +928,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
>  	}
>  
>  	if (!PageUnevictable(page))
> -		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
> +		update_page_reclaim_stat(lruvec, file, PageActive(page_tail), 1);

The change to __pagevec_lru_add_fn() below makes sure the tail pages
are already accounted. This would make them count twice.

>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> @@ -973,7 +973,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
>  	if (page_evictable(page)) {
>  		lru = page_lru(page);
>  		update_page_reclaim_stat(lruvec, page_is_file_lru(page),
> -					 PageActive(page));
> +					 PageActive(page), nr_pages);
>  		if (was_unevictable)
>  			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
>  	} else {
