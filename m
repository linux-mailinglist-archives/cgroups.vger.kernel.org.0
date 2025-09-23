Return-Path: <cgroups+bounces-10401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0867EB9724D
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 19:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC3619C6F2A
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2BC2D239F;
	Tue, 23 Sep 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v0DGtYaT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1A2C0F75
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650348; cv=none; b=XV227VNvG9JRGAElg20XeYpgc5czIICN0MffyXu51QBuLOwd2RONXSq2KDJwxQLBgBrterkpgiyK9DidQwWYO37rwVCNBraFG/J6kc4s5EU5Pq5zbnqG0qaDn/fj/tjGFFWprSBwTPDo8a2v1uTISAyLuHJXOiISHcSmRpFqxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650348; c=relaxed/simple;
	bh=j2d13GXcz450pDM3MQEavPsSldI+HSmDIxze10yD/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMu3AePJXNPdOXcODcmLb2OLQSVudWZoK0NOvOUfuhNdetR6P3BSvAMQh4Eovg9T64nVkJM/tlZnhpnzIzNs6SKf/h4Y4fAmOjqJJsP72J3D/TsnHV6CSeEJFkFa4eFTudSNXMhROxwuvmWvjydAZ5jqP2mvW8MoQFNmtMg684A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v0DGtYaT; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Sep 2025 10:58:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758650334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yYKyXs58ep6KuR+AMq5KlViCjagWm/Z5ncA3hHpUIH4=;
	b=v0DGtYaTVzThHF6HsIWYKdJB/qBlprObAXIATcqkmwxmMa7V6QoGhVss3iKlYuSIRwPGGc
	nG1tSqjYBS7hiT/YHjzG7YrQINl0nQ4gjEL/4PREyAph7Gi50E8x6XFX2RIKufm3NYgCRo
	xD+0stdmC/cbEWobkH/e/YB9EgK6T8U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, david@redhat.com, chengming.zhou@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH linux-next v3 0/6] memcg: Support per-memcg KSM metrics
Message-ID: <4sunwlleii5mrlwvnio4rm4uvrngzcdbsig7xer3ytyixpu543@7dlwpeeocjbl>
References: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
X-Migadu-Flow: FLOW_OUT

Hi Xu,

On Sun, Sep 21, 2025 at 11:07:26PM +0800, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> v2->v3:
> ------
> Some fixes of compilation error due to missed inclusion of header or missed
> function definition on some kernel config.
> https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> 
> v1->v2:
> ------
> According to Shakeel's suggestion, expose these metric item into memory.stat
> instead of a new interface.
> https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> 
> Background
> ==========
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related metrics.
> 
> So add the counter in the existing memory.stat without adding a new interface.
> To diaplay per-memcg KSM statistic counters,  we traverse all processes of a
> memcg and summing the processes' ksm_rmap_items counters instead of adding enum
> item in memcg_stat_item or node_stat_item and updating the corresponding enum
> counter when ksmd manipulate pages.
> 
> Now Linux users can look up all per-memcg KSM counters by:
> 
> # cat /sys/fs/cgroup/xuxin/memory.stat | grep ksm
> ksm_rmap_items 0
> ksm_zero_pages 0
> ksm_merging_pages 0
> ksm_profit 0
> 
> Q&A
> ====
> why don't I add enum item in memcg_stat_item or node_stat_item like
> other items in memory.stat ?
> 
> I tried the way of adding enum item in memcg_stat_item and updating them when
> ksmd manipulate pages, but it failed with error statistic ksm counters of
> memcg. This is because of the following reasons:
> 
> 1) The KSM counter of memcgroup can be correctly incremented, but cannot be
> properly decremented. E,g,, when ksmd scans pages of a process, it can use
> the mm_struct of the struct ksm_rmap_item to reverse-lookup the memcg
> and then increase the value via mod_memcg_state(memcg, MEMCG_KSM_COUNT, 1).
> However, when the process exits abruptly, since ksmd asynchronously scans
> the mmslot list in the background, it is no longer able to correctly locate
> the original memcg through mm_struct by get_mem_cgroup_from_mm(), as the
> task_struct has already been freed.
> 
> 2) The first issue could potentially be addressed by adding a memcg
> pointer directly into the ksm_rmap_item structure. However, this
> increases memory overhead, especially when there are a large
> number of ksm_rmap_items in the system (due to a high volume of
> pages being scanned by ksmd). Moreover, this approach does not
> resolve the same problem for ksm_zero_pages, because updates to
> ksm_zero_pages are not performed through ksm_rmap_item, but
> rather directly during unmap or page table entry (pte) faults
> based on the mm_struct. At that point, if the process has
> already exited, the corresponding memcg can no longer be
> accurately identified.
>

Thanks for writing this up and sorry to disappoint you but this
explanation is giving me more reasons that memcg is not the right place
for these stats.

If you take a look at the memcg stats exposed through memory.stat, there
are two generally two types. First are the ones that describe the type
or property of the underlying memory and that memory is associated or
charged to the memcg e.g. anon or file or kernel (and other types)
memory. Please note that this memory lifetime can be independent from
the process that might have allocated them.

Second are the events that are faced by the processes in that
memcg like page faults, reclaim etc.

The ksm stats are about the process and not about the memcg of the
process. Process jumping from one memcg to another will take all these
stats with it. You can easily get ksm stats in userspace by traversing
/proc/pids/ksm_stats with the pids from cgroup.procs. You are just
looking for an easier way to get such stats instead of manual traversal.
I would suggest exploring cgroup iter based bpf program which can do
the stats collect and expose to userspace for a given cgroup hierarchy.


