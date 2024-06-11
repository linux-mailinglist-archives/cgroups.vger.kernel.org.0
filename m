Return-Path: <cgroups+bounces-3156-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E91904487
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDEE91F23F9E
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2024 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A880C03;
	Tue, 11 Jun 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U5m/6k/F"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE977F49B
	for <cgroups@vger.kernel.org>; Tue, 11 Jun 2024 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133935; cv=none; b=jMb1Vu8YumDEWd++0J+08IW4F4XNKNVDtYeH5s6d4wdGHRSAZ62BXz7vL8DLNJ5WIZm1xcOkzUAK+PEx8ZW7b8qmV9X2vmY3NavIKBEb6JYwqlEyF+gXud8KU85ubgxBbVDZ2/hhylE6eFRqnIoAZJnBVQZIbv+iHQ/r6bK274Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133935; c=relaxed/simple;
	bh=Ymp+DR9Tt14kZL2jrAdEJecNjjZSBNN/lyGEmd259pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9B+Cii0FtzQ0WxkXYHfLJ3mPu1FmnYhgsu0yxCKcUQftWbFjlP024FgUb/4uMOu1vUkPnQkJNXYO3Sladul66XugnPRi9yqE7wYHR+hbM2dmjgSiQ5oA+kwKHHOh/1tuPxZWTxNps7t+G2igsSyl/eLFetzPBDPktpnBu95vR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U5m/6k/F; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: findns94@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718133931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHX4czqVnKBAHHkY7DkzRLGWyI8lBYat9UvV74uCHE8=;
	b=U5m/6k/FSCGoNcJDsu7J7cbq3oMNJQTCeyoGCy8ucoPF30Flv6V6WBMaPuw2ABlJ+yub5u
	o5+y02lHLqw2MgS74XKeN/yMyfZLc7YMI2lvNCRzGxhwsCDQtDm5DYuQI5QKMg1WdziIKg
	G8GZQj7JbvRr4mvJhQAJou3ja510ARc=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: corbet@lwn.net
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: shakeelb@google.com
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: david@redhat.com
X-Envelope-To: chrisl@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: wangkefeng.wang@huawei.com
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: findns94@gmail.com
X-Envelope-To: hughd@google.com
X-Envelope-To: schatzberg.dan@gmail.com
Date: Tue, 11 Jun 2024 12:25:24 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yue Zhao <findns94@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>, 
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH v6 0/2] Add swappiness argument to memory.reclaim
Message-ID: <htpurelstaqpswf5nkhtttm3vtbvga7qazs2estwzf2srmg65x@banbo2c5ewzw>
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi folks,

This series has been in the mm-unstable for several months. Are there
any remaining concerns here otherwise can we please put this in the
mm-stable branch to be merged in the next Linux release?

