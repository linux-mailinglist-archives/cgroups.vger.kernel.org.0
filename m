Return-Path: <cgroups+bounces-4029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31890942753
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 09:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549AC1C21753
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 07:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C821A4F18;
	Wed, 31 Jul 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sBB2QVMX"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A001A4B57
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 07:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409405; cv=none; b=B6MGNc4TzQiaRRkPIZBpuW6SnCvm2wzXg7qMCqAspdTwgExU3HDddQ7t4/pflhVMoJ5rubNmMCx6k+1pdK3/HcI5jCwyYQQ/+1TRXwMz6xaLa+hzadUjkvDx6r/1fLwMyApE9mNe/JaVklvZfcvy5JDOKdnIMj4vHJTGirZwXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409405; c=relaxed/simple;
	bh=wIio6avPk/HR/4H7vbXWTIRXk1acTSV/aAQ2/XXjf4s=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jgWZ8OcCWuoec+aC3YFoikb9EK2Zdvpo2m69PNm8Jt1yo8SAnTGoDSm65TrHAQFjYaMd62LzYb3GvM6zF1rBJVZ4RDnPd9WLsmg5H48sXmu6FuXuopjCR5js9IngV33S8OKEK6FVbAHoBvSIXGM64rEcKUjlQi2qucjPmkCdXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sBB2QVMX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722409401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd0fgaKpb14AqzIiZc9ZPFNZJ6RSfTKvGzEefKObQXM=;
	b=sBB2QVMXNwCBAKwnrBNAhslLWpKRRkaLPNM4xyXN6I6Wwel77CdDRdiBObtT2R7ZkBCv9K
	bJklRurI3Lxc2aXgbqjxksBEEj1bZutaQsFPzDeDla1qp8/fAfhZY7fz3T0ymlNwXCsOdr
	u0KDYVLKaa52P1QUviqHOQasPKKEEGA=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
Date: Wed, 31 Jul 2024 15:02:40 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 vbabka@kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B54AF0F4-6CE8-4791-868E-62C7704AB832@linux.dev>
References: <20240725094330.72537-1-songmuchun@bytedance.com>
 <CGME20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d@eucas1p2.samsung.com>
 <3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
X-Migadu-Flow: FLOW_OUT



> On Jul 31, 2024, at 02:52, Marek Szyprowski <m.szyprowski@samsung.com> =
wrote:
>=20
> On 25.07.2024 11:43, Muchun Song wrote:
>> The obj_cgroup_memcg() is supposed to safe to prevent the returned
>> memory cgroup from being freed only when the caller is holding the
>> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
>> ignore thoes conditions when users call some upper APIs which call
>> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
>> the link below). So it is better to add lockdep assertion to
>> obj_cgroup_memcg() to find those issues ASAP.
>>=20
>> Because there is no user of obj_cgroup_memcg() holding objcg_lock
>> to make the returned memory cgroup safe, do not add objcg_lock
>> assertion (We should export objcg_lock if we really want to do).
>> Additionally, this is some internal implementation detail of memcg
>> and should not be accessible outside memcg code.
>>=20
>> Some users like __mem_cgroup_uncharge() do not care the lifetime
>> of the returned memory cgroup, which just want to know if the
>> folio is charged to a memory cgroup, therefore, they do not need
>> to hold the needed locks. In which case, introduce a new helper
>> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
>> could eliminate a memory access of objcg->memcg for kmem, actually,
>> a really small gain.
>>=20
>> Link: =
https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.co=
m/
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> This patch landed in today's linux-next as commit 230b2f1f31b9 ("mm:=20=

> kmem: add lockdep assertion to obj_cgroup_memcg"). I my tests I found=20=

> that it triggers the following warning on Debian bookworm/sid system=20=

> image running under QEMU RISCV64:

Thanks for your report.

I'd like to say excellent since it indeed indicates this patch works
well. Your report is actually a bug that I fixed it in [1] but not
related to this patch.

[1] =
https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.co=
m/

