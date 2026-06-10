Return-Path: <cgroups+bounces-16809-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 20/sKbl+KWqVXwMAu9opvQ
	(envelope-from <cgroups+bounces-16809-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:11:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EA966A94D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:11:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BvId1BCG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16809-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16809-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8572831C6644
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64FD4219FC;
	Wed, 10 Jun 2026 15:04:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6332E143;
	Wed, 10 Jun 2026 15:04:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781103871; cv=none; b=TmsWEQ0nWFvNr+pEevyqIVoLGD25prugQgKztljhzCBnwOJ3gshNQlGUsSgK8/ft16B4FlhvBCdqg8gLytUDoCHejqlLm31jk4w/pWcwASoXN26MsSWsKnBckAXInYjIo/6eqkmh0oC12xZ27C6EQyJHYHcMpd7xBk36yOjV0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781103871; c=relaxed/simple;
	bh=jNe3TvOjAQxv1+MeK2kF84ILjX5Wl+v8fr1tJkPYDp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH1xUFGqXIB4r8oYtb8y62sBhJaJXjroA9udNL5ZHk7BJlN6UNMrdZeOKpVcHAJl6E+m/Om3VLKtzrNCoZBXOlvWoOyPEEvpKeFTfSzTNVvlpt2VxeDtZOEzJ5JyEbkYWyYwHrqbWPnuCN+/cv8wPUCxbjCeEy62FvlF3++lXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvId1BCG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730151F00893;
	Wed, 10 Jun 2026 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781103870;
	bh=bqQ2MsiuNikXhJ97L9YlCS1PYnOleFH1f5mUL5vq1EA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BvId1BCGPSToIBbE1L5b8Dn2qSkmq5lOlBrZk4c2rj4KIDlmMfMsVpugk8LRgk3ue
	 SMYk9DRM2wxdMbN8yNc616ye6N7tbzCijrvfl99chFsGQfOgt+wTKZ2mv/B1jjXLay
	 IF9zMSxV+ro0mPcL89jVsT9WHltYvwKVcfUiOMNllu6W3/jG0XZAj1Y/28Jy0NagIJ
	 h8+7OwcAaq86orIL7myxUPCOfXZWf0G4cwAU6AC3KcOD8/Bw7ksZHPIXqoAM044OZV
	 V0qU8rEzdFgA8NCPO9gv8S2Ih/EAfEchoesd7oWKQfD510H+dDupPCw0IWTw3G2tAt
	 /ymjvyHYSoDyg==
Message-ID: <e42ed4e2-c0ba-4b36-b1a5-090a5afa762d@kernel.org>
Date: Thu, 11 Jun 2026 00:04:24 +0900
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
 <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
 <0b9dce0f-f2a8-4b52-9c06-600eb13d4a7c@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <0b9dce0f-f2a8-4b52-9c06-600eb13d4a7c@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EdfxVfiruOiCQ0OSxtJqjQYZ"
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
	TAGGED_FROM(0.00)[bounces-16809-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 08EA966A94D

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EdfxVfiruOiCQ0OSxtJqjQYZ
Content-Type: multipart/mixed; boundary="------------AxdjQdvvIQrAARW40azyu6pE";
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
Message-ID: <e42ed4e2-c0ba-4b36-b1a5-090a5afa762d@kernel.org>
Subject: Re: [PATCH RFC 00/15] mm/slab: introduce alloc_flags and
 slab_alloc_context
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
 <e650e125-5f6c-4de7-88b5-9da666bb0a4e@kernel.org>
 <0b9dce0f-f2a8-4b52-9c06-600eb13d4a7c@kernel.org>
In-Reply-To: <0b9dce0f-f2a8-4b52-9c06-600eb13d4a7c@kernel.org>

--------------AxdjQdvvIQrAARW40azyu6pE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/10/26 11:04 PM, Vlastimil Babka (SUSE) wrote:
> On 6/10/26 15:46, Harry Yoo wrote:
>>
>>
>> On 6/9/26 6:17 PM, Vlastimil Babka (SUSE) wrote:
>>> This series is based on slab/for-next. If all goes well, it would
>>> hopefully go to slab/for-next soon after the 7.2 merge window, so any=

>>> other work can be based on it to avoid conflicts, as it touches a lot=

>>> parts of slab.
>>>
>>> Git: https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git=
/log/?h=3Db4/slab_alloc_flags
>>>
>>> The slab implementation currently relies on gfp flags to convey
>>> some context information internally:
>>>
>>> - The absence of both __GFP_RECLAIM flags is interpreted as "cannot s=
pin
>>>   on locks", and intended to be used by kmalloc_nolock(). But false
>>>   positives are possible e.g. during early boot where gfp_allowed_mas=
k
>>>   clears __GFP_RECLAIM from all allocations. This leads to unnecessar=
y
>>>   allocation failures and workarounds such as fd3634312a04 ("debugobj=
ect:
>>>   Make it work with deferred page initialization - again").
>>>
>>> - __GFP_NO_OBJ_EXT exists and takes up valuable bit in the gfp flags
>>>   space, only to prevent recursive kmalloc() allocations for obj_ext
>>>   arrays and sheaves.
>>
>> [ Cc'ing Vishal and Matthew as it's somewhat relevant to memdescs... ]=

>>
>> When the page allocator starts allocateing slab objects,
>> we still need a way to avoid recursion for obj_ext arrays and sheaves
>> (by passing SLAB_ALLOC_NO_RECURSE).
>>
>> Looking at kmalloc_flags(), probably we'll end up introducing a separa=
te
>> gfp type for slab-specific flags?
>=20
> What do you mean by separate gfp type?

I meant the patchset is introducing a new type to specify the context
(specific to slab) other than gfp_t... which is `unsigned int
alloc_flags` now.

>> Hmm but SLAB_ALLOC_* flags are defined in mm/slab.h and kmalloc_flags(=
)
>> is defined in include/linux/slab.h. Do yo intend to restrict the slab
>> alloc flags to MM only?
>=20
> Yeah I don't expect users outside MM. If a valid one appears, we can mo=
ve
> it. I should try moving kmalloc_flags() to mm/slab.h as well, unless th=
ere's
> some header dependency issue that will prevent it.

Ack.

>>> The page allocator uses its internal alloc_flags to convey various
>>> context information, including ALLOC_TRYLOCK (meaning "cannot spin").=

>>> This series copies that concept for the slab allocator, with its own
>>> slab-specific internal flags:
>>>
>>> - SLAB_ALLOC_DEFAULT - no extra flags (the value is 0), but explicit
>>> - SLAB_ALLOC_TRYLOCK - do not spin on locks (used by kmalloc_nolock()=
)
>>> - SLAB_ALLOC_NEW_SLAB - replacing existing 'bool new_slab' parameter
>>> 			for allocating obj_ext arrays
>>> - SLAB_ALLOC_NO_RECURSE - replacing usage of __GFP_NO_OBJ_EXT
>>>
>>> To reduce the amount of parameters in various internal functions, we
>>> additionally introduce slab_alloc_context (also inspired by page
>>> allocator's alloc_context) for passing a number of existing arguments=

>>> and the new alloc_flags:
>>>
>>> /* Structure holding extra parameters for slab allocations */
>>> struct slab_alloc_context {
>>> 	unsigned long caller_addr;
>>> 	unsigned long orig_size;
>>> 	unsigned int alloc_flags;
>>> 	struct list_lru *lru;
>>> };
>>
>> Perhaps beyond the scope of the patchset, but I wonder if we could hav=
e
>> something like struct slab_alloc_context but for kmalloc callers to
>> simplify {PASS,DECL}_KMALLOC_PARAMS().
>>
>> Something like:
>>
>> struct kmalloc_params {
>> #ifdef CONFIG_SLAB_BUCKETS
>> 	kmem_buckets *b;
>> #endif
>> #ifdef CONFIG_KMALLOC_PARTITION_CACHES
>> 	kmalloc_token_t token;
>> #endif
>> };
>>
>> The idea is to move optional kmalloc parameters (depending on config)
>> into a single struct, instead of using the macros.
>>
>> void *__kmalloc_node(size_t size, gfp_t flags, int node,
>> 		     unsigned long caller,
>> 		     struct kmalloc_params params);
>>
>> void *kmalloc_node() {
>>     /* ... snip ...*/
>>     struct kmalloc_params params =3D KMALLOC_PARAMS(params.b, params.t=
oken);
>>     return __kmalloc_node(size, flags, node, _RET_IP_, params);
>> }
>>
>> The compiler should optimize away unused fields based on the config.
>>
>> Per System V AMD64 ABI, the compiler will use registers to pass the
>> struct, as long as the struct size does not exceed 16 bytes.
>> (Otherwise it will be passed on stack).
>=20
> Hm but does this work on all architectures,

apparently not on s390, unfortunately.
on s390 it works only when the struct size does not exceed 8 bytes.

> and are we doing this somewhere
> (for structures larger than a native word) already?

hmm perhaps struct timespec64?

> Also Marco noted earlier that gcc won't optimize away the struct if it
> becomes zero-sized:
>=20
> https://lore.kernel.org/all/CANpmjNO1aNm3mKphDGWasK_NUfVY8q4K9GCjyREZFq=
rOu9WLcw@mail.gmail.com/

Ouch, right. That means we still need at least one macro to define those
parameters :( Sounds less promising now...

--=20
Cheers,
Harry / Hyeonggon

--------------AxdjQdvvIQrAARW40azyu6pE--

--------------EdfxVfiruOiCQ0OSxtJqjQYZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCail8+AAKCRCGXBN6rc5S
1vHhAPwM06JdORhjTWRz+j2VmPKc0qPB2Et4CjeqHvgbP5SzsQEA9Qqx4so7C+dr
cBqCUZWqtyYkj1WQZSAHv2HY82G+OwA=
=Wshr
-----END PGP SIGNATURE-----

--------------EdfxVfiruOiCQ0OSxtJqjQYZ--

