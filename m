Return-Path: <cgroups+bounces-15983-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEu4IQNXB2pVzQIAu9opvQ
	(envelope-from <cgroups+bounces-15983-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:25:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484E554FC4
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15BD53052D08
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858F4EA383;
	Fri, 15 May 2026 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JgSAS10i"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432C4DB564;
	Fri, 15 May 2026 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864978; cv=none; b=G1/BYt+0S6ydViOhhiYNj7xezlMoXehdoIkMhvYvrFjvE5EwW9paNTHm9FhaR7wA7v11ycIIoGfCkBUc1qQMyz95K+sGB6zutwOat1LvRY7SpKwjTiI5xypdgiETLOKE63ZGMJolIHxVLFo+/v+0m3DPzlASbBos/NEwP+JpBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864978; c=relaxed/simple;
	bh=+GNX+XOkD15q64hRVA6zF7bSeKpAy4VIvjf3fwTChD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INVe49UvP50RexCK0F5vY+0II+RlEi3P4P686tn+P1DMfbWeDWtvQgZVbZ8aJ5WxhxsFnNlX6pJDuMCsG/0J/+g847fFaYgxkWBcb/7EN0N47zS9aiwPrk6/NgXO/e9Z5YR4T5Qc04CvSMhwSbm5AtuA6DpDktb6ovu4mn1h8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JgSAS10i; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 May 2026 10:09:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778864964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UL7gdJHu2wJk4N7LvRYzG8TK4uSgIT2pJ8INY3wtc=;
	b=JgSAS10iDi9/vbFjbI3BcdtTFV8xXmKFuN5EPhpm/zJSF7th/Gr0MlMMnryJlKYM2DZp/n
	ju01KenC4gL4rqqhYTRO/ftIa9Rl5C5lLsTnH5hBMU2XrKOoOcaahvfmfosnSlmeZ4RBL2
	QZsLjsv8VFyP9Erf/uba2NKD+Q/iTEo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Carlier <devnexen@gmail.com>, 
	Allen Pais <apais@linux.microsoft.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baoquan He <bhe@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chen Ridong <chenridong@huawei.com>, David Hildenbrand <david@kernel.org>, 
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Hugh Dickins <hughd@google.com>, Imran Khan <imran.f.khan@oracle.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Kamalesh Babulal <kamalesh.babulal@oracle.com>, 
	Lance Yang <lance.yang@linux.dev>, Liam Howlett <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Muchun Song <songmuchun@bytedance.com>, 
	Nhat Pham <nphamcs@gmail.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usamaarif642@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Wei Xu <weixugc@google.com>, Yosry Ahmed <yosry@kernel.org>, 
	Yuanchu Xie <yuanchu@google.com>, Zi Yan <ziy@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [linus:master] [mm] 01b9da291c: stress-ng.switch.ops_per_sec
 67.7% regression
Message-ID: <agdS5rIhcjIBVSog@linux.dev>
References: <202605121641.b6a60cb0-lkp@intel.com>
 <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8484E554FC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15983-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lists.linux.dev,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,linux.dev,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:37:22PM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 5/14/26 9:40 PM, Shakeel Butt wrote:
> > May 14, 2026 at 12:46 AM, "Qi Zheng" <qi.zheng@linux.dev mailto:qi.zheng@linux.dev?to=%22Qi%20Zheng%22%20%3Cqi.zheng%40linux.dev%3E > wrote:
> > 
> > 
> > > 
> > > On 5/13/26 10:27 PM, Shakeel Butt wrote:
> > > 
> > > > 
> > > > On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
> > > > 
> > > > > 
> > > > > On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
> > > > > 
> > > >   On 5/13/26 12:03 AM, Shakeel Butt wrote:
> > > >   On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
> > > > 
> > > >   Hello,
> > > > 
> > > >   kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
> > > > 
> > > >   commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > > >   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > 
> > > >   This is most probably due to shuffling of struct mem_cgroup and struct
> > > >   mem_cgroup_per_node members.
> > > > 
> > > >   Another possibility is that after objcg was split into per-node, the
> > > >   slab accounting fast path is still designed assuming only one current
> > > >   objcg per CPU:
> > > > 
> > > >   struct obj_stock_pcp {
> > > >   struct obj_cgroup *cached_objcg;
> > > >   };
> > > > 
> > > >   So it's may cause the following thrashing:
> > > > 
> > > >   CPU stock cached = memcg/node0 objcg
> > > >   free object tagged = memcg/node1 objcg
> > > >   => __refill_obj_stock --> objcg mismatch
> > > >   => drain_obj_stock()
> > > >   => cache switches to node1 objcg
> > > > 
> > > >   next local allocation tagged = node0 objcg
> > > >   => mismatch again
> > > >   => drain_obj_stock()
> > > > 
> > > > > 
> > > > > Actually I think this is the issue, we have ping pong threads running on
> > > > >   different nodes where though theu are in same cgroup but their current->obcg is
> > > > >   for local node and thus this ping pong is thrashing the per-cpu objcg stock.
> > > > > 
> > > > >   The easier fix would be to compare objcg->memcg instead of just objcg during
> > > > >   draining and caching. In addition we can add support for multiple objcg per-cpu
> > > > >   stock caching.
> > > > > 
> > > >   Something like the following:
> > > >   From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
> > > >   From: Shakeel Butt <shakeel.butt@linux.dev>
> > > >   Date: Wed, 13 May 2026 07:24:55 -0700
> > > >   Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
> > > >   shares memcg
> > > >   Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > >   ---
> > > >   mm/memcontrol.c | 14 +++++++++++++-
> > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > >   diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > >   index d978e18b9b2d..01ed7a8e18ac 100644
> > > >   --- a/mm/memcontrol.c
> > > >   +++ b/mm/memcontrol.c
> > > >   @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > >   unsigned int nr_bytes,
> > > >   bool allow_uncharge)
> > > >   {
> > > >   + struct obj_cgroup *cached;
> > > >   unsigned int nr_pages = 0;
> > > >   > if (!stock) {
> > > >   @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > >   goto out;
> > > >   }
> > > >   > - if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > >   + cached = READ_ONCE(stock->cached_objcg);
> > > >   + if (cached != objcg &&
> > > >   + (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
> > > >   drain_obj_stock(stock);
> > > >   obj_cgroup_get(objcg);
> > > >   stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > > > 
> > > This change looks like it should be able to fix the ping-pong issue, but
> > > I stiil haven't reproduced the performance regression locally. I'll
> > > continue testing it.
> > 
> > Same here, couldn't reproduce locally. It seems like we had to craft a scenario
> > where the pair pingpong threads get their current->objcg from different nodes.
> > I will try that.
> 
> I still haven't been able to reproduce the LKP results locally, but I
> used an AI bot to generate a pingpong test case (pasted at the end) and
> automatically ran the test on a physical machine. The results are as
> follows:
> 
>   parent: 8285917d6f
>   bad:    01b9da291c
>   fix:    01b9da291c + stock patch
> 
>   | kernel | mq_ops/sec mean | vs parent | drain_obj_stock / round |
>   |--------|-----------------|-----------|-------------------------|
>   | parent |     9.743M      |  baseline |          ~0             |
>   | bad    |     7.821M      |  -19.73%  |          ~11.16M        |
>   | fix    |     9.274M      |  -4.81%   |          ~0             |
> 
> Probing the drain_obj_stock() calls confirms that the fix restores the
> frequency to the parent's baseline.
> 
> And it seems that besides __refill_obj_stock(), we should also modify
> __consume_obj_stock()?
> 

Thanks a lot Qi. I will send the formal patch and will add your Debugged-by if
you don't mind.


