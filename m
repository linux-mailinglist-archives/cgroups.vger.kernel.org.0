Return-Path: <cgroups+bounces-674-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A52B7FDB48
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 16:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F55FB21488
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 15:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09902381CA;
	Wed, 29 Nov 2023 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cH3ZXWk2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EAD71
	for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:25:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41c157bbd30so36848321cf.0
        for <cgroups@vger.kernel.org>; Wed, 29 Nov 2023 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701271511; x=1701876311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ggscuLXdkbtAnynY3GdTzeA07chUPA8WGR1vy9vM7w=;
        b=cH3ZXWk2/oyUnIX75QcNokzfI3D4H2OzhpG16aUIyRI1ilDvEcXdf02UICEXQNmIUI
         FWxTLLy3hDpaNy+ClQPKo1xMP3VkQolaiKPK5mRLtzfT9fTtgk1fGwBlymMihVNujVN2
         nrNVvRotEGDL9/Cpf/fpIa+FVp0Xd1Vfo2Fzm7256RPvBmK2cX8AIYD2XZBx0bmWLlfD
         pZsE2fBA7lh/epk+zywODUzH0FQELz/sMfnyICM5RuebgTeIB0xeIGB61JJttvJ/y6V9
         SQL+AqIZNS/aWObRe9LZONObWrppjFF91e3V+kMNWvpzrOL3uobeg7BCzbxO9OACqYJm
         toXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271511; x=1701876311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ggscuLXdkbtAnynY3GdTzeA07chUPA8WGR1vy9vM7w=;
        b=hvYUgASFl2oNfTT5DGSZRShSRt1kjOfVCtxgM4MxFlBdm7zGQ4ENIT8Sc7DGyMgfhA
         pqzYBY1Qr1ndhbr5kUw3UElVktkQdA00mxdTUImBk1zGQSMcfn3pi53YuzF/CEhVgENq
         N7w4hZW2wvbCNMq8xpZbqKclkEoYeGfcBF1exupDNqexaY80P77tBG1nXyCKmFtJ3qvQ
         6LrGg6X/ileUa5Y0V1BugHGN1rgpuHXr3FrytYe7ZC32E4cdE1IaMw9OEBO/u20OXUjc
         IWruZCwC+lM+Lj8CUyrBcJIOMo7b75S2asD54PofyQtN2WdTKGNT5339VgMDy/Gmi0hh
         hljA==
X-Gm-Message-State: AOJu0YwHCQ4wJrtmZe8Dz3vZdqPIaX6kCd2uWb2QmB91hje1G7H7cllS
	4sVU6E+kQrAO04+dU8OBFSyQuw==
X-Google-Smtp-Source: AGHT+IERC5rUROsi60YXkNf8/r1k/+JDGDC0OGY/HyxD3a7Iu2Iwryw3L5ZWy48uExK2aTbpmhx8CQ==
X-Received: by 2002:ac8:60b:0:b0:423:b632:eaea with SMTP id d11-20020ac8060b000000b00423b632eaeamr11778830qth.8.1701271510969;
        Wed, 29 Nov 2023 07:25:10 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id t22-20020ac86a16000000b004196d75d79csm5633606qtr.46.2023.11.29.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:25:10 -0800 (PST)
Date: Wed, 29 Nov 2023 10:25:09 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
	vitaly.wool@konsulko.com, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v7 4/6] mm: memcg: add per-memcg zswap writeback stat
Message-ID: <20231129152509.GD135852@cmpxchg.org>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
 <20231127234600.2971029-5-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127234600.2971029-5-nphamcs@gmail.com>

On Mon, Nov 27, 2023 at 03:45:58PM -0800, Nhat Pham wrote:
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> 
> Since zswap now writes back pages from memcg-specific LRUs, we now need a
> new stat to show writebacks count for each memcg.
> 
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/vm_event_item.h | 1 +
>  mm/memcontrol.c               | 1 +
>  mm/vmstat.c                   | 1 +
>  mm/zswap.c                    | 3 +++
>  4 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index d1b847502f09..f4569ad98edf 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #ifdef CONFIG_ZSWAP
>  		ZSWPIN,
>  		ZSWPOUT,
> +		ZSWP_WB,
>  #endif
>  #ifdef CONFIG_X86
>  		DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0f3f971179..f88c8fd03689 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] = {
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>  	ZSWPIN,
>  	ZSWPOUT,
> +	ZSWP_WB,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index afa5a38fcc9c..2249f85e4a87 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1401,6 +1401,7 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_ZSWAP
>  	"zswpin",
>  	"zswpout",
> +	"zswp_wb",

ZSWPWB and "zswpwb" would match the existing naming scheme a bit
better.

>  #endif
>  #ifdef CONFIG_X86
>  	"direct_map_level2_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 5e397fc1f375..6a761753f979 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -754,6 +754,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
>  	}
>  	zswap_written_back_pages++;
>  
> +	if (entry->objcg)
> +		count_objcg_event(entry->objcg, ZSWP_WB);
> +

You need to call count_vm_event() as well, otherwise the /proc/vmstat
counter will stay zero.

