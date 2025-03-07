Return-Path: <cgroups+bounces-6872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E767A55DAB
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 03:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7EF3B4B03
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 02:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2104D1714B4;
	Fri,  7 Mar 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1qIFAev"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810141632C8
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314556; cv=none; b=uVEwXvob6tT3+FM0bZI8E1VVfG/cCMsPsVy1AkPAa65M+TRjAfj4qh9WsKzre5/gaMHUTE+9k7IT3MqWR5v/ZiLS5lmSKICzyoZabNHulDlqqSy0ULfvkXb4Z8RMaUvq5LcEz8RtrEXsrJ1gHomWCGBQNMqJamll66btHIseJVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314556; c=relaxed/simple;
	bh=TiywCEGjGXVyJ7rV06IXU3+OqvQV2e3a/X7hTHzQJi8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=vDjSFX/HVhMGtRCPGRz3Okb08QH61jQ9yScHN+zTkYwkO7ekqTb4YUM45y51QUSamFqSpTiTu3yYG+U6u6qBxJs/v5BPZsMY45Z3AL2rfWkzHmtzLxngILJUFKU0dz9Vyjh55naozS/69noSJjQFhXLYQdDOWZjaAxNRN+GKFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D1qIFAev; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741314550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5iiMgCTiEWsFPEP57NRn/hQnxZm6wGqGwBHu+DParc=;
	b=D1qIFAevA+kRZFqH55xQgQ9Oy1gk21CRqrHc9OFwXYZnEH3IyI441NbgZL/Fmwt0qUxRP3
	c9nPcho1Ar6IS85NSOm2bIxPBtPSVOZ2kG417PPbrd2AX7LkPsWLEfCTZKdG3kdFIsOwP1
	VpfBvzOFJ0UFGmA74Qdua5n4pHCiR6g=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250306143735.GB290530@cmpxchg.org>
Date: Fri, 7 Mar 2025 10:28:32 +0800
Cc: Kairui Song <ryncsn@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
 mhocko@kernel.org,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 akpm@linux-foundation.org,
 chrisl@kernel.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A4994942-1844-4F51-BF23-08848E069484@linux.dev>
References: <20250306023133.44838-1-songmuchun@bytedance.com>
 <CAMgjq7B5SyqYFbLhbgNCvQejqxVs5C6SaV_iot4P64EZLHZ8Gg@mail.gmail.com>
 <20250306143735.GB290530@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT



> On Mar 6, 2025, at 22:37, Johannes Weiner <hannes@cmpxchg.org> wrote:
>=20
> On Thu, Mar 06, 2025 at 10:54:12AM +0800, Kairui Song wrote:
>> On Thu, Mar 6, 2025 at 10:32=E2=80=AFAM Muchun Song =
<songmuchun@bytedance.com> wrote:
>>>=20
>>> The commit 6769183166b3 has removed the parameter of id from
>>> swap_cgroup_record() and get the memcg id from
>>> mem_cgroup_id(folio_memcg(folio)). However, the caller of it
>>> may update a different memcg's counter instead of
>>> folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
>>> @swap_memcg could be different with @memcg and update the counter
>>> of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
>>> ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
>>> swap counter will leak since the wrong recorded ID. Fix it by
>>> bring the parameter of id back.
>>>=20
>>> Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording =
and clearing")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>=20
> Looking at the original commit again, we also should do this:
>=20
> ---
>=20
> =46rom 2685ca87d73d0c2b91cfd6959e381a40db235119 Mon Sep 17 00:00:00 =
2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 6 Mar 2025 09:31:42 -0500
> Subject: [PATCH] mm: swap_cgroup: remove double initialization of =
locals
>=20
> Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording =
and clearing")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Yes.

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.

> ---
> mm/swap_cgroup.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 1007c30f12e2..de779fed8c21 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -92,8 +92,7 @@ void swap_cgroup_record(struct folio *folio, =
unsigned short id,
>  */
> unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int =
nr_ents)
> {
> - 	pgoff_t offset =3D swp_offset(ent);
> - 	pgoff_t end =3D offset + nr_ents;
> + 	pgoff_t offset, end;
> 	struct swap_cgroup *map;
> 	unsigned short old, iter =3D 0;
>=20
> --=20
> 2.48.1



