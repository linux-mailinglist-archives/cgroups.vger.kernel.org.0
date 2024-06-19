Return-Path: <cgroups+bounces-3238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CE90F1F1
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 17:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B88282785
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F01865B;
	Wed, 19 Jun 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cZ+ya7L8"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63914A615
	for <cgroups@vger.kernel.org>; Wed, 19 Jun 2024 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718810233; cv=none; b=dy/g5Zh0Jq2cPZjGB74CWj4u16Bv+TAH0103Tsjp3zC3mEmmLrQxz7FC/FuVdG2VgdmKKHrw7ZF6dXouMWQbmpSfbEmDrzqVDf4evYH/i79tk8jl7JiMQQLptqhXZRlAJ9paU9Wrc8xCc/mGJlBp3n0L11gwOi5scoDQhet92z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718810233; c=relaxed/simple;
	bh=WmRtfWcGGrHUU4sglkK7hcD/9SbpAjYOqFrEZO35OvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Qi9asrtxgGA32ZB9DwAgOSsAPkhKNJSNeqXyIWs68HbbWS+c3EKb3IR/7mcjWYugLLRSbbDQZ4sj1vP1yJx9ZlZY2jwx/gI5e0Uk5PwqMJIwkMLtXTuKlne9diEb4V8EYXirPsx+wEqLmOzX78sHxJMVeeej0oX/xhXScISnJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cZ+ya7L8; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240619151703euoutp01bc44763b96988de716648a3f00fbf2ac~acMq_upia1908519085euoutp01s
	for <cgroups@vger.kernel.org>; Wed, 19 Jun 2024 15:17:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240619151703euoutp01bc44763b96988de716648a3f00fbf2ac~acMq_upia1908519085euoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718810223;
	bh=AVBFj8bxKG89wl4Soyn2tyFHkZuTFMOACKBUqbcjecw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cZ+ya7L8e1qk0hwHseHDFi52beh8JhpM8ZCXDeKDV8TNMV3kyJmV5UdE+fYiXppd3
	 aAKcSAuPMp4VbJmTqmST/O5yeWZMKn2qH1VipFJJb/tO2bu9nq/Ov0vOPY7I9x3VDO
	 kGLjpvXX+0Hs8R9EAcw9G2xthwCsazBzS9cURn5c=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240619151703eucas1p2562f4f2b8b76053d828572fe4e6f76e4~acMqxY3Fh1412714127eucas1p2K;
	Wed, 19 Jun 2024 15:17:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 0C.49.09624.F66F2766; Wed, 19
	Jun 2024 16:17:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240619151703eucas1p267edf4a9270c570208630e93426ea6e5~acMqYHiff1416214162eucas1p2F;
	Wed, 19 Jun 2024 15:17:03 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240619151703eusmtrp1dd09dd111a9b2252b3fd640d9963c2c2~acMqXlAnH0578105781eusmtrp1d;
	Wed, 19 Jun 2024 15:17:03 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-1f-6672f66f7b7b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.05.08810.F66F2766; Wed, 19
	Jun 2024 16:17:03 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240619151702eusmtip2295998e66b5afaa5fd2d6a057f3e030d~acMp0y7dZ3074730747eusmtip2z;
	Wed, 19 Jun 2024 15:17:02 +0000 (GMT)
Message-ID: <3a73665f-f1dc-4494-b250-da1a57b92369@samsung.com>
Date: Wed, 19 Jun 2024 17:17:02 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next] mm/hugetlb_cgroup: register lockdep key for
 cftype
