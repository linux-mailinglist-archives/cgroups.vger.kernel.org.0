Return-Path: <cgroups+bounces-16843-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bklmEzRQKmpFnAMAu9opvQ
	(envelope-from <cgroups+bounces-16843-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 08:05:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89AB66EE1F
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 08:05:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=a2XT4r8o;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16843-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16843-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C399930068F7
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 06:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B53337BA4;
	Thu, 11 Jun 2026 06:05:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B9E30146C;
	Thu, 11 Jun 2026 06:05:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157937; cv=none; b=WsC8uYnGPDD85d1iCof5ycEjlVMvYtZDh1Te5ElR/QFIi0Nn36WwEHVTFm/kVuTzNeCDugF9CVfWzUsFTL5JoZ56J2Rx3ImIUDnatTxjwhg99RSHE8sqPUA0LBRtvtpHfrrxIdKXpF3BuAUZk8g+WtHtjEW8efCb6/iEgjclSqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157937; c=relaxed/simple;
	bh=KCobAk1v9fNVAoJf0iITbOT1BGY69Eo1RWAE+L3IdP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBndtXAMEKWso39teE0JmVk2ylPnQMs86+a5Xbdc2q7WA1+Nj3dV77HlGNqwAmmYYN16/PljxvQLZz3tYtoHwD1VHM1CTzBr+FX8nJbm/JiFMyjPU48JbJgRmB+an4tOX2sXIJDdF0W4HosSQBjz0ZhdfgCyucOsTwLQV+c7Eeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2XT4r8o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9681F00893;
	Thu, 11 Jun 2026 06:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781157936;
	bh=KCobAk1v9fNVAoJf0iITbOT1BGY69Eo1RWAE+L3IdP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=a2XT4r8oIoL31aBcHxAtMHleb4Gc/zG6F4q9xprFGdnrduVq98kVvFMSv+Npbmeru
	 lCjdn1z/FvGPf+yMUK4O8Lu8LO6kx/7IJIIBHN3nh+OFgTif71AH35fhp8ToKRDWzi
	 lT0nQXzfLinRd3g9h+96+JvJuSiyomGpXiDDqi8Jjln1E57A1aUyHcmGqX5q8EH7W8
	 PWldc39RNmMOi6agX9cx2SjouHHEYZatOyJB9jusa1Rt99Hav1l4dlNPLS+wD83DAB
	 +S6AOkwLbizkluJanjzk6P+cMVRoUgW09PPbD0iTzWTzAgih1pk1eQDJJAWhzEuaQq
	 Ltyl3flw0ND7Q==
Message-ID: <f9b7935c-f5f0-496c-b55e-1f3feee5c87a@kernel.org>
Date: Thu, 11 Jun 2026 15:05:31 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] mm/slab: replace struct partial_context with
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
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1O40a5juCIbpxLZ5dsBsgvqk"
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
	TAGGED_FROM(0.00)[bounces-16843-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B89AB66EE1F

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1O40a5juCIbpxLZ5dsBsgvqk
Content-Type: multipart/mixed; boundary="------------7WEiTOn02pyYbf3OU7fSBKOd";
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
Message-ID: <f9b7935c-f5f0-496c-b55e-1f3feee5c87a@kernel.org>
Subject: Re: [PATCH v2 07/16] mm/slab: replace struct partial_context with
 slab_alloc_context
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-7-7190909db118@kernel.org>

--------------7WEiTOn02pyYbf3OU7fSBKOd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> Refactor get_from_partial_node(), get_from_any_partial(),
> get_from_partial() and ___slab_alloc().
>=20
> Remove struct partial_context, which used to be more substantial but
> shrank as part of the sheaves conversion. Instead pass gfp_flags and
> pointer to the new slab_alloc_context, which together is a superset of
> partial_context.
>=20
> This means alloc_flags are now available and we can use them to
> determine if spinning is allowed, further reducing false positive "not
> allowed" in the slow path due to gfp flags lacking __GFP_RECLAIM.
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------7WEiTOn02pyYbf3OU7fSBKOd--

--------------1O40a5juCIbpxLZ5dsBsgvqk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaipQKwAKCRCGXBN6rc5S
1hN2AQDWJkWZRiTjIEVAqbOLRNnR7yDNdfBWX6DI98H+AvJzHQEAqj6jWeaKqi19
xu+cPt/SkA9DOj9yVbTLCWbf+IbJeQA=
=a3Ad
-----END PGP SIGNATURE-----

--------------1O40a5juCIbpxLZ5dsBsgvqk--