>=20
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at include/linux/memcontrol.h:373=20
> mem_cgroup_from_slab_obj+0x13e/0x1ea
> Modules linked in:
> CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.10.0+ #15154
> Hardware name: riscv-virtio,qemu (DT)
> epc : mem_cgroup_from_slab_obj+0x13e/0x1ea
>  ra : mem_cgroup_from_slab_obj+0x13c/0x1ea
> ...
> [<ffffffff80257256>] mem_cgroup_from_slab_obj+0x13e/0x1ea
> [<ffffffff801f0b3e>] list_lru_del_obj+0xa6/0xc2
> [<ffffffff8027c6c6>] d_lru_del+0x8c/0xa4
> [<ffffffff8027da60>] __dentry_kill+0x15e/0x17a
> [<ffffffff8027ec3c>] dput.part.0+0x242/0x3e6
> [<ffffffff8027edee>] dput+0xe/0x18
> [<ffffffff8027324c>] lookup_fast+0x80/0xce
> [<ffffffff80273e28>] walk_component+0x20/0x13c
> [<ffffffff802747e2>] path_lookupat+0x64/0x16c
> [<ffffffff80274bf4>] filename_lookup+0x76/0x122
> [<ffffffff80274d80>] user_path_at+0x30/0x4a
> [<ffffffff802d12bc>] __riscv_sys_name_to_handle_at+0x52/0x1d8
> [<ffffffff80b60324>] do_trap_ecall_u+0x14e/0x1da
> [<ffffffff80b6c546>] handle_exception+0xca/0xd6
> irq event stamp: 198187
> hardirqs last  enabled at (198187): [<ffffffff8028ca9e>]=20
> lookup_mnt+0x186/0x308
> hardirqs last disabled at (198186): [<ffffffff8028ca74>]=20
> lookup_mnt+0x15c/0x308
> softirqs last  enabled at (198172): [<ffffffff800e34f6>]=20
> cgroup_apply_control_enable+0x1f6/0x2fc
> softirqs last disabled at (198170): [<ffffffff800e34d8>]=20
> cgroup_apply_control_enable+0x1d8/0x2fc
> ---[ end trace 0000000000000000 ]---
>=20
> Similar warning appears on ARM64 Debian bookworm system. Reverting it =
on=20
> top of linux-next hides the issue, but I assume this is not the best =
way=20
> to fix it.
>=20
> I'm testing kernel built from riscv/defconfig with PROVE_LOCKING,=20
> DEBUG_ATOMIC_SLEEP, DEBUG_DRIVER and DEBUG_DEVRES options enabled.
>=20
>> ---
>> v3:
>>  - Use lockdep_assert_once(Vlastimil).
>>=20
>> v2:
>>  - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
>>=20
>>  include/linux/memcontrol.h | 20 +++++++++++++++++---
>>  mm/memcontrol.c            |  6 +++---
>>  2 files changed, 20 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index fc94879db4dff..95f823deafeca 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct =
folio *folio);
>>   * After the initialization objcg->memcg is always pointing at
>>   * a valid memcg, but can be atomically swapped to the parent memcg.
>>   *
>> - * The caller must ensure that the returned memcg won't be released:
>> - * e.g. acquire the rcu_read_lock or css_set_lock.
>> + * The caller must ensure that the returned memcg won't be released.
>>   */
>>  static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup =
*objcg)
>>  {
>> + lockdep_assert_once(rcu_read_lock_held() || =
lockdep_is_held(&cgroup_mutex));
>>   return READ_ONCE(objcg->memcg);
>>  }
>>=20
>> @@ -438,6 +438,19 @@ static inline struct mem_cgroup =
*folio_memcg(struct folio *folio)
>>   return __folio_memcg(folio);
>>  }
>>=20
>> +/*
>> + * folio_memcg_charged - If a folio is charged to a memory cgroup.
>> + * @folio: Pointer to the folio.
>> + *
>> + * Returns true if folio is charged to a memory cgroup, otherwise =
returns false.
>> + */
>> +static inline bool folio_memcg_charged(struct folio *folio)
>> +{
>> + if (folio_memcg_kmem(folio))
>> + return __folio_objcg(folio) !=3D NULL;
>> + return __folio_memcg(folio) !=3D NULL;
>> +}
>> +
>>  /**
>>   * folio_memcg_rcu - Locklessly get the memory cgroup associated =
with a folio.
>>   * @folio: Pointer to the folio.
>> @@ -454,7 +467,6 @@ static inline struct mem_cgroup =
*folio_memcg_rcu(struct folio *folio)
>>   unsigned long memcg_data =3D READ_ONCE(folio->memcg_data);
>>=20
>>   VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
>> - WARN_ON_ONCE(!rcu_read_lock_held());
>>=20
>>   if (memcg_data & MEMCG_DATA_KMEM) {
>>   struct obj_cgroup *objcg;
>> @@ -463,6 +475,8 @@ static inline struct mem_cgroup =
*folio_memcg_rcu(struct folio *folio)
>>   return obj_cgroup_memcg(objcg);
>>   }
>>=20
>> + WARN_ON_ONCE(!rcu_read_lock_held());
>> +
>>   return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
>>  }
>>=20
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 622d4544edd24..3da0284573857 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup =
*memcg, unsigned int nr_pages)
>>=20
>>  static void commit_charge(struct folio *folio, struct mem_cgroup =
*memcg)
>>  {
>> - VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
>> + VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
>>   /*
>>    * Any of the following ensures page's memcg stability:
>>    *
>> @@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>>   struct uncharge_gather ug;
>>=20
>>   /* Don't touch folio->lru of any random page, pre-check: */
>> - if (!folio_memcg(folio))
>> + if (!folio_memcg_charged(folio))
>>   return;
>>=20
>>   uncharge_gather_clear(&ug);
>> @@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio =
*old, struct folio *new)
>>   return;
>>=20
>>   /* Page cache replacement: new folio already charged? */
>> - if (folio_memcg(new))
>> + if (folio_memcg_charged(new))
>>   return;
>>=20
>>   memcg =3D folio_memcg(old);
>=20
> Best regards
> --=20
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland



