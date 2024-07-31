Return-Path: <cgroups+bounces-4030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DA09428DC
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 10:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7545A1C2193B
	for <lists+cgroups@lfdr.de>; Wed, 31 Jul 2024 08:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B51A7F68;
	Wed, 31 Jul 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XD5VOvBF"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7344A450E2
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 08:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413351; cv=none; b=BPxyd9i5CrHRb40yoo3LL4yrSr/TTAANPPLGWOGyt3vrDmxejwa/DFjZC2PRduHXcDBCC+SV516qF9tPEjEzPJDYfKryx8ra+TpklRUX98J7Z+KBkovXUz+sOSp3IsCjv8bkgzwi5/ZVV9YceW/d3AA0swB7zaTxIpv/Dvqnljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413351; c=relaxed/simple;
	bh=aAsGuhgsJ+RcZGg7s9FG2ZamtSJAOlPEpsbp/fvZJb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ikXAfo2QHnLCAuFajJWQCGP2xjJmE1AH40dMShu6ve6GQdGA3NpCzG+udzJtwvi5Fz5jfJC8fU6LNDIy46R5b7Sx0r+Jt5wAKcCWr45bqw3R0i6+0DOv44gK1kuQC0h/4hA4SwcTYGGVbMQEHIgkkPl1tkoh11J5/MSWEFxckwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XD5VOvBF; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240731080906euoutp0155b82c51886c2f7a601a70718ad71642~nPdAZ5yKk0056100561euoutp01b
	for <cgroups@vger.kernel.org>; Wed, 31 Jul 2024 08:09:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240731080906euoutp0155b82c51886c2f7a601a70718ad71642~nPdAZ5yKk0056100561euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722413346;
	bh=psYRFhcGmf3wASUpnlXo7MO1TNPFdUhRoiHoQgtDZCo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=XD5VOvBFNBL/+QW1U7DgwZsv3VIUPMEpb0aTllIBlBevNwTO4HbRZxmqSxI5i0vX1
	 IKUrMznjxNr0Ojj11jPvnp9bommxASRljjhCUejVCiX69hNS1LZMChe9g9bvSPkamN
	 3G5Bi5rcMDbaXBo40gKrNXMO7EMMVsjG6eTcdfb4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240731080906eucas1p2fb77f38a7fc88b0c014b3a28cd07f1ca~nPdAH029l3133931339eucas1p22;
	Wed, 31 Jul 2024 08:09:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.A3.09620.121F9A66; Wed, 31
	Jul 2024 09:09:06 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240731080905eucas1p24352cabf1a359cd5839430d8ad253628~nPc-uQ8kC2025620256eucas1p2n;
	Wed, 31 Jul 2024 08:09:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731080905eusmtrp29d35ab5ac72a39255cb24cc2958d0918~nPc-tbGmS1490014900eusmtrp2v;
	Wed, 31 Jul 2024 08:09:05 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-95-66a9f1214d25
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 44.03.08810.121F9A66; Wed, 31
	Jul 2024 09:09:05 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240731080904eusmtip25d4cabef9e369b48b58821ba815301df~nPc__Csa-3130431304eusmtip2s;
	Wed, 31 Jul 2024 08:09:04 +0000 (GMT)
