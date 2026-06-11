Return-Path: <cgroups+bounces-16837-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iaKXNGUpKmq7jQMAu9opvQ
	(envelope-from <cgroups+bounces-16837-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 05:20:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B566DF52
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 05:20:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CaRcdCYL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16837-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16837-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0389630B974A
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F7306742;
	Thu, 11 Jun 2026 03:20:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E80282F14;
	Thu, 11 Jun 2026 03:20:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781148003; cv=none; b=SXDSoJY3d1a9eKoHKuIMxHT1F63t+f3mZG6Dl+7/Rak4qgkKwgdJCF+y9T0XDdcrty56lkeT5XyTw8rCsQHNtH8Wl65ZieNOiuZmvh/WB384JUSf/aEea8VfkBXkAX5SMmod5lFGxRxcAFnoHQ00gXp4Rxt5lY+hIGoFRxPpWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781148003; c=relaxed/simple;
	bh=yZp4mbybfeWBbQyUi5IQswzQrapznOm57mZS5dUdAzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwL5qfdIEirSS1sypa/k/g4yFUT7AZ9R1LeVEqiNLbAA6lgGLCerycKcPJ7SVUyC42GUgiOKL40LWk+jYPhcvWvxhKZCUrG0NAf/NZ6gibgBd4P/ge4G6FWxBnkaKd7cxhQJGSjx2pi2VwVCl5wbznDjGi6ijPCGliEM/ulCdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaRcdCYL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4601F00893;
	Thu, 11 Jun 2026 03:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781148001;
	bh=lV1GNdkgro/OqOIjQyGXZb45UgCwfe6cngFGPzUwNKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CaRcdCYLdFBMG2U0OECS83QNk048Ism+paiOtvsAKH++R3QsX0t6aHJx5kzKDDAY5
	 Jd/cHpiorQfNr2F8d+GBgsA4fw7EFZUEhAaLgEBKXY+HHK56a0LtZ7uxuTv0eO6WCr
	 sUFd9YiN00yIdieybG1oRiOSP9OYYquwMrxpHKYI1XlywKjROHnXtTB2+B6X1DVirQ
	 0phrB9TVcE+LS/Kn7EpIgxgJr3pmMrC5lr14XFwXaT1xdTyr98VMxlGDr2cV3mQKuq
	 6gWZND2hRwBZqLiLdSJx3g46wqJmIW65bUGbxSTKLWMXPV428arsMxnmlvwYXISs4s
	 bbizqDHPU8LMw==
Message-ID: <b6530e92-d648-4028-9e77-0df8c3ab166d@kernel.org>
Date: Thu, 11 Jun 2026 12:19:49 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] mm/slab: do not init any kfence objects on
 allocation
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NNY604SA5UiiZSV2yXEUe0od"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16837-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:andreyknvl@gmail.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gentwo.org,google.com,kernel.org,linux-foundation.org,cmpxchg.org,gmail.com,googlegroups.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 324B566DF52

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NNY604SA5UiiZSV2yXEUe0od
Content-Type: multipart/mixed; boundary="------------1ImZQKiu5FF50fcbIpGt8ndW";
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
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Message-ID: <b6530e92-d648-4028-9e77-0df8c3ab166d@kernel.org>
Subject: Re: [PATCH v2 02/16] mm/slab: do not init any kfence objects on
 allocation
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org>

--------------1ImZQKiu5FF50fcbIpGt8ndW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> When init (zeroing) on allocation is requested, for kmalloc() we
> generally have to zero the full object size even if a smaller size is
> requested, in order to provide krealloc()'s __GFP_ZERO guarantees.

Oh, today I learned...

> When we end up allocating a kfence object, kfence perfoms the zeroing o=
n
> its own because has its own redzone beyond the requested size. Thus
> slab_post_alloc_hook() has an 'init' parameter which has to be evaluate=
d
> in all callers (via slab_want_init_on_alloc()) and should be false for
> kfence allocations.

TIL again :D

> For kfence allocations in slab_alloc_node() this is achieved by subtly
> skipping over the slab_want_init_on_alloc() call.

Indeed subtle and I didn't realize this.

> Other callers (i.e.
> kmem_cache_alloc_bulk_noprof()) however evaluate it unconditionally eve=
n
> if they do end up with a kfence allocation. This is only subtly not a
> problem, as those are not kmalloc allocations and thus the "requested
> size" equals s->object_size and thus it cannot interfere with kfence's
> redzone.

Right.

> There's just a unnecessary double zeroing (in both kfence and
> slab_post_alloc_hook()), but it's all very fragile and contradicts the
> comment in kfence_guarded_alloc().

Right.

> Remove this subtlety and simplify the code by eliminating the init
> parameter from slab_post_alloc_hook() and make it call
> slab_want_init_on_alloc() itself. Instead add a is_kfence_address()
> check before performing the memset, which will start doing the right
> thing for all callers of slab_post_alloc_hook().

Great, more straightforward!

