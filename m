Return-Path: <cgroups+bounces-13348-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GqmNr/3cGmgbAAAu9opvQ
	(envelope-from <cgroups+bounces-13348-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 16:58:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7159924
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 16:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81C6F68E9C0
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E355C4A33F7;
	Wed, 21 Jan 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ3Rldgf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2E4A3405
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007518; cv=none; b=k0UBS4mcv+P1+iuJzhgtGLVBFoEP22QcyrbI6vJvXc4V0yKf5BiLAk9YAd2K80j84wSvEKPKqClCGDhE6aR43Q2i60nSj2YIPkOatAteVRQwToUE/MFsIg8B0rDhAWXHY9jR/P0ndPNLu4ZXMLFXhbods/crvsv18VUpLLShtn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007518; c=relaxed/simple;
	bh=+OwBnIlWcgkstsBQ2nMNm7ynJcQbUy4My6NYE9UynHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFHTNpHXr9q/UuiHFZgMrm7nRjsA/9TFQzGO05orPcIGZMwwQSvifU8O5FH7cwt8yHY9iuNv86XC74Rb5WVqaFLw9GAAvYcUYhhVN8kEziF8TBSfPPBqQqOIvoI3gwg7GBU/Rfkvea5gBah4xooG1yrZqQ0ZyrRPuClg9JR9hfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ3Rldgf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7afb2cf09so4614435ad.3
        for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769007516; x=1769612316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UpnJM6r29OmlECz6ZZJlv11hzQUIyaYlzl/s4DXsy2Q=;
        b=WQ3RldgfTDTYXmznnbH713BQ3GkU5GIkUehJNgZpdrZQxs0LsdrYjQn/maUr/UoakB
         8mOWZ4XNAKYRXUFEHnLXQxjSouixWmXQmkIufNY8U5jdIY3K4ObLO1lJzXeYJaaF6Y00
         pQbPiD9Y5lFJ1OGqWl6qsvBf1vq70mi2tEJwV58/2F252AqSJDoa2herbjR5bvM/SrDj
         pnNY9cmGjtOLr1N3mC9+obWMILEYF/ZPFcfJIgxCWRHkGeSMFA+3dUSkAz12fAe77oMm
         tv8Wk+7U6ZNq6Gf3tHvu/uAbEg0L6sgnDOZJqLhH7EQYY73F8esqEZrNYe8Y/AxVSJs/
         F2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007516; x=1769612316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpnJM6r29OmlECz6ZZJlv11hzQUIyaYlzl/s4DXsy2Q=;
        b=MqKrpmvFcsM5A9TOyCBoDKEPp4Fyf6tPus7gJ/lY3iLEBGIm9j5xcETOeOHCd2/APa
         r9Af29QVvu+NIHey71oR4k0X0K4LO/shbShnkMyVcajPBKBAKxnJgWus2egrra8kc+EZ
         MmiWWqqo4bixh5oF0e9JvgUeHBgZqghI50IysMF/hY70lahWCBmmcu6x3ZkQhXUI03UB
         IMPsrzrGqgPlpSsD20s0d4jDE5bCgor4EAdIWthhlfGPuPuOkL+KegBi+Dh68VI6Th+j
         GzrZYlOnM3XQ6ZKXGXuHt/t6+ungaliGmTATd6taaODTVcbhyVcssdB0w+2s3siPTj/m
         REew==
X-Forwarded-Encrypted: i=1; AJvYcCVchI+ofTZdfQFubRISBU5NS1YqGJ/3lUEv1xjNkUr9JvU0mSUCAIyUsrB13yuV807FmwxcsMSG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywos8Gc4AGK1KvZ7BZ3AaYj4w1NXWHQ6V6VNmnH8uHN9tnrUkj1
	08xpS/zGa0PZrPjgNQSus9yNVIWJzxxzygKkb3oFF5dktHxdLYG5iF8l
X-Gm-Gg: AZuq6aJKB9ZG9uvQCWbcU+EQeh/Tf7FYQEGn7E8Vo/4600kOyLpmqKYHFu0B+fD88VL
	ahGh8OYPh7+gbjaFHzePR1HEc9He4enS12CLHlSPEs81jN4nr7FJBZr8VzrGWRLnZrdRBUD5Y6T
	Te4p3nyyW+qNF1LKSIN8LlLCRr4Z02aSMDpaI4i0jphzHG6ILgPhhWjfh3qiOdE/3mfywkp3h2B
	3Aq3bWQWJQgtf2Cjp/rvxp+mPNE+L2GC9JDcFclieDU64GPNWiV1k/TE+W50g9+YvBMnn2zro0k
	SbC9yT3w7ifscL29CboyYdJF1BQKv7bWKHz93eCibRm5X5S/nD5yp5cYYVhv61mAS6C53pA0yA7
	4kwLrw5/ulBdoO6laox9hlMc/ZQ8MORUJ0ibNupYJyXuEw4sgrsB2B/akSmnfpnJQ8LRR4SOyqJ
	WOa/5//D84jPnjU/CGdbg7Q/DLOkUGBG1HExjr6nrHdVXzqyI=
X-Received: by 2002:a17:902:c949:b0:2a1:3cd8:d2df with SMTP id d9443c01a7336-2a7177db71fmr179679185ad.54.1769007515562;
        Wed, 21 Jan 2026 06:58:35 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7646119b4sm53170045ad.71.2026.01.21.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:58:34 -0800 (PST)
Date: Wed, 21 Jan 2026 22:58:27 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	zhengqi.arch@bytedance.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [RFC PATCH -next 1/7] vmscan: add memcg heat level for reclaim
Message-ID: <aXDfTiDrUHbQaFWX@KASONG-MC4>
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
 <20260120134256.2271710-2-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120134256.2271710-2-chenridong@huaweicloud.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13348-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 4DC7159924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 01:42:50PM +0800, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The memcg LRU was originally introduced to improve scalability during
> global reclaim. However, it is complex and only works with gen lru
> global reclaim. Moreover, its implementation complexity has led to
> performance regressions when handling a large number of memory cgroups [1].
> 
> This patch introduces a per-memcg heat level for reclaim, aiming to unify
> gen lru and traditional LRU global reclaim. The core idea is to track
> per-node per-memcg reclaim state, including heat, last_decay, and
> last_refault. The last_refault records the total reclaimed data from the
> previous memcg reclaim. The last_decay is a time-based parameter; the heat
> level decays over time if the memcg is not reclaimed again. Both last_decay
> and last_refault are used to calculate the current heat level when reclaim
> starts.
> 
> Three reclaim heat levels are defined: cold, warm, and hot. Cold memcgs are
> reclaimed first; only if cold memcgs cannot reclaim enough pages, warm
> memcgs become eligible for reclaim. Hot memcgs are reclaimed last.
> 
> While this design can be applied to all memcg reclaim scenarios, this patch
> is conservative and only introduces heat levels for traditional LRU global
> reclaim. Subsequent patches will replace the memcg LRU with
> heat-level-based reclaim.
> 
> Based on tests provided by YU Zhao, traditional LRU global reclaim shows
> significant performance improvement with heat-level reclaim enabled.
> 
> The results below are from a 2-hour run of the test [2].
> 
> Throughput (number of requests)		before	   after	Change
> Total					1734169    2353717	+35%
> 
> Tail latency (number of requests)	before	   after	Change
> [128s, inf)				1231	   1057		-14%
> [64s, 128s)				586	   444		-24%
> [32s, 64s)				1658	   1061		-36%
> [16s, 32s)				4611	   2863		-38%
> 
> [1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
> [2] https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/

Hi Ridong,

Thanks very much for checking the test! The benchmark looks good.

While I don't have strong opinion on the whole approach yet as I'm
still checking the whole series. But I have some comment and question
for this patch:

> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/memcontrol.h |   7 ++
>  mm/memcontrol.c            |   3 +
>  mm/vmscan.c                | 227 +++++++++++++++++++++++++++++--------
>  3 files changed, 192 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index af352cabedba..b293caf70034 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -76,6 +76,12 @@ struct memcg_vmstats;
>  struct lruvec_stats_percpu;
>  struct lruvec_stats;
>  
> +struct memcg_reclaim_state {
> +	atomic_long_t heat;
> +	unsigned long last_decay;
> +	atomic_long_t last_refault;
> +};
> +
>  struct mem_cgroup_reclaim_iter {
>  	struct mem_cgroup *position;
>  	/* scan generation, increased every round-trip */
> @@ -114,6 +120,7 @@ struct mem_cgroup_per_node {
>  	CACHELINE_PADDING(_pad2_);
>  	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>  	struct mem_cgroup_reclaim_iter	iter;
> +	struct memcg_reclaim_state	reclaim;
>  
>  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
>  	/* slab stats for nmi context */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f2b87e02574e..675d49ad7e2c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3713,6 +3713,9 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  
>  	lruvec_init(&pn->lruvec);
>  	pn->memcg = memcg;
> +	atomic_long_set(&pn->reclaim.heat, 0);
> +	pn->reclaim.last_decay = jiffies;
> +	atomic_long_set(&pn->reclaim.last_refault, 0);
>  
>  	memcg->nodeinfo[node] = pn;
>  	return true;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4aa73f125772..3759cd52c336 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5978,6 +5978,124 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>  	return inactive_lru_pages > pages_for_compaction;
>  }
>  
> +enum memcg_scan_level {
> +	MEMCG_LEVEL_COLD,
> +	MEMCG_LEVEL_WARM,
> +	MEMCG_LEVEL_HOT,
> +	MEMCG_LEVEL_MAX,
> +};

This looks similar to MEMCG_LRU_HEAD, MEMCG_LRU_TAIL, MEMCG_LRU_OLD,
MEMCG_LRU_YOUNG of the memcg LRU? But now it's unaware of the aging event?

> +
> +#define MEMCG_HEAT_WARM		4
> +#define MEMCG_HEAT_HOT		8
> +#define MEMCG_HEAT_MAX		12
> +#define MEMCG_HEAT_DECAY_STEP	1
> +#define MEMCG_HEAT_DECAY_INTERVAL	(1 * HZ)

This is a hardcoded interval (1s), but memcg_decay_heat is driven by reclaim
which is kind of random, could be very frequent or not happening at all,
that doesn't look pretty by first look.

> +
> +static void memcg_adjust_heat(struct mem_cgroup_per_node *pn, long delta)
> +{
> +	long heat, new_heat;
> +
> +	if (mem_cgroup_is_root(pn->memcg))
> +		return;
> +
> +	heat = atomic_long_read(&pn->reclaim.heat);
> +	do {
> +		new_heat = clamp_t(long, heat + delta, 0, MEMCG_HEAT_MAX);

The hotness range is 0 - 12, is that a suitable value for all setup and
workloads?

> +		if (atomic_long_cmpxchg(&pn->reclaim.heat, heat, new_heat) == heat)
> +			break;
> +		heat = atomic_long_read(&pn->reclaim.heat);
> +	} while (1);
> +}
> +
> +static void memcg_decay_heat(struct mem_cgroup_per_node *pn)
> +{
> +	unsigned long last;
> +	unsigned long now = jiffies;
> +
> +	if (mem_cgroup_is_root(pn->memcg))
> +		return;
> +
> +	last = READ_ONCE(pn->reclaim.last_decay);
> +	if (!time_after(now, last + MEMCG_HEAT_DECAY_INTERVAL))
> +		return;
> +
> +	if (cmpxchg(&pn->reclaim.last_decay, last, now) != last)
> +		return;
> +
> +	memcg_adjust_heat(pn, -MEMCG_HEAT_DECAY_STEP);
> +}
> +
> +static int memcg_heat_level(struct mem_cgroup_per_node *pn)
> +{
> +	long heat;
> +
> +	if (mem_cgroup_is_root(pn->memcg))
> +		return MEMCG_LEVEL_COLD;
> +
> +	memcg_decay_heat(pn);
> +	heat = atomic_long_read(&pn->reclaim.heat);
> +
> +	if (heat >= MEMCG_HEAT_HOT)
> +		return MEMCG_LEVEL_HOT;
> +	if (heat >= MEMCG_HEAT_WARM)
> +		return MEMCG_LEVEL_WARM;
> +	return MEMCG_LEVEL_COLD;
> +}
> +
> +static void memcg_record_reclaim_result(struct mem_cgroup_per_node *pn,
> +					struct lruvec *lruvec,
> +					unsigned long scanned,
> +					unsigned long reclaimed)
> +{
> +	long delta;
> +
> +	if (mem_cgroup_is_root(pn->memcg))
> +		return;
> +
> +	memcg_decay_heat(pn);
> +
> +	/*
> +	 * Memory cgroup heat adjustment algorithm:
> +	 * - If scanned == 0: mark as hottest (+MAX_HEAT)
> +	 * - If reclaimed >= 50% * scanned: strong cool (-2)
> +	 * - If reclaimed >= 25% * scanned: mild cool (-1)
> +	 * - Otherwise:  warm up (+1)

The naming is bit of confusing I think, no scan doesn't mean it's all hot.
Maybe you mean no reclaim? No scan could also mean a empty memcg?

> +	 */
> +	if (!scanned)
> +		delta = MEMCG_HEAT_MAX;
> +	else if (reclaimed * 2 >= scanned)
> +		delta = -2;
> +	else if (reclaimed * 4 >= scanned)
> +		delta = -1;
> +	else
> +		delta = 1;
> +
> +	/*
> +	 * Refault-based heat adjustment:
> +	 * - If refault increase > reclaimed pages: heat up (more cautious reclaim)
> +	 * - If no refaults and currently warm:     cool down (allow more reclaim)
> +	 * This prevents thrashing by backing off when refaults indicate over-reclaim.
> +	 */
> +	if (lruvec) {
> +		unsigned long total_refaults;
> +		unsigned long prev;
> +		long refault_delta;
> +
> +		total_refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_ANON);
> +		total_refaults += lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_FILE);

I think you want WORKINGSET_REFAULT_* or WORKINGSET_RESTORE_* here.

> +
> +		prev = atomic_long_xchg(&pn->reclaim.last_refault, total_refaults);
> +		refault_delta = total_refaults - prev;
> +
> +		if (refault_delta > reclaimed)
> +			delta++;
> +		else if (!refault_delta && delta > 0)
> +			delta--;
> +	}
> +
> +	memcg_adjust_heat(pn, delta);
> +}
> +
>  static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
> @@ -5986,7 +6104,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  	};
>  	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
>  	struct mem_cgroup *memcg;
> -
> +	int level;
> +	int max_level = root_reclaim(sc) ? MEMCG_LEVEL_MAX : MEMCG_LEVEL_WARM;

