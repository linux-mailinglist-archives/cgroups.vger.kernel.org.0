Return-Path: <cgroups+bounces-3624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 915A592EA6D
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 16:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CBE1C212E0
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 14:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345EC161900;
	Thu, 11 Jul 2024 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tu7Hs5cM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493215218A
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707271; cv=none; b=qwrZRmol6edncn2+ct5cdIDbt8M4r4WZ+5FGLAgdMkTtKgi5h/1FQhDMlOD6ejfGnlRbrV9nAdx7bH7Iujk0xyAqcEItrKXJOPCVrQLaxbr4rnWk9Y1yiFLZZNa+z7FyljXt8HTtAvEfLFUvtFNia2sVDPjTdaAH2lAe+gKDd1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707271; c=relaxed/simple;
	bh=k6gEHt+xvUkeIRyoiWjWbAiSg5WbedFbm/FHPHtlVRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU44W9+MUmYxBJBXHdjGjKlpkkLO18BuqvggLnjexUHXIpzwONFwitSt/tBkmfKtEqBzILKQb6QzQP+Pd4D46zkLCQWvtrEqHl6lylcc+5RFSvmUh2voN9r0Mz+kwEsiT9YJFZhx9Fk0wrRbhbsbXCh3PznSqR5PDnezsYcdqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tu7Hs5cM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea7d2a039so949272e87.3
        for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720707265; x=1721312065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETcGYWGq4nimdvPCfHodnKlCUrAHYcZUT9Kd0lfRhLg=;
        b=Tu7Hs5cM/U/Iw/ASeGNjbQp517UHoNZcVR756O0iesE63YWkkrQU/fV/DvOXSx5f8x
         77oEdCzBZXmMdwIt048/owv6pyW9gn0a1wn/O98g7P5OxtOhFA4n3oMIxPtxOATV4IVI
         hPGOgtt9SF2s27jXNA9RtIwbigfVUKmNBOlOKcRyCxm/umJXHckCFWj521L+kNfwnTNN
         gzmE2eSQan/Hx/MLx1BQm/hpojUb3zldbVv5eTLu7iywY7p9VNCx9nwLfg80uh3U9gVw
         nJDTxj5vz4rPXjNxDcH7nGbv4OJdPHxyhiauKu6hrrpZQ3F1F0Y9RF1lQUZeHEtJ6T/e
         ip0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720707265; x=1721312065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETcGYWGq4nimdvPCfHodnKlCUrAHYcZUT9Kd0lfRhLg=;
        b=J/xdNIBciHOEsqwAE5kVlSJzPA7NYexU06JPMoqKoX9FHCv+m9c5af5ad9/2khkxlI
         MDFcoNJeVyNaWiTMHX1V6fcHPk26Fbhc4dwl8aWDq7En6MKMgUmJelGc+dfYDTemw6wG
         jelTUl9/FaHZ62cju8Wz3B9QdC7SsMtoXQt7SO+Z5Mwvna+PlFhb89mxpBb2+Wc7BETE
         NrKIA4wQx8GIgevG3SSICbgbcDZc8w8lFJQm9RC5qKYxZRnNu07UFroWhnFjgTgCh46y
         ghabRwf9WYDvWSXGfjgEYUKX2FPzWQvXrx8m5zrmEUtme3icI8+jUf+40CdURzUylpRw
         F0SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC9ODhKdwiZLxBnj1LzM4albccXaawpBaPVDz8lHmd8llzgqlTJegfzq954K7TYjrImmReuu8RXfy5PBp8Jf71AQQBQa+JOA==
X-Gm-Message-State: AOJu0YyvqSRusg72M8UAcOnXFfxraQhXq1iQDvOYPc7l38iSlTI+ybXv
	NTm3Qgg7Kcf6ygw0KCXYXrGXRsLF58apXahkPN/8Fji2YhXsZ8zHJlN5w6AkgPykhRFJJtQhFvE
	z
X-Google-Smtp-Source: AGHT+IEzPG+qu6OL9MzbpwkC6XP8o+jkAEZwKCZapFXu49qLNouCsz3lCZ+8q2VzbI+KQgfySGooLg==
X-Received: by 2002:a19:e05e:0:b0:52e:9765:84e8 with SMTP id 2adb3069b0e04-52eb99da425mr4901525e87.66.1720707265401;
        Thu, 11 Jul 2024 07:14:25 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff045sm257878966b.126.2024.07.11.07.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:14:24 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:14:23 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH cgroup/for-6.11] cgroup: Add Michal Koutny as a maintainer
Message-ID: <5yfatxvtkpti2mrym2kd7j4qcdu7rxkyp5xvvwcefzvpdc2mkp@q5f7ug5tij6o>
References: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5uhdydamedm7ydyu"
Content-Disposition: inline
In-Reply-To: <Zo8OzWUzDv3rQIiw@slm.duckdns.org>


--5uhdydamedm7ydyu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Wed, Jul 10, 2024 at 12:44:29PM GMT, Tejun Heo <tj@kernel.org> wrote:
> Michal has been contributing and reviewing patches across cgroup for a wh=
ile
> now. Add him as a maintainer.

I hope this to be helpful to you and the community.

=2E..
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5536,6 +5536,7 @@ CONTROL GROUP (CGROUP)
>  M:	Tejun Heo <tj@kernel.org>
>  M:	Zefan Li <lizefan.x@bytedance.com>
>  M:	Johannes Weiner <hannes@cmpxchg.org>
> +M:	Michal Koutn=FD <mkoutny@suse.com>
>  L:	cgroups@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
=20
Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--5uhdydamedm7ydyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZo/ovQAKCRAt3Wney77B
SVSaAQDl/jTgKWUbqGX7f4PGpzw+02qS3ODuDV7XRrjJHXM2bwD7Bs0rBaW5Zo3t
4Ww0qfl2Qg0TLkMplYXm2qlvmy9fdQ4=
=LWj3
-----END PGP SIGNATURE-----

--5uhdydamedm7ydyu--

