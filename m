Return-Path: <cgroups+bounces-4003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30215942008
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74492821C1
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 18:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E21AA3FD;
	Tue, 30 Jul 2024 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dWuKcRby"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7971AA3C6
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365531; cv=none; b=nGipWsvG2Xfnx0Q/vXxRgBcK7jWHcF8FMnBXiY2NudR0mrv4MdKVlLUNKvFMgE0yRH0HXYf2Vs/jvHWsy57EpL2FaeIYgllV6cJ6Ks7wltAdCeP6FkqhUNx/k4rv5gXAVvInDejzp0Cr0Q8aCPF4sotasTwYGVHc/jMMbCWznJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365531; c=relaxed/simple;
	bh=riniWKHEmj3X689knihuF1Y2pcd2cCjGp03KBgM7p2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=N/0pmRxTIg8hn3yB5b8KuMfGUID9hyXndDHkEF7TaDzON3wraSLkAqEPfRcdZp//8PCDUycg15ME4XVCbB8+CT3SQXHxeW1InBmwrbPq0V3RWwjs52LDrepHC2SnvZTnFz4NeB3cuaNoJqYOh9TdDQcfLLkB+42m+MGVcqjqnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dWuKcRby; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240730185207euoutp02f8aa83daca246712ba7b459ccdd76280~nElJNTc-J3049230492euoutp02M
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 18:52:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240730185207euoutp02f8aa83daca246712ba7b459ccdd76280~nElJNTc-J3049230492euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722365527;
	bh=XUNVEVBUHu1MPJWO59vj8nIO541Z7GC1J8wR3j5KZH0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dWuKcRbyK7oE4ShiHJAB/gfNCKccE9hMoqAKBUxctqefPzXYJWr9HWStN+N7MsL/i
	 0UWFGyUrormx/TbE/Y9G+hazj6O8nsPfoJbucR7J+30eTaKomrJ6VQPfLBtnhOA2A8
	 Z4v7PHnUvc+qa8x7zQnlGOEdjMVNs7AgEcPCzmLs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240730185206eucas1p1df436db2791401ea0be3eae5ebebaac2~nElI_oNaC2664426644eucas1p1c;
	Tue, 30 Jul 2024 18:52:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.9C.09620.65639A66; Tue, 30
	Jul 2024 19:52:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d~nElIXt5sj0112901129eucas1p2c;
	Tue, 30 Jul 2024 18:52:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240730185206eusmtrp13b917d5a00e2d87d1ffa7e475320f451~nElIW_h_C2512925129eusmtrp1e;
	Tue, 30 Jul 2024 18:52:06 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-9f-66a9365685ef
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.E4.08810.65639A66; Tue, 30
	Jul 2024 19:52:06 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240730185205eusmtip254116d38b5380f42798cb0aecb28208d~nElHe4d8e1554215542eusmtip2E;
	Tue, 30 Jul 2024 18:52:05 +0000 (GMT)
Message-ID: <3c4b978b-b1fe-42d2-b1a7-a58609433f3c@samsung.com>
Date: Tue, 30 Jul 2024 20:52:04 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: kmem: add lockdep assertion to obj_cgroup_memcg
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240725094330.72537-1-songmuchun@bytedance.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH/e3ezW02uU3Ng5bCSMkyNynrUhIWlSuNpCgjglx5p5KabGlp
	GSsjH1ith83mqwep2Zwy0lKTcqWb6HxGqWUj0sTViLQkTaxt18r/Pud7fud8zzn82Bi/genF
	Tkg+QcmSJYkCFhevb5vuXr1/3QOpSKEVkcU1GhY5UFGIkw91u8j+xmIW+V7zm0l+nirHyPKG
	Dzh5VeNBjqlLGGSLuQsjc8bNeJiLeM6oYYlffPmKiXVVuSyxbuKas9hY+AsX31EUYOJJnU+U
	80FuaCyVmJBGyYSbYrjxUwWjzJR76089aq1lKlDn6jzEYQOxFmrvXsLtzCcqEcx+jM9DXBt/
	RzBccQOng0kE7S8LmH8rdO2lTDpRgeBS6XkWHXxD8HhK4ejFIzbBXPEHB+OEH9SoCpxpfTG0
	3xpx6B6EL5iHCh26GxEBbZZeB7sTnQi01WftjBG74dabBgbNnjA0UuZgFhEMedY8lp05Nq93
	Y1UY/cYXsuqKMPtAQGRzwHLR7EyPvRUuWEcRzW5gMTya15dCx/V8fL4Awe1fZgYdKBEoxobm
	KzbCu64Zmx3bZhEANY1COwKxGVRGjEZXGLAupmdwhWv1qnmZBzkX+XQPf1AbtP9cW3r6MCUS
	qBdcRb1gS/WCbdT/bW8jvAp5UqnypDhKviaZOhkklyTJU5Pjgo4eT9Ih2+/qmDP8eIIqLd+C
	9IjBRnoEbEzgzjv86r6Uz4uVpGdQsuOHZamJlFyPvNm4wJPnF+tL8Yk4yQnqGEWlULK/WQab
	46VgSLFPV4u7rTJ50aqYJo+ihh1Lwmezi175VaWXins+1ZvQg5+a9cOHuqNTcjGrdN9WbV/z
	7zOm8P6lz1RaTkpdSFmaaNlU//PY19OMtxE/wkKCD3hFY0bhm+qZnXXZy8dP+mSoQ7a7NJaX
	SL1DmyZWBe69/FqQJMz0jq4uE+3LTA+b5Q42irRZvU0xaU+2ud5URi55OxjZETCS04wFuC0v
	EY6eK1GZlMv2bImMOOLvNKn0MO4p9/kITj2lqXdIcsuwW6j2dNSOrCOLKmdymTpRYKYlUaUy
	GJy0GeGua1sjq4V8YjjKFKjXT2RM529wb6td4XPF5E88tf4cMpnyDQECXB4vCV6JyeSSP33B
	6e3MAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsVy+t/xe7phZivTDLb+Y7GYs34Nm8WN5TNY
	LFZv8rW4vGsOm8W9Nf9ZLV5/W8ZssWznQxaLiWtELZ7PmstkcfD+OWaLjpf3WRy4Pf6dWMPm
	cfjNe2aPTas62Tw2fZrE7nFixm8Wj4UNU5k9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0
	tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL0Mv4NvUpa8Fi84otRzewNjCe0e1i5OSQEDCR
	2HRyHiuILSSwlFHi+2J3iLiMxMlpDawQtrDEn2tdbF2MXEA17xklbu3ZzwSS4BWwk/g35yEL
	iM0ioCqxfvpUdoi4oMTJmU/A4qIC8hL3b80AiwsLeEsce3WRHWSQiMAZRomnO9aDFTEL+Eo8
	nn2RGeIKW4nv+3eyQ8TFJW49mQ+2jE3AUKLrLcgVnBycQIvvPF/FDFFjJtG1tYsRwpaXaN46
	m3kCo9AsJHfMQjJqFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM1m3Hfm7e
	wTjv1Ue9Q4xMHIyHGCU4mJVEeOOvLE0T4k1JrKxKLcqPLyrNSS0+xGgKDIyJzFKiyfnAdJFX
	Em9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cCUwO+620xuifgM3seV
	morR09886ar8o/FllUjyAoX2e54CnDuKj4ldMOecaaugk1U8Ra5eR+dJuIoee6nIpfr1D7e4
	chvXFDFKtHxW3el/RNXp7r/dyW7fY3ddm5AjukL8+8lt5ZrTz2p/jLgwuf3x8vqnriayL9Xq
	8t+8v3Do2bvbvUozJD/M3rVNfufTgKTWF5IbBeZ84S16/fe9qvVO39kK030kP057+MT3X9k7
	1us+674t+rkqpH+i1dblIabLG7kUn+3y4K08ZHN9NrtMrdbz5aFzbM3mLfhX8aPUi2OC929t
	HjMnc7+LE7JzQn7cj733ovCMpuS8p85ft697sWrdm9khHx3dRa7dWfR7qRJLcUaioRZzUXEi
	AKFiKQBfAwAA
