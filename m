Return-Path: <cgroups+bounces-16861-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S5NzE2/QKmrAxQMAu9opvQ
	(envelope-from <cgroups+bounces-16861-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:12:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B7672F8D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 17:12:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i9ic+r2W;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16861-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16861-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C703233C1D51
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5A3F0773;
	Thu, 11 Jun 2026 15:11:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A82DCBE3;
	Thu, 11 Jun 2026 15:11:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190674; cv=none; b=OscSEHya1dDtjbfocxESVQoTEIuz3H7bnIshrS4pDUW2WfsxXSisDag2oSfL1Y5KvW9R4PlC+5HoXTcNK3fmNHN3aypn1jluBdzoLSk6JBus8MYlnXJ2+SaJPM5biHWEMfhBLC0xZlLy6glRqaMnN3GXz39hVA0xjzPTjaK+8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190674; c=relaxed/simple;
	bh=EDCDjHbzniQNTeeRlr9MUeOJ6a+wF+8kej2BDLtfJBA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AJaOJCCDsKjutbhDxrOb4q1hhMWf7OZkA/fFHE8kwK//l28p/PG+J/Cww7uG0ehGrQJCgb1Hn6J+c1aq4Y/PZwwwdwgqGJq0KwGNK3UGKigVLX6k1qEqv2ZW94idg/Y8fxTOkLxPZNznW+sRSUmXXUmNc6rUzvZadWrTv61YZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9ic+r2W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1AF1F00893;
	Thu, 11 Jun 2026 15:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190673;
	bh=a00kAyBp1nYhmRNrUiqyLY0i6xIPDg05ArjKISlux/k=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=i9ic+r2WO59KlmKWcwj+C6Tbc5ykvmdS5lgQIfjY1Vnf7aLDclXnPLPzQ5svBe3h9
	 w80fB1RVlc2eJn+xdmt6N9owW8SBnErKj19XsYd5YK4GvjWFfC6o/34VSKisJWqgIq
	 KEoDdLuBskCrYfc2qvesrqDJNPwUvY8skHfSsfwKgMESBdHejQzHs2LXeIbnOYOtUF
	 3RG00lTP0hZCkjUJ09Hzr/1G58+Ba9YAMThIGr29qZk5iK0DQOCK6bRx9vwolAyj+a
	 FUc89Tp7joOwnuAO9L/yS4REhX9UbiM4q53iBtK4zGikdTJh/dxrkWgy8LHZMzfr1I
	 oA88zb2mGDO1A==
Message-ID: <74adf668-78c2-4989-a6c6-c6ec7bd68855@kernel.org>
Date: Fri, 12 Jun 2026 00:11:07 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harry Yoo <harry@kernel.org>
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
 <b6530e92-d648-4028-9e77-0df8c3ab166d@kernel.org>
 <159d1e20-5b21-4329-ac9a-f7a5cb0fd56a@kernel.org>
 <e71bfc13-c233-4f85-a6ec-76327d3c6510@kernel.org>
Content-Language: en-US
In-Reply-To: <e71bfc13-c233-4f85-a6ec-76327d3c6510@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16861-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:andreyknvl@gmail.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,gentwo.org,google.com,kernel.org,linux-foundation.org,cmpxchg.org,gmail.com,googlegroups.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 977B7672F8D



On 6/11/26 11:47 PM, Vlastimil Babka (SUSE) wrote:
> On 6/11/26 10:34, Vlastimil Babka (SUSE) wrote:
>> On 6/11/26 05:19, Harry Yoo wrote:
>>>
>>>> This potentially adds overhead of the is_kfence_address() check to
>>>> allocation hotpath, but that one is designed to be as small as possi=
ble,
>>>> and it's only evaluated if zeroing is about to happen. This means (a=
side
>>>> from init_on_alloc hardening) only for __GFP_ZERO allocations, and t=
he
>>>> zeroing itself comes with an overhead likely larger than the added
>>>> check.
>>>>
>>>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>>> ---
>>>>  mm/kfence/core.c |  2 +-
>>>>  mm/slub.c        | 23 ++++++++---------------
>>>>  2 files changed, 9 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index e2ee8f1aaccf..8e5264d3ddbf 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -4565,9 +4565,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct=
 kmem_cache *s, gfp_t flags)
