Return-Path: <cgroups+bounces-14407-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGtZN+6vn2kAdQQAu9opvQ
	(envelope-from <cgroups+bounces-14407-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:29:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EEF1A01C1
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1298303FFFA
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 02:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D65377556;
	Thu, 26 Feb 2026 02:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="inLRTyPS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727637648D
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772072905; cv=none; b=GTXjXx1smeIKC/RelUs7raDpj5pvZuhRcb5qmgrr3ImQmvaZab7txbnC97UO5+c5YypIqrIBJBbf9yHCFRfXcg5JpB6nkMC2ew/zBBwbv8zhpfTp0cWi4p92An/DLQZZIq6u2GDMjHhe9er9Q7g180VYeqtBUyrkFmhOnFaW6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772072905; c=relaxed/simple;
	bh=m3Y5OU4vPC5Kug79bnRfmWT3RINZid7mrn+RWwWruF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuzK6PnJFLHFfehjGgaoAOSwvtvwmvQOfI0MbsrunsxLXBZge/l8oOwAlbpPP8dC4uvVclyE7+1gxPBIOP5d/C1n8r7rCrqPAxccXH+vUsUu7+abRDw++kvB8Wmph3gSkLtuEjj8JVTXufVPR1k7BnLP/HYZf0e8CAqpbXp+9Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=inLRTyPS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 18:27:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772072890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J8G7n0G5IvJbjAWS80AASD+GlHfDZ2XYW2oW2fVo6QM=;
	b=inLRTyPSomd7cx4tU1l+xytkHbPVoB+tKgvlzV/f7mXEW2S2TI31JThNxm3yX9SBJdI5p1
	i0VoBYNMyPj1gMmS3Ptyr4w2cftRfMimJ/kcnc7uxjbuoeeEjCNe2dKfi5gncND2OYLgLN
	KjtZfn55mBY7Dw+8pMmY+l0Ybo4QO+Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 update 30/32] mm: memcontrol: convert objcg to be
 per-memcg per-node type
Message-ID: <aZ-uNV1biPYLhJ48@linux.dev>
References: <0f915487ffc653cf6ea19335c21c01aa06004641.1772005110.git.zhengqi.arch@bytedance.com>
 <20260225094456.74145-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225094456.74145-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14407-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 41EEF1A01C1
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:44:56PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Convert objcg to be per-memcg per-node type, so that when reparent LRU
> folios later, we can hold the lru lock at the node level, thus avoiding
> holding too many lru locks at once.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> changlog:
>  - fix a missing root_obj_cgroup conversion and completely delete
>    root_obj_cgroup.
> 
>  include/linux/memcontrol.h | 23 +++++------
>  include/linux/sched.h      |  2 +-
>  mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
>  3 files changed, 62 insertions(+), 42 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 45d911dd903e7..6e11552a90618 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -116,6 +116,16 @@ struct mem_cgroup_per_node {
>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>  	struct mem_cgroup_reclaim_iter	iter;
>  
> +	/*
> +	 * objcg is wiped out as a part of the objcg repaprenting process.
> +	 * orig_objcg preserves a pointer (and a reference) to the original
> +	 * objcg until the end of live of memcg.
> +	 */
> +	struct obj_cgroup __rcu	*objcg;
> +	struct obj_cgroup	*orig_objcg;

The layout of struct mem_cgroup_per_node is very performance sensitive. Please
couple of performance benchmarks after rearranging the fields particularly the
above two pointers together at the start of the struct.

Otherwise:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

