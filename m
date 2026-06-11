Return-Path: <cgroups+bounces-16846-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tT4bAypqKmr8owMAu9opvQ
	(envelope-from <cgroups+bounces-16846-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 09:56:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE666F9D7
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 09:56:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cuHWA9uR;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16846-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16846-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D1C93180D0D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF12D7DCE;
	Thu, 11 Jun 2026 07:52:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E682369985;
	Thu, 11 Jun 2026 07:52:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164364; cv=none; b=VgVmAN5j7UkjocP/2iRL8N+cmFBdN/KQ1lUwWBiNcmzkQlb3MR3gONqI39iUxnF80FOAcTJEwQEovFl7tf8etGwab/4RbWToE4jVAnnCAiIUjCRYGlVQ5Dihf8cCDeLUmEPyB+T0MY6vrFhVcRp920zLrOPM41co9j75rcAhn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164364; c=relaxed/simple;
	bh=mPcwQG1rbs4ruOPR40Na309HgvsibwaGkH/cLy7B1pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2mqE4aoWeRAyFxziW6vzwXQr9HN3BNrOPRi+fhgxYOXq5JxbKh9bn/5m3jm2Az6imUT2LXbZV4krzxxF+eTyKV29X/UXi5UzvtAoaVlz3b0D5Bw/DBq2aisv9Ip5p7jKhymeJjniGIe8rPdGnMMb8R9cZIS9cW8Rh2xZiivFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuHWA9uR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D21F00893;
	Thu, 11 Jun 2026 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781164363;
	bh=xijNDdKPHv1jokABJ/KJ4UCI30y34c5TQzlLjkdoZMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cuHWA9uRu0xicoIbUbVAW5BaFPsqNLc/45roEzdVUouxzUOPf5BBWNRR+7WBZmwNX
	 WN5xVEkq3jOWwSHFNktNsKOCsvvgQJKzhB+Azy/snZxkFydWBlqOhofwJI+84TQ1ui
	 BPK6xXyy42L1bIagjFwuQH2g+t5W8FcFXnGaW/D7CvgtmyRHXix8PY+bBVTkbSMcYm
	 i1NQpit5I8a4LCLppcGOd76APYY1/dgsFjD+ySBztXkLDZuX9qGDo/pV6q3yfHpfwF
	 +Mq5PqIZJpXV5+bTLyUdBEP8k2/uF+bacz1+6xU1BDwV1MGvr0JnPxiS7MdSWcJ8zd
	 ozRnuwapIYjEw==
Message-ID: <49ca905a-0303-4fad-8257-485b0ed47c8d@kernel.org>
Date: Thu, 11 Jun 2026 16:52:38 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] mm/slab: pass alloc_flags to new slab allocation
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
 <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------YrjDV9X0pifSc8pX0GjzraWe"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16846-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CBE666F9D7

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------YrjDV9X0pifSc8pX0GjzraWe
Content-Type: multipart/mixed; boundary="------------6OoaCLw56CPWa63NRnaF50aC";
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
Message-ID: <49ca905a-0303-4fad-8257-485b0ed47c8d@kernel.org>
Subject: Re: [PATCH v2 08/16] mm/slab: pass alloc_flags to new slab allocation
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-8-7190909db118@kernel.org>

--------------6OoaCLw56CPWa63NRnaF50aC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> Add the alloc_flags parameter to allocate_slab() and new_slab()
> so it can be used to determine if spinning is allowed, independently
> from gfp flags.
>=20
> refill_objects() passes SLAB_ALLOC_DEFAULT because it can only be
> reached from contexts that allow spinning.
>=20
> Also change how trynode_flags are constructed in ___slab_alloc() to
> achieve the same "do not upgrade to GFP_NOWAIT" by using masking instea=
d
> of a branch. It will now also not upgrade in cases where gfp is weaker
> than GFP_NOWAIT (i.e. lacks __GFP_KSWAPD_RECLAIM) but doesn't come from=

> kmalloc_nolock() - which is more correct anyway.

Wait, debugobjects intentionally avoids __GFP_KSWAPD_RECLAIM,
but we have been upgrading it to GFP_NOWAIT?

> During the masking keep also existing __GFP_NOMEMALLOC (pointed out by
> Sashiko) and __GFP_ACCOUNT. Previously the hardcoded GFP_NOWAIT would
> eliminate them, but it's not a big problem that would need a separate
> fix.

Ack.

> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  mm/slub.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/mm/slub.c b/mm/slub.c
> index 98b79e5e7679..8f6ca3d5fdfa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4467,25 +4470,22 @@ static void *___slab_alloc(struct kmem_cache *s=
, gfp_t gfpflags, int node,
>  	 * 1) try to get a partial slab from target node only by having
>  	 *    __GFP_THISNODE in pc.flags for get_from_partial()
>  	 * 2) if 1) failed, try to allocate a new slab from target node with
> -	 *    GPF_NOWAIT | __GFP_THISNODE opportunistically
> +	 *    (at most) GFP_NOWAIT | __GFP_THISNODE opportunistically
>  	 * 3) if 2) failed, retry with original gfpflags which will allow
>  	 *    get_from_partial() try partial lists of other nodes before
>  	 *    potentially allocating new page from other nodes
>  	 */
>  	if (unlikely(node !=3D NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
>  		     && try_thisnode)) {
> -		if (unlikely(!allow_spin))
> -			/* Do not upgrade gfp to NOWAIT from more restrictive mode */
> -			trynode_flags =3D gfpflags | __GFP_THISNODE;
> -		else
> -			trynode_flags =3D GFP_NOWAIT | __GFP_THISNODE;
> +		trynode_flags &=3D GFP_NOWAIT | __GFP_NOMEMALLOC | __GFP_ACCOUNT;
> +		trynode_flags |=3D __GFP_NOWARN | __GFP_THISNODE;
>  	}

--=20
Cheers,
Harry / Hyeonggon

--------------6OoaCLw56CPWa63NRnaF50aC--

--------------YrjDV9X0pifSc8pX0GjzraWe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaippRgAKCRCGXBN6rc5S
1mN5AP4tMVF5FXhfn3M1bOH0zcppauyBP0EZheCoVRoD/P0knwD/S22l7s4G+UN+
i+T+KAlgVhbzLZ9juSKgV6kPwZV7/wY=
=x6rW
-----END PGP SIGNATURE-----

--------------YrjDV9X0pifSc8pX0GjzraWe--

