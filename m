Return-Path: <cgroups+bounces-10487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92381BA8194
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 08:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0B3C03CE
	for <lists+cgroups@lfdr.de>; Mon, 29 Sep 2025 06:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4A24EAB2;
	Mon, 29 Sep 2025 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USfRMIGE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7914D28137D
	for <cgroups@vger.kernel.org>; Mon, 29 Sep 2025 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759126877; cv=none; b=awMdANaoGuVQUfHonNg1JvDr7wl3Az0msTcZwRwu60mqNARbuvJXuOgDpwqp8aU3VQ+WE/FULIPRfm89XwCLb28yqKxwJ1KYCHwrKpugeSDXT7T0ki0OJkckIzrCq5BXqq8fy+ufAAK0aQgDWDmMdsvzcp1iV1+W+LK8gp6KKG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759126877; c=relaxed/simple;
	bh=Ct/x0vHC+gnGF7bhOiHyGsyesLhn9UEQwemK/00JaAQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BNdjboz53OkkHLTuPEzdupvmRr6mCP4z8ZW1u47I/V5uN0hYpwLU2mRbiIgJgctUy+neE122mxvuNY4RGaUIMOGfu8wRtnGGsZCmqFDM/KIq4ub/Y2jj9v8Xlxk8QS625kttj+GB9yfQiCqNG5GjOx3La4siT7txjmJZO2Y17lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USfRMIGE; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759126863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPlcwctVJa17AvuiwxVh/6RW6wt+NjqgznwU1ySTOQ4=;
	b=USfRMIGEHmHCVGO6HIWoOwjk2Btbyv0LZIpc8bsGpLdUoKp4ZcO8+SPsZECt0H6GWMKSDv
	teaqjscf8gMtHDHIRdHCx/moLTh+HDHIHGgSNYqzkBM5kImeJTHv7mjX73HK67oHx4HhYM
	nwrCRiVlA2Y9b78r26l5VOrp7AA0WJI=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v3 4/4] mm: thp: reparent the split queue during memcg
 offline
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <2ddd0c184829e65c5b3afa34e93599783e7af3d4.1759056506.git.zhengqi.arch@bytedance.com>
Date: Mon, 29 Sep 2025 14:20:16 +0800
Cc: hannes@cmpxchg.org,
 hughd@google.com,
 mhocko@suse.com,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 david@redhat.com,
 lorenzo.stoakes@oracle.com,
 ziy@nvidia.com,
 harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com,
 npache@redhat.com,
 ryan.roberts@arm.com,
 dev.jain@arm.com,
 baohua@kernel.org,
 lance.yang@linux.dev,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2EC0CBCD-73FD-400A-921A-EAB45B21ACB8@linux.dev>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
 <2ddd0c184829e65c5b3afa34e93599783e7af3d4.1759056506.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Sep 28, 2025, at 19:45, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> Similar to list_lru, the split queue is relatively independent and =
