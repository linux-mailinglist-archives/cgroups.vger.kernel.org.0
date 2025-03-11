Return-Path: <cgroups+bounces-6974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A2A5C2FC
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D4A3B1860
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2906C1D5150;
	Tue, 11 Mar 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZIlKNz/A"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5217A2E2
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700971; cv=none; b=lCUWrG1cMXh/MwP2sfxNbadgwiVco1iNY2WiEGGdbI0oeVHhnQnir1zGC5m5Y+dX6qZZTwHZZyTGDA8ThDBmtFr5lSwC+6GjZDL7i62J3DZ+94SMDpPMqYnHgB34SpihQo4zp3hhC6QWqZcr6PEjeuUcn9uH9gf2crCPHR83Yks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700971; c=relaxed/simple;
	bh=RpJxqB/c9WlwSsJ3kc9FCZvjBh8kGAK1R1+AogqQdEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzIEm77wUs72yhpXrCrl2beZGMNmD9Sdgliue619pR5/a+KaAzGbi3IYXIP4Di2T3BxmkXoIEg63VzMF4Yv+L1YcCnnEHyE4hubaUAJ5B9oaP/9hTstTwlwxVmel9fNZpk6tg1FBZ2M20gNHFI9e4wg8w9YWn046st0EAs7L79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZIlKNz/A; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so19819085e9.1
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741700968; x=1742305768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqB/iF+dei4y3VWYyAk1QsAKHD9oZbrYePOTdReSlBs=;
        b=ZIlKNz/AANlWu1zcQYMeEfLvex4jQF9sCMdTWEPjA99X9S2Dg2gBohYaVEiWyaHC8p
         3+Nct091ySZ09NS8Beawcn5I7QNzTPVos7yDQiDiXbJa0ubpdzQCEUQnoOHC5gdFfvWN
         WGinFs9KQ8L7g114LQSt+KLRQorUG4zM36RuNNlXVinddfKxMdevK3gmtUw4kqMb1v1e
         9Xsauo4jCcOh9ptRZXA5KnsUObCfOIdy02LN37A4dxdprzs9IBEexoQAu8m4vCRV86H2
         BOV7mBnCJM/oPncMvxMNXuSZawwZJNdprru7xCvBTgSNVhCHHWEnPgkDAMncNAkAKpGL
         clNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700968; x=1742305768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqB/iF+dei4y3VWYyAk1QsAKHD9oZbrYePOTdReSlBs=;
        b=Y/wiUdmnFgUg0+bZmw3PfjUsPzOHW/Y1jvh454PzWV1NusMlQpPKnF0HYHjnjHIROz
         8/6WTjGcLtZBOvy5xGURRITVwsuHvIUMiuTZn1y4Ro87Ebztf/mXxqSPr84aAySR+Vmk
         oOZNb6+nxdR6tve0LJVY3t45DjQKA40DWR9+TvBzs1k7HJcUwdsJeAZ4Kq+g4guyxUbL
         Ih2ty9iUQWGbgsZD11DcFXrIwxjPsYoywhmueShWr3DssegU5ryntBA3aFgUPi9OVDB3
         sHIBoMKaGJKsamnuKlLuGJeFl0r+yUT/KiMWy3KyrnotcLPI3SWFmTqsuYuqa08T0B2c
         qeCw==
X-Forwarded-Encrypted: i=1; AJvYcCXmkd1Esh3QqNC8PPNm7ao1KBy7Ucc4jf7H9kK6OPj85HXuvkZ9OCoSoAmlChKvedihNI+NkKrW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4WbpZ0FDRL4+Fp6Pu9EUdv1wzdzRNIcxING/XChSr47rpIuW
	em271pwsS0gczWn7mHYY4eE3lHONr2NSqZUR7SX2VUaYk0xvYItoMLaiS2f2FfQ=
X-Gm-Gg: ASbGncun49oXS4Gj3H5/u2lgK9Wtvud6Y0JDVsJ19eDHXZ+u3iSEwLP3MZWyEjWKL/5
	gyUoKLYT5GlOvdWS3Ycn8w3w/4Dv+cCreW292+iazoGrIcuG9bTwp7FIU3/s+4EiIbQnCcIrhaO
	g4MAiG+9S2mhNI6TcZNA+CFBQMUc3cb96IHVpajd1MPBAC0YCCG5fcZeZ9JJ29KoFheuVnieYo5
	6IFaJ3wJUPEOjXwA9FbWLY0l5ohZ7pIrNsvhiMghL2r22OkqZX4Nwx4VpQBwgCgdE3KMN/h3O26
	6ccwz0i04GlpGG03j3naE//22B6WRJkX9rQ9rM287cx68ok=
X-Google-Smtp-Source: AGHT+IHb+rSRbvUlQBkhWQdq8ou6WdPqG3+rRdmBEuLAz661CxrAjVqbigcZm8EOTGlYJNTw3Y20yw==
X-Received: by 2002:a05:600c:1c1c:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43d054a2461mr25392025e9.18.1741700968169;
        Tue, 11 Mar 2025 06:49:28 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf7c8249bsm73699775e9.7.2025.03.11.06.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:49:27 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:49:25 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, tj@kernel.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <jtqkpzqv4xqy4vajm6fljin6ospot37qg252dfk3yldzq6aubu@icg3ndtg3k7i>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <n4pe2mks7idmyd5rg6o3d6ay75f3pf4bkwv4hcwkpa2jsryk6v@5d5r3wdiddil>
 <Z8X1IfzdjbKEg5OM@google.com>
 <6no5upfirmqnmyfz2vdbcuuxgnrfttvieznj6xjamvtpaz5ysv@swb4vfaqdmbh>
 <9c50b4ac-7c04-45ff-bf42-9630842eec21@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2iwj5eprdbpucc2n"
Content-Disposition: inline
In-Reply-To: <9c50b4ac-7c04-45ff-bf42-9630842eec21@gmail.com>


--2iwj5eprdbpucc2n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
MIME-Version: 1.0

On Mon, Mar 10, 2025 at 10:59:30AM -0700, JP Kobryn <inwardvessel@gmail.com=
> wrote:
> > DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock) =3D
> > 	__RAW_SPIN_LOCK_INITIALIZER(cgroup_rstat_base_cpu_lock);
> >=20
> > (I see other places in kernel that assign into the per-cpu definition
> > but I have no idea whether that does expands and links to what's
> > expected. Neglecting the fact that the lock initializer is apparently
> > not for external use.)
>=20
> I gave this a try. Using lockdep fields to verify, it expanded as
> intended:
> [    1.442498] [ss_rstat_init] cpu:0, lock.magic:dead4ead,
> lock.owner_cpu:-1, lock.owner:ffffffffffffffff
> [    1.443027] [ss_rstat_init] cpu:1, lock.magic:dead4ead,
> lock.owner_cpu:-1, lock.owner:ffffffffffffffff
> ...
>=20
> Unless anyone has objections on using the double under macro, I will use
> this in v3.

Actually, I have the objection (to the underscored macro).
It may be work today but it may break subtly in the future.

Maybe add a separate patch that introduces a proper (non-underscore)
initializer (or percpu wrapped initializer) macro and people Cc'd on
that may evaluate wiseness of that.

Michal

--2iwj5eprdbpucc2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9A/YQAKCRAt3Wney77B
SZCmAQCrGZJINyrqRI+1swFv3OuIJLzuOa6+2ok8ZfMh1ppsugD9EYFPHrhvMxIa
MhkTkgF7mt76n5ysmfBe+t/kdeHEngs=
=GYKH
-----END PGP SIGNATURE-----

--2iwj5eprdbpucc2n--

