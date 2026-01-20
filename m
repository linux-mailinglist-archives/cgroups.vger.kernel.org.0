Return-Path: <cgroups+bounces-13315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20339D3C098
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 08:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E04495426F1
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 07:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B0399A66;
	Tue, 20 Jan 2026 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ms2mAtWJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905A314D37
	for <cgroups@vger.kernel.org>; Tue, 20 Jan 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893608; cv=none; b=kv1WlEoML4hcggo1aYBv2Rmg2trFywY6AOXr9oo6K33Zr6co7CRosuM/RPPb4PbZ9XqGYUz+6Owr+KZcHzfzD31IJCTKnKn9FQiW6G6c3KWJtO3867H5122+xlV2sso4PNmBkCZcXX9qJbHDUOZ50RR7eK+Vk4hPWYwKSCrvfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893608; c=relaxed/simple;
	bh=e5i5WQUyxdUBFvOVvECMvRh86d3GWzdcvyPp/EIlgoI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eRplH2WWzGX2YzuCvw940aerIzDD+f7mgFNIW3Q6ttw3a9AfW3zsevE8CAWLtyGD4FqwGPgeAuoDRYtUZYLcWaSMWSosIDOuAGddT+hnNvta4bm7OV29oVgcmj/N6XmVFpEkMBZGq4BOEEqgL0zABfzhBALRK53pcMtE0QHE9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ms2mAtWJ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768893585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/HlxvZX2gPKCzNfgWKeEIdwyaofi4etP4O/2x5X3mrQ=;
	b=Ms2mAtWJVCJ3bCD2diLe3CLeoi8jlKaH2qIr4FlGtR6V3qhfMJT0Ib9OAeVP03hAHK9ufe
	MNzGg4ABpc3blKV10kpt/lBWMkPSHtv7OVMYSw/apNXrvrVm0wXIxChAGS/BmkfqH1tDNU
	jQYdymDeTksa5BeyAQvFkDsjGyKiCwM=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 28/30 fix 1/2] mm: memcontrol: fix
 lruvec_stats->state_local reparenting
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5a18658e-2076-4cbf-bc53-5b6e99c1035f@linux.dev>
Date: Tue, 20 Jan 2026 15:19:00 +0800
Cc: hannes@cmpxchg.org,
 hughd@google.com,
 mhocko@suse.com,
 roman.gushchin@linux.dev,
 david@kernel.org,
 lorenzo.stoakes@oracle.com,
 ziy@nvidia.com,
 harry.yoo@oracle.com,
 yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com,
 axelrasmussen@google.com,
 yuanchu@google.com,
 weixugc@google.com,
 chenridong@huaweicloud.com,
 mkoutny@suse.com,
 akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com,
 lance.yang@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A13923AA-8200-4863-8080-EC4B254BA3AA@linux.dev>
References: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
 <ifcth3hxyrwmmeo3nejettdtkw2ndxdjbylszmhq3vohuhsncl@k23pew6gywko>
 <5a18658e-2076-4cbf-bc53-5b6e99c1035f@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 19, 2026, at 11:36, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
