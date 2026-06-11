Return-Path: <cgroups+bounces-16840-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PaLfBtlBKmoklQMAu9opvQ
	(envelope-from <cgroups+bounces-16840-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:04:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D341C66E5C4
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:04:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ovoH7RXY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16840-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16840-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE693050F41
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D9F3537C8;
	Thu, 11 Jun 2026 04:57:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08BB238171;
	Thu, 11 Jun 2026 04:57:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153871; cv=none; b=H5cF+j5z3tbclik90Qo9f1I+zy1EHobwICkCaM66EGatAG+WtIMjhbeB45rYVguQZWcyaxF7ZSTS8XvFDirHEAj2OYiMu3Yc54fCAcknYHUW09t0uuUEvWUpUR3xb+wCOWidudwRnpB0QTI60sGKhnIQFme5QeYjLWP/U49Gxjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153871; c=relaxed/simple;
	bh=rPXbXmseReDxlfFLMEq1wKW5R0sBDfdHAGp/dzQ6skg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3WG1M5lyKSW1hS6bKNpM6KcFnDCncCuGGWGh6x4MiSo7R6da4ZkYEv9aM48x/XLveP+VU/MkVUHq7yCr7l6kM/MUcATu1iNpBMYGafAHgmCRfRqypWjSgCJCe9Kg53gMSppEJie+2AnBhLi2gwExKkefS9Sd9iQE84LG6DPVPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovoH7RXY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9780A1F00893;
	Thu, 11 Jun 2026 04:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781153861;
	bh=rPXbXmseReDxlfFLMEq1wKW5R0sBDfdHAGp/dzQ6skg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ovoH7RXYEpV1zAeJEinykeprmqVgXdFWDCWcpQLn6fgXzXhY3UlUqtf4JtXqz2cLS
	 FJo4v0tTeZSl3vT990E1U7UFovkIirYQ91CSoD03B/BMvpc4AmrLiOd69kN7d9oYcY
	 q7PCes77Wwa/1snwRzYun4Ui4XCOGC7hNu4UnjqgXFiAbQxhMUCPgPfemHYbm0Ebix
	 jIWqIYNM/4KH8zIc8aLMZ70l55Nk2PlSmlrx9/u3GL25Z5EORRnyKUOLQKfObPmhZw
	 rw54uozu9lDajgan0qRSkHYZzpAXoKR7+M4Dp7fahnMc87fpr91QBFuaxx5/g5XiQz
	 Np+FVrD/wtYIQ==
Message-ID: <80afa9ac-ed48-438e-a18d-87aa8dff23c4@kernel.org>
Date: Thu, 11 Jun 2026 13:57:35 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zrehXDAjlbhFhdK5H063TW73"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16840-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D341C66E5C4

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zrehXDAjlbhFhdK5H063TW73
Content-Type: multipart/mixed; boundary="------------lp6v3Rt10tV79iXTePM8CevI";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Message-ID: <80afa9ac-ed48-438e-a18d-87aa8dff23c4@kernel.org>
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>

--------------lp6v3Rt10tV79iXTePM8CevI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> Similarly to the page allocators, introduce slab-allocator specific
> alloc flags that internally control allocation behavior in addition to
> gfp_flags, without occupying the limited gfp flags space.
>=20
> Introduce the first flag SLAB_ALLOC_TRYLOCK that behaves similarly to
> page allocator's ALLOC_TRYLOCK and will be used to reimplement
> kmalloc_nolock()'s "!allow_spin" behavior. That currently relies on
> gfpflags_allow_spinning() and thus the lack of both __GFP_RECLAIM flags=
,
> importantly __GFP_KSWAPD_RECLAIM. This can give false-positive results
> e.g. in early boot with a restricted gfp_allowed_mask.
>=20
> Also introduce alloc_flags_allow_spinning() to replace the usage of
> gfpflags_allow_spinning().
>=20
> Start using alloc_flags and the new check first in alloc_from_pcs() and=

> __pcs_replace_empty_main(). This means some slab allocations that were
> falsely treated as kmalloc_nolock() due to their gfp flags will now hav=
e
> higher chances of succeed, and this will further increase with followup=

> changes.
>=20
> Remove a WARN_ON_ONCE() from refill_objects() as it's now legitimate to=

> reach it from a slab allocation that's not _nolock() and yet lacks
> __GFP_KSWAPD_RECLAIM for other reasons.
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------lp6v3Rt10tV79iXTePM8CevI--

--------------zrehXDAjlbhFhdK5H063TW73
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaipAQAAKCRCGXBN6rc5S
1liHAP93IfCcefH4oC5NqVaMFx2nH2a1RYl/VCXiuzTBFVHwygEAzw865aRaoheL
3Yd7pXejrNcoaV9GzniJGj0nDB+/Xgk=
=IIMK
-----END PGP SIGNATURE-----

--------------zrehXDAjlbhFhdK5H063TW73--

