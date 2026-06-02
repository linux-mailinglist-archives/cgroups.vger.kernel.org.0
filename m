Return-Path: <cgroups+bounces-16544-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFDFICVCHmraiAkAu9opvQ
	(envelope-from <cgroups+bounces-16544-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:38:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0D627553
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 04:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3C403002F41
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC6A364049;
	Tue,  2 Jun 2026 02:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JGiAuZIQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC73630BE
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367901; cv=none; b=oGe02fA8sHcrzLDQUaEqG3B9/F+EF/m2tVOAgAo0/VwC+P9tRuRBUgisz6cjduV/HUBTfD74y38zXujIBHy4wQdc1k03D9Y10qEyP8qGKVZztrRCJciMQJAPsLhpsn63Z6FoPf3EiRD85+Pfe7weuBzbthaG4iSeP/qBioYXhqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367901; c=relaxed/simple;
	bh=96nhWNtDU8LPmZyWrQOJNpY471Rj9hGd5/qiQb6AYk0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dwqX9TqT8YPxht059REDTiVWoRiSsm+y3ykhltBtqB8yBCC90y+jTl6OhWZOED+iIUMsi8y8LxoOL8/sODcnjak9Q7ZRBRCKIc/7zPb8nKJ8f/53fcSbu8fjjJ/CbGFlCjBNSak3gNy95FN6RcjTo9A3/4rmUnYlKhUmOALC0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JGiAuZIQ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780367888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKmVnwBQTYER22XxHtKgTEyxPcm6+PF1gPWG/CQnepo=;
	b=JGiAuZIQLye/+Tr5WQmbONLcGtvIIS11nHqAEbCgq1kKsxaQCmxnVcxjqgt2N4pMDxeD/+
	mD0m9ZFj7qpHL0VeyNUB9MpN+KanG/aD2i184DUr7pRbGdpJzUoZjyHpNvxzqab7wstkbL
	s+8siCc82RccvASUNGd1HBOD+46UPcQ=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2] mm/list_lru: drain before clearing xarray entry on
 reparent
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260601161501.1444829-1-shakeel.butt@linux.dev>
Date: Tue, 2 Jun 2026 10:37:25 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Dave Chinner <david@fromorbit.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Qi Zheng <qi.zheng@linux.dev>,
 Kairui Song <kasong@tencent.com>,
 Meta kernel team <kernel-team@meta.com>,
 linux-mm@kvack.org,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Chris Mason <clm@fb.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CD76642-E809-4E81-9F12-DB110A9F958D@linux.dev>
References: <20260601161501.1444829-1-shakeel.butt@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16544-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6AC0D627553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On Jun 2, 2026, at 00:15, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>=20
> memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
> xas_store(&xas, NULL) before reparenting its per-node lists into the
> parent. This opens a window where a concurrent list_lru_del() arriving
> for the dying memcg sees xa_load() =3D=3D NULL, walks to the parent in
> lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
> list_del_init() on an item still physically linked on the dying
> memcg's list.
>=20
> If another in-flight thread holds the dying memcg's per-node lock at
> the same moment (another list_lru_del, or a list_lru_walk_one running
> an isolate callback), both threads modify ->next/->prev pointers on =
the
> same physical list under different locks. Adjacent items can corrupt
> each other's links.
>=20
> Fix it by reversing the order: reparent each per-node list and mark =
the
> child's list lru dead and then clear the xarray entry. Any concurrent
> list_lru op that finds the still-set xarray entry either takes the =
dying
> memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
> and walks to the parent, where the items now live.
>=20
> Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup =
scope")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Chris Mason <clm@fb.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1:
> - Use xa_erase_irq() instead of xa_erase() (Sashiko & Claude).
> - Added comment on CSS_DYING check in memcg_list_lru_alloc avoiding a =
new mlru
>  allocation.
>=20
> mm/list_lru.c | 21 ++++++++++++---------
> 1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index dd29bcf8eb5f..d454bce9a78e 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -473,26 +473,29 @@ void memcg_reparent_list_lrus(struct mem_cgroup =
*memcg, struct mem_cgroup *paren
> 	mutex_lock(&list_lrus_mutex);
> 	list_for_each_entry(lru, &memcg_list_lrus, list) {
> 		struct list_lru_memcg *mlru;
> - 		XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
>=20
> 		/*
> -		 * Lock the Xarray to ensure no on going list_lru_memcg
> -		 * allocation and further allocation will see =
css_is_dying().
> +		 * css_is_dying() check in memcg_list_lru_alloc() avoids
> +		 * allocating a new mlru since CSS_DYING is already set =
for this
> +		 * memcg a rcu grace period ago.

I see. xas_lock_irqsave() in memcg_list_lru_alloc() functions as an RCU =
read lock.

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

> 		 */
> - 		xas_lock_irq(&xas);
> - 		mlru =3D xas_store(&xas, NULL);
> - 		xas_unlock_irq(&xas);
> + 		mlru =3D xa_load(&lru->xa, memcg->kmemcg_id);
> 		if (!mlru)
> 			continue;
>=20
> 		/*
> -		 * With Xarray value set to NULL, holding the lru lock =
below
> -		 * prevents list_lru_{add,del,isolate} from touching the =
lru,
> -		 * safe to reparent.
> +		 * Reparent each per-node list and mark the child dead
> +		 * (LONG_MIN) before clearing xarray entry otherwise a
> +		 * concurrent list_lru_del() may corrupt the list if it =
arrives
> +		 * after xarray clear but before reparenting as
> +		 * lock_list_lru_of_memcg will acquire parent's lock =
while the
> +		 * item is still on child's list.
> */
> 		for_each_node(i)
> 			memcg_reparent_list_lru_one(lru, i, =
&mlru->node[i], parent);
>=20
> + 		xa_erase_irq(&lru->xa, memcg->kmemcg_id);
> +
> 		/*
> 		 * Here all list_lrus corresponding to the cgroup are =
guaranteed
> 		 * to remain empty, we can safely free this lru, any =
further
> --=20
> 2.53.0-Meta
>=20


