Return-Path: <cgroups+bounces-17306-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Op+3KJ8WPmrQ/ggAu9opvQ
	(envelope-from <cgroups+bounces-17306-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 08:05:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A86CA8DE
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 08:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DlqtmkwO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17306-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17306-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7353F301F38C
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB542580CF;
	Fri, 26 Jun 2026 06:05:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B3E1EB1AA;
	Fri, 26 Jun 2026 06:05:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453911; cv=none; b=IkQ8DfKBi83RrRuzUoMnLJEc3OaSKbN9H/hMTyjMKDQdCBLKuOsA6wivmbvRbaZrZnThB976mXQaEhzHy1b6H6D/57OQM8po6s3ydoRS4bFUDPbfEs4iTEvZOt0z5jgweJAnkHPnhUPLyfFyR94hPYCaxbbYzNhB+QuoqHPkVHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453911; c=relaxed/simple;
	bh=S9oL7c3i+gk56KOTzil5DMHlEF4gYOabQZTiWR5RK4M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KJN7VL+N8zP5tq3fIiUS5dGajw4nnxPHFec4/6Zz52ZYNmwcKp2BEPJ/Tb5fKHvx19E4inZGWyB1ICsiPV6KXK5+jkjFbV9BmOM761XfMmKOC5j+W14BDfKHnQqtoGgG6fv2Li9zVQJhGoEABkwcn62Id3RzEgP9iKB74LJ5EIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlqtmkwO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47471F000E9;
	Fri, 26 Jun 2026 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782453909;
	bh=S9oL7c3i+gk56KOTzil5DMHlEF4gYOabQZTiWR5RK4M=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=DlqtmkwOymvSa5ZtNvNfHbECUNFE7rZKzhXuStdjYZwLnFUTSY2M3eKhy4ZtQzyri
	 LZwaAEt+JAkRKwkl4Bnd+/4ByhlVn2eQ26irDRzqRYoKWyEOmG2En6OYMDuSRSYa/D
	 pUV4zyONLqW65JAZDreixRqs/BNWc5qhuUy/CHbWayhycGCaN77lcVM7GAJKHUu8/q
	 wpV1XUCSP0JxWFUJe/yHBXAmgM6T5xTZc/vpUM54JJUZ/zVg5he8bd0nc6pUt6Q6dG
	 SXfhzNN8oGBK2YqiGGS7HDVJrEJcFRycal3pN8pooUnnC5R7nMG7ImePS7JrLGgkbr
	 cgEaFra2NEg/g==
Message-ID: <be9556d1-7eba-4472-a932-bf56db6285e1@kernel.org>
Date: Fri, 26 Jun 2026 15:04:50 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
From: Harry Yoo <harry@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
Content-Language: en-US
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ejXnirQmd0n0E9T07k6SM4Rs"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:ast@kernel.org,m:pfalcato@suse.de,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17306-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0A86CA8DE

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ejXnirQmd0n0E9T07k6SM4Rs
Content-Type: multipart/mixed; boundary="------------xqitAKa4qlewiFSJqUEqWGv3";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <be9556d1-7eba-4472-a932-bf56db6285e1@kernel.org>
Subject: Re: [PATCH RFC 0/4] memcg,slab: kmalloc_nolock() fixes
References: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>
In-Reply-To: <20260624-kmalloc-nolock-fixes-v1-0-fdf4d17351dd@kernel.org>

--------------xqitAKa4qlewiFSJqUEqWGv3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/24/26 10:11 PM, Harry Yoo (Oracle) wrote:
> Apologies for posting another series during the merge window.
> But these are bug fixes and there are other features that need to be
> rebased on top, so...

Okay, given that this needs a bit of discussion with the memcg folks and
this has been there for a year and nobody noticed, I'd suggest we be bit
less hurried and not delay other new features going on because of this.

But I still think they should eventually be fixed.

--=20
Cheers,
Harry / Hyeonggon

--------------xqitAKa4qlewiFSJqUEqWGv3--

--------------ejXnirQmd0n0E9T07k6SM4Rs
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCaj4WggAKCRCGXBN6rc5S
1gJoAQCU62++/Xsx2zl/wm3/4ApCCo8iBQMYmBrJ4FIbh3ZIfwEA8BrSGtpSXrbl
07eyqHG4yRJBsXB/Xo0SQu5z9kQcFgI=
=TLzD
-----END PGP SIGNATURE-----

--------------ejXnirQmd0n0E9T07k6SM4Rs--

