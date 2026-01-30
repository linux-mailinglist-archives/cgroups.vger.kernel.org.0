Return-Path: <cgroups+bounces-13544-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAdpBICGfGmbNgIAu9opvQ
	(envelope-from <cgroups+bounces-13544-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 11:22:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B4B94EC
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84317302AE0E
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299A35E544;
	Fri, 30 Jan 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gr4vNUXs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D40135CB92
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768544; cv=none; b=twstbbOrDddyDYrrUCS6H0kyLx4ruJApwNKhLsA4UUPjVWvmQ1Bwl4T3ojyVM0yg0jOAUZPlpn8lMoPh/+tU9R7N9ihIwnyaDttA8BXg/BE6B+Q2Yv+Q2Pqzhrew4hMVEJfF8kq6bqucu+TxntBm5gjIC8z7ALtQpyiM3y51oZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768544; c=relaxed/simple;
	bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5IKKc4GPb3qBYZ3s6O3JE22QzQHOY0a+nk/IdeCa/Taq715qJhlP/mvfpkjsG46MPirBvJPp2mxKV5AJ5guP+TjF11T6SbpjAKqv18YuvAX6z4AQ0OZCtNDyY6xXjTRCtw5lOyA5HM86pY7mOidb+pVUhToUrOnXe5FrsMKI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gr4vNUXs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1893720f8f.1
        for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769768541; x=1770373341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
        b=Gr4vNUXsb+lf9QOsJ/Jmn80Hn5LmaoTN4KXvT/eB6ITDJP9Cyl10UhjEBzpLlviyPN
         FVp1RfJrue+IQrZBzw5uHmcXSopGtOqTyr3qyGJYOFAZlwL5etPl9Ck0rID4s8nk1YYf
         /nxVD385g3RGfbDRyPIaH35cXtQyEM1o8TfFTWS3qqjHS7v54+Mh2d1Sr9Hb5x+me5KC
         QgCQlljImlhPGjXJ4vV2sZVHpTJqE44QFQLAZshjYx915X3Hm96avnlH2KfCuM3wnwkf
         dXr+U90HHDJnKA4rHxFmMAdwicM+H1UKf23HsiD+6ZrxCVSdfSv1KXz2sySuFrYgdmwa
         xgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769768541; x=1770373341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C6M3tSHSfSWufF6RUJ85n9Nm2/4nxP6ALy7z2Z7v60=;
        b=SlT+XoUTmaen75rjPjF+BR8SZrgR+91SOp5m3vLemNmCuH2VPzfyCLniWrQqhl/pPP
         pS0icDxBdSa4JzrFV7VSu9LFiQOqlFqrzT+tDZG/z05uRHu5z3dRzYLv4UZSKwOSmSCf
         /x7A4zMOkkBsZKQE1yIDa5rcrQYqVZPDFjHdcauFFNS7ab3oajBZ5rIrAlSoUYI1qSSW
         0XCFCqU0KlD2iHpf9Q0SXvpnOzZUx1lAb8JO2Lj7ehg0m/nmxAWMANCRO7CIjIUtrnc0
         vPl7suRLnKEV5nBg5YFiN6CzNyERtK2shj4TuyP60mCH1O2Mcd72jrwU5JVySNgL6sNk
         fvHg==
X-Forwarded-Encrypted: i=1; AJvYcCWNEBnr1Dp+Ngk+0ctqbE5iSNy7PM4mcUjqX8mHcrysTSiPC0gu90+3i7ygdjlr5kiFRKR4FLm2@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyQPAwHK3491mohZwfhThPSAMKJVZo1/JNBM22fPuRZXMf0eK
	/fbo1wPFaQv/Ok9Rcx6qH/2SSEb0P1HPpdVUOzdqx6AFGlkXMQAtYW20ieUcNSd54C12yjKSI3X
	HCPPB
X-Gm-Gg: AZuq6aKjPbMvztq5PMar21TDRjAG/PzWBm3KafhsVEO90Ih3AEaEFAaaqs8Eg3WfIda
	PQf4PJENzRbS0MKBMLzE8UTOlj5cwFlzFZLidWUPKsZUEnDIdd7wtJLIqeuuGwTce0ySQqFACl8
	/afAYuuGCVr7f+T0n+M2kf7WfI78+tY3odeEQkFB0OFW4zhc9OYrUJ5fd4LxrRrK66EeNW1sD1a
	pZ50EVLNu7zcoSa7pLO70hx8rUpXYeYSgrWJtdVpog8R+KFijt5VWBHfrGX/SYbpNNOcanMMwVq
	b6V3TVOfz7T7FwBHEMrhfJR48/AugtmU58BlL1dNeRLtIU5/ohmmdqPBW0WPZnI4cZQbtxN5P6/
	geC0b/BUoJn0mjYIeS1KQgel84hutCAX6I1tEVBco++hnYo05T3FQUlvLjEoRP4JWowRtsdWi1+
	YjHo4wTUfUJQ4c4Ff5wX8R/9L9wATfeAo=
X-Received: by 2002:a05:6000:2305:b0:432:da3b:5949 with SMTP id ffacd0b85a97d-435f3a72ae9mr3679398f8f.21.1769768540911;
        Fri, 30 Jan 2026 02:22:20 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1354d43sm22606824f8f.43.2026.01.30.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 02:22:20 -0800 (PST)
Date: Fri, 30 Jan 2026 11:22:18 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
Message-ID: <stsf73lnkx2luuak3a7oi3q4l5axosrxogi2lncw4dkndnc2ge@3tioqa6ww5q7>
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zispwon7xf4glpk3"
Content-Disposition: inline
In-Reply-To: <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13544-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 843B4B94EC
X-Rspamd-Action: no action


--zispwon7xf4glpk3
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16
 to 32
MIME-Version: 1.0

On Thu, Jan 29, 2026 at 05:51:33PM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> We compiled with 'make allmodconfig'.

A-ha.

> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly.

Good.

> Can I propose increasing the maximum number now? If we switch certain con=
figs to
> default N and then a new subsystem is added later, the default configurat=
ion may
> work fine, but it will become a problem under allmodconfig =E2=80=94 whic=
h some users
> actually rely on.
>=20
> Besides, this shouldn't be a major change, right?

I'd like there to be gradual move away from legacy controllers code
captured in config defaults.
Could you adjust the commit message to stress out the allmodconfig tests?

The change is OK technically.

Thanks,
Michal

--zispwon7xf4glpk3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaXyGSxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ai/3gD+Pqinek9yDHfUrKo9Kffa
e6XIsBNZyHtXPceaa55CI3gA/0dRtNVhHx0+A1IfBm3aDf/gT/fX1P09yTJj8Mt/
8Y4E
=Tf8X
-----END PGP SIGNATURE-----

--zispwon7xf4glpk3--

