Return-Path: <cgroups+bounces-16803-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TiYVMzdVKWqLVAMAu9opvQ
	(envelope-from <cgroups+bounces-16803-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 14:14:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A147669284
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 14:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GeGBmsT3;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16803-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16803-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 773063077633
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884C404BD7;
	Wed, 10 Jun 2026 12:07:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE193FD13E;
	Wed, 10 Jun 2026 12:06:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093220; cv=none; b=S+s3VcbDbRZwjAVZRcgSK6tHVzCQPRUfuw0Ps+XIZt4woTkxM1fS+lrh9JG61OXBl2Duqr5ylj5bLHcy+7SSp//Ai7pYicr5/GFibyEBUipEaE5Kkt80XE/xH6tRL/qh+dJHzEv9YHTHazKCIFFkZcVOJUBWnJ8XTnmzfQwMBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093220; c=relaxed/simple;
	bh=3S5TEHpMOJZU/HfVPLHwrccmgC5OBUEG+pp6rgdD7zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKAPiY4shUdOM/f3CmuX++h0OM1iEsyrFmGPs3b0zC6mjP11XAbrC3knKo8cocdolqFYQgs7cpwAMBWPFNEDAEMWm+PWOSIRIS5wq+WW9IQV0BjTfYud1noIHojV9n/fRZlbsH1oTO+N8C7nntnDBgdnOGKoL0224pi3CVHFxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeGBmsT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8BC1F00893;
	Wed, 10 Jun 2026 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781093219;
	bh=/lvjM4grmcimakDhjqCbNRnKzubZHkQeH7hKgRM5Kes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GeGBmsT3+kIwRsklxR1TYcu4DqZ9f5X0qV3yfdqTVZ1RHxYeoHPp7nVT50F9xmJp8
	 SvgyxqCDtgoLHpHMIfy3qi7zMg0I+/ZvihPE4l+DBGZ0+bIPpwYJYWemhdkmgAyfcv
	 KyZeSUMfW120ZPiEt1g26W8BArl6YBtkPQ9kUG8XxhLDcyA+GYY3JtoypalZeDpRnz
	 NpdO7Ms+LsRnii1ytDuw950lQSfwuXs4Jyi0Jr/peEg4/5v8hO6vpaXZ/6ehel5KlP
	 jNNF5uM/RAE99niIFsmrqwHphAZ4npUzWBo8HM3hlS/KQK0G6c7MC/WRTy+gCiL2B+
	 HW2Gm8XlYS23Q==
Message-ID: <d0d7e853-12e2-4db1-8e20-ee66c3006dd0@kernel.org>
Date: Wed, 10 Jun 2026 21:06:50 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/15] mm/slab: stop inlining __slab_alloc_node()
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
 <20260609-slab_alloc_flags-v1-2-2bf4a4b9b526@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-2-2bf4a4b9b526@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------o7p8tJJhETiZ7lV3nDNGI84L"
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
	TAGGED_FROM(0.00)[bounces-16803-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 5A147669284

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------o7p8tJJhETiZ7lV3nDNGI84L
Content-Type: multipart/mixed; boundary="------------8e0X05FoqZgOTYBzGdnEpcJ3";
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
Message-ID: <d0d7e853-12e2-4db1-8e20-ee66c3006dd0@kernel.org>
Subject: Re: [PATCH RFC 02/15] mm/slab: stop inlining __slab_alloc_node()
References: <20260609-slab_alloc_flags-v1-0-2bf4a4b9b526@kernel.org>
 <20260609-slab_alloc_flags-v1-2-2bf4a4b9b526@kernel.org>
In-Reply-To: <20260609-slab_alloc_flags-v1-2-2bf4a4b9b526@kernel.org>

--------------8e0X05FoqZgOTYBzGdnEpcJ3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/9/26 6:17 PM, Vlastimil Babka (SUSE) wrote:
> With sheaves, this is no longer part of the allocation fastpath.  For
> the same reason, also mark the call to it from slab_alloc_node() as
> unlikely().
>=20
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------8e0X05FoqZgOTYBzGdnEpcJ3--

--------------o7p8tJJhETiZ7lV3nDNGI84L
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCailTWgAKCRCGXBN6rc5S
1pPLAQCl0frg9IhgBHxe7oh9laNSSKIorQjoahz5YjcSR7zvLQD8Dn39qHQ/vH8o
K3q/ObZo2YOj/eCIlLKJ0EcvC1VDfAo=
=+15X
-----END PGP SIGNATURE-----

--------------o7p8tJJhETiZ7lV3nDNGI84L--