X-CMS-MailID: 20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d
References: <20240725094330.72537-1-songmuchun@bytedance.com>
	<CGME20240730185206eucas1p28b14a1d9802ce2703bd13edc75e1b55d@eucas1p2.samsung.com>

On 25.07.2024 11:43, Muchun Song wrote:
> The obj_cgroup_memcg() is supposed to safe to prevent the returned
> memory cgroup from being freed only when the caller is holding the
> rcu read lock or objcg_lock or cgroup_mutex. It is very easy to
> ignore thoes conditions when users call some upper APIs which call
> obj_cgroup_memcg() internally like mem_cgroup_from_slab_obj() (See
> the link below). So it is better to add lockdep assertion to
> obj_cgroup_memcg() to find those issues ASAP.
>
> Because there is no user of obj_cgroup_memcg() holding objcg_lock
> to make the returned memory cgroup safe, do not add objcg_lock
> assertion (We should export objcg_lock if we really want to do).
> Additionally, this is some internal implementation detail of memcg
> and should not be accessible outside memcg code.
>
> Some users like __mem_cgroup_uncharge() do not care the lifetime
> of the returned memory cgroup, which just want to know if the
> folio is charged to a memory cgroup, therefore, they do not need
> to hold the needed locks. In which case, introduce a new helper
> folio_memcg_charged() to do this. Compare it to folio_memcg(), it
> could eliminate a memory access of objcg->memcg for kmem, actually,
> a really small gain.
>
> Link: https://lore.kernel.org/all/20240718083607.42068-1-songmuchun@bytedance.com/
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This patch landed in today's linux-next as commit 230b2f1f31b9 ("mm: 
kmem: add lockdep assertion to obj_cgroup_memcg"). I my tests I found 
that it triggers the following warning on Debian bookworm/sid system 
image running under QEMU RISCV64:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at include/linux/memcontrol.h:373 
mem_cgroup_from_slab_obj+0x13e/0x1ea
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.10.0+ #15154
Hardware name: riscv-virtio,qemu (DT)
epc : mem_cgroup_from_slab_obj+0x13e/0x1ea
  ra : mem_cgroup_from_slab_obj+0x13c/0x1ea
...
[<ffffffff80257256>] mem_cgroup_from_slab_obj+0x13e/0x1ea
[<ffffffff801f0b3e>] list_lru_del_obj+0xa6/0xc2
[<ffffffff8027c6c6>] d_lru_del+0x8c/0xa4
[<ffffffff8027da60>] __dentry_kill+0x15e/0x17a
[<ffffffff8027ec3c>] dput.part.0+0x242/0x3e6
[<ffffffff8027edee>] dput+0xe/0x18
[<ffffffff8027324c>] lookup_fast+0x80/0xce
[<ffffffff80273e28>] walk_component+0x20/0x13c
[<ffffffff802747e2>] path_lookupat+0x64/0x16c
[<ffffffff80274bf4>] filename_lookup+0x76/0x122
[<ffffffff80274d80>] user_path_at+0x30/0x4a
[<ffffffff802d12bc>] __riscv_sys_name_to_handle_at+0x52/0x1d8
[<ffffffff80b60324>] do_trap_ecall_u+0x14e/0x1da
[<ffffffff80b6c546>] handle_exception+0xca/0xd6
irq event stamp: 198187
hardirqs last  enabled at (198187): [<ffffffff8028ca9e>] 
lookup_mnt+0x186/0x308
hardirqs last disabled at (198186): [<ffffffff8028ca74>] 
lookup_mnt+0x15c/0x308
softirqs last  enabled at (198172): [<ffffffff800e34f6>] 
cgroup_apply_control_enable+0x1f6/0x2fc
softirqs last disabled at (198170): [<ffffffff800e34d8>] 
cgroup_apply_control_enable+0x1d8/0x2fc
---[ end trace 0000000000000000 ]---

