Return-Path: <cgroups+bounces-15896-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kINGMgWYBGpiLwIAu9opvQ
	(envelope-from <cgroups+bounces-15896-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 17:25:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 232285360CE
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 17:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A3C31E2CFE
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 14:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C691349CE6;
	Wed, 13 May 2026 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kSK6UKwk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B398421A0A
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682465; cv=none; b=DgehXFKWuWLWuGGGAUQDIKcwSSoAFqLztjG1wMlb7j2TdLAs9bnBsxbMP0LuD2JEe7Mags/QLmC5zy1VP2nhQJfSU88/AKXb+DYGhWF+83iUWni1ni7iBR+TwTdECBQOf5NiWGG3FqMB6rGVrtfzF+qYzfBYuS+G5iACEtcKrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682465; c=relaxed/simple;
	bh=qlljKeyeN1rG4Iou/1YDlXG59mRnd1ahfTrMddNlR5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrQ7iNOrekKeHvKi8cd1d81Y3uiuRX8UOFAkD0qp2c0L1lk4QOdR4rX1bruEpwhTg/gtYUMYvNv1UcYKi1Ep9TfsPX6K9beSUrVZ5pJz+HRvNxTBYJYEX1bp2l1k4LEezJlXVmAg0h+/fnOWJNFLiJcz62F2wjFaDtXA6mkg3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kSK6UKwk; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 May 2026 07:27:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778682450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT6KxnKuDG1JfLVVwS36wJ8yrLhF0nn4rcZS0tX7pQM=;
	b=kSK6UKwkJV4guHYiDnTwdaxVuAQy0iSI+VE0KvC0Z6NJkwMmxZ6zjNSsPG1BsjELGVPtHU
	YQGGEQ04qJDqNky7sxs1usfZXIDNVbmVO/b7z1G1H1VxySwk/FeVpk1Nv5Wk4hWp3wivo0
	9618ELZQyQLdm6EPn9e588IlFeaCEkw=
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
Message-ID: <agSJ4ulNDZ17ah8H@linux.dev>
References: <202605121641.b6a60cb0-lkp@intel.com>
 <agNO8G8tPnPuVrGq@linux.dev>
 <0e1b8994-944d-4dda-8966-3cd43661796d@linux.dev>
 <agSAT4ldp3dzKWPl@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agSAT4ldp3dzKWPl@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 232285360CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15896-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 06:49:45AM -0700, Shakeel Butt wrote:
> On Wed, May 13, 2026 at 10:10:34AM +0800, Qi Zheng wrote:
> > 
> > 
> > On 5/13/26 12:03 AM, Shakeel Butt wrote:
> > > On Tue, May 12, 2026 at 08:56:52PM +0800, kernel test robot wrote:
> > > > 
> > > > 
> > > > Hello,
> > > > 
> > > > kernel test robot noticed a 67.7% regression of stress-ng.switch.ops_per_sec on:
> > > > 
> > > > 
> > > > commit: 01b9da291c4969354807b52956f4aae1f41b4924 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> > > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > This is most probably due to shuffling of struct mem_cgroup and struct
> > > mem_cgroup_per_node members.
> > 
> > Another possibility is that after objcg was split into per-node, the
> > slab accounting fast path is still designed assuming only one current
> > objcg per CPU:
> > 
> > struct obj_stock_pcp {
> >     struct obj_cgroup *cached_objcg;
> > };
> > 
> > So it's may cause the following thrashing:
> > 
> >  CPU stock cached = memcg/node0 objcg
> >  free object tagged = memcg/node1 objcg
> >  => __refill_obj_stock --> objcg mismatch
> >      => drain_obj_stock()
> >      => cache switches to node1 objcg
> > 
> >  next local allocation tagged = node0 objcg
> >  => mismatch again
> >      => drain_obj_stock()
> 
> Actually I think this is the issue, we have ping pong threads running on
> different nodes where though theu are in same cgroup but their current->obcg is
> for local node and thus this ping pong is thrashing the per-cpu objcg stock.
> 
> The easier fix would be to compare objcg->memcg instead of just objcg during
> draining and caching. In addition we can add support for multiple objcg per-cpu
> stock caching.

Something like the following:

From d756abe831a905d6fe32bad9a984fc619dafb7e0 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 13 May 2026 07:24:55 -0700
Subject: [PATCH] mm/memcontrol: skip obj_stock drain when refilled objcg
 shares memcg

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d978e18b9b2d..01ed7a8e18ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3318,6 +3318,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 			       unsigned int nr_bytes,
 			       bool allow_uncharge)
 {
+	struct obj_cgroup *cached;
 	unsigned int nr_pages = 0;
 
 	if (!stock) {
@@ -3327,7 +3328,18 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 		goto out;
 	}
 
-	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
+	cached = READ_ONCE(stock->cached_objcg);
+	if (cached != objcg &&
+	    (!cached || obj_cgroup_memcg(cached) != obj_cgroup_memcg(objcg))) {
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-- 
2.53.0-Meta