> This potentially adds overhead of the is_kfence_address() check to
> allocation hotpath, but that one is designed to be as small as possible=
,
> and it's only evaluated if zeroing is about to happen. This means (asid=
e
> from init_on_alloc hardening) only for __GFP_ZERO allocations, and the
> zeroing itself comes with an overhead likely larger than the added
> check.
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/kfence/core.c |  2 +-
>  mm/slub.c        | 23 ++++++++---------------
>  2 files changed, 9 insertions(+), 16 deletions(-)
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index e2ee8f1aaccf..8e5264d3ddbf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4565,9 +4565,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct km=
em_cache *s, gfp_t flags)
> =20
>  static __fastpath_inline
>  bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
> -			  gfp_t flags, size_t size, void **p, bool init,
> +			  gfp_t flags, size_t size, void **p,
>  			  unsigned int orig_size)
>  {
> +	bool init =3D slab_want_init_on_alloc(flags, s);
>  	unsigned int zero_size =3D s->object_size;
>  	bool kasan_init =3D init;
>  	size_t i;
> @@ -4608,7 +4609,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
>  	for (i =3D 0; i < size; i++) {
>  		p[i] =3D kasan_slab_alloc(s, p[i], init_flags, kasan_init);
>  		if (p[i] && init && (!kasan_init ||
> -				     !kasan_has_integrated_init()))
> +				     !kasan_has_integrated_init())
> +				 && !is_kfence_address(p[i]))

I hope we could make it bit more verbose and straightforward,
something like:

diff --git a/mm/slub.c b/mm/slub.c
index 5d7ea72ebebd..29cf4590f9d9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4573,7 +4573,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s,
gfp_t flags, size_t size,
 {
 	bool init =3D slab_want_init_on_alloc(flags, s);
 	unsigned int zero_size =3D s->object_size;
-	bool kasan_init =3D init;
 	size_t i;
 	gfp_t init_flags =3D flags & gfp_allowed_mask;

@@ -4591,29 +4590,37 @@ bool slab_post_alloc_hook(struct kmem_cache *s,
gfp_t flags, size_t size,
 	if (slub_debug_orig_size(s))
 		zero_size =3D ac->orig_size;

-	/*
-	 * When slab_debug is enabled, avoid memory initialization integrated
-	 * into KASAN and instead zero out the memory via the memset below with=

-	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
-	 * cause false-positive reports. This does not lead to a performance
-	 * penalty on production builds, as slab_debug is not intended to be
-	 * enabled there.
-	 */
-	if (__slub_debug_enabled())
-		kasan_init =3D false;
-
-	/*
-	 * As memory initialization might be integrated into KASAN,
-	 * kasan_slab_alloc and initialization memset must be
-	 * kept together to avoid discrepancies in behavior.
-	 *
-	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.=

-	 */
 	for (i =3D 0; i < size; i++) {
-		p[i] =3D kasan_slab_alloc(s, p[i], init_flags, kasan_init);
-		if (p[i] && init && (!kasan_init ||
-				     !kasan_has_integrated_init())
-				 && !is_kfence_address(p[i]))
+		bool skip_init =3D false;
+
+		if (is_kfence_address(p[i])) {
+			/*
+			 * kfence zeroes the object instead of SLUB to avoid
+			 * overwriting its own redzone, and zeroing of
+			 * s->object_size will corrupt it.
+			 */
+			skip_init =3D true;
+		} else if (__slub_debug_enabled()) {
+			/*
+			 * KASAN never zeroes memory when slab_debug is enabled
+			 * to avoid overwriting SLUB redzones. This does not
+			 * lead to a performance penalty on production builds,
+			 * as slab_debug is not intended to be enabled there.
+			 */
+			skip_init =3D false;
+		} else if (kasan_has_integrated_init()) {
+			/*
+			 * ARM64 can set memory tags and zero the memory using
+			 * a single instruction. Since HW_TAGS KASAN uses that
+			 * while tagging the object, a separate zeroing is
+			 * unnecessary unless slab_debug is enabled.
+			 */
+			skip_init =3D true;
+		}
+
+		p[i] =3D kasan_slab_alloc(s, p[i], init_flags, init && skip_init);
+		/* memset and hooks come after KASAN as p[i] might get tagged */
+		if (p[i] && init && !skip_init)
 			memset(p[i], 0, zero_size);
 		if (alloc_flags_allow_spinning(ac->alloc_flags))
 			kmemleak_alloc_recursive(p[i], s->object_size, 1,


--------------1ImZQKiu5FF50fcbIpGt8ndW--

--------------NNY604SA5UiiZSV2yXEUe0od
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaiopVQAKCRCGXBN6rc5S
1qf1AQCkwBnwoQgxZAsuAP72uiKVtEWTPAPJ6W+HF7tj4lLdOQEA41/pwOc+hFy8
V01e9zirV/n17A0+eoEKzP2MsoFCyww=
=W0ll
-----END PGP SIGNATURE-----

--------------NNY604SA5UiiZSV2yXEUe0od--