>=20
>=20
> On 1/18/26 11:22 AM, Shakeel Butt wrote:
>> On Thu, Jan 15, 2026 at 06:41:38PM +0800, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>=20
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>  include/linux/memcontrol.h |  2 --
>>>  mm/memcontrol-v1.c         |  8 --------
>>>  mm/memcontrol-v1.h         |  5 ++++-
>>>  mm/memcontrol.c            | 19 ++++++++-----------
>>>  4 files changed, 12 insertions(+), 22 deletions(-)
>>>=20
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index 1fe554eec1e25..e0b84b109b7ac 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -944,8 +944,6 @@ bool memcg_vm_event_item_valid(enum =
vm_event_item idx);
>>>  unsigned long lruvec_page_state(struct lruvec *lruvec, enum =
node_stat_item idx);
>>>  unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>>         enum node_stat_item idx);
>>> -void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>>> -        struct mem_cgroup *parent, int idx);
>>>    void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>>>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
>>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>>> index 03b924920d6a5..daf9bad8c45ea 100644
>>> --- a/mm/memcontrol-v1.c
>>> +++ b/mm/memcontrol-v1.c
>>> @@ -1909,14 +1909,6 @@ void reparent_memcg1_state_local(struct =
mem_cgroup *memcg, struct mem_cgroup *pa
>>>   reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
>>>  }
>>>  -void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, =
struct mem_cgroup *parent)
>>> -{
>>> - int i;
>>> -
>>> - for (i =3D 0; i < ARRAY_SIZE(memcg1_stats); i++)
>>> - reparent_memcg_lruvec_state_local(memcg, parent, memcg1_stats[i]);
>>> -}
>>> -
>>>  void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf =
*s)
>>>  {
>>>   unsigned long memory, memsw;
>>> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
>>> index 45528195d3578..5b1188f3d4173 100644
>>> --- a/mm/memcontrol-v1.h
>>> +++ b/mm/memcontrol-v1.h
>>> @@ -75,7 +75,6 @@ void memcg1_uncharge_batch(struct mem_cgroup =
*memcg, unsigned long pgpgout,
>>>    void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf =
*s);
>>>  void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct =
mem_cgroup *parent);
>>> -void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, =
struct mem_cgroup *parent);
>>>    void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
>>>  static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
>>> @@ -116,6 +115,10 @@ static inline void memcg1_uncharge_batch(struct =
mem_cgroup *memcg,
>>>    static inline void memcg1_stat_format(struct mem_cgroup *memcg, =
struct seq_buf *s) {}
>>>  +static inline void reparent_memcg1_state_local(struct mem_cgroup =
*memcg, struct mem_cgroup *parent)
>>> +{
>>> +}
>>> +
>>>  static inline void memcg1_account_kmem(struct mem_cgroup *memcg, =
int nr_pages) {}
>>>  static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg) { =
return false; }
>>>  static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, =
unsigned int nr_pages,
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 7333a37830051..b7b35143d4d2d 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -225,13 +225,13 @@ static inline struct obj_cgroup =
*__memcg_reparent_objcgs(struct mem_cgroup *memc
>>>   return objcg;
>>>  }
>>>  -#ifdef CONFIG_MEMCG_V1
>>> +static void reparent_memcg_lruvec_state_local(struct mem_cgroup =
*memcg,
>>> +       struct mem_cgroup *parent, int idx);
>>>  static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool =
force);
>>>    static inline void reparent_state_local(struct mem_cgroup *memcg, =
struct mem_cgroup *parent)
>>>  {
>> No reparenting local stats for v2.
>=20
> It seems that lruvec_stats->state_local (non-hierarchical) needs to be
> relocated in both v1 and v2.

Here we might need to elaborate a bit. Specifically, in the function
`count_shadow_nodes`, the use of `lruvec_page_state_local` to obtain
LRU and SLAB pages seems to also require these logics to work correctly.
For SLAB, it appears that the statistics here have already been
problematic for a while since SLAB pages have been reparented, right?

>=20
>>> - if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>> - return;
>>> + int i;
>>>     synchronize_rcu();
>>>  @@ -239,13 +239,10 @@ static inline void =
reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
>>>     /* The following counts are all non-hierarchical and need to be =
reparented. */
>>>   reparent_memcg1_state_local(memcg, parent);
>>> - reparent_memcg1_lruvec_state_local(memcg, parent);
>>> -}
>>> -#else
>>> -static inline void reparent_state_local(struct mem_cgroup *memcg, =
struct mem_cgroup *parent)
>>> -{
>>> +
>>> + for (i =3D 0; i < NR_LRU_LISTS; i++)
>>> + reparent_memcg_lruvec_state_local(memcg, parent, i);
>>>  }
>>> -#endif
>>>    static inline void reparent_locks(struct mem_cgroup *memcg, =
struct mem_cgroup *parent)
>>>  {
>>> @@ -510,8 +507,8 @@ unsigned long lruvec_page_state_local(struct =
lruvec *lruvec,
>>>   return x;
>>>  }
>>>  -void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
>>> -        struct mem_cgroup *parent, int idx)
>>> +static void reparent_memcg_lruvec_state_local(struct mem_cgroup =
*memcg,
>>> +       struct mem_cgroup *parent, int idx)
>>>  {
>>>   int i =3D memcg_stats_index(idx);
>>>   int nid;
>>> --=20
>>> 2.20.1



