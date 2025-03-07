Return-Path: <cgroups+bounces-6873-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF40A55DAD
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 03:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5E2188D19F
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 02:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE4317B506;
	Fri,  7 Mar 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tnp/THdq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2F17E472
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314562; cv=none; b=Ut1HgRGqqrwtji5FpRuBgdVeLQKwaVucU27czetQi//FoTTEWreqRzhn1FyzFo/ay8LmR4PpIyDygmwrUaeovQtkVVp2BmkpfRnTeYk4beJqobM2JTffW3fZLmmlcdlHl4v5l8jyHM+27584ohDSZmMzPsf1SLM4DkCC4AvBfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314562; c=relaxed/simple;
	bh=TiywCEGjGXVyJ7rV06IXU3+OqvQV2e3a/X7hTHzQJi8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E3AZ3VB6p3DD3HnSJkBXK1w9iyQK2ZLU3rZjY3bogk9A+8hG+cKfVH+locS+QEVfYfXv1hYA4HQyE8eXlmyyuVVoODVrciTeafwPSVQJJJ5deGBGumFI1Rg2iWIvnoV/8Cw48FC8yf8XlhCFbKLRzHOcnJOTsj2myWqsy+FHJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tnp/THdq; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741314558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5iiMgCTiEWsFPEP57NRn/hQnxZm6wGqGwBHu+DParc=;
	b=Tnp/THdqlK9ZHz2Hj9AjymBG4h+GlmuFEJX2OlpsUazIBYf/P2DFsAXw1Q/IDm6lf1yo37
	S4l9+oOzbMNd8vDctiBG4knumn7PJSgQrJMHICllqdXZmKhe850Enoww7PXwlvbyh0JIrn
	+3tDMqHT/FxKRQRzuCX44FnNzRY9+Yc=
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



