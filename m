Return-Path: <cgroups+bounces-16023-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO//CW4ZCmo/wwQAu9opvQ
	(envelope-from <cgroups+bounces-16023-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 21:39:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C182356396E
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15EDA30160E4
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAB33D25DC;
	Sun, 17 May 2026 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvufxR/3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8663536308D
	for <cgroups@vger.kernel.org>; Sun, 17 May 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779046752; cv=none; b=HbFkSHB2u38BZWPB66skAADg3qAi/R5/N5u5SNfAYpAHxwxhHx04hbuXaBaVqpZJGZXGQyMpFYruHqevX4sjr3B0NwrvI2m31RZLBrEmTVmxJkS8XnmyJZJi8EcA843ZOddcDEjHypW/5e68oP0PIvRiVX7z+01dGjvx6n7uczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779046752; c=relaxed/simple;
	bh=4q+ggM690tgwgZRb/GGTvagzzCpOF5q1ZjJ7P1xxi3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2jYvQFKGLSWFL/NOKhthp7x8W5iy/UE4exS9xe1JsKq55+L99C0ofaL0WjMCd1+ct0iH8dSfisp8XTqDPcf/eVVPwx29oO34kygYutyAxxDKu8bqFe/QJEtUu7xCCdgXBag0X5EF/VsA2ExcZHAc+7GnVceuCFL1R690FShbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvufxR/3; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 17 May 2026 12:38:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779046737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vkkU2txQqya1KzbYt5PMEvI3vCZlClG1M28QDAsLkFw=;
	b=KvufxR/304uZuZv6UxWYGC+8bRKN236iAvZRN9h4jixNisdBoosVkl6EOB9hUTACy4mz7q
	rPUaLmVozzx7+BvKWCNjmAJqyih51pF+mIvC23rNvHO4gq+cnSOG416J1cpCWIVuB1rv5H
	owXLIB+F8rXR3/xK/mu0a08FPaTuc4I=
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
Message-ID: <agoYp1zW9afZ6uQz@linux.dev>
References: <202605121641.b6a60cb0-lkp@intel.com>
 <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev>
 <agSJ4ulNDZ17ah8H@linux.dev>
 <46e9f5cf-34cb-466d-a53a-5778768af4d9@linux.dev>
 <93b7c3f206f158e7387cbb5f0bf5845b59b93053@linux.dev>
 <19693be6-7132-446e-b3fc-b7e9f56e5949@linux.dev>
 <agdS5rIhcjIBVSog@linux.dev>
 <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agm61hMv08XnV8sI@xsang-OptiPlex-9020>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: C182356396E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16023-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,intel.com,vger.kernel.org,linux-foundation.org,gmail.com,linux.microsoft.com,google.com,redhat.com,huawei.com,kernel.org,oracle.com,cmpxchg.org,suse.com,bytedance.com,nvidia.com,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 08:55:50PM +0800, Oliver Sang wrote:
> hi, Shakeel, hi, Qi,
> 
> On Fri, May 15, 2026 at 10:09:06AM -0700, Shakeel Butt wrote:
> > On Fri, May 15, 2026 at 03:37:22PM +0800, Qi Zheng wrote:
> > > Hi Shakeel,
> > > 
> > > On 5/14/26 9:40 PM, Shakeel Butt wrote:
> > > > May 14, 2026 at 12:46 AM, "Qi Zheng" <qi.zheng@linux.dev mailto:qi.zheng@linux.dev?to=%22Qi%20Zheng%22%20%3Cqi.zheng%40linux.dev%3E > wrote:
> > > > 
> > > > 
> > > > > 
> > > > > On 5/13/26 10:27 PM, Shakeel Butt wrote:
> > > > > 
> > > > > > 
> > > > > > On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
> > > > > > 
> > > > > > > 
> > > > > > > On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
> > > > > > > 
> > > > > >   On 5/13/26 12:03 AM, Shakeel Butt wrote:
> > > > > >   On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
> > > > > > 
> > > > > >   Hello,
> > > > > > 
> > > > > >   kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
> > > > > > 
> > > > > >   commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > > > > >   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > > > > 
> > > > > >   This is most probably due to shuffling of struct mem_cgroup and struct
> > > > > >   mem_cgroup_per_node members.
> > > > > > 
> > > > > >   Another possibility is that after objcg was split into per-node, the
> > > > > >   slab accounting fast path is still designed assuming only one current
> > > > > >   objcg per CPU:
> > > > > > 
> > > > > >   struct obj_stock_pcp {
> > > > > >   struct obj_cgroup *cached_objcg;
> > > > > >   };
> > > > > > 
> > > > > >   So it's may cause the following thrashing:
> > > > > > 
> > > > > >   CPU stock cached = memcg/node0 objcg
> > > > > >   free object tagged = memcg/node1 objcg
> > > > > >   => __refill_obj_stock --> objcg mismatch
> > > > > >   => drain_obj_stock()
> > > > > >   => cache switches to node1 objcg
> > > > > > 
> > > > > >   next local allocation tagged = node0 objcg
> > > > > >   => mismatch again
> > > > > >   => drain_obj_stock()
> > > > > > 
> > > > > > > 
> > > > > > > Actually I think this is the issue, we have ping pong threads running on
> > > > > > >   different nodes where though theu are in same cgroup but their current->obcg is
> > > > > > >   for local node and thus this ping pong is thrashing the per-cpu objcg stock.
> > > > > > > 
> > > > > > >   The easier fix would be to compare objcg->memcg instead of just objcg during
> > > > > > >   draining and caching. In addition we can add support for multiple objcg per-cpu
> > > > > > >   stock caching.
> > > > > > > 
> > > > > >   Something like the following:
> > > > > >   From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
> > > > > >   From: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > >   Date: Wed, 13 May 2026 07:24:55 -0700
> > > > > >   Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
> > > > > >   shares memcg
> > > > > >   Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > >   ---
> > > > > >   mm/memcontrol.c | 14 +++++++++++++-
> > > > > >   1 file changed, 13 insertions(+), 1 deletion(-)
> > > > > >   diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > >   index d978e18b9b2d..01ed7a8e18ac 100644
> > > > > >   --- a/mm/memcontrol.c
> > > > > >   +++ b/mm/memcontrol.c
> > > > > >   @@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > > > >   unsigned int nr_bytes,
> > > > > >   bool allow_uncharge)
> > > > > >   {
> > > > > >   + struct obj_cgroup *cached;
> > > > > >   unsigned int nr_pages = 0;
> > > > > >   > if (!stock) {
> > > > > >   @@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
> > > > > >   goto out;
> > > > > >   }
> > > > > >   > - if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
> > > > > >   + cached = READ_ONCE(stock->cached_objcg);
> > > > > >   + if (cached != objcg &&
> > > > > >   + (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
> > > > > >   drain_obj_stock(stock);
> > > > > >   obj_cgroup_get(objcg);
> > > > > >   stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> > > > > > 
> > > > > This change looks like it should be able to fix the ping-pong issue, but
> > > > > I stiil haven't reproduced the performance regression locally. I'll
> > > > > continue testing it.
> > > > 
> > > > Same here, couldn't reproduce locally. It seems like we had to craft a scenario
> > > > where the pair pingpong threads get their current->objcg from different nodes.
> > > > I will try that.
> > > 
> > > I still haven't been able to reproduce the LKP results locally, but I
> > > used an AI bot to generate a pingpong test case (pasted at the end) and
> > > automatically ran the test on a physical machine. The results are as
> > > follows:
> > > 
> > >   parent: 8285917d6f
> > >   bad:    01b9da291c
> > >   fix:    01b9da291c + stock patch
> > > 
> > >   | kernel | mq_ops/sec mean | vs parent | drain_obj_stock / round |
> > >   |--------|-----------------|-----------|-------------------------|
> > >   | parent |     9.743M      |  baseline |          ~0             |
> > >   | bad    |     7.821M      |  -19.73%  |          ~11.16M        |
> > >   | fix    |     9.274M      |  -4.81%   |          ~0             |
> > > 
> > > Probing the drain_obj_stock() calls confirms that the fix restores the
> > > frequency to the parent's baseline.
> > > 
> > > And it seems that besides __refill_obj_stock(), we should also modify
> > > __consume_obj_stock()?
> > > 
> > 
> > Thanks a lot Qi. I will send the formal patch and will add your Debugged-by if
> > you don't mind.
> > 
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>
> 
> we tested above patch, and it recovers the regression:
> 
> =========================================================================================
> compiler/cpufreq_governor/kconfig/method/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   gcc-14/performance/x86_64-rhel-9.4/mq/100%/debian-13-x86_64-20250902.cgz/lkp-spr-r02/switch/stress-ng/60s
> 
> commit:
>   8285917d6f ("mm: memcontrol: prepare for reparenting non-hierarchical stats")
>   01b9da291c ("mm: memcontrol: convert objcg to be per-memcg per-node type")
>   682fd4e9ff  <--- above patch from Shakeel
> 
> 8285917d6f383aef 01b9da291c4969354807b52956f 682fd4e9ffd4009805f81dd25ed
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       5849          +210.2%      18145 ±  3%      +1.5%       5935        stress-ng.switch.nanosecs_per_context_switch_mq_method
>  2.296e+09           -67.7%  7.408e+08 ±  3%      -1.4%  2.263e+09        stress-ng.switch.ops
>   38288993           -67.7%   12355813 ±  3%      -1.4%   37739220        stress-ng.switch.ops_per_sec
> 
> 
> full compasison is as below [3]
> 
> but there are two notes. 
> 
> #1 is that we noticed there is a fomal patch later from Shakeel in [1] which has
> more changes. not sure if this test is enough? do you want us to test [1]
> further?

Thanks Oliver, I will send a v2 soon, please test v2.

> 
> #2: when we test above patch, we found the server easy to crash while running
> tests. we try to run up to 20 times, only 2 of them run successfully (above
> 37739220 is just the average data from these 2 runs, since the data is stable,
> we think maybe it's ok to report to you with this data).
> we also noticed for [1] there is a [syzbot ci] report in [2]. since we don't
> have serial output for our test server in this report which is for performance
> tests, we cannot say if other 18 runs failed due to similar reason. just FYI.
> 

The syzbot report is simply a rcu warning which will be fixed in v2. Do you
have more details on the crash you are seeing? Is it page counter underflow
warning?

Thanks again for the help.

