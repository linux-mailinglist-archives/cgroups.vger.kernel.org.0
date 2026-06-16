Return-Path: <cgroups+bounces-16995-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lTCqIdT9MGqiaAUAu9opvQ
	(envelope-from <cgroups+bounces-16995-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 09:40:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C068CE43
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 09:40:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WVuT1eoO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16995-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16995-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFE80301F986
	for <lists+cgroups@lfdr.de>; Tue, 16 Jun 2026 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AF409608;
	Tue, 16 Jun 2026 07:37:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126F30D3FA;
	Tue, 16 Jun 2026 07:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595421; cv=none; b=gKCCkKfURiHIr00qVc4CuEzvJ2P3i/xdAsNgmYbpJlSIDZIdFvVm5QUoprOT2wEibA2bGT6gAPJpk8S+jXEHDPJ3vP2jGLqhXdirtZ0sK7uazfAqvOJuM/aZjbhRoWuv5I/whMUCCnTkuMxFiqy31H4OkQ6AN8ijuuXmoxuy0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595421; c=relaxed/simple;
	bh=C0SQXZXcDK37wkHElxqiRp0RIECcOs5tuub8eZyEmJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F73E3cb8DLmTIOJp7Z+ZhGEXu5GhG46vVvuhPFS8hRHLehJMrtoFyovYb+Q7Wdp+QVoA4MQ0L7KmDlfWE6Hkyv6tJzVEqFrOygwpapoc1l0PvBaxG5OTxCpRR41mu1XhHSGWTOaaSXFAwYq/QyEJExZaFqt5EK3gQVuGoqaeHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVuT1eoO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5444F1F000E9;
	Tue, 16 Jun 2026 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781595420;
	bh=5Zuvpy/om7dvDoo0bahuFE1gIzJ3xVFBIKDkOPcndWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WVuT1eoOY8TWzkywZHqQyFYaW5P3K31o1i1TgmDQ7B7poDBJrGLNtZoA4HLoVJHXB
	 BeotV6NhvZOZnlmLRktEz+gAmzKry1Y+KwFLpzOTiqUx0rhc/jqypJLYq4upmu5vLs
	 +Y8VwPCYDSgHd2FBh42LzJV6zH0vuRo/DP7bzXlUR8OrjNhZLZdK8Ba1CN/BtCCUM3
	 n/DDljxzH6+JlJMB2B1h6bb+AlwWfgqqC2/prIWG8kFEp322QJiYJTODdhUvV2d91J
	 80okA7PtATHRAxvCaNUP6gT4pv98SU9xza0S19A76Av4r00d1xhHvBrP0HMi20YhUJ
	 oVC4UUnv/PIxg==
Message-ID: <e9beb94a-6508-4bd0-b641-41e718990f7b@kernel.org>
Date: Tue, 16 Jun 2026 16:36:55 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/15] mm/slab: pass alloc_flags through
 slab_post_alloc_hook() chain
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
 <20260615-slab_alloc_flags-v3-8-ce1146d140fb@kernel.org>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-8-ce1146d140fb@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EkvyZtXuR3d9K5ob5n80abvz"
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
	TAGGED_FROM(0.00)[bounces-16995-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D89C068CE43

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EkvyZtXuR3d9K5ob5n80abvz
Content-Type: multipart/mixed; boundary="------------stFMe09eLufvGCHekZ4jWmS0";
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
Message-ID: <e9beb94a-6508-4bd0-b641-41e718990f7b@kernel.org>
Subject: Re: [PATCH v3 08/15] mm/slab: pass alloc_flags through
 slab_post_alloc_hook() chain
References: <20260615-slab_alloc_flags-v3-0-ce1146d140fb@kernel.org>
 <20260615-slab_alloc_flags-v3-8-ce1146d140fb@kernel.org>
In-Reply-To: <20260615-slab_alloc_flags-v3-8-ce1146d140fb@kernel.org>

--------------stFMe09eLufvGCHekZ4jWmS0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/15/26 8:54 PM, Vlastimil Babka (SUSE) wrote:
> Convert the whole following call stack to pass either slab_alloc_contex=
t
> (thus including alloc_flags) or just alloc_flags as necessary:
>=20
> slab_post_alloc_hook()
>   alloc_tagging_slab_alloc_hook()
>     __alloc_tagging_slab_alloc_hook()
>       prepare_slab_obj_exts_hook()
>         alloc_slab_obj_exts()
>   memcg_slab_post_alloc_hook()
>     __memcg_slab_post_alloc_hook()
>       alloc_slab_obj_exts()
>=20
> Converting all these at once avoids unnecessary churn and is mostly
> mechanical.
>=20
> This ultimately allows to decide if spinning is allowed using
> alloc_flags in alloc_slab_obj_exts(), as well as slab_post_alloc_hook()=
=2E
> Aside from alloc_from_pcs_bulk() (to be handled next) there is nothing
> else in slab itself relying on gfpflags_allow_spinning() which can
> be false even if not called from kmalloc_nolock().
>=20
> A followup change will also use the alloc_flags availability in the cal=
l
> stack above to remove the __GFP_NO_OBJ_EXT flag.
>=20
> For alloc_slab_obj_exts(), also replace the suboptimal "bool new_slab"
> parameter with a SLAB_ALLOC_NEW_SLAB flag with identical functionality.=

>=20
> To further reduce the number of parameters of slab_post_alloc_hook(),
> also make 'struct list_lru *lru' (which is NULL for most callers) a new=

> field of slab_alloc_context.
>=20
> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-9-7190909db=
118@kernel.org
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

--=20
Cheers,
Harry / Hyeonggon

--------------stFMe09eLufvGCHekZ4jWmS0--

--------------EkvyZtXuR3d9K5ob5n80abvz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCajD9GAAKCRCGXBN6rc5S
1swRAQC5Heey0qs5T5oZbvAP8kXpLeXbOKeSkTmZwj4iV8q5MgD/a/a6PMtHlo/f
Ji3GIS4uuYi9wu5M9w3uDj6nDa5b/Qg=
=E0J3
-----END PGP SIGNATURE-----

--------------EkvyZtXuR3d9K5ob5n80abvz--

