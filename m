Return-Path: <cgroups+bounces-8354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC614AC4BEC
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 12:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB24B17ADC9
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9424DD13;
	Tue, 27 May 2025 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZA4B6jv/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADB61D63C0;
	Tue, 27 May 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340279; cv=none; b=l3ehNClpy73cpqsPBOekepuH0gHcOhGitbwxCQEi1MuCQRFKaK/T7tS92Zpksf4uPrVU3WOYZZRrKSxgK6/g77Vw17VX/1oYU8qOOXCrEJJ8PHUIHNKnomHU1+CxVT4DWVEpUdekLiCA5wEgjNU5OKnhhMHxodhcaGNf92sB+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340279; c=relaxed/simple;
	bh=atB4q9mfxkHYBz4CND/eGCnJPFD3h6p5A9WsgN1NOJo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppYI8ydFeceMpeKmKSVqCwt6N995tkm1xhLBlaHLL2hXXl9oGtzu96VKR/KflLXm32dpu8DHXWW15jykwT/aEU1ByIIv6yXrlCjduZa8NvSNuTneqM+N6hu43v1vpbSzlCdtwSlaS3Elz0P1IOxT7hM6NHHq+a7HZeG3xX8KcK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZA4B6jv/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so2411527a91.1;
        Tue, 27 May 2025 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748340277; x=1748945077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7aqc8T49oslh+HPpplQG3216rFUwciiw4eqysXyXUF4=;
        b=ZA4B6jv/eiq4StU6AIyDAzjqZn3REuoZ8P/1+AJzZq3TplLmPJ2HtBQgOophflscjl
         KDaEwQivZnC/l7ep2UgrzQhqR5AS1bV8kOXSSRamsc4PEHVGlcYlcXOhr6gdfRttltti
         eE6ejjvCLngFgu0wuCVcRdh8pFs84jvERKVjU5RuLJ58UIzXzNgT1kju4l1nWni5sQGv
         DxKpg+dMKCfYgUGG4pyTYffW2Ch64WrMyFaXmp3M0Nw8LQe/WAeWPggAgQibJd3d4fQz
         SqVWbvvZwBR/+F/0GBCi3/vBdTW75vTuVDoaWrsuqNEBxOz2G8pY9mEP3urGfgn4yL6v
         op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748340277; x=1748945077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7aqc8T49oslh+HPpplQG3216rFUwciiw4eqysXyXUF4=;
        b=Vw7WHLRrMRjDXcAl+uFH8RKtsdFaMJRKx9T5gjonnKcWgSgrLkViNSpHYmVpT1oNaF
         Xrq1WUZXn/Ww3PJFtI+XGJSI1ekrsUEZg6yQDHDnG+9nUopjve/ttLCianI6JPeyM6Hr
         C9uGeP/u8W54sm7zXRZFJ9SU5/vS4IXwmlB+fK48eUTpgP3ZUILO3I3zYJM4guheTRHK
         xNDBpeqmUrdn+54ayT1MzhPQ6mgucGWVhVS8AMedjC5VWGLPKry+Mvr4hbOoH/Fwhffy
         VXBeyBCtbAGQ0YtHw4dqe2Bk3cKBYWEj0hVZh9HwHyjywZpr8U8CNv7GtC9dUOdCSQGk
         NndA==
X-Forwarded-Encrypted: i=1; AJvYcCWo/znNWk3U95SVnCVLe2QiC6j4YsMlhjuaz+ntfx85Ha+3Jv2kd2+GCbjbP4X2ffOuWvv/5xfTmAUX@vger.kernel.org, AJvYcCX0ksSVKoWv2bvmPTO6JKuDsvaQWLyhqNATi/aGD/dOM0tPXaJDZy5MHQXcmHrtSL9zar+Dllq/@vger.kernel.org, AJvYcCXVHT2SFI/AwZOF8+zyoioGXlBNmLIqI95kFuR28fhPV3n+0mKE+VwAU+8zZkFIce8ZFxo0JCRleQx9ory7@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwC7y9fmK+H5FydCBzC48ov0Sy/tByXNRIw7NxJrOXRviRU6V
	Va5kePo+kMc1M6qu23K0YJtpQnbIdKrtv7XdApee1RegM96S8uGnpr8M
X-Gm-Gg: ASbGncugN1ajk27v344ucNiT2/8CglnwG/bO8K8KLEXJTjAQxcO0j7nhuqxC/BlFhZ9
	f6elNHF5vCYviWecWA7Ifapex/pYzpYWh+bVxWVPZ64CL9gJfoXsU6xDTZGAtSQod7xwjwRs+X4
	xnO6aEbjMz6ain74D2gFfy5+dRExqiaZn9WTE4R9CAuypnziP3nJO2DNF+MtCOBGNIv0PqOh7h8
	4IVa6E/YkiMUC13Va9RZrRIy1Szw7IvsAi0uL7KMPnSZhmREnoEhIbjDZeLCVs9oaA9Fi/X1ozZ
	Akrni/DTCBqrJ4XLyUac9auLDE5KMxf2g34ah8jfJ43QE/ufZxDjGM+N3sg0TA==
X-Google-Smtp-Source: AGHT+IECP57koT4p5ndKxxShdOfs6I12HDw/1fLrYCQVGhBzGFisqQ2/wQcyX+ce9G/xHQIv8GOhkg==
X-Received: by 2002:a17:90b:3f0d:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-3110f304457mr18525052a91.13.1748340277360;
        Tue, 27 May 2025 03:04:37 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31127b886b5sm5464742a91.19.2025.05.27.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 03:04:36 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3ABCD423BF34; Tue, 27 May 2025 17:04:29 +0700 (WIB)
Date: Tue, 27 May 2025 17:04:29 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup: clarify controller enabling
 semantics
Message-ID: <aDWOLU4qjhl0ds0U@archie.me>
References: <20250527085335.256045-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvrOZ3B0jJT6C2Z5"
Content-Disposition: inline
In-Reply-To: <20250527085335.256045-2-vishalc@linux.ibm.com>


--rvrOZ3B0jJT6C2Z5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 02:23:36PM +0530, Vishal Chourasia wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 1a16ce68a4d7..0e1686511c45 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -438,8 +438,8 @@ Controlling Controllers
>  Enabling and Disabling
>  ~~~~~~~~~~~~~~~~~~~~~~
> =20
> -Each cgroup has a "cgroup.controllers" file which lists all
> -controllers available for the cgroup to enable::
> +Each cgroup has a cgroup.controllers file, which lists all the controlle=
rs
> +available for that cgroup and which can be enabled for its children.

Keep the double colon (literal code block).

> =20
>    # cat cgroup.controllers
>    cpu io memory
> --=20
> 2.49.0
>=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--rvrOZ3B0jJT6C2Z5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaDWOIwAKCRD2uYlJVVFO
ozIEAP4nNL3HcVZ1wrqZ8/JIS7zNxFUbM3PHe9sr0xsJhUe0SwEAtSFG0mRgwB4b
lHzX/szn6UFuu1I3YPfQOAk4JaPYlwg=
=FcOj
-----END PGP SIGNATURE-----

--rvrOZ3B0jJT6C2Z5--