Why limit to MEMCG_LEVEL_WARM when it's not a root reclaim?

>  	/*
>  	 * In most cases, direct reclaimers can do partial walks
>  	 * through the cgroup tree, using an iterator state that
> @@ -5999,62 +6118,80 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  	if (current_is_kswapd() || sc->memcg_full_walk)
>  		partial = NULL;
>  
> -	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
> -	do {
> -		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -		unsigned long reclaimed;
> -		unsigned long scanned;
> -
> -		/*
> -		 * This loop can become CPU-bound when target memcgs
> -		 * aren't eligible for reclaim - either because they
> -		 * don't have any reclaimable pages, or because their
> -		 * memory is explicitly protected. Avoid soft lockups.
> -		 */
> -		cond_resched();
> +	for (level = MEMCG_LEVEL_COLD; level < max_level; level++) {
> +		bool need_next_level = false;
>  
> -		mem_cgroup_calculate_protection(target_memcg, memcg);
> +		memcg = mem_cgroup_iter(target_memcg, NULL, partial);
> +		do {
> +			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +			unsigned long reclaimed;
> +			unsigned long scanned;
> +			struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
>  
> -		if (mem_cgroup_below_min(target_memcg, memcg)) {
> -			/*
> -			 * Hard protection.
> -			 * If there is no reclaimable memory, OOM.
> -			 */
> -			continue;
> -		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
>  			/*
> -			 * Soft protection.
> -			 * Respect the protection only as long as
> -			 * there is an unprotected supply
> -			 * of reclaimable memory from other cgroups.
> +			 * This loop can become CPU-bound when target memcgs
> +			 * aren't eligible for reclaim - either because they
> +			 * don't have any reclaimable pages, or because their
> +			 * memory is explicitly protected. Avoid soft lockups.
>  			 */
> -			if (!sc->memcg_low_reclaim) {
> -				sc->memcg_low_skipped = 1;
> +			cond_resched();
> +
> +			mem_cgroup_calculate_protection(target_memcg, memcg);
> +
> +			if (mem_cgroup_below_min(target_memcg, memcg)) {
> +				/*
> +				 * Hard protection.
> +				 * If there is no reclaimable memory, OOM.
> +				 */
>  				continue;
> +			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
> +				/*
> +				 * Soft protection.
> +				 * Respect the protection only as long as
> +				 * there is an unprotected supply
> +				 * of reclaimable memory from other cgroups.
> +				 */
> +				if (!sc->memcg_low_reclaim) {
> +					sc->memcg_low_skipped = 1;
> +					continue;
> +				}
> +				memcg_memory_event(memcg, MEMCG_LOW);
>  			}
> -			memcg_memory_event(memcg, MEMCG_LOW);
> -		}
>  
> -		reclaimed = sc->nr_reclaimed;
> -		scanned = sc->nr_scanned;
> +			if (root_reclaim(sc) && memcg_heat_level(pn) > level) {
> +				need_next_level = true;
> +				continue;
> +			}
>  
> -		shrink_lruvec(lruvec, sc);
> +			reclaimed = sc->nr_reclaimed;
> +			scanned = sc->nr_scanned;
>  
> -		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> -			    sc->priority);
> +			shrink_lruvec(lruvec, sc);
> +			if (!memcg || memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B))

If we might have memcg == NULL here, the pn = memcg->nodeinfo[pgdat->node_id]
and other memcg operations above looks kind of dangerous.

Also why check NR_SLAB_RECLAIMABLE_B if there wasn't such a check previously?
Maybe worth a separate patch.

> +				shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> +					    sc->priority);
>  
> -		/* Record the group's reclaim efficiency */
> -		if (!sc->proactive)
> -			vmpressure(sc->gfp_mask, memcg, false,
> -				   sc->nr_scanned - scanned,
> -				   sc->nr_reclaimed - reclaimed);
> +			if (root_reclaim(sc))
> +				memcg_record_reclaim_result(pn, lruvec,
> +						    sc->nr_scanned - scanned,
> +						    sc->nr_reclaimed - reclaimed);

Why only record the reclaim result for root_reclaim?

>  
> -		/* If partial walks are allowed, bail once goal is reached */
> -		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
> -			mem_cgroup_iter_break(target_memcg, memcg);
> +			/* Record the group's reclaim efficiency */
> +			if (!sc->proactive)
> +				vmpressure(sc->gfp_mask, memcg, false,
> +					   sc->nr_scanned - scanned,
> +					   sc->nr_reclaimed - reclaimed);
> +
> +			/* If partial walks are allowed, bail once goal is reached */
> +			if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
> +				mem_cgroup_iter_break(target_memcg, memcg);
> +				break;
> +			}
> +		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
> +
> +		if (!need_next_level)
>  			break;
> -		}
> -	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
> +	}

IIUC you are iterating all the memcg's for up to MEMCG_LEVEL_MAX times and
only reclaim certain memcg in each iteration. I think in theory some workload
may have a higher overhead since there are actually more iterations, and
will this break the reclaim fairness?

>  }
>  
>  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> -- 
> 2.34.1

