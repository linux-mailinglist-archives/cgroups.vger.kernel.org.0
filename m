Return-Path: <cgroups+bounces-15150-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC91KnMUzWmMZwYAu9opvQ
	(envelope-from <cgroups+bounces-15150-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 14:49:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3637ABB0
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FFB3302E926
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33440629D;
	Wed,  1 Apr 2026 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DuCPEUoQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E589840628B
	for <cgroups@vger.kernel.org>; Wed,  1 Apr 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046390; cv=none; b=DLE0vjCH7hvk9M9NZmJuRk4WVFT6ToLFWdU02x/QZ2nqlt4yzSFCSWzcT2vRRLXIC9cMSvqiWN8sa/tPTvIqYyAfhO59izc92Yi85Cos3OjdC40P/2CGO+FvDdQKBxj+17QmRuo/vuIDHuOL4/ijxAiKrGiVBVfZ2pa13T1zI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046390; c=relaxed/simple;
	bh=CGMBUCxewdfii0r275bpztDmU7H6wrTH4UvTpQOEpOU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ilJ+NXEKFFVHPjB1ACDeqVJOLb9a85JP9EPoBnt7EVlfuMGMUDCkKpmUUbldfqhLMeej4B+A1QHcvkz1qmOi76gNvgBWkmsD3ea96HOflgDlAZOEAqaBUjP6811B/CssV8kISkdY3rSAgtj0dKKNh+pYz1+kE0U3ovto5KMSMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DuCPEUoQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775046376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RRpsgUrZWaL+QC1rauEtM+0dsvtlEKa3fb+EjeI+Vg=;
	b=DuCPEUoQ585nScG8yHQ7EYzzMTFYAosos72EJa5eXCTRxZSXHExP4bnU5tW90oMuKkp5Ay
	WYLplWHm7RjosHRA1bSoehBUqKAZxQ93bUXPDx/tKg91C2lL77mO3+unvHyY9jKVxmeofP
	vVr5tOOeue8gXsBtv4fOj9imFr5VfTY=
Date: Wed, 01 Apr 2026 12:26:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "teawater" <hui.zhu@linux.dev>
Message-ID: <a897fa9eb0ba60fa5a5b4be106d9d376f2f1e2ca@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mm-stable v3] mm/memcontrol: batch memcg charging in
 __memcg_slab_post_alloc_hook
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko"
 <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Hui Zhu" <zhuhui@kylinos.cn>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>
In-Reply-To: <acv5QCe0qMUUW2xP@hyeyoo>
References: <20260331091707.226786-1-hui.zhu@linux.dev>
 <acvnjCr26zpQUW0h@linux.dev> <acv5QCe0qMUUW2xP@hyeyoo>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15150-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: B8B3637ABB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
>=20On Tue, Mar 31, 2026 at 08:32:30AM -0700, Shakeel Butt wrote:
>=20
>=20>=20
>=20> On Tue, Mar 31, 2026 at 05:17:07PM +0800, Hui Zhu wrote:
> >  From: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  When kmem_cache_alloc_bulk() allocates multiple objects, the post-=
alloc
> >  hook __memcg_slab_post_alloc_hook() previously charged memcg one obj=
ect
> >  at a time, even though consecutive objects may reside on slabs backe=
d by
> >  the same pgdat node.
> >=20=20
>=20>  Batch the memcg charging by scanning ahead from the current positi=
on to
> >  find a contiguous run of objects whose slabs share the same pgdat, t=
hen
> >  issue a single __obj_cgroup_charge() / __consume_obj_stock() call fo=
r
> >  the entire run. The per-object obj_ext assignment loop is preserved =
as-is
> >  since it cannot be further collapsed.
> >=20=20
>=20>  This implements the TODO comment left in commit bc730030f956 ("mem=
cg:
> >  combine slab obj stock charging and accounting").
> >=20=20
>=20>  The existing error-recovery contract is unchanged: if size =3D=3D =
1 then
> >  memcg_alloc_abort_single() will free the sole object, and for larger
> >  bulk allocations kmem_cache_free_bulk() will uncharge any objects th=
at
> >  were already charged before the failure.
> >=20=20
>=20>  Benchmark using kmem_cache_alloc_bulk() with SLAB_ACCOUNT
> >  (iters=3D100000):
> >=20=20
>=20>  bulk=3D32 before: 215 ns/object after: 174 ns/object (-19%)
> >  bulk=3D1 before: 344 ns/object after: 335 ns/object ( ~)
> >=20=20
>=20>  No measurable regression for bulk=3D1, as expected.
> >=20=20
>=20>  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >=20=20
>=20>  Do we have an actual user of kmem_cache_alloc_bulk(GFP_ACCOUNT) in=
 kernel?
> >=20

Hi=20Harry and Shakeel,

> Apparently we have a SLAB_ACCOUNT user in io_uring.c.
> (perhaps it's the only user?)

Looks like __io_alloc_req_refill is only user that call kmem_cache_alloc_=
bulk
with SLAB_ACCOUNT.

I am working on make a benchmark code for it.

Best,
Hui

>=20
>=20>=20
>=20> If yes, can you please benchmark that usage? Otherwise can we pleas=
e wait for
> >  an actual user before adding more complexity? Or you can look for op=
portunities
> >  for kmem_cache_alloc_bulk(GFP_ACCOUNT) users and add the optimizatio=
n along with
> >  the user.
> >=20
>=20Good point. I was also wondering what are use cases benefiting
> from this beyond the microbenchmark.
>=20
>=20>=20
>=20> Have you looked at the bulk free side? I think we already have rcu =
freeing in
> >  bulk as a user. Did you find any opportunities in optimizing the
> >  __memcg_slab_free_hook() from bulk free?
> >=20
>=20Probably a bit out of scope but one thing to note on slab side:
> kfree_bulk() (called by kfree_rcu batching) doesn't specify slab cache,
> and it builds a detached freelist which contains objects from the same =
slab.
>=20
>=20On the other hand kmem_cache_free_bulk() with non-NULL slab cache
> simply calls free_to_pcs_bulk() and it passes objects one by one to
> __memcg_slab_free_hook() since objects may not come from the same slab.
>=20
>=20Now that we have sheaves enabled for (almost) all slab caches, it mig=
ht
> be worth revisiting - e.g. sort objects by slab cache and
> pass them to free_to_pcs_bulk() instead of building a detached freelist=
.
>=20
>=20And let __memcg_slab_free_hook() handle objects from the same cache b=
ut
> from different slabs.
>=20
>=20--=20
>=20Cheers,
> Harry / Hyeonggon
>

