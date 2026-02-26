Return-Path: <cgroups+bounces-14406-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SZbaN4Cln2mHdAQAu9opvQ
	(envelope-from <cgroups+bounces-14406-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 02:44:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D719FE87
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 02:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8D5305DA44
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49E372B21;
	Thu, 26 Feb 2026 01:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DBpR2vEH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7C1E505
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070130; cv=none; b=Ddea44KkMwlG57Vy0bOlMV6PoXADE6EnZqehmk2J54xDxA/WOO2h01qN7BueZ/dOA/LHipf1lo9WTnDnECAx/qhLEkA6EXdvVdYZ5Dt8RWvVP8q8h1zFWniM7hwicBBRHXJvWdTT2m5xoWX80uCSSiTW0KE+U+D630z3uEn4OtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070130; c=relaxed/simple;
	bh=/LKqdjFoiQ04/XIA87m3i7gEF0FyoRJDwONhXGMRjXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwuymNv3nLanjVQrj3ZHA9/S+I6Sc6/1GZUv/Nmcctr0KeCXPfjj7qjKADUAuYMdSze6c7UgmB9xHw8GB8utn42y1xvZfwKEg3FnvVwSs8A3fxygBbwoHpb3AaJnE4++p0uyVFwxKSH0uMUPxMg394jRfpofJcq+rZpE+/qA0dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DBpR2vEH; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 17:41:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772070116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCvGmCmilt3Iav7ktXIbGgvFCADiAsVJLuTgICHbbvU=;
	b=DBpR2vEHIC7mO2TzWh+tPoXu1M0seTK3lc9QNrkr4WCCR0KRQGf/X0U8dUG6eoOfO/W5Eo
	QoZ6Lz1NfN4dRNNpPK000BXyGzhaRdY9c2l3lawHKeoxcAk42kCxcc5L15Bmf2X39OjXIS
	Ufk8H2HzfJmRbO1VmozjxmiaJ7e4so4=
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
Subject: Re: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <aZ-kefGBeT-RzGcG@linux.dev>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
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
	TAGGED_FROM(0.00)[bounces-14406-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 861D719FE87
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:53:12PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> To resolve the dying memcg issue, we need to reparent LRU folios of child
> memcg to its parent memcg. This could cause problems for non-hierarchical
> stats.
> 
> As Yosry Ahmed pointed out:
> 
> ```
> In short, if memory is charged to a dying cgroup at the time of
> reparenting, when the memory gets uncharged the stats updates will occur
> at the parent. This will update both hierarchical and non-hierarchical
> stats of the parent, which would corrupt the parent's non-hierarchical
> stats (because those counters were never incremented when the memory was
> charged).
> ```
> 
> Now we have the following two types of non-hierarchical stats, and they
> are only used in CONFIG_MEMCG_V1:
> 
> a. memcg->vmstats->state_local[i]
> b. pn->lruvec_stats->state_local[i]
> 
> To ensure that these non-hierarchical stats work properly, we need to
> reparent these non-hierarchical stats after reparenting LRU folios. To
> this end, this commit makes the following preparations:
> 
> 1. implement reparent_state_local() to reparent non-hierarchical stats
> 2. make css_killed_work_fn() to be called in rcu work, and implement
>    get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>    between mod_memcg_state()/mod_memcg_lruvec_state()
>    and reparent_state_local()
> 3. change these non-hierarchical stats to atomic_long_t type to avoid race
>    between mem_cgroup_stat_aggregate() and reparent_state_local()
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

[...]

> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -45,6 +45,7 @@ static inline bool do_memsw_account(void)
>  
>  unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
>  unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
> +void mod_memcg_page_state_local(struct mem_cgroup *memcg, int idx, unsigned long val);

The above seems like addition by mistake.

After fixing this, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


