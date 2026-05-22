Return-Path: <cgroups+bounces-16197-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGuLOPz4D2pDSAYAu9opvQ
	(envelope-from <cgroups+bounces-16197-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:34:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC35AF8D6
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3194301C580
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8062F355F5F;
	Fri, 22 May 2026 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R3BIP27m"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078732B10A
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431655; cv=none; b=XNSvtN5Ju/vCEWZ69/6WIh1YhHALFgQCAmpDOrKrTBmqNnJgZuCxubcjSSbD3EIYvLvC3zuRIUGfFWZ65PbiOHNQsrZuGozWcgMd//ThPgARSTbsMTYobpQ7UpBYydav8IqvtHaDHDyo/EHRyn2Fx2EzvCWcw6yDxmadqy08Ji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431655; c=relaxed/simple;
	bh=Gy5USktPc+DpxcRXvlEYPQxVTY5mpX1apEBEYv6GvUg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pl6xr60n+onv3xttfZ/m7LqseHV1dlvZgh1ltO5/me2lhzUDnqyCv1tcN8utAHyrNofoEc2fuwT7P9T2kOvKyzwkckz4mEhYNDur3JzrHNKjYbH+Oq27ivGA/Qda0pjY6oPrBfrXTV/WBKRVVMSSzxQ3QhIOKvOlOOuGi0p78Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R3BIP27m; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779431641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWYdv8Hq6G2AEgBieu9Gbg4GlepaISy61ztZHjyMni4=;
	b=R3BIP27mW+JwnrtL7IlLGViBLl+RRlOm7FTyg9F4tpUNBp2eyZAsYpkwE7xjqmj+/CYioM
	72UZzTOPR8+H05RrzFxiOfWAU15R4Ne87ebUd37dHDdCdghdXHFDFiKMGtGK2vMR2RqRvp
	fk3X96YdGpGgG1BbTOe9Fk2dHI+a1Dc=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2 4/4] memcg: multi objcg charge support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260522011908.1669332-5-shakeel.butt@linux.dev>
Date: Fri, 22 May 2026 14:33:36 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Harry Yoo <harry@kernel.org>,
 Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D6F8C2F-F3E7-4326-A4F6-D5B1433A6C55@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
 <20260522011908.1669332-5-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16197-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.963];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,intel.com:email]
X-Rspamd-Queue-Id: 47AC35AF8D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 22, 2026, at 09:19, Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>=20
> Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
> per-node type") split a memcg's single obj_cgroup into one per NUMA
> node so that reparenting LRU folios can take per-node lru locks. As a
> side effect, the per-CPU obj_stock_pcp -- which caches exactly one
> cached_objcg -- thrashes on workloads where threads of the same memcg
> run on different NUMA nodes. The kernel test robot reported a 67.7%
> regression on stress-ng.switch.ops_per_sec from this pattern.
>=20
> Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
> nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
> slots on consume/refill/account, prefer empty slots when inserting,
> and evict a random slot only when full. With multiple slots a CPU can
> hold the per-node objcg variants of one memcg plus a few siblings
> without ever forcing a drain.
>=20
> A single int8_t index records which slot the cached slab stats belong
> to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
> =3D 5 the layout (verified with pahole) is:
>=20
>  offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) =3D 8B
>  offset 8  : nr_bytes[5]                                     =3D 10B
>  offset 18 : padding                                         =3D 6B
>  offset 24 : cached[5]                                       =3D 40B
>  offset 64 : (line 2) work_struct + flags (cold)
>=20
> so consume_obj_stock, refill_obj_stock and the slab account path each
> touch exactly one 64-byte cache line on non-debug 64-bit builds.
>=20
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: =
https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
> Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg =
per-node type")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Tested-by: kernel test robot <oliver.sang@intel.com>
> ---
>=20
> Changes since v1:
> - Use round robin for drain
>=20
> mm/memcontrol.c | 188 ++++++++++++++++++++++++++++++++++--------------
> 1 file changed, 136 insertions(+), 52 deletions(-)
>=20
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 78c02451312b..ba17633b0bd0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref =
*ref)
> 	* However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> 	*
> 	* The following sequence can lead to it:
> - 	* 1) CPU0: objcg =3D=3D stock->cached_objcg
> + 	* 1) CPU0: objcg cached in one of stock->cached[i]
> 	* 2) CPU1: we do a small allocation (e.g. 92 bytes),
> 	*          PAGE_SIZE bytes are charged
> 	* 3) CPU1: a process from another memcg is allocating something,
> 	*          the stock if flushed,
> 	*          objcg->nr_charged_bytes =3D PAGE_SIZE - 92
> 	* 5) CPU0: we do release this object,
           ^
           4

Since you're already modifying the comments in this section,
would you mind fixing the numbering as well? I noticed that the
sequence was wrong a while back :)

> - 	*          92 bytes are added to stock->nr_bytes
> + 	*          92 bytes are added to stock->nr_bytes[i]
> 	* 6) CPU0: stock is flushed,
           ^
           5

Thanks,
Muchun

> 	*          92 bytes are added to objcg->nr_charged_bytes




