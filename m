Return-Path: <cgroups+bounces-9973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3EB524B8
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 01:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F6257B646E
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 23:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770D63064BA;
	Wed, 10 Sep 2025 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCvxi0ew"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3D7282F5;
	Wed, 10 Sep 2025 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547297; cv=none; b=jSaBsRCHUjErcQiRU+5ysc/UzsYloLfRE2V7N5L1DtkJXOA6y9/XB4b1yjTbs6Hwj/mVC3YCqmfOyjKYQgOEs7HaQhM/ETjTO/Qn27zI5bT7+qYXTsz9CRcQKZ972WtTzAlk5yRc7nRv5W6S7DvsRkrF9zpA1IlraXBWNP8Bfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547297; c=relaxed/simple;
	bh=eFxtgKR83MrEuA47DhOIbgBHX+KlIG8hTh2LQqjlSlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Cl6/gJn7GX2K6FItdRTFi11782mJRp0XYozsKzOc+SQ62aWseErmsetoDlbTkeMEe6Ag6qYVj8cPqnnNZvsHWHpdHlhjEqvS7Hj8liGQxOpFEsKttoQ3SJwoe1uL9J1eB0XsMkve7jrd0AVOq5cZm7t/61bm9NLv1UqxeWKJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCvxi0ew; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so106858b3a.3;
        Wed, 10 Sep 2025 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757547295; x=1758152095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L83OmJnlnRObHJm5rh4huVP1DHkzrTe/WeiSjIPyfoA=;
        b=WCvxi0ewQ5jGvLscjsSIrpcFXNf+qQ4Yrb+I392bsFYb6XuTXElFNSO1tJEPurxHqj
         mezu0Ck1L4Jkqj7f8ake1ESYhiUE8PAPTPzb+Zie5+PCSCJ4EBia8HkqjjWmrEKd+7Hp
         mEb7T7cJGrmhK7ivsnZ1hWsb7p/lg+Rj7VI6zQ5JXHsNxOS+Jj2L9K+9KPPak6hbIFt0
         NcSwBrlsP8VsK8YJ2/9q/7590NK6l6vk6z284C0ZTvA99i0uLuGUR3ezZtD1PyNlMCkM
         8h2Zfv0XbVS+ZezEaDPzcECQFfJX55p6P6TYeZgNNM8lZGgYVLtVpfLrt+gSWmV6eYWN
         UYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757547295; x=1758152095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L83OmJnlnRObHJm5rh4huVP1DHkzrTe/WeiSjIPyfoA=;
        b=aCshBl0DUNFVjgO6ffzmjgXcHkCLpYocT26YKXgKxNJTqPPH4nHRdBFvw+NneE1h31
         a0K9RVlCUCtIOXS4PrezjbEyn3/f+A+1aFezqsNly+16j/bes+IZcqizkgkg+JS2xz9e
         bJ5yoP04cIEdOfGPKKmEFKd+zpuR21XtoBLuEaPTUOfCW26/nJrvD5+6rP0SmGSeb8Qi
         aw2ZvTSXwdLIhrUsULOWmVqiTto1mJSsJfOzziCXM9pcK5jZ0VYD0i4/FNT7Lsw5SWLb
         4keWovGrDqtSTkSbpOxJbf5hH2XxaROQqJniEDOyOosfwYe+1l6JvPx+5+H2FH2G5ebO
         c+FA==
X-Forwarded-Encrypted: i=1; AJvYcCUbc84hLGz4mVuc6CqPHvre6k6KEzGZ8KJiZHq9P+NjHB+MyUUNlespTwWhO8tRFWoyykhFcX+fK3Kj@vger.kernel.org, AJvYcCUmxbVfeqQ4BdevFhFYBwvO+pFFgKuJ36LGHu4rdUm8x/uNsobEZGNEwnPvvaDugvl/D61HQQxX@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjlZJX692rc+jcBY2cvow9AlA4v14VZjVX+74S0yfWgTRSR39
	KEIJDpkfucNadBXAGqv1Lim0mO+JkBQLECqoKbIUKExHL+NS7jdeQyiq
X-Gm-Gg: ASbGncsXSSF3kaCshVswrtREp8opDfvgoGSA4j0lBXacOSBs+eP1m6tloMUbn/N2YY0
	d7YosFhN+fCw53GUmCbOBiBgnqtw2bux+X/DXHPs0cHcH5q5la1/pvkgBlnYo/TFiU0xz+yR/rX
	0KEHwACdbQd4HQEsiJ9IHNN4vIhziP5pMptZNz4Dtnj57GwWwvQZ0xrZZws08ZxpCGDJ5gMwLaC
	1IRUbwDccCNLQrT1/htqR0lVncFpKhT/U0XAOtti98nf6WHVyTnFKTwOnTmjGCOxHRXvosoHh2L
	ficCZXE91VKA1pT7Dod8IPZUxNLINT5ZisVow8oSUZRqee79U/hHtX7srfcsdQaSG2V4z9HLP/5
	+SvILrws3A2vo319pJ7LpgA+V9Q==
X-Google-Smtp-Source: AGHT+IH1VBXQZF9Pbgh0Y0oOXEX86Q5eTMHk/H1cMk3qgJg7DkCYSDiwZfGuYRp99w8BfskwDEDxAQ==
X-Received: by 2002:a17:902:e551:b0:24d:cd5a:5e88 with SMTP id d9443c01a7336-2516da07750mr226912245ad.2.1757547295042;
        Wed, 10 Sep 2025 16:34:55 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff5a7sm39108455ad.121.2025.09.10.16.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 16:34:54 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0283241FA3A1; Thu, 11 Sep 2025 06:34:50 +0700 (WIB)
Date: Thu, 11 Sep 2025 06:34:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <aMILGtrAHb3dKVq7@archie.me>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
 <6geggl3iu2hffdop43rtd6yp2ivd26ytfn4xdclurwce6mapal@4ve46y652dbj>
 <875xdqtp7m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UsU7vGubNiLv2087"
Content-Disposition: inline
In-Reply-To: <875xdqtp7m.fsf@trenco.lwn.net>


--UsU7vGubNiLv2087
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 07:24:45AM -0600, Jonathan Corbet wrote:
> Michal Koutn=C3=BD <mkoutny@suse.com> writes:
>=20
> > On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gma=
il.com> wrote:
> >> manually-arranged table of contents (as reST comments) gets out-of-sync
> >> with actual toctree as not all of these are added to it.
> >
> > Is this true? I generated HTML with this patch and the resulting ToC
> > matches what's in the comment.
> >
> >> Replace it with automatically-generated table of contents via contents=
::
> >> directive.
> >
> > Mauro, what's the best practice wrt consistent ToC and having it in
> > plaintext form?
>=20
> I fairly routinely get patches fixing manual TOCs that are not updated
> to match changes elsewhere.  We have a nice system that can manage the
> TOC automatically for us, it seems best to me to use it.
>=20
> That said, if having the TOC in the plain-text version of the document
> is deemed to be important, then it needs to be kept and manually
> maintained.

So for the v2, should I fix up the manual toctree to match autogenerated
one?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--UsU7vGubNiLv2087
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMILGgAKCRD2uYlJVVFO
oy3PAP4yTquF7DXoT96XrGn5T6IGDvwCzQg3+0dEjrX0lyLC7QEAzwEi6CO3ZnGr
3wkojXo+RTN8o3V0Y1letnvGzguC1A0=
=4FUJ
-----END PGP SIGNATURE-----

--UsU7vGubNiLv2087--

