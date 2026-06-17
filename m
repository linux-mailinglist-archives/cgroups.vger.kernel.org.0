Return-Path: <cgroups+bounces-17042-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bbIPIh+xMmq53gUAu9opvQ
	(envelope-from <cgroups+bounces-17042-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:37:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED76169A971
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 16:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bCG6sPUF;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17042-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17042-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCD4F30CF5B7
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C451244BC92;
	Wed, 17 Jun 2026 14:37:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2139DBD4;
	Wed, 17 Jun 2026 14:37:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707025; cv=none; b=o3Tk2BugwPal5jQmg7/o4ypgl/06MCEciRl1Xa+QedxnShf2k0Bq9qpSoVBXMh+Vk0qWiMH3Ek9kPFx0desbnY/5vhZPZ6Hm/RHWy/nKJOYEeGIZR/dEp+I3ULwU+9FmYUeGy7NB56orcteSYcWUOSYbdgh1pPBk/Ne6LvQBSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707025; c=relaxed/simple;
	bh=UlarZjz9hb/rXsZr46rmLI8X0P0F5x2cPPGw+EkC9ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnhM0nsGCBvAps+UtwrzgKsdvPtaC09vcbpGxcQpJESwVTUtMBNYwgAvzjzSE4OnWDW34eTiaIS6pnz5kSDULsXaAwdkpTzmW5RV++uDAoknQSnhvc8TNzv/p19TV7tUqIiFLAsOa/kQTjuUEghhtctcysdnQ4pmztXE+5i4m8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCG6sPUF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D231F000E9;
	Wed, 17 Jun 2026 14:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707024;
	bh=UlarZjz9hb/rXsZr46rmLI8X0P0F5x2cPPGw+EkC9ok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bCG6sPUF2jYcVg9dDrzvJNAZYQUr/vuARhv3RVL/2ysFZlxJRvkaCLKyEKXqyzZmI
	 fKbKuhccmK5+ZPKO+1uZVZB0ofCpLz60PpbOu0FYYXuB6scZApXyb8EeZEN3D9lxLH
	 AJlDoaz4tghoSEaqJFLVQ8jmUST+zsxuml1CxX9VP0CMiZNU6hyRBV523HcslHcwgl
	 PLdBbXuyPHbHHlaW/n8bzvfKQIn2pyvhfZCmufP0Aw0Zy878G8TcRRUJVyhP6XukBT
	 pizbh0YHdGPC+8ZhPXyrH2HKNZ16voiuLOZl/N2PAGcbsc+hVCNSwwahg4+MRBricy
	 SiujHPqM6gAxg==
Message-ID: <918fae64-1323-46ea-a86e-3c847a52f174@kernel.org>
Date: Wed, 17 Jun 2026 23:36:58 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] mm/slab: replace __GFP_NO_OBJ_EXT with
 SLAB_ALLOC_NO_RECURSE for sheaves
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
 <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0psGISE63oZNEUmTQW1sVnap"
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
	TAGGED_FROM(0.00)[bounces-17042-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED76169A971

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0psGISE63oZNEUmTQW1sVnap
Content-Type: multipart/mixed; boundary="------------TBNAO9MmQOQu2Pmqd1aWCBrf";
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
Message-ID: <918fae64-1323-46ea-a86e-3c847a52f174@kernel.org>
Subject: Re: [PATCH v3 15/15] mm/slab: replace __GFP_NO_OBJ_EXT with
 SLAB_ALLOC_NO_RECURSE for sheaves
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-15-ce1146d140fb@kernel.org>

--------------TBNAO9MmQOQu2Pmqd1aWCBrf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> Finish the switch away from __GFP_NO_OBJ_EXT by replacing it with
> SLAB_ALLOC_NO_RECURSE when allocating empty sheaves. Pass alloc_flags t=
o
> [__]alloc_empty_sheaf(). Callers that can't be part of a recursive
> kmalloc() chain simply pass SLAB_ALLOC_DEFAULT. Use kmalloc_flags()
> instead of kzalloc() for allocating the sheaf.
>=20
> With that we can finalize the removal the __GFP_NO_OBJ_EXT handling fro=
m
> obj_ext allocations as well, leaving only SLAB_ALLOC_NO_RECURSE in
> place.
>=20
> This leaves __GFP_NO_OBJ_EXT with no users in slab, so stop allowing th=
e
> flag in kmalloc_nolock().
>=20
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-16-7190909d=
b118@kernel.org
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------TBNAO9MmQOQu2Pmqd1aWCBrf--

--------------0psGISE63oZNEUmTQW1sVnap
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajKxCgAKCRCGXBN6rc5S
1r87AQCEyvL7xwt5erc8QniuHD39QfJrMf+Jct/CdQ6VCpZwHQD9F2GeRLOW2gH8
BdWpY/PNn1VD0J1HMWM/+M8tRZMkoAw=
=AtOR
-----END PGP SIGNATURE-----

--------------0psGISE63oZNEUmTQW1sVnap--

