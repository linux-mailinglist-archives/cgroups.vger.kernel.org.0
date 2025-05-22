Return-Path: <cgroups+bounces-8309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF136AC0279
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE5E9E754B
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6355B3A1DB;
	Thu, 22 May 2025 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XorGxnXs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CBF9DA
	for <cgroups@vger.kernel.org>; Thu, 22 May 2025 02:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747881135; cv=none; b=KshuvWlUh2ztU+XkqD2aeODatfomc0YXU9CKki2xkYOMEBQGDPBe5q6QW8tfaW8w/vdYOreY1iS9mCjc5SIE1EzHYB7vK6bAqnFfY1hxdqufU7sIebuQ3Bc1RM+2ECGFpxL4nsa6/hEu4qiSGKgtNovBKpC989P0oFDxSTduaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747881135; c=relaxed/simple;
	bh=CIkfuXr5e/FFnQf8w7cXy456Pqrq9wN5w94SM65gMCM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U4kCbzvZhpgulg16k+B6ZOo1EM2Op9fG07c3rZ0DxAYpL81IeLCwveLah/XAmMK7l5IvjswVJv/06w6S+ArwGMc0KSOeQPjNcT9ZvEbqsMo3J/d2djYLrpOfjzb74XkrjwkKaAKhiKJAtPpo+oUMxI/iHVJ1+YgLxwGq0IJugUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XorGxnXs; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747881120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7OyzNFi4koovf7Ot55c4ptctb/+0JCIucwjXRDLPVY=;
	b=XorGxnXsae3VA5C2XCc0b1ahJ4y3yZPrGL8iFM61ZfF/bFE72dsoWm1KBWgv8HcBWbInlm
	Tc35CcCFHdTz7gf3QP37s+aiEutg8fLTRFzwXKgRgckoYYwJ0TnjCDKVEzb4G0cmVdp+ZQ
	zncFIK9i1r3a1eelRhzVGRbTthLmg2Y=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH RFC 27/28] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <aCxnFg0VSpd7g_Ju@hyeyoo>
Date: Thu, 22 May 2025 10:31:20 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 hannes@cmpxchg.org,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 david@fromorbit.com,
 zhengqi.arch@bytedance.com,
 yosry.ahmed@linux.dev,
 nphamcs@gmail.com,
 chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
Content-Transfer-Encoding: 7bit
Message-Id: <3782D28E-B0F0-4CC7-98A6-27E443A92730@linux.dev>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-28-songmuchun@bytedance.com> <aCxnFg0VSpd7g_Ju@hyeyoo>
To: Harry Yoo <harry.yoo@oracle.com>
X-Migadu-Flow: FLOW_OUT



> On May 20, 2025, at 19:27, Harry Yoo <harry.yoo@oracle.com> wrote:
> 
> On Tue, Apr 15, 2025 at 10:45:31AM +0800, Muchun Song wrote:
>> Pagecache pages are charged at allocation time and hold a reference
>> to the original memory cgroup until reclaimed. Depending on memory
>> pressure, page sharing patterns between different cgroups and cgroup
>> creation/destruction rates, many dying memory cgroups can be pinned
>> by pagecache pages, reducing page reclaim efficiency and wasting
>> memory. Converting LRU folios and most other raw memory cgroup pins
>> to the object cgroup direction can fix this long-living problem.
>> 
>> Finally, folio->memcg_data of LRU folios and kmem folios will always
>> point to an object cgroup pointer. The folio->memcg_data of slab
>> folios will point to an vector of object cgroups.
>> 
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> include/linux/memcontrol.h |  78 +++++--------
>> mm/huge_memory.c           |  33 ++++++
>> mm/memcontrol-v1.c         |  15 ++-
>> mm/memcontrol.c            | 228 +++++++++++++++++++++++++------------
>> 4 files changed, 222 insertions(+), 132 deletions(-)
> 
> [...]
> 
>> +static void lruvec_reparent_lru(struct lruvec *src, struct lruvec *dst,
>> + 				enum lru_list lru)
>> +{
>> + 	int zid;
>> + 	struct mem_cgroup_per_node *mz_src, *mz_dst;
>> +
>> + 	mz_src = container_of(src, struct mem_cgroup_per_node, lruvec);
>> + 	mz_dst = container_of(dst, struct mem_cgroup_per_node, lruvec);
>> +	
>> + 	if (lru != LRU_UNEVICTABLE)
>> + 	list_splice_tail_init(&src->lists[lru], &dst->lists[lru]);
>> +
>> + 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>> + 		mz_dst->lru_zone_size[zid][lru] += mz_src->lru_zone_size[zid][lru];
>> + 		mz_src->lru_zone_size[zid][lru] = 0;
>> + 	}
>> +}
> 
> I think this function should also update memcg and lruvec stats of
> parent memcg? Or is it intentional?

Hi Harry,

No. Do not need. Because the statistics are accounted hierarchically.

Thanks.

> 
> -- 
> Cheers,
> Harry / Hyeonggon



