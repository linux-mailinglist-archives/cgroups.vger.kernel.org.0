Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0B932D719
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhCDPtk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Mar 2021 10:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235671AbhCDPtN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Mar 2021 10:49:13 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000CC061756
        for <cgroups@vger.kernel.org>; Thu,  4 Mar 2021 07:48:33 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id s7so18098237qkg.4
        for <cgroups@vger.kernel.org>; Thu, 04 Mar 2021 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BPzzifR3jmKfmhbVLe6vXoybjuDrovQTeCnMZN/atRQ=;
        b=WWef2GAfbou80N5BMcLGOfy0SRUKVjvprQBlt+eQ+fl9znRom4oEqDUkcVMMFRhCsH
         HsSgPUCsRxtfs2w2UEYQT8vJ7rEWDZ2ACkOnMGQe65sLG88PHpR+1P/F+9hK0PA7JVeG
         7UuWOMl76v8wjCcKe7UDA5MFirmoqXx4dzCu/bQ3QKktRLHNXPLldgF4/HqlPEFukYzz
         vrmARnzD/btz1fvFlMRfqt0RDiFQX5hbc2fi1W0JrT8ItDNEy+F/ItC7C9js8zRa2q9Y
         Mld0Q+guocOpuvIvtAEx8d0GvDnv1b/zleQfkTOv0IL7WjOCaqoUCmjMVWgUCbcSx4Lv
         k/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPzzifR3jmKfmhbVLe6vXoybjuDrovQTeCnMZN/atRQ=;
        b=q/7f6DUI+jDNypyNpl32iZBbLnR71j80UJfeEqo01u3Dw+BMybt0usvY3nr7HF7Dpp
         UF0/Zi0Hr8Ok181YATPW9Hmv2VrUKmgQNJK4moIAnA0hOu0ke5LIipjCuHhfFKk7Rdnk
         2a0cvPxWJownDUZnmlZ4GzyESHyJpitkZaMHAiOO4AulG+XOUdpwKvMEsAl48XE8yu3+
         sJzYlj99Sm3dX1rzWr+tVl9uVjcUusj9yRZD0WbAmN6xWu1sjLmE5JpTot4YbVvjUBy9
         wb2iPP8p7gm0QeBLH5ghkIBOSZa1aDxIu9+fyv8tuymi1w6zT3wHraObbwucZNzh2FuW
         0aAA==
X-Gm-Message-State: AOAM531x4rYvPnRXVL9oKp5hQTuXZ9qFdOcNWWbSKH/txg4ltzwlpOsQ
        8800oOJYAE60WxTWpPfGJE9mag==
X-Google-Smtp-Source: ABdhPJxHWNi0keQbMNoJsGuf4uKSTRrd3e3gnQprSCI2sh41sPnTTTzbepxGjVS3MrOEBSsK107UVg==
X-Received: by 2002:a37:4e01:: with SMTP id c1mr4577182qkb.16.1614872912480;
        Thu, 04 Mar 2021 07:48:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b28e])
        by smtp.gmail.com with ESMTPSA id h3sm15841551qtp.8.2021.03.04.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 07:48:31 -0800 (PST)
Date:   Thu, 4 Mar 2021 10:48:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memcg: charge before adding to swapcache on swapin
Message-ID: <YEEBTm/NIugjQWG5@cmpxchg.org>
References: <20210304014229.521351-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304014229.521351-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 03, 2021 at 05:42:29PM -0800, Shakeel Butt wrote:
> Currently the kernel adds the page, allocated for swapin, to the
> swapcache before charging the page. This is fine but now we want a
> per-memcg swapcache stat which is essential for folks who wants to
> transparently migrate from cgroup v1's memsw to cgroup v2's memory and
> swap counters. In addition charging a page before exposing it to other
> parts of the kernel is a step in the right direction.
> 
> To correctly maintain the per-memcg swapcache stat, this patch has
> adopted to charge the page before adding it to swapcache. One
> challenge in this option is the failure case of add_to_swap_cache() on
> which we need to undo the mem_cgroup_charge(). Specifically undoing
> mem_cgroup_uncharge_swap() is not simple.
> 
> To resolve the issue, this patch introduces transaction like interface
> to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
> initiates the charging of the page and mem_cgroup_finish_swapin_page()
> completes the charging process. So, the kernel starts the charging
> process of the page for swapin with mem_cgroup_charge_swapin_page(),
> adds the page to the swapcache and on success completes the charging
> process with mem_cgroup_finish_swapin_page().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

The patch looks good to me, I have just a minor documentation nit
below. But with that addressed, please add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> +/**
> + * mem_cgroup_charge_swapin_page - charge a newly allocated page for swapin
> + * @page: page to charge
> + * @mm: mm context of the victim
> + * @gfp: reclaim mode
> + * @entry: swap entry for which the page is allocated
> + *
> + * This function marks the start of the transaction of charging the page for
> + * swapin. Complete the transaction with mem_cgroup_finish_swapin_page().
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
> +				  gfp_t gfp, swp_entry_t entry)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned short id;
> +	int ret;
>  
> -	if (!memcg)
> -		memcg = get_mem_cgroup_from_mm(mm);
> +	if (mem_cgroup_disabled())
> +		return 0;
>  
> -	ret = try_charge(memcg, gfp_mask, nr_pages);
> -	if (ret)
> -		goto out_put;
> +	id = lookup_swap_cgroup_id(entry);
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_id(id);
> +	if (!memcg || !css_tryget_online(&memcg->css))
> +		memcg = get_mem_cgroup_from_mm(mm);
> +	rcu_read_unlock();
>  
> -	css_get(&memcg->css);
> -	commit_charge(page, memcg);
> +	ret = __mem_cgroup_charge(page, memcg, gfp);
>  
> -	local_irq_disable();
> -	mem_cgroup_charge_statistics(memcg, page, nr_pages);
> -	memcg_check_events(memcg, page);
> -	local_irq_enable();
> +	css_put(&memcg->css);
> +	return ret;
> +}
>  
> +/*
> + * mem_cgroup_finish_swapin_page - complete the swapin page charge transaction
> + * @page: page charged for swapin
> + * @entry: swap entry for which the page is charged
> + *
> + * This function completes the transaction of charging the page allocated for
> + * swapin.

It's possible somebody later needs to change things around in the
swapin path and it's not immediately obvious when exactly these two
functions need to be called in the swapin sequence.

Maybe add here and above that charge_swapin_page needs to be called
before we try adding the page to the swapcache, and finish_swapin_page
needs to be called when swapcache insertion has been successful?