To: Xiu Jianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, sj@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240619015527.2212698-1-xiujianfeng@huawei.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7r534rSDPa8kbOYs34Nm8WN5TNY
	LFZv8rW4vGsOm8W9Nf9ZLU68PsJmcfjrGyaLX8uPMlpsn7WD0YHT49+JNWweh9+8Z/ZoOfKW
	1WPTqk42j02fJrF7nJjxm8Xj8ya5APYoLpuU1JzMstQifbsErowFM2IKrqlWHHvu1MC4VL6L
	kZNDQsBEYt+S48xdjFwcQgIrGCX+7rrKCOF8YZTo3bEJKvOZUWLO5fvsMC3Pd22AqlrOKPH6
	wxsmCOcjo0TDvJVsXYwcHLwCdhIPrhmAmCwCqhLNc+JAenkFBCVOznzCAmKLCshL3L81A2ym
	sECQxKO5d9hBxogINDFKPPh1ixUkwSwQJzFx9XV2CFtc4taT+UwgNpuAoUTX2y42EJsTaFVv
	90KoGnmJ7W/ngF0tIfCfQ6KzbyYzxNUuEnu/TmSEsIUlXh3fAvWNjMTpyT0sEA3tjBILft9n
	gnAmAH3z/BZUh7XEnXO/wD5jFtCUWL9LHyLsKDHx1B1GkLCEAJ/EjbeCEEfwSUzaNp0ZIswr
	0dEmBFGtJjHr+Dq4tQcvXGKewKg0CylcZiF5cxaSd2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84
	Mbe4NC9dLzk/dxMjME2d/nf80w7Gua8+6h1iZOJgPMQowcGsJML7vKsoTYg3JbGyKrUoP76o
	NCe1+BCjNAeLkjivaop8qpBAemJJanZqakFqEUyWiYNTqoEpx/fVZ7ctE348iF0vrvVN2OzK
	jwNfqqVUxTasEa+566HgKDOjt6o90sn11qz7E1w2ff34S/r5ja/Bqk8m33/26rdA467PTZlT
	HPe/Pv35x88bCtbZ1Ueu2ASmeRkkftnh91LqQOOm6NnBZ7ZWdFv11XJ82vigXz1g5VT+N4d8
	JCTYq0O//WeYvFkpv3atsNbuKyapW/X+3BL1f5BhZK/5VvN1wn8NB8almz5vt+acO+/asQ33
	XlhrXd2jJGa0YHZZ5fZtR1ouvuoJ+LA3PfpOjOiDAGvO55eSt32p3aw12ddGTV/bQLn4B4tl
	n0nhuj4XneTdftz6t34vNjpSrapnHGoTPXGy1fvQ1fLPbnc3KLEUZyQaajEXFScCAIDRiXfC
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7r534rSDDresFrMWb+GzeLG8hks
	Fqs3+Vpc3jWHzeLemv+sFideH2GzOPz1DZPFr+VHGS22z9rB6MDp8e/EGjaPw2/eM3u0HHnL
	6rFpVSebx6ZPk9g9Tsz4zeLxeZNcAHuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
	rJWRqZK+nU1Kak5mWWqRvl2CXsaCGTEF11Qrjj13amBcKt/FyMkhIWAi8XzXBsYuRi4OIYGl
	jBKXvkxghEjISJyc1sAKYQtL/LnWxQZR9J5R4sblVexdjBwcvAJ2Eg+uGYCYLAKqEs1z4kDK
	eQUEJU7OfMICYosKyEvcvzWDHcQWFgiSeDT3DjvIGBGBJkaJrYeXgCWYBeIk5p//yQIxfyKj
	xKEFV1ggEuISt57MZwKx2QQMJbreghzBycEJtLe3eyFUs5lE19YuRghbXmL72znMExiFZiE5
	ZBaSUbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYFxuO/Zz8w7Gea8+6h1i
	ZOJgPMQowcGsJML7vKsoTYg3JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbnAxNDXkm8oZmBqaGJ
	maWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDk9Lt3veVyyq+fqhYJHZcPPOdAX/j
	cff0L3aB83NffzCp49geduRz3bMDpZUnW+9Yp0XUR2/7IxpxLLfe12D3lNstt71Ljtkzr1/4
	1NJgEW++eITxkuZ25j8bbjifM2Dd4dv/+NW9ZeIcP1aaJ624lNKnvWt/kPN3rgKf2ud3z4Sn
	G1+e67e0c4H24W1qU+b1/5m6atNS6Xu31s+UKFa+80ilt4Cx1X/L130tZSy8IgWXxarzz9wu
	M3HpY5r49eKMYDtzu1MtpY/reM+tCLy20dBvbarz1PUXamdvCJy6/aRc2uXmi4t93wbOeLny
	p+22aX91z9ak3eb2yZug0+R3/Ohr2clbv+aaNq8sPsU2W0uJpTgj0VCLuag4EQDmWmheVAMA
	AA==
X-CMS-MailID: 20240619151703eucas1p267edf4a9270c570208630e93426ea6e5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240619020518eucas1p17fb54c2c1cb9c62f1cc5bf9b04c1ec19
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240619020518eucas1p17fb54c2c1cb9c62f1cc5bf9b04c1ec19
References: <CGME20240619020518eucas1p17fb54c2c1cb9c62f1cc5bf9b04c1ec19@eucas1p1.samsung.com>
	<20240619015527.2212698-1-xiujianfeng@huawei.com>

