Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2720A320247
	for <lists+cgroups@lfdr.de>; Sat, 20 Feb 2021 01:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhBTAft (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Feb 2021 19:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhBTAfs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Feb 2021 19:35:48 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B1C061793
        for <cgroups@vger.kernel.org>; Fri, 19 Feb 2021 16:34:31 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id k8so3068630qvm.6
        for <cgroups@vger.kernel.org>; Fri, 19 Feb 2021 16:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dddqDG5OH+l1ND7BjX6aGGlaSzT3Qqk6VPLYVIkB8Zk=;
        b=j3hoLdIcaOoMzPPzi5cxfKzQ6iy0+AxlZBenkTInEAaFtLcL7CAtbl/oK5f/dMNtoU
         +wzNPu7pcJjBgE5T+v/+W/Z094r37wQbBGmS1/kYm+DgOsw+36T7wGKBlwApDIK+VA3X
         3/o7H8q8f4SmFsjr+R9Q6kPeVToT8SBYBaPpBRFrATTV6AToiYmxPWkmzhf71RcHVHU4
         QZZfcHEMxDHzTj2lg3wGzIe4j3yX2rvNk0L/sB9iTk9mfdmQbjFexGECkA4vF/ixM7Hu
         G0fAWXTfnaIe5vEhXkeleTdZQRORgGrA9GYOxnX/TyDLoUF2GtgLWJdRTzDnXve8LS/W
         5NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dddqDG5OH+l1ND7BjX6aGGlaSzT3Qqk6VPLYVIkB8Zk=;
        b=iI9ncz+p1mgDJ3qY8o/sS6uyIOOXAHJUgh02WN4PhxgenGAJc8/UU2ClyvrHIwYB3w
         bhgrk+hnNJ7mDHekfRO6mi9EbepYIvivVLPDYXd6cNo82MH0aZYNw7/Zq4RLaIdPG5Iv
         SDBvPXs2uZvx4vQN7TTo04yWrTvgTdM5oP442kcyiaLChpVvaLw2TPr64ZcTE9Dj9qWt
         E6NDbJtJ6qN9J6yz2c0afkXn9sFDwDpaZSYAbn7uGeIJkCW+0orxwLREyay2VKAPFoBC
         5a7XMTAxPRv/RYLCL9fEsILXURLIwCN2LNnEU5JnYlv0ls5dBK+1eLviKmgDCQYUdlNr
         XPRg==
X-Gm-Message-State: AOAM532MlOMFVHrxMic3/S36nNBkMsu4L6fhbQJgWlQ0qDB+9kwnWwC0
        ULY2ydBlIwjlKJ3IsFLzeTslvw==
X-Google-Smtp-Source: ABdhPJyz2aw4CyDY8MTIrmXm7JuOSGibUvPefK8lA9Kt+Ar2Xeti/RlZK4uikpYz2aUAJyEqVrXAzw==
X-Received: by 2002:a0c:aece:: with SMTP id n14mr2253955qvd.52.1613781270232;
        Fri, 19 Feb 2021 16:34:30 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id r2sm6445507qti.4.2021.02.19.16.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 16:34:29 -0800 (PST)
Date:   Fri, 19 Feb 2021 19:34:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: charge before adding to swapcache on swapin
Message-ID: <YDBZFY8WnLewRqLg@cmpxchg.org>
References: <20210219224405.1544597-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219224405.1544597-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 19, 2021 at 02:44:05PM -0800, Shakeel Butt wrote:
> Currently the kernel adds the page, allocated for swapin, to the
> swapcache before charging the page. This is fine but now we want a
> per-memcg swapcache stat which is essential for folks who wants to
> transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> swap counters.
> 
> To correctly maintain the per-memcg swapcache stat, one option which
> this patch has adopted is to charge the page before adding it to
> swapcache. One challenge in this option is the failure case of
> add_to_swap_cache() on which we need to undo the mem_cgroup_charge().
> Specifically undoing mem_cgroup_uncharge_swap() is not simple.
> 
> This patch circumvent this specific issue by removing the failure path
> of  add_to_swap_cache() by providing __GFP_NOFAIL. Please note that in
> this specific situation ENOMEM was the only possible failure of
> add_to_swap_cache() which is removed by using __GFP_NOFAIL.
> 
> Another option was to use __mod_memcg_lruvec_state(NR_SWAPCACHE) in
> mem_cgroup_charge() but then we need to take of the do_swap_page() case
> where synchronous swap devices bypass the swapcache. The do_swap_page()
> already does hackery to set and reset PageSwapCache bit to make
> mem_cgroup_charge() execute the swap accounting code and then we would
> need to add additional parameter to tell to not touch NR_SWAPCACHE stat
> as that code patch bypass swapcache.
> 
> This patch added memcg charging API explicitly foe swapin pages and
> cleaned up do_swap_page() to not set and reset PageSwapCache bit.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

The patch makes sense to me. While it extends the charge interface, I
actually quite like that it charges the page earlier - before putting
it into wider circulation. It's a step in the right direction.

But IMO the semantics of mem_cgroup_charge_swapin_page() are a bit too
fickle: the __GFP_NOFAIL in add_to_swap_cache() works around it, but
having a must-not-fail-after-this line makes the code tricky to work
on and error prone.

It would be nicer to do a proper transaction sequence.

> @@ -497,16 +497,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>  	__SetPageLocked(page);
>  	__SetPageSwapBacked(page);
>  
> -	/* May fail (-ENOMEM) if XArray node allocation failed. */
> -	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow)) {
> -		put_swap_page(page, entry);
> +	if (mem_cgroup_charge_swapin_page(page, NULL, gfp_mask, entry))
>  		goto fail_unlock;
> -	}
>  
> -	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
> -		delete_from_swap_cache(page);
> -		goto fail_unlock;
> -	}
> +	/*
> +	 * Use __GFP_NOFAIL to not worry about undoing the changes done by
> +	 * mem_cgroup_charge_swapin_page() on failure of add_to_swap_cache().
> +	 */
> +	add_to_swap_cache(page, entry,
> +			  (gfp_mask|__GFP_NOFAIL) & GFP_RECLAIM_MASK, &shadow);

How about:

	mem_cgroup_charge_swapin_page()
	add_to_swap_cache()
	mem_cgroup_finish_swapin_page()

where finish_swapin_page() only uncharges the swap entry (on cgroup1)
once the swap->memory transition is complete?

Otherwise the patch looks good to me.
