Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7755E3C263A
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 16:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhGIOvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhGIOvf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 10:51:35 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC4C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 07:48:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d1so7756363qto.4
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zc2BPQuzaGpps9hYR6A1SS6spRlObwvCzaY7uIl0fFs=;
        b=JjjnbfYvxPo1NWSBJyvtgC3bk+XjiBXa9XnURKljN5acQnzH15vHkDQMcFUrMK1kKy
         dllvEWiXreEpZ2IYRdzBgVDviwe/+oDhuJ+32k7xARC6sIYWxqYM47UBp/Jr2KMNe/im
         Yv1AaH5yzrL2BdSCcFsOcnLsrzO9jBE5in/utMROdxyYfh83hIDL0edY5lWunZJz4qRL
         jNzVXVUCxw6Wkf51faXzwe6+bYtOPb6hmCIqBp5dsq1c+zYiFrRDb72JlDhrA/BWwgSz
         obYUN0vGYbcCmC9EWi6WCsqUSZdvbUh5wwq6Th1zP1Jr74QYDo0ogJBNdI143IfDTXXH
         LUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zc2BPQuzaGpps9hYR6A1SS6spRlObwvCzaY7uIl0fFs=;
        b=UW4zLjWYiSTkxdnFQch4A2M3y9BbE2ZcqpVBEeXuAkb6Xc+9zMCzTP6RA0UYb0WJ4K
         EIcws37Sju3J+uMcKQmt4tJGSyxomi4RSgSVxY+SpgR/VrLNFK36fcnNAEC2Q0YRSABH
         GrpdWwKNAOEZ7bDuXlXM3MMZ37lOOlYQQchdBOsLaeUeBvr7zFijswEfOZBaVm61pSWx
         wE5dlYm96lw8im+NvXQm2wUB0xhiDm7O1V2C5KwMU6nh/wzqkiTKv4TSgjg5l/HD2wHY
         0RC4psy/UNJ/UlH0QdqvYlwtdQIonLEUV4tS3uAu+uJcfHon4D3FqKsf1Mvdu13mrdFj
         DVlA==
X-Gm-Message-State: AOAM533CpN90CL7lpLTavojtfzFPrhUn+YV/m8sid1apdDcJCZKO/sHW
        bD0Ys1+AaW6VTro9NSUqdFNVHg==
X-Google-Smtp-Source: ABdhPJymN1G1/IcEEKsYsC76uVcFFA+vVSUTNwGP91lvr0dxcWNiE3iRXktWTxmOtZ7K1vS9aeSNmQ==
X-Received: by 2002:a05:622a:449:: with SMTP id o9mr34293601qtx.272.1625842130626;
        Fri, 09 Jul 2021 07:48:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8649])
        by smtp.gmail.com with ESMTPSA id l5sm2573791qkb.62.2021.07.09.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:48:49 -0700 (PDT)
Date:   Fri, 9 Jul 2021 10:48:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
Message-ID: <YOhh0IabpRk/W/qR@cmpxchg.org>
References: <20210709000509.2618345-1-surenb@google.com>
 <20210709000509.2618345-3-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709000509.2618345-3-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 08, 2021 at 05:05:08PM -0700, Suren Baghdasaryan wrote:
> Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
> functions to perform mem_cgroup_disabled static key check inline before
> calling the main body of the function. This minimizes the memcg overhead
> in the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~0.4% overhead reduction when running PFT test
> comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
> configurationon on an 8-core ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Sounds reasonable to me as well. One comment:

> @@ -693,13 +693,59 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
>  		page_counter_read(&memcg->memory);
>  }
>  
> -int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
> +struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> +
> +int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
> +			gfp_t gfp);
> +/**
> + * mem_cgroup_charge - charge a newly allocated page to a cgroup
> + * @page: page to charge
> + * @mm: mm context of the victim
> + * @gfp_mask: reclaim mode
> + *
> + * Try to charge @page to the memcg that @mm belongs to, reclaiming
> + * pages according to @gfp_mask if necessary. if @mm is NULL, try to
> + * charge to the active memcg.
> + *
> + * Do not use this for pages allocated for swapin.
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
> +				    gfp_t gfp_mask)
> +{
> +	struct mem_cgroup *memcg;
> +	int ret;
> +
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	memcg = get_mem_cgroup_from_mm(mm);
> +	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> +	css_put(&memcg->css);
> +
> +	return ret;

Why not do

int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
			gfp_t gfp_mask);

static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
				    gfp_t gfp_mask)
{
	if (mem_cgroup_disabled())
		return 0;

	return __mem_cgroup_charge(page, memcg, gfp_mask);
}

like in the other cases as well?

That would avoid inlining two separate function calls into all the
callsites...

There is an (internal) __mem_cgroup_charge() already, but you can
rename it charge_memcg().

