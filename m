Return-Path: <cgroups+bounces-17045-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dVuqMgyyMmrh3gUAu9opvQ
	(envelope-from <cgroups+bounces-17045-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:41:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD269A9DC
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jZ3DSq6l;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17045-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17045-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47B4B3055C29
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D32438FEA;
	Wed, 17 Jun 2026 14:40:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B92217F27;
	Wed, 17 Jun 2026 14:40:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707246; cv=none; b=kUxbenQiBOjpCGFsYuMLDaM1lyYrmJ1NQj8ElFeUwPAIvR5TD6Y7bhzN80J4dkGTt2sx0wXr+/euVmoLDPXQQKh2gMUjfqjqRJ3+gX9/u9v0L27ScF4IRzOWucIPF2tr0pnQ3VTK5WFThPzg19rbPVhSXMNXPq9BGjLBiSPUtwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707246; c=relaxed/simple;
	bh=nbIei5LQuFojnG61oo9TKFoyCWfciPusCPgoFw/p6i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OSjekzgWXPzsaN41DMht36Air21OtitoIMf9/3+KoKFhHaYaN245gwScWWFbZflr3h+nrvbKU8QIxvvWzNg4r9aCwnot7ctSL7ggk1CJ42Hgf1jv1tJYpRGQ4DfXi7YHPcpz1dE8Sn+XTPS/l0mnh8mgw3SV2TX2jV3GNGbTNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZ3DSq6l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7565F1F000E9;
	Wed, 17 Jun 2026 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707245;
	bh=nbIei5LQuFojnG61oo9TKFoyCWfciPusCPgoFw/p6i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jZ3DSq6l+QsHgbvMKTv3EZBc/yQZkW1DWZudDzczG0ToiC/FZhcJcb10b5j0pCQSs
	 v8E6T26mo+I5raG2Luz57wasV+M16uL1T1+p0zZ8UVhuiPT98nv41MW/9QGWvuwsHj
	 fLoCTYDnWfuYvmYOc+GYRVGVHbkQDd0aAkFWbTwKIhonIWFvPC7ekmQfWkqCKtaLWo
	 rTjJ4HNqRsBTEyUPvO+Zxk5I+fgdrp//kizFou1k46AcHc10Pf73nKgZgqKUX0Marf
	 4gAzFwLRYE+8GoedamHKn3j5hp+440s4kut6/nVmL1FiCaxP6VIHzJzv9uyjdhFiU1
	 m4ZOa7/7LFnyg==
Message-ID: <02f9c426-b568-4ddc-882f-aab8c7f31976@kernel.org>
Date: Wed, 17 Jun 2026 23:40:39 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
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
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
 <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
 <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GV0qWTMYBB1AKSMm3bfNfef6"
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
	TAGGED_FROM(0.00)[bounces-17045-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDBD269A9DC

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GV0qWTMYBB1AKSMm3bfNfef6
Content-Type: multipart/mixed; boundary="------------oVz7MBau50V4H9MeL0byYqJq";
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
Message-ID: <02f9c426-b568-4ddc-882f-aab8c7f31976@kernel.org>
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
 <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
 <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>
In-Reply-To: <26c29e4b-09b1-424a-b4e4-3358aac20115@kernel.org>

--------------oVz7MBau50V4H9MeL0byYqJq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/17/26 11:36 PM, Vlastimil Babka (SUSE) wrote:
> On 6/17/26 15:56, Harry Yoo wrote:
>> On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
>>> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself a=
nd
>>> gfp flags are a scarce resource, unlike slab's alloc_flags.
>>>
>>> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent a=
s
>>> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
>>> family function should not recurse into another kmalloc*() for the
>>> purposes of allocating auxiliary structures (obj_ext arrays or sheave=
s).
>>>
>>> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
>>> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
>>> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
>>> added. This will also pass through SLAB_ALLOC_NOLOCK so we don't need=

>>> to special case kmalloc_nolock() anymore.
>>>
>>> Note that until now the kmalloc_nolock() ignored the incoming gfp fla=
gs
>>> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass=
 on
>>> the incoming gfp flags (only augmented with __GFP_ZERO), because if
>>> alloc_flags contain SLAB_ALLOC_NOLOCK, the incoming gfp flags have to=

>>> be also compatible with it. However, we might have added __GFP_THISNO=
DE
>>> for opportunistic slab allocation, as pointed out by Hao Li, and
>>> __GFP_COMP by allocate_slab() as pointed out by Shengming Hu. Solve t=
his
>>> by adding both flags to OBJCGS_CLEAR_MASK as it makes sense to strip
>>> them anyway for non-kmalloc_nolock() allocations of sheaves or obj_ex=
t
>>> arrays as well.
>>>
>>> To avoid recursion of sheaf -> obj_ext -> sheaf -> ... allocations at=

>>> this patch, until the next patch converts sheaves to
>>> SLAB_ALLOC_NO_RECURSE, use both gfp and alloc_flags for obj_ext. The
>>> next patch will remove the gfp part.
>>>
>>> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-15-719090=
9db118@kernel.org
>>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
>>> ---
>>
>> Looks good to me,
>> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
>=20
> Thanks!
> =20
>> With some comments below.
>>
>> I was worried that perhaps replacing SLAB_ALLOC_NO_RECURSE with
>> __GFP_NO_OBJ_EXT will create a cycle of
>>
>> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
>> -> kmalloc_flags(SLAB_ALLOC_NO_RECURSE)
>> -> alloc_from_pcs(SLAB_ALLOC_NO_RECURSE)
>> -> refill_objects(SLAB_ALLOC_DEFAULT)
>> -> new_slab(SLAB_ALLOC_DEFAULT)
>> -> account_slab(SLAB_ALLOC_DEFAULT)
>> -> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
>>
>> with __GFP_NO_OBJ_EXT, it would have been passed to refill_objects(),
>> but SLAB_ALLOC_NO_RECURSE is not. However this cycle does not exist
>> because alloc_slab_obj_exts() clears __GFP_ACCOUNT (as part of
>> OBJCG_CLEAR_MASK) and memory profiling itself does not invoke
>> alloc_slab_obj_exts() when allocating new slabs if SLAB_ACCOUNT is not=

>> set (which is interesting, by the way).
>=20
> Hm yeah I think we should propagate alloc_flags to refill_objects() etc=
, to=20
> avoid later surprise. But can be done as a later cleanup.

Ack.

>> Also alloc_slab_obj_exts() propagating SLAB_ALLOC_NEW_SLAB to
>> kmalloc_flags() is little bit confusing because it does not have any
>> effect due to SLAB_ALLOC_NO_RECURSE.
>=20
> OK let's address this one by this fixup:

The fixup looks good to me, thanks!

--=20
Cheers,
Harry / Hyeonggon


--------------oVz7MBau50V4H9MeL0byYqJq--

--------------GV0qWTMYBB1AKSMm3bfNfef6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajKx5wAKCRCGXBN6rc5S
1t9iAQDiPXLnO6zy942RtBt/uX/MTobE+4pvYi/Tod2EIOc7ZgEAm+SvzDRW2ab1
rNcaW/zRWDP59NB8KIsOmgrG6w6qBAg=
=zqiN
-----END PGP SIGNATURE-----

--------------GV0qWTMYBB1AKSMm3bfNfef6--