Message-ID: <9ccb51d9-df7a-4c8d-8b52-d0485de32f4c@samsung.com>
Date: Wed, 31 Jul 2024 10:09:03 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Andrew
	Morton <akpm@linux-foundation.org>, vbabka@kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <B54AF0F4-6CE8-4791-868E-62C7704AB832@linux.dev>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djP87pKH1emGZxfx2gxZ/0aNosby2ew
	WKze5GtxedccNot7a/6zWrz+tozZYtnOhywWE9eIWjyfNZfJ4uD9c8wWHS/vszhwe/w7sYbN
	4/Cb98wem1Z1snls+jSJ3ePEjN8sHgsbpjJ7fN4kF8AexWWTkpqTWZZapG+XwJXx/95vloKv
	dhWbjpxga2BcZ9LFyMkhIWAicWD9QdYuRi4OIYEVjBKXLqxnhHC+MEp8mzwNyvkMlHnRxw7T
	0vFlCjNEYjmjxOvPu9khnI+MEp9X72UCqeIVsJNYPOk+M4jNIqAq0XPxBxtEXFDi5MwnLCC2
	qIC8xP1bM8CmCgt4Sxx7dRHMFhFQl7j29BnYUGaBq0wSOw8/A2tmFhCXuPVkPtgCNgFDia63
	XWBxTgFbiYlzF7NA1MhLbH87B+w8CYFuTolNu74yQ9ztIvFizTE2CFtY4tXxLVD/yEj83wky
	FKShnVFiwe/7UM4ERomG57cYIaqsJe6c+wXUzQG0QlNi/S59EFNCwFFi+glmCJNP4sZbQYgb
	+CQmbZsOFeaV6GgTgpihJjHr+Dq4rQcvXGKewKg0CylYZiH5chaSb2YhrF3AyLKKUTy1tDg3
	PbXYOC+1XK84Mbe4NC9dLzk/dxMjMH2d/nf86w7GFa8+6h1iZOJgPMQowcGsJMIrdHJlmhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAOT5j5uhWg/H/Zs
	C7bpUsEHr7zQ6jzV0pbUorno4lLdpWqb//6peWsXu2mi4JLZq27M9EgWS8zmy96/bsehdSb7
	ZxppM4Xn9B7pYj+292rG829nn1ks9WWRqu0ykXmzpbfSacurN1Pmv7H5c4VZKO71opv3l0yx
	uHbl/4WSruhs+X1qu3YVTfB11y94c/zCmbP7yjmK3GIct95TyripI/bN3ntSt/47p5I02yPW
	33Ycks5KOK/ds+nK2yqp1QkTqs5oLGm+YJWZ+EtwWVT4pYCyQCE/Qe2GPSmJjLXF+4WXJ6T+
	m9nAHbl69pwL3QXvephuv9+u2HL85rJPK6/zJN9iktscoBS97ewHrqDQldG8SizFGYmGWsxF
	xYkAecgzQM4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7qKH1emGby/oWwxZ/0aNosby2ew
	WKze5GtxedccNot7a/6zWrz+tozZYtnOhywWE9eIWjyfNZfJ4uD9c8wWHS/vszhwe/w7sYbN
	4/Cb98wem1Z1snls+jSJ3ePEjN8sHgsbpjJ7fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdo
	aaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx/95vloKvdhWbjpxga2BcZ9LFyMkhIWAi
	0fFlCjOILSSwlFFiW5c7RFxG4uS0BlYIW1jiz7Uuti5GLqCa94wSc8++AGvgFbCTWDzpPpjN
	IqAq0XPxBxtEXFDi5MwnLCC2qIC8xP1bM9hBbGEBb4ljry6C2SIC6hLXnj5jBxnKLHCdSeLk
	+m/MEBt+MkpcuN4NtppZQFzi1pP5TCA2m4ChRNfbLrANnAK2EhPnLmaBqDGT6NraxQhhy0ts
	fzuHeQKj0Cwkh8xCMmoWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzXbcd+
	bt7BOO/VR71DjEwcjIcYJTiYlUR4hU6uTBPiTUmsrEotyo8vKs1JLT7EaAoMjYnMUqLJ+cCE
	kVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLSbLUHIeqX9zrTo
	wz/XXZ8/s2Nt+QSPXTqzy9135gQ/vbl+1pbykw/uXahZvVagfd0JhW17WNkP3mzxjd92sv5D
	zo48sQmCiR7mZ9Yd1K1rL8gXe/8o4M0fwePBJx6YXwl0yrP03WYtyPjE6NWx87sY3z1/qCvj
	ptKeVPDygHte6jvL+c6KUXcY438t+CB25c/rla3X1odF/Mtfo8t90lVlm+65noLwSaZpFlFx
	XP+eP7c5tpktdmXyycg9rA/PdDAyMJWsuMjErV4yazZvq5608Fub6TMqTIRvxKtqOF0wYaw7
	cepOyIJpeU3T9yv87DHm5f64v3J727qtFt6C7f/emt44MDngj9oELsZVN+2UWIozEg21mIuK
	EwHUiaYXYAMAAA==
