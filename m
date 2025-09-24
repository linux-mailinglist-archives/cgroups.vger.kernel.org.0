Return-Path: <cgroups+bounces-10411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88968B98701
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 08:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3692A2A63
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 06:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1759D24DCEF;
	Wed, 24 Sep 2025 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qe8M1AYQ"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5141FDD;
	Wed, 24 Sep 2025 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758696686; cv=none; b=Y2ViIVmmWd6eskJh4gzl/yNXa994ebYGJj94lCONgI95QpMfPaz42sG2Z6IBxhKpUA6kuECYFZJEAcTTBn+3rdqtnGXZQe4JEX0NF0pqSQCa+aMUZWF6se3AnkZ2nW3SyZWjppgkl0mCgY7AJmLIxf+PHMPQ9q/tpSiKKj/J7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758696686; c=relaxed/simple;
	bh=K2bOS3pbWoyhTpGBmbM+NzPuDyPHGCYGFF4KgBK2D28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrbptHU2PcuIxcUTF0k7bgpvZ8TijVj7/ZMqumcmHvOZUv4Mi53rRXqcEoouX53eJ74uFxYN69sAsz76Z2FEKLVhwqF7Yg6koEzvtvtBwYV1DprJ1wGfAGVC1o7f5rO6zCCZlXM2gW6BHdig2ly4/7wPGwjiJCYQbbI0K1PFfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qe8M1AYQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fgGZ5MdQVPSnCQ97+Io7ZKtLMPQ2htWlC9C9WcFirJ0=; b=qe8M1AYQnc7JU5DT9p/LAHPBdE
	Gjm8LVMlnLOGfQXdzhYgBqS3x8e5RCJ/AgECtiUsD7kgJ6zlowRseDahFZCvXNuhOAPTk6SvIz4eq
	/LsM0USJ7sX600fZp4fVom5+1LMDBAk2jNihUUyxuBxcF0Qo72DOYXy/yjBnant5+k0QZpHmxpd4v
	tddxDcVyx1waflIJ86eyHDVG+v0CGcVg+mj20PVMidv/Pb0AlEVDwKwQqCVP+9VGW11hzsWOrZdJx
	Iwos6RHauBCTnc72zpGls3bkoVfryNEdgZCf2PINVKwwXAH++Er/bPHYKpYQA0N1mVOboYlDnsf5P
	x08RH7ig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1J37-0000000AFMH-1S5J;
	Wed, 24 Sep 2025 06:32:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 007D230033D; Wed, 24 Sep 2025 08:32:19 +0200 (CEST)
Date: Wed, 24 Sep 2025 08:32:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, lance.yang@linux.dev,
	mhiramat@kernel.org, yangyicong@hisilicon.com, will@kernel.org,
	dianders@chromium.org, mingo@kernel.org, lihuafei1@huawei.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org
Subject: Re: [PATCH v2 2/2] memcg: Don't trigger hung task warnings when
 memcg is releasing resources.
Message-ID: <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924034100.3701520-3-sunjunchao@bytedance.com>

On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
> Hung task warning in mem_cgroup_css_free() is undesirable and
> unnecessary since the behavior of waiting for a long time is
> expected.
> 
> Use touch_hung_task_detector() to eliminate the possible
> hung task warning.
> 
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Still hate this. It is not tied to progress. If progress really stalls,
no warning will be given.

>  mm/memcontrol.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8dd7fbed5a94..fc73a56372a4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -63,6 +63,7 @@
>  #include <linux/seq_buf.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
> +#include <linux/nmi.h>
>  #include "internal.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
> @@ -3912,8 +3913,15 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
>  	int __maybe_unused i;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> -	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		/*
> +		 * We don't want the hung task detector to report warnings
> +		 * here since there's nothing wrong if the writeback work
> +		 * lasts for a long time.
> +		 */
> +		touch_hung_task_detector(current);
>  		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> +	}
>  #endif
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
>  		static_branch_dec(&memcg_sockets_enabled_key);
> -- 
> 2.39.5
> 