Similar warning appears on ARM64 Debian bookworm system. Reverting it on 
top of linux-next hides the issue, but I assume this is not the best way 
to fix it.

I'm testing kernel built from riscv/defconfig with PROVE_LOCKING, 
DEBUG_ATOMIC_SLEEP, DEBUG_DRIVER and DEBUG_DEVRES options enabled.

> ---
> v3:
>   - Use lockdep_assert_once(Vlastimil).
>
> v2:
>   - Remove mention of objcg_lock in obj_cgroup_memcg()(Shakeel Butt).
>
>   include/linux/memcontrol.h | 20 +++++++++++++++++---
>   mm/memcontrol.c            |  6 +++---
>   2 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fc94879db4dff..95f823deafeca 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -360,11 +360,11 @@ static inline bool folio_memcg_kmem(struct folio *folio);
>    * After the initialization objcg->memcg is always pointing at
>    * a valid memcg, but can be atomically swapped to the parent memcg.
>    *
> - * The caller must ensure that the returned memcg won't be released:
> - * e.g. acquire the rcu_read_lock or css_set_lock.
> + * The caller must ensure that the returned memcg won't be released.
>    */
>   static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
>   {
> +	lockdep_assert_once(rcu_read_lock_held() || lockdep_is_held(&cgroup_mutex));
>   	return READ_ONCE(objcg->memcg);
>   }
>   
> @@ -438,6 +438,19 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
>   	return __folio_memcg(folio);
>   }
>   
> +/*
> + * folio_memcg_charged - If a folio is charged to a memory cgroup.
> + * @folio: Pointer to the folio.
> + *
> + * Returns true if folio is charged to a memory cgroup, otherwise returns false.
> + */
> +static inline bool folio_memcg_charged(struct folio *folio)
> +{
> +	if (folio_memcg_kmem(folio))
> +		return __folio_objcg(folio) != NULL;
> +	return __folio_memcg(folio) != NULL;
> +}
> +
>   /**
>    * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
>    * @folio: Pointer to the folio.
> @@ -454,7 +467,6 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>   	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
>   
>   	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> -	WARN_ON_ONCE(!rcu_read_lock_held());
>   
>   	if (memcg_data & MEMCG_DATA_KMEM) {
>   		struct obj_cgroup *objcg;
> @@ -463,6 +475,8 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
>   		return obj_cgroup_memcg(objcg);
>   	}
>   
> +	WARN_ON_ONCE(!rcu_read_lock_held());
> +
>   	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
>   }
>   
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 622d4544edd24..3da0284573857 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2366,7 +2366,7 @@ void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
>   
>   static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
>   {
> -	VM_BUG_ON_FOLIO(folio_memcg(folio), folio);
> +	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
>   	/*
>   	 * Any of the following ensures page's memcg stability:
>   	 *
> @@ -4617,7 +4617,7 @@ void __mem_cgroup_uncharge(struct folio *folio)
>   	struct uncharge_gather ug;
>   
>   	/* Don't touch folio->lru of any random page, pre-check: */
> -	if (!folio_memcg(folio))
> +	if (!folio_memcg_charged(folio))
>   		return;
>   
>   	uncharge_gather_clear(&ug);
> @@ -4662,7 +4662,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>   		return;
>   
>   	/* Page cache replacement: new folio already charged? */
> -	if (folio_memcg(new))
> +	if (folio_memcg_charged(new))
>   		return;
>   
>   	memcg = folio_memcg(old);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