X-CMS-MailID: 20240731080905eucas1p24352cabf1a359cd5839430d8ad253628
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d
References: <20240725094330.72537-1-songmuchun@bytedance.com>
	<CGME20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d@eucas1p2.samsung.com>
	<3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
	<B54AF0F4-6CE8-4791-868E-62C7704AB832@linux.dev>

On 31.07.2024 09:02, Muchun Song wrote:
>> On Jul 31, 2024, at 02:52, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> On 25.07.2024 11:43, Muchun Song wrote:
>>> The obj_cgroup_memcg() is supposed to safe to prevent the returned
>>> memory cgroup from being freed only when the caller is holding the
>>> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
>>> ignore thoes conditions when users call some upper APIs which call
>>> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
>>> the link below). So it is better to add lockdep assertion to
>>> obj_cgroup_memcg() to find those issues ASAP.
>>>
>>> Because there is no user of obj_cgroup_memcg() holding objcg_lock
>>> to make the returned memory cgroup safe, do not add objcg_lock
>>> assertion (We should export objcg_lock if we really want to do).
>>> Additionally, this is some internal implementation detail of memcg
>>> and should not be accessible outside memcg code.
>>>
>>> Some users like __mem_cgroup_uncharge() do not care the lifetime
>>> of the returned memory cgroup, which just want to know if the
>>> folio is charged to a memory cgroup, therefore, they do not need
>>> to hold the needed locks. In which case, introduce a new helper
>>> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
>>> could eliminate a memory access of objcg->memcg for kmem, actually,
>>> a really small gain.
>>>
>>> Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> This patch landed in today's linux-next as commit 230b2f1f31b9 ("mm:
>> kmem: add lockdep assertion to obj_cgroup_memcg"). I my tests I found
>> that it triggers the following warning on Debian bookworm/sid system
>> image running under QEMU RISCV64:
> Thanks for your report.
>
> I'd like to say excellent since it indeed indicates this patch works
> well. Your report is actually a bug that I fixed it in [1] but not
> related to this patch.
>
> [1] https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/

