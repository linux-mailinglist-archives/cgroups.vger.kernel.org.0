Return-Path: <cgroups+bounces-17143-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6BZ4H51POWq9qQcAu9opvQ
	(envelope-from <cgroups+bounces-17143-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:07:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E46B0988
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 17:07:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=E7bLp4bh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17143-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17143-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F1123053D3A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068EC311977;
	Mon, 22 Jun 2026 14:59:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAA8310784
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 14:59:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140394; cv=none; b=u/xZEYk6fK6WETYmnmqOF1A/wNfTq1mFwaG57yxg/ltuKIRDrfsTStTbL8BLNkofSopdgXbDn7h02Vab25pwhYNfCsx/8AWyOBIoRl6RUQUSE0Nf5jY0fgo3VB9fglgPli1XQUB2uTG8Diy/NuGSzah+X98U9zcXeWV8QD568nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140394; c=relaxed/simple;
	bh=ldiV49nTOJakUd/lq40ATV26AvsFUe7adDKrFWuU5M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwe7POSn2BYb2hdUSgI0jLRKAV48N2J3tLsIdzDJmROhm0nLvb2YCGYxX0I9c1H89x3wJwK9PQaINIyTK7L8Kw0/OulvnTLTJHi+F6cvT7OBjiely08VAp42srU2hLg/KYMEWY+O8gLh8pmrj5vbrGeX8in2IlYPhqDlc96tfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E7bLp4bh; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so3550291f8f.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 07:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782140392; x=1782745192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zcPZNhFDsA2OPbjtRR+Ls4WcplfDzhOVh4J1exTT4U=;
        b=E7bLp4bhGmN6vmCqkqW5VNKX0LKY+J8VKXVqXJDK60dGDbt2sKYKzEwfeyv4F/Iyr1
         Kg0TjpSYOrKAnJakkdnQ1QctDCDhSHYBegysIg+lbtn/pJFNKie15+WfGkXndCYOzFif
         j2w4NDGyN0iKUgcGjKmPkgQRCgIhg4KDocbb3Cs3h8a5aWPqUZwYSBG/T3nobVt872Xi
         3z9KKGt6LGBtISRpy9Z9Bk2/Y4vaObV2lPnx6/q71QSYwz0jyApCKTODbDzU4bpOaBpe
         vJWSxKXzLmi3PG17Nkl8+6NfiQD3dwt75xESJwwu3+C19cUk9Ae7Pm5zTxrj/acE0aiD
         T+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140392; x=1782745192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zcPZNhFDsA2OPbjtRR+Ls4WcplfDzhOVh4J1exTT4U=;
        b=WtoENgOPmuWqFS8oo4t4KPbywpIyZeZVeJTt73e37PoqreLJU2qFN/FxlfoG9k6xoJ
         akwV1Nn6Oy+6Qg8J2grICrZPN/tq6QNbEceUMJM5aZemlUVwabkiQxPlVknbvj0xjJ8n
         ZJ0Ie/LvP5arzqi+qD6/81yJdv42UWjOG3Imt799Q8YvUyOpePCu6w9QNncBz7AbZr19
         ivn2KsaOt6ga1+XYhDdMFQbqgOcJoEUnm61c0JyL47bLm2dZjMx/hkHaTyXwZrh5Tt07
         ilYZINOHY9aj6peDV/B0UidnnbTo2O49GYcAyfMFQg3P4fIa+n5CRs595Mh7tQprsTpp
         8PGg==
X-Forwarded-Encrypted: i=1; AFNElJ83Ga9HOCkHCuFan7PmS+2YShrgJJVXsFXwUNkKAkmcNubKRr+h1GQaMuCuUGvWzPe6IDZAet1l@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6o31qwh7FOOcGJi0IlxXSN6LsjI5mrbPlt1BahEo02rYt3hM
	wjGFC6ETcsn96ERzY1a5wxVUXySaPr7xyf+7DwzJt6BxuH4VhYOFa72Xu02ezxf43ck=
X-Gm-Gg: AfdE7cnEmk/GVG/8egZQ1Bv5o0R+PRqwu07Vfpy/PXVlVncs77EPS7tHOvL9NuCUCfk
	7VBxMUn14aQ2u/kvKNB9TkTFTqF2g9AzyNl5iVf36F1gqOG4pA3QdAFyREgiKJdcnXif53HWkCG
	q1zJ6jkNO5KlIoM1Xn3vdbVwOrlQoDCZAsr6SN1Krkpzs4fPt+pQ8nIxwVlC6J6EIRbzWvTxCQC
	1IqXBFfmtJuMCnACL6XxqPfiQA846gRkAB6dFThrdsq4d9+UW15QUfxvw4x1RnqVflYx++WbzWt
	d7o6DfhiBZlkLhxeejlWgBxm+wQc8aiItevBuEAC2Xa5RV3Vjjre2fW4UNm44qdHLLUQRGhTrJ2
	nBLdoKRidExYSecp27lNGK2uoCvnThc1psSmMM6m8yeVANt935WVTU8+EsT0D0tTm92FiqskJaT
	WoPPzUr5RSjI4N1N44LiumNa6DjwP0
X-Received: by 2002:a05:600c:3496:b0:492:415c:8ac2 with SMTP id 5b1f17b1804b1-492415c961fmr246774685e9.36.1782140391947;
        Mon, 22 Jun 2026 07:59:51 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4924944fb71sm205787465e9.14.2026.06.22.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:59:51 -0700 (PDT)
Date: Mon, 22 Jun 2026 16:59:49 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
Message-ID: <ajlLhFnMZGoVxLE6@localhost.localdomain>
References: <20260620122751.388770-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7z2vuj6kqtgqe2kl"
Content-Disposition: inline
In-Reply-To: <20260620122751.388770-1-doehyunbaek@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17143-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:doehyunbaek@gmail.com,m:tj@kernel.org,m:corbet@lwn.net,m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:yosry@kernel.org,m:nphamcs@gmail.com,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,cmpxchg.org,linux-foundation.org,linux.dev,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,localhost.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A25E46B0988


--7z2vuj6kqtgqe2kl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
MIME-Version: 1.0

On Sat, Jun 20, 2026 at 12:27:51PM +0000, Doehyun Baek <doehyunbaek@gmail.c=
om> wrote:
> Fix minor cgroup v2 memory.stat documentation issues.  Correct the
> vmalloc per-node marker now that vmalloc uses the native NR_VMALLOC node
> stat, and document zswap_incomp as a byte-valued memory amount instead
> of as a page counter.
>=20
> Fixes: c466412c73c3 ("mm: memcontrol: switch to native NR_VMALLOC vmstat =
counter")
> Fixes: 5ad41a38c364 ("mm: zswap: add per-memcg stat for incompressible pa=
ges")
> Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 993446ab66d0..ce6741f78f4f 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1570,7 +1570,7 @@ The following nested keys are defined.
>  	  sock (npn)
>  		Amount of memory used in network transmission buffers
> =20
> -	  vmalloc (npn)
> +	  vmalloc
>  		Amount of memory used for vmap backed memory.

The vmalloc change looks OK...

> =20
>  	  shmem
> @@ -1735,7 +1735,7 @@ The following nested keys are defined.
>  		Number of pages written from zswap to swap.
> =20
>  	  zswap_incomp
> -		Number of incompressible pages currently stored in zswap
> +		Amount of memory used by incompressible pages currently stored in zswap
>  		without compression. These pages could not be compressed to
>  		a size smaller than PAGE_SIZE, so they are stored as-is.

=2E..but what do you mean by this?
As I'm looking at the code in obj_cgroup_charge_zswap() and
memcg_page_state_output_unit(), I'd say those are pages and the docs is
thus alright.

Thanks,
Michal

--7z2vuj6kqtgqe2kl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajlN2BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiYqQD/Yrcx9m1Cd6p0RIJlgi6p
Pw+UTZoClU4K345dMUKxS9oA/iffuwIIMbqckL/HpyJUf1dxbIeOVfV/GJ9kehOF
i2kH
=yZlU
-----END PGP SIGNATURE-----

--7z2vuj6kqtgqe2kl--