On 19.06.2024 03:55, Xiu Jianfeng wrote:
> When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
> trigger a bug,
>
> mount -t cgroup2 none /sys/fs/cgroup
> cd /sys/fs/cgroup
> echo "+hugetlb" > cgroup.subtree_control
>
> The log is as below:
>
> BUG: key ffff8880046d88d8 has not been registered!
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 3 PID: 226 at kernel/locking/lockdep.c:4945 lockdep_init_map_type+0x185/0x220
> Modules linked in:
> CPU: 3 PID: 226 Comm: bash Not tainted 6.10.0-rc4-next-20240617-g76db4c64526c #544
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:lockdep_init_map_type+0x185/0x220
> Code: 00 85 c0 0f 84 6c ff ff ff 8b 3d 6a d1 85 01 85 ff 0f 85 5e ff ff ff 48 c7 c6 21 99 4a 82 48 c7 c7 60 29 49 82 e8 3b 2e f5
> RSP: 0018:ffffc9000083fc30 EFLAGS: 00000282
> RAX: 0000000000000000 RBX: ffffffff828dd820 RCX: 0000000000000027
> RDX: ffff88803cd9cac8 RSI: 0000000000000001 RDI: ffff88803cd9cac0
> RBP: ffff88800674fbb0 R08: ffffffff828ce248 R09: 00000000ffffefff
> R10: ffffffff8285e260 R11: ffffffff828b8eb8 R12: ffff8880046d88d8
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880067281c0
> FS:  00007f68601ea740(0000) GS:ffff88803cd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005614f3ebc740 CR3: 000000000773a000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? __warn+0x77/0xd0
>   ? lockdep_init_map_type+0x185/0x220
>   ? report_bug+0x189/0x1a0
>   ? handle_bug+0x3c/0x70
>   ? exc_invalid_op+0x18/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? lockdep_init_map_type+0x185/0x220
>   __kernfs_create_file+0x79/0x100
>   cgroup_addrm_files+0x163/0x380
>   ? find_held_lock+0x2b/0x80
>   ? find_held_lock+0x2b/0x80
>   ? find_held_lock+0x2b/0x80
>   css_populate_dir+0x73/0x180
>   cgroup_apply_control_enable+0x12f/0x3a0
>   cgroup_subtree_control_write+0x30b/0x440
>   kernfs_fop_write_iter+0x13a/0x1f0
>   vfs_write+0x341/0x450
>   ksys_write+0x64/0xe0
>   do_syscall_64+0x4b/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7f68602d9833
> Code: 8b 15 61 26 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 08
> RSP: 002b:00007fff9bbdf8e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f68602d9833
> RDX: 0000000000000009 RSI: 00005614f3ebc740 RDI: 0000000000000001
> RBP: 00005614f3ebc740 R08: 000000000000000a R09: 0000000000000008
> R10: 00005614f3db6ba0 R11: 0000000000000246 R12: 0000000000000009
> R13: 00007f68603bd6a0 R14: 0000000000000009 R15: 00007f68603b8880
>
> For lockdep, there is a sanity check in lockdep_init_map_type(), the
> lock-class key must either have been allocated statically or must
> have been registered as a dynamic key. However the commit e18df2889ff9
> ("mm/hugetlb_cgroup: prepare cftypes based on template") has changed
> the cftypes from static allocated objects to dynamic allocated objects,
> so the cft->lockdep_key must be registered proactively.
>
> Fixes: e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on template")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202406181046.8d8b2492-oliver.sang@intel.com
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Fixes the issue pointed here:

https://lore.kernel.org/all/602186b3-5ce3-41b3-90a3-134792cc2a48@samsung.com/

> ---
> v3: remove #ifdef CONFIG_DEBUG_LOCK_ALLOC in struct cftype
> v2: add bug log to commit message
> ---
>   include/linux/cgroup-defs.h | 2 --
>   mm/hugetlb_cgroup.c         | 2 ++
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..293af7f8a694 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -681,9 +681,7 @@ struct cftype {
>   	__poll_t (*poll)(struct kernfs_open_file *of,
>   			 struct poll_table_struct *pt);
>   
> -#ifdef CONFIG_DEBUG_LOCK_ALLOC
>   	struct lock_class_key	lockdep_key;
> -#endif
>   };
>   
>   /*
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 2b899c4ae968..4ff238ba1250 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -836,6 +836,8 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>   			cft->file_offset = MEMFILE_OFFSET0(offset) +
>   					   MEMFILE_FIELD_SIZE(offset) * idx;
>   		}
> +
> +		lockdep_register_key(&cft->lockdep_key);
>   	}
>   }
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


