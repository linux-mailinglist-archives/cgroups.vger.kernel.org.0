Return-Path: <cgroups+bounces-10163-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A0B592ED
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D135F1BC2E7C
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059A62F6566;
	Tue, 16 Sep 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm3UcmcM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB052F657C
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017193; cv=none; b=QbEdqxSzicofMqaCOqXvXerH/2QBn+/Ls5Weket/K7gKQopDFLPFd/8ZScfuFEMBjlKmdzFqKe8XhSXpDxRhd4jy2Wz0HiKaN/CxuWacFVniodpu42r2RU1s6D10On8+8M2b8sECNA6np+NHJgykM3lVtoCLdHALVwSGrnLLgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017193; c=relaxed/simple;
	bh=G4K5UJmVzmGU0trA0faHWCoNw1ZO47dPJ1TCITM8KAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aieNkaG+ye4YyGVOfdlAzOOi4QEqSjctZm05kV3GJ9/CAwD6uYKg/dFCi2d+lEaB1oJoXHxNR0d8uK4egeNimxRmRfnm9zyn7jM9Cd//k/JmrfPGXF9JE5/3OcVwpeyeWgDkVII6qeGE6RRDXLMbHPb+xP18ku8vaqjvYm2w3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm3UcmcM; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so3205698a12.3
        for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758017192; x=1758621992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G4K5UJmVzmGU0trA0faHWCoNw1ZO47dPJ1TCITM8KAk=;
        b=Mm3UcmcMMbw/QPI6r2vHfhdW5d+Gi65yCKKe6s6Ag2RTaR7oq8XPSjB3my7Nu69h6Y
         QNxoGhv3IMBWw8kAzEo8Zvoqf/wMYPFUnxbRvErre3yZQ/tUD+SIfpLqL3Jt/uUqKpky
         TLdIeLn0zNwYR7OUNWzicuEg6o/1Z7435OL3/K4ltfBoT/S3WzVFvmpXu8ttxcxR25tE
         4UjOnvjj6uEi24MAtL4/J5B9N11s5DxZJV0/XlDFEimCoXVAzi5UdTkPKO+e0rrNgK+b
         pV/bhSLMgl4i5lsm2rgHOy6zQvjTIOIB3LFcz3oCX2IGQmWuJaPQach4kc6myOguI1/H
         5npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017192; x=1758621992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4K5UJmVzmGU0trA0faHWCoNw1ZO47dPJ1TCITM8KAk=;
        b=ICPYDH+31AgeP1rmXKEijYf/UjTPM8D5lFLxJHu3e2slcNBOdRxKbw20hwAWXCOuq4
         tgyu1rdMcOcoSArlaNrA1kenRMh/UV7/wcqLk7zmSJwqPyK4lU3LpvokE8/t4f84x3wb
         uonwws3XXRj5aOcUchBLZ+k9P7e2E9H0EBtGHGqP8xMZ2nL0ZhTWVvfUW+zUXa5/Poi8
         arUE00JSlxUAiZ4+QYUCv03KusPW4+OPl7+yxElLHIH+B5UwHEQ934vrSM4YHYRAu9cB
         mNIqyEMkXx0yUsPuMWmQ3Zj7yZUbyhdjdsz9452h1e5RJ2loOsGT3U7bMVMEWCs5PrHi
         ZXsg==
X-Forwarded-Encrypted: i=1; AJvYcCU5kxnorpimnIdV3NU8VRsJwuSXGfxn/WpDZlRPX2cD6A5X/UpSbj8bFGxiV5JQTrI2JXt6hmrC@vger.kernel.org
X-Gm-Message-State: AOJu0YxdS/Kf49IwGKVs1OYrC7i/tUr8GA0uKI6B23IC8LD16ui6wbRD
	Qv5vXvDuOP9V+VLXNhdO2qPYaLg7aT/CkIX366afDIWG1VcfBqA+sFnd
X-Gm-Gg: ASbGnctE6mWCwzPWhbwYSiKb4NzDXWUcBQrsBw0iOpKPClrRg5Zi7+O9tA1lIWUAJ+7
	e+ETN58w355X3j2aMdchbxofj1YvsDUx17fz+tHIQ8bsDNYvLDNpAe8JCARq7bv2G8dwSu3o6AB
	z+8PMnfaoiFkAsCKTSsFE9qkKPW7Gm29CXyI6oKnVRPSvx7Zhb8c+MLUs+NNw7ilWyjI8NN98h+
	BS3hTQmWThJhVli0zp/odtVOq3OLZTXGeGzvISOyvo2l0CLQe3xcGDqbmUVJ5451rQAg2UDRJoh
	jmDVWwvwodfB8+eG5KmUFSEJWU3d36sPDr3lTPAMGFjTPdy6xxLMEVqBx25bgAidsDjxmrVWwzn
	PNwzHIZnGa6WcDSFIQShKFlyjOsybLNlhEfWD
X-Google-Smtp-Source: AGHT+IFu56DW5QsTTu7FqSRf+eX6vttphxkswrnXkXlqHZwWQd1X43O+42AXEDd8McQoAwl1ZIfxxQ==
X-Received: by 2002:a17:903:384c:b0:242:9bc4:f1ca with SMTP id d9443c01a7336-25d271317cfmr195632915ad.57.1758017191557;
        Tue, 16 Sep 2025 03:06:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2613fe8f9absm93210335ad.131.2025.09.16.03.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:06:28 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D212B420A809; Tue, 16 Sep 2025 17:06:25 +0700 (WIB)
Date: Tue, 16 Sep 2025 17:06:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux cgroups <cgroups@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrea Righi <arighi@nvidia.com>,
	Johannes Bechberger <me@mostlynerdless.de>,
	Changwoo Min <changwoo@igalia.com>,
	Shashank Balaji <shashank.mahadasyam@sony.com>,
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>,
	Cengiz Can <cengiz@kernel.wtf>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Message-ID: <aMk2oZx1zrO1XoWs@archie.me>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-3-bagasdotme@gmail.com>
 <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>
 <aMgJPWETGVt_AE9i@archie.me>
 <pmsodjam5jjih3v3fogokfyshn44izvouhihkijvfxazmmbqoo@hi7b3klfk7nv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72On6oC1EHsYwW2+"
Content-Disposition: inline
In-Reply-To: <pmsodjam5jjih3v3fogokfyshn44izvouhihkijvfxazmmbqoo@hi7b3klfk7nv>


--72On6oC1EHsYwW2+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:36:25AM +0200, Michal Koutn=C3=BD wrote:
> On Mon, Sep 15, 2025 at 07:40:29PM +0700, Bagas Sanjaya <bagasdotme@gmail=
=2Ecom> wrote:
> > > Erm, so in addition to keeping manual ToC in sync, we'd also need to
> > > maintain the section numbers manually?
> >=20
> > Right.
>=20
> I mean -- that's not right. Either generate all automatically (original
> approach) or simplify maintenance of the manual ToC (as liked by Tejun)
> by stripping (meaningless?) manual numbers.

Do you mean either I have to use .. contents:: and remove the manual ToC
(as in v1) or sync the manual ToC without section numbers?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--72On6oC1EHsYwW2+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMk2nAAKCRD2uYlJVVFO
o11bAQDrtBYosJLsFIKmSSr8jhMAUh/P7ECdLm2/LY/49qeNHgEA/T1tlX3dC6oN
EOQkBAoHcliESjhLAgZ7r+held5mxAg=
=mlk1
-----END PGP SIGNATURE-----

--72On6oC1EHsYwW2+--