>>>> =20
>>>>  static __fastpath_inline
>>>>  bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lr=
u,
>>>> -			  gfp_t flags, size_t size, void **p, bool init,
>>>> +			  gfp_t flags, size_t size, void **p,
>>>>  			  unsigned int orig_size)
>>>>  {
>>>> +	bool init =3D slab_want_init_on_alloc(flags, s);
>>>>  	unsigned int zero_size =3D s->object_size;
>>>>  	bool kasan_init =3D init;
>>>>  	size_t i;
>>>> @@ -4608,7 +4609,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s=
, struct list_lru *lru,
>>>>  	for (i =3D 0; i < size; i++) {
>>>>  		p[i] =3D kasan_slab_alloc(s, p[i], init_flags, kasan_init);
>>>>  		if (p[i] && init && (!kasan_init ||
>>>> -				     !kasan_has_integrated_init()))
>>>> +				     !kasan_has_integrated_init())
>>>> +				 && !is_kfence_address(p[i]))
>>>
>>> I hope we could make it bit more verbose and straightforward,
>>> something like:
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 5d7ea72ebebd..29cf4590f9d9 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4573,7 +4573,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s,=

>>> gfp_t flags, size_t size,
>>>  {
>>>  	bool init =3D slab_want_init_on_alloc(flags, s);
>>>  	unsigned int zero_size =3D s->object_size;
>>> -	bool kasan_init =3D init;
>>>  	size_t i;
>>>  	gfp_t init_flags =3D flags & gfp_allowed_mask;
>>>
>>> @@ -4591,29 +4590,37 @@ bool slab_post_alloc_hook(struct kmem_cache *=
s,
>>> gfp_t flags, size_t size,
>>>  	if (slub_debug_orig_size(s))
>>>  		zero_size =3D ac->orig_size;
>>>
>>> -	/*
>>> -	 * When slab_debug is enabled, avoid memory initialization integrat=
ed
>>> -	 * into KASAN and instead zero out the memory via the memset below =
with
>>> -	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones =
and
>>> -	 * cause false-positive reports. This does not lead to a performanc=
e
>>> -	 * penalty on production builds, as slab_debug is not intended to b=
e
>>> -	 * enabled there.
>>> -	 */
>>> -	if (__slub_debug_enabled())
>>> -		kasan_init =3D false;
>>> -
>>> -	/*
>>> -	 * As memory initialization might be integrated into KASAN,
>>> -	 * kasan_slab_alloc and initialization memset must be
>>> -	 * kept together to avoid discrepancies in behavior.
>>> -	 *
>>> -	 * As p[i] might get tagged, memset and kmemleak hook come after KA=
SAN.
>>> -	 */
>>>  	for (i =3D 0; i < size; i++) {
>>> -		p[i] =3D kasan_slab_alloc(s, p[i], init_flags, kasan_init);
>>> -		if (p[i] && init && (!kasan_init ||
>>> -				     !kasan_has_integrated_init())
>>> -				 && !is_kfence_address(p[i]))
>>> +		bool skip_init =3D false;
>>> +
>>> +		if (is_kfence_address(p[i])) {
>>> +			/*
>>> +			 * kfence zeroes the object instead of SLUB to avoid
>>> +			 * overwriting its own redzone, and zeroing of
>>> +			 * s->object_size will corrupt it.
>>> +			 */
>>> +			skip_init =3D true;
>>
>> But now we perform this check even if init is false, making it more ho=
t.
>>
>>> +		} else if (__slub_debug_enabled()) {
>>> +			/*
>>> +			 * KASAN never zeroes memory when slab_debug is enabled
>>> +			 * to avoid overwriting SLUB redzones. This does not
>>> +			 * lead to a performance penalty on production builds,
>>> +			 * as slab_debug is not intended to be enabled there.
>>> +			 */
>>> +			skip_init =3D false;
>>> +		} else if (kasan_has_integrated_init()) {
>>> +			/*
>>> +			 * ARM64 can set memory tags and zero the memory using
>>> +			 * a single instruction. Since HW_TAGS KASAN uses that
>>> +			 * while tagging the object, a separate zeroing is
>>> +			 * unnecessary unless slab_debug is enabled.
>>> +			 */
>>
>> (I like the new/updated comments)
>>
>>> +			skip_init =3D true;
>>> +		}>
>>
>> And these two are now done in every loop iteration even though they do=
n't
>> depend on the object. Yeah it's a static key and build-time constant b=
ut still.
>>
>> But maybe there's some middle ground?
>>
>> Above the loop do (with your comments).
>=20
> OK, not so simple, we still need the kasan_init variable too.

Ouch, right.

> I've ended up with this, thoughts?

Much better!

> From 3a1c4398ce9f361a4e6f4d9946eab6237eea89c2 Mon Sep 17 00:00:00 2001
> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> Date: Wed, 10 Jun 2026 17:40:04 +0200
> Subject: [PATCH] mm/slab: do not init any kfence objects on allocation
>=20
> When init (zeroing) on allocation is requested, for kmalloc() we
> generally have to zero the full object size even if a smaller size is
> requested, in order to provide krealloc()'s __GFP_ZERO guarantees.
>=20
> When we end up allocating a kfence object, kfence perfoms the zeroing o=
n

nit: perfoms -> performs

> its own because has its own redzone beyond the requested size. Thus
> slab_post_alloc_hook() has an 'init' parameter which has to be evaluate=
d
> in all callers (via slab_want_init_on_alloc()) and should be false for
> kfence allocations.
>=20
> For kfence allocations in slab_alloc_node() this is achieved by subtly
> skipping over the slab_want_init_on_alloc() call. Other callers (i.e.
> kmem_cache_alloc_bulk_noprof()) however evaluate it unconditionally eve=
n
> if they do end up with a kfence allocation. This is only subtly not a
> problem, as those are not kmalloc allocations and thus the "requested
> size" equals s->object_size and thus it cannot interfere with kfence's
> redzone. There's just a unnecessary double zeroing (in both kfence and
> slab_post_alloc_hook()), but it's all very fragile and contradicts the
> comment in kfence_guarded_alloc().
>=20
> Remove this subtlety and simplify the code by eliminating the init
> parameter from slab_post_alloc_hook() and make it call
> slab_want_init_on_alloc() itself. Instead add a is_kfence_address()
> check before performing the memset, which will start doing the right
> thing for all callers of slab_post_alloc_hook().
>=20
> This potentially adds overhead of the is_kfence_address() check to
> allocation hotpath, but that one is designed to be as small as possible=
,
> and it's only evaluated if zeroing is about to happen. This means (asid=
e
> from init_on_alloc hardening) only for __GFP_ZERO allocations, and the
> zeroing itself comes with an overhead likely larger than the added
> check.

> While at it, refactor the handling of evaluating when KASAN does the
> init instead of SLUB, with no intended functional changes. A
> non-functional change is that we don't pass kasan_init as true to
> kasan_slab_alloc() if kasan has no integrated init, but then the value
> is ignored anyway, so it's theoretically more correct.

Right.

> Thanks to Harry Yoo for the initial refactoring attempt, and for update=
d
> comments that are used here.

No problem ;)

> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-2-7190909db=
118@kernel.org
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Thanks!

--=20
Cheers,
Harry / Hyeonggon

