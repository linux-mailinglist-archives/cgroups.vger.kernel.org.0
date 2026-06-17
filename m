Return-Path: <cgroups+bounces-17040-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QrMsGGyoMmpF3QUAu9opvQ
	(envelope-from <cgroups+bounces-17040-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:00:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22669A5B6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:00:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kraHK5CF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17040-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17040-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0A5C30D32F9
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 13:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAA3F0746;
	Wed, 17 Jun 2026 13:56:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F633D47C8;
	Wed, 17 Jun 2026 13:56:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704609; cv=none; b=Gyu55MPSsACc5oV6ssesPWFKWWoaI4Usc5MhBLC+uSef0PGH2TxSkFMA/VIJ2rcflfoqn+p5hd3SXPBAsUe+hQ4ck2+w+6Jo3xiu40VZCLLFb9umpSM06qCzGcbKe3R9VzSwqGM0/dTEmoZl7u6K4pRT507qeGzyxYrsyCJVK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704609; c=relaxed/simple;
	bh=Mi7jxCBuTqaaYC6JDqqn8peOnTfQK8+n6GuPM4X817w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAzoPT8ikIbuXmMJbBBz2cQoRZAgAyPewdzOFioL/Ns9mslP8YezkfkTl44yKy834CC5kNGjsQeBJsr/Zeh1J3WyLEYcCfH1D/6DvHtpUeO1rB2TX3C8NcryWJyNO+TAiiRqBwC/MS8upL5SgnwyhKnb+G+7kYtbnfi5bwT8rsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kraHK5CF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62731F000E9;
	Wed, 17 Jun 2026 13:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781704608;
	bh=Mi7jxCBuTqaaYC6JDqqn8peOnTfQK8+n6GuPM4X817w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kraHK5CF4FrRvFnQJ0VsRChLUJSHWInCzt2ZQlbzcfxiJwaZPkbZb/szb9+MAX+i7
	 t7gPjz6AE5H0WiV9bYsLcRXHAMXa62IrS8LD2lKFH7hlfwE4/LLR8yYFx14Ja4XU9J
	 g100+AcmfJ8CMsw7poJskCe+caWz7uE5qvBpnBdyWbrxS7wC6/cWekkczcgFSeaQiH
	 iqJFBRWZz4HXTsi53E/M1UspG4tGKSACwTcuWuWkDaSbhypB9XoilM0+4Sx/5H4hB7
	 jnT1bbpPzpCQ0t9EM1W+WtJvaLsHGa48iknWK4LE0Cvcgu+9Ot5Eooe4m25C7IHiYm
	 x9HRHfRAZV7Ug==
Message-ID: <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
Date: Wed, 17 Jun 2026 22:56:42 +0900
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
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3cY5hSMZtGl0G9UhgN7kKCMK"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-17040-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD22669A5B6

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3cY5hSMZtGl0G9UhgN7kKCMK
Content-Type: multipart/mixed; boundary="------------5rrQhoodNrxJ9Qsb340LQn6A";
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
Message-ID: <78b67a9b-44e5-4649-957a-9d42bfaa098e@kernel.org>
Subject: Re: [PATCH v3 14/15] mm/slab: remove __GFP_NO_OBJ_EXT usage from
 alloc_slab_obj_exts()
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-14-ce1146d140fb@kernel.org>

--------------5rrQhoodNrxJ9Qsb340LQn6A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> __GFP_NO_OBJ_EXT has limited scope within the slab allocator itself and=

> gfp flags are a scarce resource, unlike slab's alloc_flags.
>=20
> Introduce SLAB_ALLOC_NO_RECURSE alloc flag that has the same intent as
> __GFP_NO_OBJ_EXT but a more generic name, meaning that a kmalloc()
> family function should not recurse into another kmalloc*() for the
> purposes of allocating auxiliary structures (obj_ext arrays or sheaves)=
=2E
>=20
> First, replace the __GFP_NO_OBJ_EXT for allocating obj_ext arrays in
> alloc_slab_obj_exts(). Make use of the newly added kmalloc_flags()
> function, where we can pass alloc_flags with SLAB_ALLOC_NO_RECURSE
> added. This will also pass through SLAB_ALLOC_NOLOCK so we don't need
> to special case kmalloc_nolock() anymore.
>=20
> Note that until now the kmalloc_nolock() ignored the incoming gfp flags=

> and hardcoded __GFP_ZERO | __GFP_NO_OBJ_EXT. But it's correct to pass o=
n
> the incoming gfp flags (only augmented with __GFP_ZERO), because if
> alloc_flags contain SLAB_ALLOC_NOLOCK, the incoming gfp flags have to
> be also compatible with it. However, we might have added __GFP_THISNODE=

> for opportunistic slab allocation, as pointed out by Hao Li, and
> __GFP_COMP by allocate_slab() as pointed out by Shengming Hu. Solve thi=
s
> by adding both flags to OBJCGS_CLEAR_MASK as it makes sense to strip
> them anyway for non-kmalloc_nolock() allocations of sheaves or obj_ext
> arrays as well.
>=20
> To avoid recursion of sheaf -> obj_ext -> sheaf -> ... allocations at
> this patch, until the next patch converts sheaves to
> SLAB_ALLOC_NO_RECURSE, use both gfp and alloc_flags for obj_ext. The
> next patch will remove the gfp part.
>=20
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-15-7190909d=
b118@kernel.org
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

With some comments below.

I was worried that perhaps replacing SLAB_ALLOC_NO_RECURSE with
__GFP_NO_OBJ_EXT will create a cycle of

alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)
-> kmalloc_flags(SLAB_ALLOC_NO_RECURSE)
-> alloc_from_pcs(SLAB_ALLOC_NO_RECURSE)
-> refill_objects(SLAB_ALLOC_DEFAULT)
-> new_slab(SLAB_ALLOC_DEFAULT)
-> account_slab(SLAB_ALLOC_DEFAULT)
-> alloc_slab_obj_exts(SLAB_ALLOC_DEFAULT)

with __GFP_NO_OBJ_EXT, it would have been passed to refill_objects(),
but SLAB_ALLOC_NO_RECURSE is not. However this cycle does not exist
because alloc_slab_obj_exts() clears __GFP_ACCOUNT (as part of
OBJCG_CLEAR_MASK) and memory profiling itself does not invoke
alloc_slab_obj_exts() when allocating new slabs if SLAB_ACCOUNT is not
set (which is interesting, by the way).

Also alloc_slab_obj_exts() propagating SLAB_ALLOC_NEW_SLAB to
kmalloc_flags() is little bit confusing because it does not have any
effect due to SLAB_ALLOC_NO_RECURSE.

Those are quite subtle and perhaps worth some attention.
But technically, should not be a blocker for the patch.

--=20
Cheers,
Harry / Hyeonggon

--------------5rrQhoodNrxJ9Qsb340LQn6A--

--------------3cY5hSMZtGl0G9UhgN7kKCMK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajKnmgAKCRCGXBN6rc5S
1haJAQDK3uVXonDI0YBvLzkAybijWZr2Qa7jZx3GhFza1G/qjQD/dcdV6qNgaQS6
SF4LWQHTO6baylkB0+NrAe4QBdWSKQ8=
=/47q
-----END PGP SIGNATURE-----

--------------3cY5hSMZtGl0G9UhgN7kKCMK--

