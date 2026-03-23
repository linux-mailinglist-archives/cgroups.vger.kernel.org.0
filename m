Return-Path: <cgroups+bounces-14986-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPUqEW7xwGkUOwQAu9opvQ
	(envelope-from <cgroups+bounces-14986-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:53:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52832EDE18
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1734C3004F1B
	for <lists+cgroups@lfdr.de>; Mon, 23 Mar 2026 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68F3630BB;
	Mon, 23 Mar 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoUOiYcw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B75362133;
	Mon, 23 Mar 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252395; cv=none; b=nVjJFmLet+LWm/Lxx4j8X2JSLualWQzHsvbiPPM+IxzA9SoZrQtXakqIWbzgVI/sTLrcBxKTJlgQV1SODOOFwSjustAANOZJz+f7gl8jBbvImUvfMUJCMZ0TPS5z0c4b6SLsCdO52hIPC0zxwNYfEEmFOEQ52ICB9EOI2v0xdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252395; c=relaxed/simple;
	bh=ep0hDSwCBGOnuJvxJme1oMbAirhVZHXupMETu8snQ4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuThdvCtUGQK9gethVxg0hQBPMShM5rn5Ap4mlsYEOuP0pmjY5YQSJg2wx9GtFYH025A9WOZZBVOTLMDRnAdwloMNAkhZXXUEcwmoK/EuNXz7Jh2XZCTkFr9wThGferVM4rK/KL6un32+UzB42QHdIpgnoLsXOwdqIT9ZD/NKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoUOiYcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1A8C4CEF7;
	Mon, 23 Mar 2026 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252394;
	bh=ep0hDSwCBGOnuJvxJme1oMbAirhVZHXupMETu8snQ4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NoUOiYcwo/H7w+dsYAyFCvOVNzzuboDFucLEAGhVJsh7zhirN/JAuNuWb0IChI9YA
	 9vacG2nDCrg4TOJCH796WyyHEbOdUj3Aa+3UtJY1Dfadu4cwp7rNVm3Sm7lQiFtaip
	 jMomh59jceywvp/GIcqbU0lzcwFWAN1r/xkmxSD7p/xu7/U4U3WkKGImyP7YS7t9NH
	 R4jDo3sditHBH6CeIMfspKwqM2K8ekpeVDT6WOasAdfhcDqeQ0MQmD0j4BDk5p4+1G
	 4kXhH2gwBcnwv0DFDxUPMmYMGdOUpmSvIENx8GDttcQfl6Z68qPMvt8k4kpdZy5Ntr
	 C5f2nbGbZY1dw==
Date: Mon, 23 Mar 2026 16:53:12 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	chenridong@huaweicloud.com, mkoutny@suse.com,
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com, lance.yang@linux.dev, bhe@redhat.com,
	usamaarif642@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH v6 30/33] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-ID: <acDxaEgnqPI-Z4be@hyeyoo>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
 <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e862995c45a7101a541284b6ebee5e5c32c89066.1772711148.git.zhengqi.arch@bytedance.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14986-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: D52832EDE18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 07:52:48PM +0800, Qi Zheng wrote:
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
> 
> Co-developed-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  kernel/cgroup/cgroup.c |  9 ++--
>  mm/memcontrol-v1.c     | 16 +++++++
>  mm/memcontrol-v1.h     |  7 +++
>  mm/memcontrol.c        | 97 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 125 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 23b70bd80ddc9..b0519a16f5684 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -473,6 +501,30 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return x;
>  }
>  
> +#ifdef CONFIG_MEMCG_V1
> +static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
> +				     enum node_stat_item idx, int val);
> +
> +void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
> +				       struct mem_cgroup *parent, int idx)
> +{
> +	int nid;
> +
> +	for_each_node(nid) {
> +		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
> +		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
> +		struct mem_cgroup_per_node *child_pn, *parent_pn;
> +
> +		child_pn = container_of(child_lruvec, struct mem_cgroup_per_node, lruvec);
> +		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
> +
> +		__mod_memcg_lruvec_state(child_pn, idx, -value);
> +		__mod_memcg_lruvec_state(parent_pn, idx, value);

We should probably change the type of `@val` from int to val to avoid
losing non hierarchical stats during reparenting?

>  #ifdef CONFIG_MEMCG_V1
>  static void __mod_memcg_state(struct mem_cgroup *memcg,
>  			      enum memcg_stat_item idx, int val)
>
> @@ -769,6 +857,15 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
>  #endif
>  	return x;
>  }
> +
> +void reparent_memcg_state_local(struct mem_cgroup *memcg,
> +				struct mem_cgroup *parent, int idx)
> +{
> +	unsigned long value = memcg_page_state_local(memcg, idx);
> +
> +	__mod_memcg_state(memcg, idx, -value);
> +	__mod_memcg_state(parent, idx, value);
> +}

Same here.

Otherwise LGTM.

>  #endif
>  
>  static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,

-- 
Cheers,
Harry / Hyeonggon

