Return-Path: <cgroups+bounces-16084-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPq8JrBzDGqihwUAu9opvQ
	(envelope-from <cgroups+bounces-16084-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:29:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE6580886
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ADC1307B164
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88422ED846;
	Tue, 19 May 2026 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neS7SnKW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7DB2F260C
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200614; cv=none; b=PexM9WnF0F5IeSuEOmizqNzpmlldBz5uOEkYRXDBsIQvLQLl1OOFcKI1zPqCr3ULUw+629dP8ZnXK+jUdiDyBKHlOQagajFGlCG/Vmxt93DXe3Y8I2uWFLISP4Jz2C0VwiyWWnAmcafZf/9apsMG0xea028bTOAx/e9MgdwlFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200614; c=relaxed/simple;
	bh=8ifH/UA+VgeuASfq1b3ZvQZY1J2+sKJcLYTTdo2Xc8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8f6Kd8RfV4T97jrU7mGM0b50CiLY4g7jwZlVaPfAvQSpEi0QR0R54tuKvlKWV5+bpLPZ/V3Vu6/RDYBTQPWo4pIXN2UqT0mdVE9A6CGmcI1lNa0vT6erVGus/4N+ZV2ZCZuSPPLV8WBdkEvZaoEuX8QFOjVFttWf+TPl8H88Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neS7SnKW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 07:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779200599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyW1YOk9r0m548R3B54+4mgbQrewwLREY/skBzhD8RY=;
	b=neS7SnKWEcrDEAwGy+eGkdpjaleJUkspHWnNERsyY6JNMwKQWMgs8GX0M2ynIVKdT6LRNO
	FLuzIxip1qQwS7eJ+++PfUsCcTq1RxJg/niShpyPZLwYvOVTVTudRNJNEkApgMpRuNRZn6
	l+/f+NIHYrFg1nCH7xi4UlRGvy4vGtg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Carlier <devnexen@gmail.com>, Allen Pais <apais@linux.microsoft.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Baoquan He <bhe@redhat.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	David Hildenbrand <david@kernel.org>, Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	Imran Khan <imran.f.khan@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>, Lance Yang <lance.yang@linux.dev>, 
	Liam Howlett <Liam.Howlett@oracle.com>, Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Muchun Song <songmuchun@bytedance.com>, 
	Nhat Pham <nphamcs@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>, Yosry Ahmed <yosry@kernel.org>, 
	Yuanchu Xie <yuanchu@google.com>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
Message-ID: <agxxuHOfNLX-32kI@linux.dev>
References: <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
 <agoYp1zW9afZ6uQz@linux.dev>
 <agtATZG9mIlYzMUl@linux.dev>
 <agtPMpQK2jXdQAY4@linux.dev>
 <agvvRNJTAtNkCVZc@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agvvRNJTAtNkCVZc@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16084-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D9CE6580886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Oliver,

On Tue, May 19, 2026 at 01:04:04PM +0800, Oliver Sang wrote:
> hi, Shakeel,
> 
> On Mon, May 18, 2026 at 10:54:20AM -0700, Shakeel Butt wrote:
> > On Mon, May 18, 2026 at 09:39:00AM -0700, Shakeel Butt wrote:
> > > On Sun, May 17, 2026 at 12:38:48PM -0700, Shakeel Butt wrote:
> > > > On Sun, May 17, 2026 at 08:55:50PM +0800, Oliver Sang wrote:
> > > > > hi, Shakeel, hi, Qi,
> > > > > 
> > > > > #2: when we test above patch, we found the server easy to crash while running
> > > > > tests. we try to run up to 20 times, only 2 of them run successfully (above
> > > > > 37739220 is just the average data from these 2 runs, since the data is stable,
> > > > > we think maybe it's ok to report to you with this data).
> > > > > we also noticed for [1] there is a [syzbot ci] report in [2]. since we don't
> > > > > have serial output for our test server in this report which is for performance
> > > > > tests, we cannot say if other 18 runs failed due to similar reason. just FYI.
> > > > > 
> > > > 
> > > > The syzbot report is simply a rcu warning which will be fixed in v2. Do you
> > > > have more details on the crash you are seeing? Is it page counter underflow
> > > > warning?
> > > > 
> > > > Thanks again for the help.
> > > 
> > > Hi Oliver, it seems like sashiko found another issue with v2, so, if you have
> > > not yet started the test, you can skip it.
> 
> firstly, let me still give you an update about v2. I applied it directly on top
> of 01b9da291c, found it can recover the performance.
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s
> 
> commit: 
>   8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
>   01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>   8da1b1ea43 ("memcg: cache obj_stock by memcg, not by objcg pointer")   <---- v2
> 
> 8285917d6f383aef 01b9da291c4969354807b52956f 8da1b1ea4344c152a3892cbb132
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       5849          +210.2%      18145 ±  3%      +0.8%       5896        stress-ng.switch.nanosecs_per_context_switch_mq_method
>  2.296e+09           -67.7%  7.408e+08 ±  3%      -0.8%  2.278e+09        stress-ng.switch.ops
>   38288993           -67.7%   12355813 ±  3%      -0.8%   37987427        stress-ng.switch.ops_per_sec
> 
> but since this version is out-of-date now, I won't give out the full
> comparison. if you still want it, please let me know.
>

Thanks a lot and this is good enough.

> > > 
> > > Also I am rethinking the approach, so I will send a prototype in response on
> > > this email for which I will need your help in testing.
> > 
> > Hi Oliver, can you please test the following patch?
> 
> got it. will change to test following patch. and this looks quite different
> with v2 or v3, so if you still want us to test v3, please let me know. thanks!
> 

No need to test v3 as it is similar to v2. Please test the following patch as it
is a direction I want to pursue and wanted an early signal if this is the right
direction.

> > 
> > From: Shakeel Butt <shakeel.butt@linux.dev>
> > Subject: [PATCH] memcg: shrink obj_stock_pcp and cache multiple objcgs
> > 
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 213 +++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 156 insertions(+), 57 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d978e18b9b2d..2a9e5136a956 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >  	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> >  	 *
> >  	 * The following sequence can lead to it:
> > -	 * 1) CPU0: objcg == stock->cached_objcg
> > +	 * 1) CPU0: objcg cached in one of stock->cached[i]
> >  	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
> >  	 *          PAGE_SIZE bytes are charged
> >  	 * 3) CPU1: a process from another memcg is allocating something,
> >  	 *          the stock if flushed,
> >  	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> >  	 * 5) CPU0: we do release this object,
> > -	 *          92 bytes are added to stock->nr_bytes
> > +	 *          92 bytes are added to stock->nr_bytes[i]
> >  	 * 6) CPU0: stock is flushed,
> >  	 *          92 bytes are added to objcg->nr_charged_bytes
> >  	 *
> > @@ -2017,13 +2017,25 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
> >  	.lock = INIT_LOCAL_TRYLOCK(lock),
> >  };
> >  
> > +/*
> > + * NR_OBJ_STOCK is sized so the entire hot path of obj_stock_pcp
> > + * (lock, accounting metadata, nr_bytes[] and cached[]) fits within a
> > + * single 64-byte cache line on non-debug 64-bit builds. With 5 slots:
> > + *   lock(1) + index(1) + node_id(2) + slab stats(4) + nr_bytes(10)
> > + *   + pad(6) + cached(40) == 64 bytes.
> > + * A CPU can thus consume/refill/account against five different objcgs
> > + * (typically per-node variants of the same memcg) while incurring at
> > + * most one cache miss on the stock.
> > + */
> > +#define NR_OBJ_STOCK 5
> >  struct obj_stock_pcp {
> >  	local_trylock_t lock;
> > -	unsigned int nr_bytes;
> > -	struct obj_cgroup *cached_objcg;
> > -	struct pglist_data *cached_pgdat;
> > -	int nr_slab_reclaimable_b;
> > -	int nr_slab_unreclaimable_b;
> > +	int8_t index;
> > +	int16_t node_id;
> > +	int16_t nr_slab_reclaimable_b;
> > +	int16_t nr_slab_unreclaimable_b;
> > +	uint16_t nr_bytes[NR_OBJ_STOCK];
> > +	struct obj_cgroup *cached[NR_OBJ_STOCK];
> >  
> >  	struct work_struct work;
> >  	unsigned long flags;
> > @@ -2031,10 +2043,13 @@ struct obj_stock_pcp {
> >  
> >  static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
> >  	.lock = INIT_LOCAL_TRYLOCK(lock),
> > +	.index = -1,
> > +	.node_id = NUMA_NO_NODE,
> >  };
> >  
> >  static DEFINE_MUTEX(percpu_charge_mutex);
> >  
> > +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i);
> >  static void drain_obj_stock(struct obj_stock_pcp *stock);
> >  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
> >  				     struct mem_cgroup *root_memcg);
> > @@ -3152,39 +3167,68 @@ static void unlock_stock(struct obj_stock_pcp *stock)
> >  		local_unlock(&obj_stock.lock);
> >  }
> >  
> > -/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
> > +/* Call after __refill_obj_stock() so a slot for objcg exists in the stock */
> >  static void __account_obj_stock(struct obj_cgroup *objcg,
> >  				struct obj_stock_pcp *stock, int nr,
> >  				struct pglist_data *pgdat, enum node_stat_item idx)
> >  {
> > -	int *bytes;
> > +	int16_t *bytes;
> > +	int i;
> >  
> > -	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
> > +	/*
> > +	 * node_id is stored as int16_t and -1 is used as the "no pgdat
> > +	 * cached" sentinel, so MAX_NUMNODES must fit in a positive int16_t.
> > +	 */
> > +	BUILD_BUG_ON(MAX_NUMNODES >= S16_MAX);
> > +
> > +	if (!stock)
> > +		goto direct;
> > +
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > +		if (READ_ONCE(stock->cached[i]) == objcg)
> > +			break;
> > +	}
> > +	if (i == NR_OBJ_STOCK)
> >  		goto direct;
> >  
> >  	/*
> >  	 * Save vmstat data in stock and skip vmstat array update unless
> > -	 * accumulating over a page of vmstat data or when pgdat changes.
> > +	 * accumulating over a page of vmstat data or when the objcg slot or
> > +	 * pgdat the stats belong to changes.
> >  	 */
> > -	if (stock->cached_pgdat != pgdat) {
> > -		/* Flush the existing cached vmstat data */
> > -		struct pglist_data *oldpg = stock->cached_pgdat;
> > +	if (stock->index < 0) {
> > +		stock->index = i;
> > +		stock->node_id = pgdat->node_id;
> > +	} else if (stock->index != i || stock->node_id != pgdat->node_id) {
> > +		struct obj_cgroup *old = READ_ONCE(stock->cached[stock->index]);
> > +		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
> >  
> >  		if (stock->nr_slab_reclaimable_b) {
> > -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
> > +			mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
> >  					  stock->nr_slab_reclaimable_b);
> >  			stock->nr_slab_reclaimable_b = 0;
> >  		}
> >  		if (stock->nr_slab_unreclaimable_b) {
> > -			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> > +			mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> >  					  stock->nr_slab_unreclaimable_b);
> >  			stock->nr_slab_unreclaimable_b = 0;
> >  		}
> > -		stock->cached_pgdat = pgdat;
> > +		stock->index = i;
> > +		stock->node_id = pgdat->node_id;
> >  	}
> >  
> >  	bytes = (idx == NR_SLAB_RECLAIMABLE_B) ? &stock->nr_slab_reclaimable_b
> >  					       : &stock->nr_slab_unreclaimable_b;
> > +	/*
> > +	 * Cached stats are int16_t; flush directly if accumulating @nr would
> > +	 * overflow or underflow the cache.
> > +	 */
> > +	if (abs(nr + *bytes) >= S16_MAX) {
> > +		nr += *bytes;
> > +		*bytes = 0;
> > +		goto direct;
> > +	}
> > +
> >  	/*
> >  	 * Even for large object >= PAGE_SIZE, the vmstat data will still be
> >  	 * cached locally at least once before pushing it out.
> > @@ -3210,10 +3254,16 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
> >  				struct obj_stock_pcp *stock,
> >  				unsigned int nr_bytes)
> >  {
> > -	if (objcg == READ_ONCE(stock->cached_objcg) &&
> > -	    stock->nr_bytes >= nr_bytes) {
> > -		stock->nr_bytes -= nr_bytes;
> > -		return true;
> > +	int i;
> > +
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > +		if (READ_ONCE(stock->cached[i]) != objcg)
> > +			continue;
> > +		if (stock->nr_bytes[i] >= nr_bytes) {
> > +			stock->nr_bytes[i] -= nr_bytes;
> > +			return true;
> > +		}
> > +		return false;
> >  	}
> >  
> >  	return false;
> > @@ -3234,16 +3284,42 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> >  	return ret;
> >  }
> >  
> > -static void drain_obj_stock(struct obj_stock_pcp *stock)
> > +/* Flush the cached slab stats (if any) back to their owning objcg/pgdat. */
> > +static void drain_obj_stock_stats(struct obj_stock_pcp *stock)
> > +{
> > +	struct obj_cgroup *old;
> > +	struct pglist_data *oldpg;
> > +
> > +	if (stock->index < 0)
> > +		return;
> > +
> > +	old = READ_ONCE(stock->cached[stock->index]);
> > +	oldpg = NODE_DATA(stock->node_id);
> > +
> > +	if (stock->nr_slab_reclaimable_b) {
> > +		mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
> > +				  stock->nr_slab_reclaimable_b);
> > +		stock->nr_slab_reclaimable_b = 0;
> > +	}
> > +	if (stock->nr_slab_unreclaimable_b) {
> > +		mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
> > +				  stock->nr_slab_unreclaimable_b);
> > +		stock->nr_slab_unreclaimable_b = 0;
> > +	}
> > +	stock->index = -1;
> > +	stock->node_id = NUMA_NO_NODE;
> > +}
> > +
> > +static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
> >  {
> > -	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
> > +	struct obj_cgroup *old = READ_ONCE(stock->cached[i]);
> >  
> >  	if (!old)
> >  		return;
> >  
> > -	if (stock->nr_bytes) {
> > -		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > -		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> > +	if (stock->nr_bytes[i]) {
> > +		unsigned int nr_pages = stock->nr_bytes[i] >> PAGE_SHIFT;
> > +		unsigned int nr_bytes = stock->nr_bytes[i] & (PAGE_SIZE - 1);
> >  
> >  		if (nr_pages) {
> >  			struct mem_cgroup *memcg;
> > @@ -3269,44 +3345,43 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
> >  		 * so it might be changed in the future.
> >  		 */
> >  		atomic_add(nr_bytes, &old->nr_charged_bytes);
> > -		stock->nr_bytes = 0;
> > +		stock->nr_bytes[i] = 0;
> >  	}
> >  
> > -	/*
> > -	 * Flush the vmstat data in current stock
> > -	 */
> > -	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
> > -		if (stock->nr_slab_reclaimable_b) {
> > -			mod_objcg_mlstate(old, stock->cached_pgdat,
> > -					  NR_SLAB_RECLAIMABLE_B,
> > -					  stock->nr_slab_reclaimable_b);
> > -			stock->nr_slab_reclaimable_b = 0;
> > -		}
> > -		if (stock->nr_slab_unreclaimable_b) {
> > -			mod_objcg_mlstate(old, stock->cached_pgdat,
> > -					  NR_SLAB_UNRECLAIMABLE_B,
> > -					  stock->nr_slab_unreclaimable_b);
> > -			stock->nr_slab_unreclaimable_b = 0;
> > -		}
> > -		stock->cached_pgdat = NULL;
> > -	}
> > +	/* Flush vmstat data when its owning slot is being drained. */
> > +	if (stock->index == i)
> > +		drain_obj_stock_stats(stock);
> >  
> > -	WRITE_ONCE(stock->cached_objcg, NULL);
> > +	WRITE_ONCE(stock->cached[i], NULL);
> >  	obj_cgroup_put(old);
> >  }
> >  
> > +static void drain_obj_stock(struct obj_stock_pcp *stock)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i)
> > +		drain_obj_stock_slot(stock, i);
> > +}
> > +
> >  static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
> >  				     struct mem_cgroup *root_memcg)
> >  {
> > -	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
> > +	struct obj_cgroup *objcg;
> >  	struct mem_cgroup *memcg;
> >  	bool flush = false;
> > +	int i;
> >  
> >  	rcu_read_lock();
> > -	if (objcg) {
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > +		objcg = READ_ONCE(stock->cached[i]);
> > +		if (!objcg)
> > +			continue;
> >  		memcg = obj_cgroup_memcg(objcg);
> > -		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> > +		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg)) {
> >  			flush = true;
> > +			break;
> > +		}
> >  	}
> >  	rcu_read_unlock();
> >  
> > @@ -3319,6 +3394,8 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >  			       bool allow_uncharge)
> >  {
> >  	unsigned int nr_pages = 0;
> > +	unsigned int stock_nr_bytes;
> > +	int i, slot = -1, empty_slot = -1;
> >  
> >  	if (!stock) {
> >  		nr_pages = nr_bytes >> PAGE_SHIFT;
> > @@ -3327,21 +3404,43 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> >  		goto out;
> >  	}
> >  
> > -	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > -		drain_obj_stock(stock);
> > +	for (i = 0; i < NR_OBJ_STOCK; ++i) {
> > +		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
> > +
> > +		if (!cached) {
> > +			if (empty_slot == -1)
> > +				empty_slot = i;
> > +			continue;
> > +		}
> > +		if (cached == objcg) {
> > +			slot = i;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (slot == -1) {
> > +		slot = empty_slot;
> > +		if (slot == -1) {
> > +			slot = get_random_u32_below(NR_OBJ_STOCK);
> > +			drain_obj_stock_slot(stock, slot);
> > +		}
> >  		obj_cgroup_get(objcg);
> > -		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > +		stock->nr_bytes[slot] = atomic_read(&objcg->nr_charged_bytes)
> >  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> > -		WRITE_ONCE(stock->cached_objcg, objcg);
> > +		WRITE_ONCE(stock->cached[slot], objcg);
> >  
> >  		allow_uncharge = true;	/* Allow uncharge when objcg changes */
> >  	}
> > -	stock->nr_bytes += nr_bytes;
> >  
> > -	if (allow_uncharge && (stock->nr_bytes > PAGE_SIZE)) {
> > -		nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > -		stock->nr_bytes &= (PAGE_SIZE - 1);
> > +	stock_nr_bytes = (unsigned int)stock->nr_bytes[slot] + nr_bytes;
> > +
> > +	/* nr_bytes[] is uint16_t; flush if we would refill >= U16_MAX. */
> > +	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
> > +	    stock_nr_bytes >= U16_MAX) {
> > +		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
> > +		stock_nr_bytes &= (PAGE_SIZE - 1);
> >  	}
> > +	stock->nr_bytes[slot] = stock_nr_bytes;
> >  
> >  out:
> >  	if (nr_pages)
> > -- 
> > 2.53.0-Meta
> > 

