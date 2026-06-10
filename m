Return-Path: <cgroups+bounces-16805-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsU4Mt1rKWpoWgMAu9opvQ
	(envelope-from <cgroups+bounces-16805-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:51:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97B669F4C
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:51:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AT2sqzeU;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16805-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16805-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A571C31F4B0C
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB93ED5A3;
	Wed, 10 Jun 2026 13:46:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C23BAD89;
	Wed, 10 Jun 2026 13:46:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099201; cv=none; b=L2nJF56MrvfKpDjTmelzmlvyr+MwLIq9D9SfbxnUv7O5S0lzy4teri2dDqvOZpHbHLUkBixth8XmTJBkw+mF91yIsBcB7GioL/9CQm8uPb//7+If1ffO9wHsaKOLR3zNpTXneX+ZsjWTZqsDtgIawBB+2DVe8VI5f3WG/3/1ZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099201; c=relaxed/simple;
	bh=5ibgF6R/kp+woBcHNq0rNqQf2+91RAduG4ErzKWMv3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ig8lort+1baDXkXYaDHrfQ7gGADGkD7iUUvkKKApQSA2wfNJL6JL9ddzeyRmNVnS76V9uf3E4YV7qUXlWlbbPhQ+k4UxaDRsG8Ozkn1TerYF0Tjo7bC6gaFVjqpEaTZYksUzcP+LR3Bsov6zta2eBxXpew1y8SKMtk0IPsw6exo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT2sqzeU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BC01F00893;
	Wed, 10 Jun 2026 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781099199;
	bh=Dx7hXdKX9Rs91i5RbhQqTgzv69QIz47hIR3AMiwNNYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AT2sqzeUgrZugH1av7dSs7GGim6/jj1LiPhEhXaf2gbGcy+RAkn0wipLKagXx/Y8x
	 zd/G3vT0sch7uSZNcp5H19u7VrxHEGijOpl19p0kY38YjzG1mbaw6JuujBmWS8Wxkz
	 500EyCB/X4kdFOM6aQQkegwD8pL4LobgyW8/gHCIBMIWRzrnoNLI7n3JIjVdzsqLhy
	 qRSdT/dCWsTUkHiBpfUCDH0SjH2RC72N8fD3VhBceMCQGsnzmmldyfooAhOjA0rVuI
	 hNrPlO/rpwexNJ+BROCvROptHgC9XcgCKAvo2pXVtrqUFEHqIddlp3HxqRI4N9mXre
	 Owi9K3ADa8RZg==
Message-ID: <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
Date: Wed, 10 Jun 2026 22:46:33 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
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
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lpBhgsI7Eg8uAMph6eYAI8CI"
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
	TAGGED_FROM(0.00)[bounces-16805-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 2B97B669F4C

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lpBhgsI7Eg8uAMph6eYAI8CI
Content-Type: multipart/mixed; boundary="------------imhDaDuV79w9s0j1YWemz0d0";
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
Message-ID: <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>

--------------imhDaDuV79w9s0j1YWemz0d0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/9/26 6:17 PM, Vlastimil Babka (SUSE) wrote:
> This series is based on slab/for-next. If all goes well, it would
> hopefully go to slab/for-next soon after the 7.2 merge window, so any
> other work can be based on it to avoid conflicts, as it touches a lot
> parts of slab.
>=20
> Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/l=
og/?h=3Db4/slab_alloc_flags
>=20
> The slab implementation currently relies on gfp flags to convey
> some context information internally:
>=20
> - The absence of both __GFP_RECLAIM flags is interpreted as "cannot spi=
n
>   on locks", and intended to be used by kmalloc_nolock(). But false
>   positives are possible e.g. during early boot where gfp_allowed_mask
>   clears __GFP_RECLAIM from all allocations. This leads to unnecessary
>   allocation failures and workarounds such as fd3634312a04 ("debugobjec=
t:
>   Make it work with deferred page initialization - again").
>=20
> - __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
>   space, only to prevent recursive kmalloc() allocations for obj_ext
>   arrays and sheaves.

[ Cc'ing Vishal and Matthew as it's somewhat relevant to memdescs... ]

When the page allocator starts allocateing slab objects,
we still need a way to avoid recursion for obj_ext arrays and sheaves
(by passing SLAB_ALLOC_NO_RECURSE).

Looking at kmalloc_flags(), probably we'll end up introducing a separate
gfp type for slab-specific flags?

Hmm but SLAB_ALLOC_* flags are defined in mm/slab.h and kmalloc_flags()
is defined in include/linux/slab.h. Do yo intend to restrict the slab
alloc flags to MM only?

> The page allocator uses its internal alloc_flags to convey various
> context information, including ALLOC_TRYLOCK (meaning "cannot spin").
> This series copies that concept for the slab allocator, with its own
> slab-specific internal flags:
>=20
> - SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
> - SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock())
> - SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
> 			for allocating obj_ext arrays
> - SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT
>=20
> To reduce the amount of parameters in various internal functions, we
> additionally introduce slab_alloc_context (also inspired by page
> allocator's alloc_context) for passing a number of existing arguments
> and the new alloc_flags:
>=20
> /* Structure holding extra parameters for slab allocations */
> struct slab_alloc_context {
> 	unsigned long caller_addr;
> 	unsigned long orig_size;
> 	unsigned int alloc_flags;
> 	struct list_lru *lru;
> };

Perhaps beyond the scope of the patchset, but I wonder if we could have
something like struct slab_alloc_context but for kmalloc callers to
simplify {PASS,DECL}_KMALLOC_PARAMS().

Something like:

struct kmalloc_params {
#ifdef CONFIG_SLAB_BUCKETS
	kmem_buckets *b;
#endif
#ifdef CONFIG_KMALLOC_PARTITION_CACHES
	kmalloc_token_t token;
#endif
};

The idea is to move optional kmalloc parameters (depending on config)
into a single struct, instead of using the macros.

void *__kmalloc_node(size_t size, gfp_t flags, int node,
		     unsigned long caller,
		     struct kmalloc_params params);

void *kmalloc_node() {
    /* ... snip ...*/
    struct kmalloc_params params =3D KMALLOC_PARAMS(params.b, params.toke=
n);
    return __kmalloc_node(size, flags, node, _RET_IP_, params);
}

The compiler should optimize away unused fields based on the config.

Per System V AMD64 ABI, the compiler will use registers to pass the
struct, as long as the struct size does not exceed 16 bytes.
(Otherwise it will be passed on stack).

> This also replaces the existing struct partial_context.
>=20
> The last necessary piece is kmalloc_flags() which can take the
> alloc_flags in addition to gfp flags and is intended for the recursive
> allocations of sheaves and obj_ext arrays, so that both
> SLAB_ALLOC_TRYLOCK and SLAB_ALLOC_NO_RECURSE can be communicated.
> Internally it decides between kmalloc_nolock() and normal kmalloc()
> depending SLAB_ALLOC_TRYLOCK.
>=20
> The rest of the series is gradually expanding the usage of both
> alloc_flags and slab_alloc_context as necessary, with bits of
> refactoring. Then, __GFP_NO_OBJ_EXT is removed completely.
>=20
> Note that some usage of gfpflags_allow_spinning() relying on absence of=

> __GFP_RECLAIM remains outside of slab (and page allocator) in memcg,
> page_owner and stackdepot code. These can thus yield false-positive
> decisions that spinning is not allowed, but should not result in
> important allocations failing anymore.
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Vlastimil Babka (SUSE) (15):
>       mm/slab: always zero only requested size on alloc
>       mm/slab: stop inlining __slab_alloc_node()
>       mm/slab: introduce slab_alloc_context
>       mm/slab: introduce alloc_flags and SLAB_ALLOC_TRYLOCK
>       mm/slab: add alloc_flags to slab_alloc_context
>       mm/slab: replace struct partial_context with slab_alloc_context
>       mm/slab: pass alloc_flags to new slab allocation
>       mm/slab: pass alloc_flags through slab_post_alloc_hook() chain
>       mm/slab: replace slab_alloc_node() parameters with slab_alloc_con=
text
>       mm/slab: allow kmem_cache_alloc_bulk() with any gfp flags
>       mm/slab: pass slab_alloc_context to __do_kmalloc_node()
>       mm/slab: introduce kmalloc_flags()
>       mm/slab: remove __GFP_NO_OBJ_EXT usage from alloc_slab_obj_exts()=

>       mm/slab: replace __GFP_NO_OBJ_EXT with SLAB_ALLOC_NO_RECURSE for =
sheaves
>       mm: remove the __GFP_NO_OBJ_EXT flag
>=20
>  include/linux/gfp_types.h       |   7 -
>  include/linux/slab.h            |  14 +-
>  include/trace/events/mmflags.h  |  10 +-
>  lib/alloc_tag.c                 |   2 +-
>  mm/kfence/core.c                |   6 +-
>  mm/memcontrol.c                 |   5 +-
>  mm/slab.h                       |  16 +-
>  mm/slub.c                       | 423 ++++++++++++++++++++++++--------=
--------
>  tools/include/linux/gfp_types.h |   7 -
>  9 files changed, 288 insertions(+), 202 deletions(-)
> ---
> base-commit: 500b2c9755301742bdbb61249511ac11a4665dae
> change-id: 20260601-slab_alloc_flags-25c782b0c57c
>=20
> Best regards,
> -- =20
> Vlastimil Babka (SUSE) <vbabka@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------imhDaDuV79w9s0j1YWemz0d0--

--------------lpBhgsI7Eg8uAMph6eYAI8CI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCailquQAKCRCGXBN6rc5S
1ovPAP9O4mfAo+3btjvBHirmJAKKcqibQgDAmFz8xIhGk8mJLgD9HdM/6HoUvsSE
ZVA9uxJ1/1v9GB9cp0SmNatJJZKFWwA=
=DeYn
-----END PGP SIGNATURE-----

--------------lpBhgsI7Eg8uAMph6eYAI8CI--