On Wed, Jan 03, 2024 at 08:48:35AM GMT, Dan Schatzberg wrote:
> Changes since V5:
>   * Made the scan_control behavior limited to proactive reclaim explicitly
>   * created sc_swappiness helper to reduce chance of mis-use
> 
> Changes since V4:
>   * Fixed some initialization bugs by reverting back to a pointer for swappiness
>   * Added some more caveats to the behavior of swappiness in documentation
> 
> Changes since V3:
>   * Added #define for MIN_SWAPPINESS and MAX_SWAPPINESS
>   * Added explicit calls to mem_cgroup_swappiness
> 
> Changes since V2:
>   * No functional change
>   * Used int consistently rather than a pointer
> 
> Changes since V1:
>   * Added documentation
> 
> This patch proposes augmenting the memory.reclaim interface with a
> swappiness=<val> argument that overrides the swappiness value for that instance
> of proactive reclaim.
> 
> Userspace proactive reclaimers use the memory.reclaim interface to trigger
> reclaim. The memory.reclaim interface does not allow for any way to effect the
> balance of file vs anon during proactive reclaim. The only approach is to adjust
> the vm.swappiness setting. However, there are a few reasons we look to control
> the balance of file vs anon during proactive reclaim, separately from reactive
> reclaim:
> 
> * Swapout should be limited to manage SSD write endurance. In near-OOM
>   situations we are fine with lots of swap-out to avoid OOMs. As these are
>   typically rare events, they have relatively little impact on write endurance.
>   However, proactive reclaim runs continuously and so its impact on SSD write
>   endurance is more significant. Therefore it is desireable to control swap-out
>   for proactive reclaim separately from reactive reclaim
> 
> * Some userspace OOM killers like systemd-oomd[1] support OOM killing on swap
>   exhaustion. This makes sense if the swap exhaustion is triggered due to
>   reactive reclaim but less so if it is triggered due to proactive reclaim (e.g.
>   one could see OOMs when free memory is ample but anon is just particularly
>   cold). Therefore, it's desireable to have proactive reclaim reduce or stop
>   swap-out before the threshold at which OOM killing occurs.
> 
> In the case of Meta's Senpai proactive reclaimer, we adjust vm.swappiness before
> writes to memory.reclaim[2]. This has been in production for nearly two years
> and has addressed our needs to control proactive vs reactive reclaim behavior
> but is still not ideal for a number of reasons:
> 
> * vm.swappiness is a global setting, adjusting it can race/interfere with other
>   system administration that wishes to control vm.swappiness. In our case, we
>   need to disable Senpai before adjusting vm.swappiness.
> 
> * vm.swappiness is stateful - so a crash or restart of Senpai can leave a
>   misconfigured setting. This requires some additional management to record the
>   "desired" setting and ensure Senpai always adjusts to it.
> 
> With this patch, we avoid these downsides of adjusting vm.swappiness globally.
> 
> Previously, this exact interface addition was proposed by Yosry[3]. In response,
> Roman proposed instead an interface to specify precise file/anon/slab reclaim
> amounts[4]. More recently Huan also proposed this as well[5] and others
> similarly questioned if this was the proper interface.
> 
> Previous proposals sought to use this to allow proactive reclaimers to
> effectively perform a custom reclaim algorithm by issuing proactive reclaim with
> different settings to control file vs anon reclaim (e.g. to only reclaim anon
> from some applications). Responses argued that adjusting swappiness is a poor
> interface for custom reclaim.
> 
> In contrast, I argue in favor of a swappiness setting not as a way to implement
> custom reclaim algorithms but rather to bias the balance of anon vs file due to
> differences of proactive vs reactive reclaim. In this context, swappiness is the
> existing interface for controlling this balance and this patch simply allows for
> it to be configured differently for proactive vs reactive reclaim.
> 
> Specifying explicit amounts of anon vs file pages to reclaim feels inappropriate
> for this prupose. Proactive reclaimers are un-aware of the relative age of file
> vs anon for a cgroup which makes it difficult to manage proactive reclaim of
> different memory pools. A proactive reclaimer would need some amount of anon
> reclaim attempts separate from the amount of file reclaim attempts which seems
> brittle given that it's difficult to observe the impact.
> 
> [1]https://www.freedesktop.org/software/systemd/man/latest/systemd-oomd.service.html
> [2]https://github.com/facebookincubator/oomd/blob/main/src/oomd/plugins/Senpai.cpp#L585-L598
> [3]https://lore.kernel.org/linux-mm/CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com/
> [4]https://lore.kernel.org/linux-mm/YoPHtHXzpK51F%2F1Z@carbon/
> [5]https://lore.kernel.org/lkml/20231108065818.19932-1-link@vivo.com/
> 
> Dan Schatzberg (2):
>   mm: add defines for min/max swappiness
>   mm: add swapiness= arg to memory.reclaim
> 
>  Documentation/admin-guide/cgroup-v2.rst | 18 +++++---
>  include/linux/swap.h                    |  5 ++-
>  mm/memcontrol.c                         | 58 ++++++++++++++++++++-----
>  mm/vmscan.c                             | 39 ++++++++++++-----
>  4 files changed, 90 insertions(+), 30 deletions(-)
> 
> -- 
> 2.39.3
> 

