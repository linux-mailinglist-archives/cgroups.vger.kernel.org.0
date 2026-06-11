Return-Path: <cgroups+bounces-16838-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YurBBW05KmqtkgMAu9opvQ
	(envelope-from <cgroups+bounces-16838-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 06:28:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A166E2EE
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 06:28:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R8PazR6j;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16838-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16838-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40D7930A91F4
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 04:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEB3345740;
	Thu, 11 Jun 2026 04:28:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8F272816;
	Thu, 11 Jun 2026 04:28:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152104; cv=none; b=rATFSzLHYN7YPZakXRO2Fm7bmhGd8S0s+xa7FJ9TNzwwQfAmq7JCzBlrzG9aX8y/z/A5FGdkRjbU2AZVk0soVXETCDyUCkSeMkZOeNhVoya+3sSm46qC/K5k4lLocf9d82rOjt0dYd4U6SC/8wYKPMKcKf/s7ZDQOCusFgmFO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152104; c=relaxed/simple;
	bh=8ebuoNn8zdrqOpxqpNoXGy+JFde83KobHja3rzwz4bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbPQdm/CiE0zlAZ6IDj9/DNV1tR4ApsrjgvNrWCmSCG9gWzmpSSTJJD33b+6ArTVZ+vV3p3ALaD8FFKHmyZMJLxLm1u2PhnHAWXrSbMxRyy1aY8xdnybeg/ofwytYwsbtvlCe230ZVcs7yHMDsevcn1czbUaWgndcfGCPk3lxwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8PazR6j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E2C1F00893;
	Thu, 11 Jun 2026 04:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781152102;
	bh=8ebuoNn8zdrqOpxqpNoXGy+JFde83KobHja3rzwz4bg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R8PazR6jVPYyf7+wFXw1X07UgYA1ez4bgnqAF61ddxjFVJS5h8D5QtzyK7zw/G971
	 HaMTOwnjh77Cw9Kkonln4915X4fMjR0tiz4JUB5RktFGKTL2tPSgjyGh489k+u440R
	 n4QyqIY04sQHH9r6jYfgBlwWA1vRoxQko/hAAQ6ploD/y+5C2sL3MhyFynIq38j5+9
	 G59bUR+8i6BF9unVvOi20zvvkAJfKf8CnktZPj8hXtTPkygc2A1Tg3hA8c5nwjMEyR
	 Qa+sf2ZxBY1DFLzcn5h21YblZCGXDCAFAvCf+iuvEJsSChwcpHDcC9Co/U+opZZBak
	 p9Ul/D30pCdeA==
Message-ID: <df75999f-e96e-4a9b-8930-1b6c6c7c17cb@kernel.org>
Date: Thu, 11 Jun 2026 13:28:14 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] mm/slab: do not limit zeroing to orig_size when
 only red zoning is enabled
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 stable@vger.kernel.org
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------9nrmmelZmALRVRtPX4TWPfgk"
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
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:surenb@google.com,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-16838-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 6E0A166E2EE

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------9nrmmelZmALRVRtPX4TWPfgk
Content-Type: multipart/mixed; boundary="------------ErL0jxv071rjUQMi0aMrpEeW";
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
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 stable@vger.kernel.org
Message-ID: <df75999f-e96e-4a9b-8930-1b6c6c7c17cb@kernel.org>
Subject: Re: [PATCH v2 01/16] mm/slab: do not limit zeroing to orig_size when
 only red zoning is enabled
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org>
In-Reply-To: <20260610-slab_alloc_flags-v2-1-7190909db118@kernel.org>

--------------ErL0jxv071rjUQMi0aMrpEeW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/11/26 12:40 AM, Vlastimil Babka (SUSE) wrote:
> When init (zeroing) on allocation is requested, for kmalloc() we
> generally have to zero the full object size even if a smaller size is
> requested, in order to provide krealloc()'s __GFP_ZERO guarantees.
>=20
> But if we track the requested size, krealloc() uses that information to=

> do the right thing. With red zoning also enabled, any unused size
> became part of the red zone, so it must not be zeroed.
>=20
> However the check is imprecise, and will trigger also when only
> SLAB_RED_ZONE is enabled without SLAB_STORE_USER. This means enabling
> red zoning alone can compromise krealloc()'s __GFP_ZERO contract.
>=20
> Fix this by using slub_debug_orig_size() instead, which is the exact
> check for whether the requested size is tracked. We don't need to care
> if red zoning is also enabled or not. Also update and expand the
> comment accordingly.
>=20
> Fixes: 9ce67395f5a0 ("mm/slub: only zero requested size of buffer for k=
zalloc when debug enabled")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------ErL0jxv071rjUQMi0aMrpEeW--

--------------9nrmmelZmALRVRtPX4TWPfgk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaio5XgAKCRCGXBN6rc5S
1sfjAQDJjxqdD8sQENhgXIPO4U/wPF/HiD82CcmCL/ATkiFhdwEA10COEVT9AbpI
m0HnlYsxgxDFh2+UgTL2jf7cbIWfNwo=
=AcAR
-----END PGP SIGNATURE-----

--------------9nrmmelZmALRVRtPX4TWPfgk--