does
> not need to be reparented along with objcg and LRU folios (holding
> objcg lock and lru lock). So let's apply the same mechanism as =
list_lru
> to reparent the split queue separately when memcg is offine.
>=20
> This is also a preparation for reparenting LRU folios.
>=20
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> include/linux/huge_mm.h |  4 ++++
> mm/huge_memory.c        | 46 +++++++++++++++++++++++++++++++++++++++++
> mm/memcontrol.c         |  1 +
> 3 files changed, 51 insertions(+)
>=20
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f327d62fc9852..0c211dcbb0ec1 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -417,6 +417,9 @@ static inline int split_huge_page(struct page =
*page)
> 	return split_huge_page_to_list_to_order(page, NULL, ret);
> }
> void deferred_split_folio(struct folio *folio, bool partially_mapped);
> +#ifdef CONFIG_MEMCG
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg);
> +#endif
>=20
> void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
> 		unsigned long address, bool freeze);
> @@ -611,6 +614,7 @@ static inline int try_folio_split(struct folio =
*folio, struct page *page,
> }
>=20
> static inline void deferred_split_folio(struct folio *folio, bool =
partially_mapped) {}
> +static inline void reparent_deferred_split_queue(struct mem_cgroup =
*memcg) {}
> #define split_huge_pmd(__vma, __pmd, __address) \
> 	do { } while (0)
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bb32091e3133e..5fc0caca71de0 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1094,9 +1094,22 @@ static struct deferred_split =
*folio_split_queue_lock(struct folio *folio)
> 	struct deferred_split *queue;
>=20
> 	memcg =3D folio_memcg(folio);
> +retry:
> 	queue =3D memcg ? &memcg->deferred_split_queue :
> 			=
&NODE_DATA(folio_nid(folio))->deferred_split_queue;
> 	spin_lock(&queue->split_queue_lock);
> + 	/*
> +	 * Notice:
> +	 * 1. The memcg could be NULL if cgroup_disable=3Dmemory is set.
> +	 * 2. There is a period between setting CSS_DYING and =
reparenting
> +	 *    deferred split queue, and during this period the THPs in =
the
> +	 *    deferred split queue will be hidden from the shrinker =
side.
> +	 */
> + 	if (unlikely(memcg && css_is_dying(&memcg->css))) {
> + 		spin_unlock(&queue->split_queue_lock);
> + 		memcg =3D parent_mem_cgroup(memcg);
> + 		goto retry;
> + 	}
>=20
> 	return queue;
> }
> @@ -1108,9 +1121,15 @@ folio_split_queue_lock_irqsave(struct folio =
*folio, unsigned long *flags)
> 	struct deferred_split *queue;
>=20
> 	memcg =3D folio_memcg(folio);
> +retry:
> 	queue =3D memcg ? &memcg->deferred_split_queue :
> 			=
&NODE_DATA(folio_nid(folio))->deferred_split_queue;
> 	spin_lock_irqsave(&queue->split_queue_lock, *flags);
> + 		if (unlikely(memcg && css_is_dying(&memcg->css))) {
> + 		spin_unlock_irqrestore(&queue->split_queue_lock, =
*flags);
> + 		memcg =3D parent_mem_cgroup(memcg);
> + 		goto retry;
> + 	}
>=20
> 	return queue;
> }
> @@ -4275,6 +4294,33 @@ static unsigned long deferred_split_scan(struct =
shrinker *shrink,
> 	return split;
> }
>=20
> +#ifdef CONFIG_MEMCG
> +void reparent_deferred_split_queue(struct mem_cgroup *memcg)
> +{
> + 	struct mem_cgroup *parent =3D parent_mem_cgroup(memcg);
> + 	struct deferred_split *ds_queue =3D =
&memcg->deferred_split_queue;
> + 	struct deferred_split *parent_ds_queue =3D =
&parent->deferred_split_queue;
> + 	int nid;
> +
> + 	spin_lock_irq(&ds_queue->split_queue_lock);
> + 	spin_lock_nested(&parent_ds_queue->split_queue_lock, =
SINGLE_DEPTH_NESTING);
> +
> + 	if (!ds_queue->split_queue_len)
> + 		goto unlock;
> +
> + 	list_splice_tail_init(&ds_queue->split_queue, =
&parent_ds_queue->split_queue);
> + 	parent_ds_queue->split_queue_len +=3D ds_queue->split_queue_len;
> + 	ds_queue->split_queue_len =3D 0;
> +
> + 	for_each_node(nid)
> + 		set_shrinker_bit(parent, nid, =
shrinker_id(deferred_split_shrinker));
> +
> +unlock:
> + 	spin_unlock(&parent_ds_queue->split_queue_lock);
> + 	spin_unlock_irq(&ds_queue->split_queue_lock);
> +}
> +#endif
> +
> #ifdef CONFIG_DEBUG_FS
> static void split_huge_pages_all(void)
> {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e090f29eb03bd..d03da72e7585d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3887,6 +3887,7 @@ static void mem_cgroup_css_offline(struct =
cgroup_subsys_state *css)
> 	zswap_memcg_offline_cleanup(memcg);
>=20
> 	memcg_offline_kmem(memcg);
> + 	reparent_deferred_split_queue(memcg);

Since the dying flag of a memcg is not set under split_queue_lock,
two threads holding different split_queue_locks (e.g., one for the
parent memcg and one for the child) can concurrently manipulate the
same split-queue list of a folio. I think we should take the same
solution like list_lru does to fix this.

Muchun,
Thanks.


> 	reparent_shrinker_deferred(memcg);
> 	wb_memcg_offline(memcg);
> 	lru_gen_offline_memcg(memcg);
> --=20
> 2.20.1
>=20


