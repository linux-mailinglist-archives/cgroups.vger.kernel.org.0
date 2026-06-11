Return-Path: <cgroups+bounces-16845-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5gURJH9YKmo9nwMAu9opvQ
	(envelope-from <cgroups+bounces-16845-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 08:41:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB9666F198
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 08:41:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ny6YH0ag;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16845-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16845-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 123B03008474
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732624DFF9;
	Thu, 11 Jun 2026 06:40:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AC34B19A;
	Thu, 11 Jun 2026 06:40:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160054; cv=none; b=iE1kkL0Ay9J4Pbx7PnRTSN2oxnGOPRNlkYCYadOO/LL+TyNkzRqo118ipt3i2XRCkODWHmqpuvLvHlSx8f6bKwhoK8rtwY9KdW2w0dSnSzL0f0AoqoJ5Baa+hn24G0exg68YlfGQnRm6eV5XCoyCiuUXS25qDICW4L0m59Mckxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160054; c=relaxed/simple;
	bh=dxIPW7D2faP2bepXt2e5ZCrEJE6XJTpZdIFCgtoHcBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3RMCwJajcOkOuIztr4ZkcriNMezEQH8/VCgs5jt8SrdRlEfHTeSJwZLWKswK4AiENrHwHromOVHvfnsGiBiJUrSW+HcNdL7U4k/DM7kJaF6dFx3r5VfSb+H0f73irKtq4g+qmBZtsx+CCVbQAliJd/GnwKYqk9xGCDp8IYqRXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny6YH0ag; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD181F00893;
	Thu, 11 Jun 2026 06:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781160053;
	bh=yi9ckVtDtphA7eMJncvdNkgvdgfwVN/oHKstajaBnTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ny6YH0agPhJrgPlTnLMxDnStHWnM4CN6azBueRu5KlTzXqgWrnXqCaxFDweGkL/aO
	 Ivlbxesvv27d8fnL5f/gdFXAjaF3tMorYBLWKMojHQVEKzeVIv1LFgYTtJaA03N3UU
	 T8O1eb2OUfiN0X/fDnGd1cdT6sjp1v3H95MDXqCAvXm68z4XVRmepW28tbE6k5jr8j
	 p2n3azySbjTwdJ8a0EPBOzxdMNnnIcB3I8Q36ec8Mog6EDsxi3Xd8zjKS6YwMv9nRA
	 u08TDIFox4+LWNfl0R0vgIb7vu11g9aqOWvqTvQ5bv/DRiSpNZSUO/KVOMJpcEPj1C
	 9DTc4fov9V1dw==
Message-ID: <7064a90e-4bf5-4be7-8b7f-a5a11dcee66f@kernel.org>
Date: Thu, 11 Jun 2026 15:40:47 +0900
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
 boundary="------------cLKhUE1LS3RNZ8H0WJkZPja5"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-16845-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EB9666F198

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cLKhUE1LS3RNZ8H0WJkZPja5
Content-Type: multipart/mixed; boundary="------------cnCTg083TbHZKFbOy4OWEa5Q";
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
Message-ID: <7064a90e-4bf5-4be7-8b7f-a5a11dcee66f@kernel.org>
Subject: Re: [PATCH v2 05/16] mm/slab: introduce alloc_flags and
 SLAB_ALLOC_TRYLOCK
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-5-7190909db118@kernel.org>

--------------cnCTg083TbHZKFbOy4OWEa5Q
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
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slab.h |  9 +++++++++
>  mm/slub.c | 17 ++++++++---------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/mm/slab.h b/mm/slab.h
> index 1bf9c3021ae3..96f65b625600 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -4664,7 +4665,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, st=
ruct slub_percpu_sheaves *pcs,
>  		return NULL;
>  	}
> =20
> -	allow_spin =3D gfpflags_allow_spinning(gfp);
> +	allow_spin =3D alloc_flags_allow_spinning(alloc_flags);

Sashiko wrote [1]:
> Does this bypass the caller's gfp constraints for standard allocations?=

> Looking at slab_alloc_node(), standard allocations now pass
> SLAB_ALLOC_DEFAULT into alloc_from_pcs():
> -	object =3D alloc_from_pcs(s, gfpflags, node);
> +	object =3D alloc_from_pcs(s, gfpflags, SLAB_ALLOC_DEFAULT, node);
> This default flag means alloc_flags_allow_spinning() will unconditional=
ly
> return true regardless of the gfp flags provided.

Yes, but that's not used in _nolock path
as mentioned in patch 6 description :)

> If a caller allocating under a raw spinlock intentionally strips
> __GFP_KSWAPD_RECLAIM (for example, by using __GFP_NOWARN) to prevent
> sleeping,

That's a horrible hack (and hypothetical. Nobody should be stripping
__GFP_KSWAP_RECLAIM instead of using kmalloc_nolock(). That's purely
broken).

> won't this allow the allocator to execute spin_lock_irqsave()
> on barn->lock or n->list_lock?
>
> On systems with preempt-rt enabled, a standard spinlock maps to a sleep=
ing
> lock, so taking these locks in an atomic context could cause a scheduli=
ng
> while atomic panic.
>
> Since there is no nolock variant available for custom caches, do caller=
s
> currently have any alternative mitigation?

Well, RT kernels are not supposed to allocate meomry under a raw
spinlock (at least w/ allow_spin =3D true)

[1]
https://sashiko.dev/#/patchset/20260610-slab_alloc_flags-v2-0-7190909db11=
8%40kernel.org

--=20
Cheers,
Harry / Hyeonggon

--------------cnCTg083TbHZKFbOy4OWEa5Q--

--------------cLKhUE1LS3RNZ8H0WJkZPja5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaipYcAAKCRCGXBN6rc5S
1vlSAP4uA7Ju8txQ+1RRIq0JRTyegK+jlhzzSR1685TnFW2XJwEAqBjZc2iaQWqe
2tkPuBbObSXUfMAJjlbXtRikXRNiPA8=
=tLgu
-----END PGP SIGNATURE-----

--------------cLKhUE1LS3RNZ8H0WJkZPja5--

