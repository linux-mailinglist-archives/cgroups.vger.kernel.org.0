Return-Path: <cgroups+bounces-9880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C078CB5199D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BAC1C82442
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88573314B3;
	Wed, 10 Sep 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OKS7Ahd8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD6F32A828
	for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515039; cv=none; b=uyHo+IPMmmX37fgvIC4mPdcuUNaRg5r1xtRYSUgutd2HSA7Hsc9ASRavJCnL6lBKCeB5h2+uXhvoifcPa5T0GWp2w4pyA4kWuGlsz8srSOoZc47cNLjRzJtvYKXGOgY4XA9IXA0ONtRlzlb7lrv8ahEV3dzyaNNq+kF5dvpnoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515039; c=relaxed/simple;
	bh=YtWkNny6zQv8H6obZQUu+9OqmAXnwGpeDffbx+GQPyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKFAjL5bCj/cW4xB225ygzH3g0zcRAcr3d3dWI96K4nAOoVR8ZW4M9xJRNytbEIwUmpWMPsqzifuW/JmRQMKVAPhpfONxv5WVmhbwlq6jd5Id2Pw7DPYzzuz/dX0Vleo/BdVq66r7Mc157ABnW9pVevW9g/S+FI02ahNnaPQcGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OKS7Ahd8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45df7cb7f6bso5650345e9.3
        for <cgroups@vger.kernel.org>; Wed, 10 Sep 2025 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757515036; x=1758119836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fx5Ezt6+mcW1cFHZMwLAbWc3FR/0c2HUuqsW00V6DDc=;
        b=OKS7Ahd8SkOGYMHQwsv5OUIz4PGECYrDs4U1hUq3RJVeB7DaDzvTkgkZ28O4aXYTYK
         gJM7tMQI376uxGjq29ZczVcIl0EF8kkESy+bYWiUpBxj2U5qsmc1jt0aPYLj55yJPgSd
         5z7zh0y3d6SmF3KEoHqYl6T+gUbec/QwZaiWezGNdCCBsVai0jr1EDDLaEHAhOD8+TQS
         cNw+n7G05OwLXyGnpFv+DFmjPmdWSNWTYZGxn9lW2IEt0Qyby/P9Lrp8DFwdP0/Ihrtu
         imJjs+ygnTN08E2zTcQoRjV+KmAZ9M8XMCZybOYUnssllw4CDjQPCZrKiEZNw7SQKJ5l
         S52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757515036; x=1758119836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx5Ezt6+mcW1cFHZMwLAbWc3FR/0c2HUuqsW00V6DDc=;
        b=ZGke0e6Brv6voOedGApi5HTS+EYhq/1amGiAoiMGO+I+jbOMZtfuMiGz7XQF73vnBM
         Mx1QpmMkWCu3B/2q68lI7MaEPDgLTl8+W9MVGlI7DtfxlCaVYkHoYeIJrEGwR7s1ruVE
         e24iUv/uHgbhYOR7yatZtnxw8q7P0vbKtchSynsp/UOT+1K1OnzJ+IHTwvmZVNM2LJue
         i9oxgKIcz3JZez9fv7WsRS6q4DooOAYUvdDwBwT/pMOEvBKEISeQBSff/K8nEgy6Xcze
         qdze9e+FtciqpddrrxDhBYaDC6ufbBDk9pnfve59+M7BlpmG+gZzpFG0Y4jNN9dR0SBU
         HdcA==
X-Forwarded-Encrypted: i=1; AJvYcCVZncOGOJYpeRNZlvxXKnX4Y86lQPrSPm+qJj28bYsuHkkTxSfluDGTu5Zx3AD43UDnjncbMkMN@vger.kernel.org
X-Gm-Message-State: AOJu0YwENPawFAb+nGLRQ0rX1uL0yiijpl3tsHAaiZ+LxqHJYoUaU4Xa
	NcQVVRabAUFJsjRIA5liefsbEGsWlVCbmtP83o17r96t0WESJQPGWkOiZf+4nKpWhuM=
X-Gm-Gg: ASbGncttj6HmJCcS8LG+hoqM78vzzPTJCBb35QQ5XsoOuYit6tWupdaEKNnuFTb8YLZ
	ZfMu3jtcCLzr6/3rXPveFMJMcjF/qxnujI/Tv3RJcbn/2lkYA1KxUse3Tz5bqQjE8Snp+MC+nUu
	0Nbj5xPPHvkz0Lg1UeQGstHydhcKb46ZB1S1lZqWc8/KO6sqW2w6R8ib27A5m4dO88zoQVW3qfl
	UcfjZ/QceusNZn+N/EsBlRF0o9iGBemd7KDtCE1qrNjEshCeKXzOLuV0CZuZrnspftsCVeM+6YC
	GBQAegKCGnRqyVo9eDsROLrFQ3wKTZagPZM7Je69e5qupwAVtTTDQbx5mNwNPZLUeXONODR+oBC
	OL6l2rVeaxQJxeWO6kxs5dOFpSdC5KWS0uL5FhIuKXS2qP+D0KPMcog==
X-Google-Smtp-Source: AGHT+IExcQbJQPTtQOThjoQdjBJVQp/bFvBGdvVjbjJZ9d3l7sJ+KPSOh4xkTU1gEzWCwG8IAQkNuQ==
X-Received: by 2002:a05:600c:1991:b0:45c:b575:1aa8 with SMTP id 5b1f17b1804b1-45dddeed95emr129259305e9.35.1757515035653;
        Wed, 10 Sep 2025 07:37:15 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df820d686sm29939695e9.10.2025.09.10.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:37:15 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:37:13 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, 
	Linux cgroups <cgroups@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrea Righi <arighi@nvidia.com>, 
	Johannes Bechberger <me@mostlynerdless.de>, Changwoo Min <changwoo@igalia.com>, 
	Shashank Balaji <shashank.mahadasyam@sony.com>, Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, 
	Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
Message-ID: <plah2scb3k4sw5dtn2bx6iqojjd7kiyscpqpqddvgvss3iglms@pdupbdckqjyz>
References: <20250910072334.30688-1-bagasdotme@gmail.com>
 <20250910072334.30688-3-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kcv74l6kt7nrzh2g"
Content-Disposition: inline
In-Reply-To: <20250910072334.30688-3-bagasdotme@gmail.com>


--kcv74l6kt7nrzh2g
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] Documentation: cgroup-v2: Replace manual table of
 contents with contents:: directive
MIME-Version: 1.0

On Wed, Sep 10, 2025 at 02:23:34PM +0700, Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> cgroup v2 docs is a lengthy single docs as compared to cgroup v1 which
> is split into several files. While new sections are continously added,
> manually-arranged table of contents (as reST comments) gets out-of-sync
> with actual toctree as not all of these are added to it.
>=20
> Replace it with automatically-generated table of contents via contents::
> directive.
>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 79 +------------------------
>  1 file changed, 1 insertion(+), 78 deletions(-)

The ship of plaintext ToC has sailed with .txt to .rst conversion. It's
better to maintain only the structure of headings and provide a
generated ToC.

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--kcv74l6kt7nrzh2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMGNDxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgL7wEA8vVmo71lBb4+jPLRKLKc
NU8qcxCPST2ZV1d0N6+C2dEA/0NgPzA4uWZcSx44ZFGNhAa2toJ5u2NBRSJ2/6yR
uSgM
=6W72
-----END PGP SIGNATURE-----

--kcv74l6kt7nrzh2g--

