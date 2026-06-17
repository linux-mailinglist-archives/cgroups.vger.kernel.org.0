Return-Path: <cgroups+bounces-17023-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sEoxAxhoMmomzgUAu9opvQ
	(envelope-from <cgroups+bounces-17023-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 11:25:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714A5697E11
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 11:25:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MVKZCXUL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17023-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17023-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7733B3054EBF
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D847C38C437;
	Wed, 17 Jun 2026 09:24:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931233BED76;
	Wed, 17 Jun 2026 09:24:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688297; cv=none; b=smGA7fsHDvmMgV3PUXWM9N3w5DjsiOtBQnRJDJTuakJKpdbuz95FrnOPTu3q+BvrLJEkGQ0KwKOtqNCieHmeHm0DQdJ3izGrHiIXk2bXn+GjBPngFteXdouHJr5pMGHL2nhJsrO/0Z4Yj9B3zb0MLKlv/ZqKGIPkL1pveRNAdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688297; c=relaxed/simple;
	bh=ukDROeDwzr3ZoL8vVJ3NTzkwU232sE6vLyeqP7y78jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=scdF+7F6BVW/q/9FHngGXGQbeg5b1zh4T1Z2cCoHgrlhASmArrem7tKrgxumAQFvc0FD9hzKQIWtl+JZv0JZarn30t8xD+r+LUpG28fY0Xu1ZLR/CUtm/Zz+wJihxWyEfdnLKbHcda3ygCK3kwl7gnxsvp4wAFlgA69JMM8mH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVKZCXUL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E2B1F000E9;
	Wed, 17 Jun 2026 09:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781688293;
	bh=ukDROeDwzr3ZoL8vVJ3NTzkwU232sE6vLyeqP7y78jw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MVKZCXULeCc3WHehHQnprURu8tAPLhNcCq/k4c0vi55Vk42y2WoRo6luW4D+o8FUK
	 K8h8MeEyeIg2MhIiiLPh8kRC9LPQynCKhfxaA+aCu+5pUoGLpqSbXAyWlCIOKwLVQb
	 Aec4MI0xzeskZa0VK89aplGsm2o9JhqXjG3GzxyNREu0Yn5ZJdf4z8/ajjeqd/qLk4
	 KZU1/YWovxiWjFxAA+xx2glO8JnUrPStRAiLjKXSikU1+R/91EH3d+fK119lfz9JLZ
	 J0cHUT37Qt0OZHEzXwwNnTOErU36KY60pTySsx75q5njKlFylGee/J/n5grhzSt6CU
	 UiF7wUqT6Kuuw==
Message-ID: <a80d7409-5a58-48c0-8ccb-b568b3e3a1f9@kernel.org>
Date: Wed, 17 Jun 2026 18:24:44 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] mm/slab: replace slab_alloc_node() parameters
 with slab_alloc_context
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
 <20260615-slab_alloc_flags-v3-9-ce1146d140fb@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-9-ce1146d140fb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tWEfSKJRdmtGLwcIaNnNhpfw"
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
	TAGGED_FROM(0.00)[bounces-17023-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 714A5697E11

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tWEfSKJRdmtGLwcIaNnNhpfw
Content-Type: multipart/mixed; boundary="------------XVYSd1G00Q7d0rl9kEo4pZcy";
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
Message-ID: <a80d7409-5a58-48c0-8ccb-b568b3e3a1f9@kernel.org>
Subject: Re: [PATCH v3 09/15] mm/slab: replace slab_alloc_node() parameters
 with slab_alloc_context
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-9-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-9-ce1146d140fb@kernel.org>

--------------XVYSd1G00Q7d0rl9kEo4pZcy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> The function takes all the parameters that exist as fields in
> slab_alloc_context, except alloc_flags. Replace them with a single
> pointer.
>=20
> This moves slab_alloc_context initialization to a number of callers,
> which is more verbose, but arguably also more clear than a long list of=

> parameters, and most do not use the 'lru' field.
>=20
> This will also allow kmalloc_nolock() to call slab_alloc_node() and
> reduce the special open-coding it currently has.
>=20
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-10-7190909d=
b118@kernel.org
> Reviewed-by: Hao Li <hao.li@linux.dev>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------XVYSd1G00Q7d0rl9kEo4pZcy--

--------------tWEfSKJRdmtGLwcIaNnNhpfw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajJn3AAKCRCGXBN6rc5S
1n9AAP9BIM7s05pk3i6+4MllnOO0QTEqYjoecioUKF0ZmLq1KgD/aE3egAllgoSq
jLfLRz8KrH5YC0vg+GWDmTfCQokaEwY=
=xhq6
-----END PGP SIGNATURE-----

--------------tWEfSKJRdmtGLwcIaNnNhpfw--

