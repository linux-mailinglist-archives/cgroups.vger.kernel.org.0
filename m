Return-Path: <cgroups+bounces-16841-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f0o3ID9HKmqBlgMAu9opvQ
	(envelope-from <cgroups+bounces-16841-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:27:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1466E8D6
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:27:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xh15kYyR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16841-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16841-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A563382151
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 05:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8D373C10;
	Thu, 11 Jun 2026 05:07:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73420367B63;
	Thu, 11 Jun 2026 05:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781154430; cv=none; b=Uf3TioCmqPpUilMTSHs7roxJAOhNzeuud8IelDvVr9Oh5zHm/BdhVdiCfsiazjnm7pck0IkJWSKWqK1Gz2enaYUVd4S+QJMWUXjKicEDt1mIJMLsm3XaSFNXaeXQNglHcDApmArQNZGiK7Di1RvKQLtPvtO8d8eX5Ja9+BHzfnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781154430; c=relaxed/simple;
	bh=vRwcg4EyJZpJwbVd0kBy+DE0ocP3539N0zcggV7Obec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHi6sCXS8MGVi0Aaxv5xXhsdTfFL1CjwWkQK1I9sDxZWIU/OvCnXxeE1jpnNCXYno7Th5xBH+9uJPrhuGy6fZuKxQR0uZtuHTVg2dhh8MNKIJ21yjgdiqEmqGgu3TMG9dQDo556RzsZPvWResHVyprM6rt73uRW4m4jmEYx49G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh15kYyR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD43B1F00893;
	Thu, 11 Jun 2026 05:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781154423;
	bh=vRwcg4EyJZpJwbVd0kBy+DE0ocP3539N0zcggV7Obec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xh15kYyRcoKUbtk//iaHVwclsSBPXWUStJlO5F51fOJvxKt88liTK0Xtqi8ZrzIvP
	 KDVnc3COPg8snsonRgh+a+hQJeDiN/hcwlSGoRQxxWEnUzM7tIAq4HFJ9QCt8/a9/Q
	 TLJh59BzVpmV/JokQNTNLpRtQJdcSHC5N5Pg9PgjqYoVOhA3AB/aG2AxwSrS/lfZ4G
	 Lqp35I7nAd4QuPpjzOYPpCPeAvsf/Q9vEr1S3ltuOBhRZ7h0yjvyI3VAZ+8/aBwSS3
	 AZCF9O/AFTyzSeC/+FUTKVmr5SE6Tv2tqItOQLCqu1DK2QED+wAmrD+lEebmFfSsyF
	 F9vRyHberjwyA==
Message-ID: <6a2d63df-bc0e-4adc-98a0-2873b4249e77@kernel.org>
Date: Thu, 11 Jun 2026 14:06:58 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] mm/slab: add alloc_flags to slab_alloc_context
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
 <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HNfaZktokc0PY3nz0b0yHnGR"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16841-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B1466E8D6

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HNfaZktokc0PY3nz0b0yHnGR
Content-Type: multipart/mixed; boundary="------------JeXH4IXAE038L45RFEnMfyKB";
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
Message-ID: <6a2d63df-bc0e-4adc-98a0-2873b4249e77@kernel.org>
Subject: Re: [PATCH v2 06/16] mm/slab: add alloc_flags to slab_alloc_context
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-6-7190909db118@kernel.org>

--------------JeXH4IXAE038L45RFEnMfyKB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> Add alloc_flags as a new field to the slab_alloc_context helper struct,=

> so we can pass it to more functions in the slab implementation without
> adding another function parameter.
>=20
> Start checking them via alloc_flags_allow_spinning() in
> alloc_single_from_new_slab() (where we can drop the allow_spin
> parameter) and ___slab_alloc(). This further reduces false-positive
> spinning-not-allowed from allocations that are not kmalloc_nolock() but=

> lack __GFP_RECLAIM flags.
>=20
> _kmalloc_nolock_noprof() initializes ac.alloc_flags using its flags tha=
t
> are SLAB_ALLOC_TRYLOCK. slab_alloc_node() and __kmem_cache_alloc_bulk()=

> are not reachable from kmalloc_nolock() and all their callers expect
> spinning to be allowed, so they can use SLAB_ALLOC_DEFAULT. This is
> temporary as the scope of slab_alloc_context will further move to the
> callers, making the alloc_flags usage more obvious.
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------JeXH4IXAE038L45RFEnMfyKB--

--------------HNfaZktokc0PY3nz0b0yHnGR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaipCcgAKCRCGXBN6rc5S
1rwHAP4lRaCG706Uz/V2rojPwBLVAPzHiybwiXmWuTC64r/8QQEAiBwpKNWBH0vV
Vhq36kkGoH1BnWFD8fJdic59Ar/RDAw=
=dyft
-----END PGP SIGNATURE-----

--------------HNfaZktokc0PY3nz0b0yHnGR--

