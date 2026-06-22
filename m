Return-Path: <cgroups+bounces-17147-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xc0BNXNiOWqTrQcAu9opvQ
	(envelope-from <cgroups+bounces-17147-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 18:27:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3B6B1202
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 18:27:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=ZtAuhLkc;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17147-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17147-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D497E302F0DF
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F733121C;
	Mon, 22 Jun 2026 16:25:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDE2F5485
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 16:25:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145508; cv=none; b=JEfYeNITDnB496qvW57E1J8bqNb0J4oXSUn1OgUMD7S4qBqChHgMEmEkoVjdNYgpBx7RvxxDMlUrn9p2bDdA78hi4njqMPPHWjfIBjgOskWptnYzWLqCGfLJ7f5Eb48Eqjti/FP9jxTCP5sENhymJb1etw0vI4eD0vTQWVE4L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145508; c=relaxed/simple;
	bh=Pqc4jM+GBUi93/Y6w+cgK7Vc7OZCkjCZX3cJzwQfJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFB5MxljKXGc2VVbBhtNS9y1b4DHTF7gx/1icPVp2rtTwKH0J2Rwn28zlThCtoRNlLvMW2ckEHEdZTspja71id4YMWZU2/BGE9EtYI9hozD038RuYv2Kh2+FwTG9meFEN9EnbNNW9/FffzHWeCvCUEnh4k/CBjbvT47InDVlRlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZtAuhLkc; arc=none smtp.client-ip=209.85.221.49
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-462cdb88d01so38361f8f.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782145505; x=1782750305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMLIt0eZRojMqZhfsI3oKKF+5t4VTIJSxwMeV7ztxpE=;
        b=ZtAuhLkclasew6/nGBdlwpjGegdiG3NWkBWGE8/UcFAe88OA1z+mm535DkIHYi1bYW
         KKLCrIb8Ww6bhX6zotfQ3fSu8h9tGyOyJLj93M4iwVhw+m+64cq5tUAZDx43TszU4vPd
         nASQwmQ3iS+JakzbAm0w71Wb9sgPsbxNRwp7CaVpxA2DU2jSM0+nItjkaduMNcoiCOJS
         8e/HyFNkHb/lQw39UeuR1C6k6Tor2c/O1NgHhFdC6AkgfsL5s1XLugUGl+JDHiM51zw9
         Llp/5yHSeloBK1mOk0QEzUrgtvJs9neKOmDmnVKgkDlmohNKVTuiBT9y2s/SlnX+sW/i
         s1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782145505; x=1782750305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMLIt0eZRojMqZhfsI3oKKF+5t4VTIJSxwMeV7ztxpE=;
        b=lZH14bZfIcS6vcRbS3Y/ujLTL9CKCGIXrk7yZQXlw11I2ftVQBdszYWONsiOtSig46
         PWFoh7nwjCvhhszQVYYTZxx60ZZSmqX5XfRq4FjWmUIdWq/5qoQhU3Zl0VTwt2Z+9FBw
         tCyjR1jK/DbDYRar+FKu4gznZhTAk5aShuthxXhQBbGAGszMc5qXTeQQD2hRIgKse1UG
         UBN5Khrs2QZM9hr4TWkkYEma2+bhcMR3gQ321STFt/OBCDtQNT6gjfqFUAXLz8BtsOVc
         Trlb6EyiYQU7GHOXxSysxqluEUFEHjsXB6hxlRUefmZuRK6Sk2f+/43nIRBwkFteG6FQ
         0ypA==
X-Forwarded-Encrypted: i=1; AHgh+RpuqLee6cgUYSKk1Y9FrFxEg0FcccjKvLOjqKlkGLJPo2/0zwPnRCllgYP2pbXA4Eh3mNDd9rqR@vger.kernel.org
X-Gm-Message-State: AOJu0YwRYWrsRJ2q2WlmvRuYxpDNu38Q9Moy15W2416dUYPOLWcsvvm5
	09bSKusDwhOCYnSQd1GQb1kXa/Sycg+JSU4yF0QTiZDGY/4dFsbrOPrAhapiR7mch9Q=
X-Gm-Gg: AfdE7ckZhb5MbJ8KcAXYXV22KKcO3IA4mQqAqfKNy2ZM6Ijy8MbS5JkpsyMeaXzjOuD
	wjbgh8y0duAgQJ6KnHNjfj2w/MD5TyaKagCxhkhVhGkeAgCA2WY9o5dihOuR3XsifLHYK+hSuOF
	xMHDpOr8yo38mMHzR3Q4HDtfcVAJG0zmGBR62XABIVxbRms6sTjcHhC5WE9luWbwf94IrF9XQlh
	VccP2LlW565+rw05iBtJngZJ2LnfcvHpFnggWzk0cAewcawC6NjnRclsk3yPXG3ioRXUHVG3xNv
	sz0Rb2XZFrEXPTn3wTdmG1O9NpS+Q83lQnGArK95xwJIascvvmJel01pLPnM4QUwrtktVd3nBGJ
	TVUAeyXiIuGipJnPrx3Six8qKEhwRHtTOBpQqcIUUXlrRUdDEJEKICcmkDuRhMzqGAy6jMQ2B+i
	ivis7ahrrh3Xx975BzWnPTlE8O/8Dh
X-Received: by 2002:a05:6000:1888:b0:460:21e7:330e with SMTP id ffacd0b85a97d-46a7efb72e0mr336250f8f.10.1782145504382;
        Mon, 22 Jun 2026 09:25:04 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5413sm28550880f8f.11.2026.06.22.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:25:03 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:25:01 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Doehyun Baek <doehyunbaek@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosry@kernel.org>, Nhat Pham <nphamcs@gmail.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
Message-ID: <ajlgcMFJ_Df2s93d@localhost.localdomain>
References: <20260620122751.388770-1-doehyunbaek@gmail.com>
 <ajlLhFnMZGoVxLE6@localhost.localdomain>
 <CAN-j9Upy=thswORWaU+QxuO2i8uJKrZxcLpt5umP5QGRhpwqaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fksukxp23q6rzf56"
Content-Disposition: inline
In-Reply-To: <CAN-j9Upy=thswORWaU+QxuO2i8uJKrZxcLpt5umP5QGRhpwqaQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17147-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,localhost.localdomain:mid,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BD3B6B1202


--fksukxp23q6rzf56
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Docs/admin-guide/cgroup-v2: fix memory.stat doc details
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 05:26:53PM +0200, Doehyun Baek <doehyunbaek@gmail.c=
om> wrote:
> However, both zswapped and zswap_incomp are memory_stats[] entries, so
> memory.stat prints them through memcg_page_state_output(). Since
> MEMCG_ZSWAP_INCOMP is not special-cased as a raw count, the stored page
> count is multiplied by the default PAGE_SIZE unit and exported as bytes.
>=20
>     unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int i=
tem)
>     {
>         return memcg_page_state(memcg, item) *
>         memcg_page_state_output_unit(item);
>     }

Ah, I messed up how memcg_page_state_output_unit() is used. The printed
values are amounts (in bytes).

> Separately, this matches the existing documentation style for zswapped,
> whose exported value is described as a memory amount:
>=20
>     zswapped
>         Amount of application memory swapped out to zswap.
>=20
> Since zswap_incomp follows the same memory.stat output path, I think its
> documentation should describe the exported value as a memory amount too.
>=20
> I also boot-tested this in QEMU with the current tree and zswap enabled.
> With incompressible pages pushed into zswap, memory.stat showed:
>=20
>     zswap 87822336
>     zswapped 87822336
>     zswap_incomp 87822336

Thanks for the test and for the fix!

>=20
> The zswap_incomp value there is byte-valued; it is not a plain page
> count. It also matches zswapped in this all-incompressible case, which
> is consistent with both being exported as memory amounts.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--fksukxp23q6rzf56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajlh2RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjefwD+NV/VDPrTB56lm0tTV9Bx
3LNony3pBqJ3qGqO0IvMxvAA/AjgY0KM15uzvd2GJiB21yMY0AXrJOboe9eQq9sh
BpQM
=ybGu
-----END PGP SIGNATURE-----

--fksukxp23q6rzf56--