Confirmed. Applying [1] on top of next-20240730 fixes this issue without 
reverting $subject.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>> ------------[ cut here ]------------
>> WARNING: CPU: 0 PID: 1 at include/linux/memcontrol.h:373
>> mem_cgroup_from_slab_obj+0x13e/0x1ea
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.10.0+ #15154
>> Hardware name: riscv-virtio,qemu (DT)
>> epc : mem_cgroup_from_slab_obj+0x13e/0x1ea
>>   ra : mem_cgroup_from_slab_obj+0x13c/0x1ea
>> ...
>> [<ffffffff80257256>] mem_cgroup_from_slab_obj+0x13e/0x1ea
>> [<ffffffff801f0b3e>] list_lru_del_obj+0xa6/0xc2
>> [<ffffffff8027c6c6>] d_lru_del+0x8c/0xa4
>> [<ffffffff8027da60>] __dentry_kill+0x15e/0x17a
>> [<ffffffff8027ec3c>] dput.part.0+0x242/0x3e6
>> [<ffffffff8027edee>] dput+0xe/0x18
>> [<ffffffff8027324c>] lookup_fast+0x80/0xce
>> [<ffffffff80273e28>] walk_component+0x20/0x13c
>> [<ffffffff802747e2>] path_lookupat+0x64/0x16c
>> [<ffffffff80274bf4>] filename_lookup+0x76/0x122
>> [<ffffffff80274d80>] user_path_at+0x30/0x4a
>> [<ffffffff802d12bc>] __riscv_sys_name_to_handle_at+0x52/0x1d8
>> [<ffffffff80b60324>] do_trap_ecall_u+0x14e/0x1da
>> [<ffffffff80b6c546>] handle_exception+0xca/0xd6
>> irq event stamp: 198187
>> hardirqs last  enabled at (198187): [<ffffffff8028ca9e>]
>> lookup_mnt+0x186/0x308
>> hardirqs last disabled at (198186): [<ffffffff8028ca74>]
>> lookup_mnt+0x15c/0x308
>> softirqs last  enabled at (198172): [<ffffffff800e34f6>]
>> cgroup_apply_control_enable+0x1f6/0x2fc
>> softirqs last disabled at (198170): [<ffffffff800e34d8>]
>> cgroup_apply_control_enable+0x1d8/0x2fc
>> ---[ end trace 0000000000000000 ]---
>>
>> Similar warning appears on ARM64 Debian bookworm system. Reverting it on
>> top of linux-next hides the issue, but I assume this is not the best way
>> to fix it.
>>
>> I'm testing kernel built from riscv/defconfig with PROVE_LOCKING,
>> DEBUG_ATOMIC_SLEEP, DEBUG_DRIVER and DEBUG_DEVRES options enabled.
>>
>>> ---
>>> v3:
>>>   - Use lockdep_assert_once(Vlastimil).
>>>
>>> v2:
>>>   - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
>>>
>>>   include/linux/memcontrol.h | 20 +++++++++++++++++---
>>>   mm/memcontrol.c            |  6 +++---
>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index fc94879db4dff..95f823deafeca 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
>>>    * After the initialization objcg->memcg is always pointing at
>>>    * a valid memcg, but can be atomically swapped to the parent memcg.
>>>    *
>>> - * The caller must ensure that the returned memcg won't be released:
>>> - * e.g. acquire the rcu_read_lock or css_set_lock.
>>> + * The caller must ensure that the returned memcg won't be released.
>>>    */
>>>   static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>>>   {
>>> + lockdep_assert_once(rcu_read_lock_held() || lockdep_is_held(&cgroup_mutex));
>>>    return READ_ONCE(objcg->memcg);
>>>   }
>>>
>>> @@ -438,6 +438,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>>>    return __folio_memcg(folio);
>>>   }
>>>
>>> +/*
>>> + * folio_memcg_charged - If a folio is charged to a memory cgroup.
>>> + * @folio: Pointer to the folio.
>>> + *
>>> + * Returns true if folio is charged to a memory cgroup, otherwise returns false.
>>> + */
>>> +static inline bool folio_memcg_charged(struct folio *folio)
>>> +{
>>> + if (folio_memcg_kmem(folio))
>>> + return __folio_objcg(folio) != NULL;
>>> + return __folio_memcg(folio) != NULL;
>>> +}
>>> +
>>>   /**
>>>    * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>>>    * @folio: Pointer to the folio.
>>> @@ -454,7 +467,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>>>    unsigned long memcg_data = READ_ONCE(folio->memcg_data);
>>>
>>>    VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
>>> - WARN_ON_ONCE(!rcu_read_lock_held());
>>>
>>>    if (memcg_data & MEMCG_DATA_KMEM) {
>>>    struct obj_cgroup *objcg;
>>> @@ -463,6 +475,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>>>    return obj_cgroup_memcg(objcg);
>>>    }
>>>
>>> + WARN_ON_ONCE(!rcu_read_lock_held());
>>> +
>>>    return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
>>>   }
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 622d4544edd24..3da0284573857 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>
>>>   static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>>>   {
>>> - VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
>>> + VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
>>>    /*
>>>     * Any of the following ensures page's memcg stability:
>>>     *
>>> @@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>>>    struct uncharge_gather ug;
>>>
>>>    /* Don't touch folio->lru of any random page, pre-check: */
>>> - if (!folio_memcg(folio))
>>> + if (!folio_memcg_charged(folio))
>>>    return;
>>>
>>>    uncharge_gather_clear(&ug);
>>> @@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>>>    return;
>>>
>>>    /* Page cache replacement: new folio already charged? */
>>> - if (folio_memcg(new))
>>> + if (folio_memcg_charged(new))
>>>    return;
>>>
>>>    memcg = folio_memcg(old);
>> Best regards
>> -- 
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


