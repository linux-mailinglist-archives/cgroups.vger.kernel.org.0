Return-Path: <cgroups+bounces-10161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D5B5925A
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B06E1BC0F94
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7429A310;
	Tue, 16 Sep 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cIj+cADX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F78299937
	for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015391; cv=none; b=sizLtEh7pqtCCP8F7aMBl86EXmvN+P9FimhuI3Zklsab5SzW4Y94dzfdRfEwFdJGhvh7tYpaNzXS27DIHyoaLLccxbGoQrnFvFIrkjbkHqi+Q6Deck6DdS0BBRrgNaWLmlfNIrEVkmHnO65GRy/TbbdZmqFyEWVs4niicF9rYSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015391; c=relaxed/simple;
	bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0VAL1DcmX1SZvxsseg1Yj6RmVXGbnG0+4+4ruSahxzZqpeGfOIZ23nGOuudmu+L24bzKkHn+wDooaUhegX9RzJBFOL4I75m11RHspEsRtlL/Ob5xi3v7KfSAP7RdI2E/8RIQF2Hpzr0k+7LJxFfzGugXUuOTPFfbIik1BBQzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cIj+cADX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so1329676f8f.0
        for <cgroups@vger.kernel.org>; Tue, 16 Sep 2025 02:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758015387; x=1758620187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
        b=cIj+cADX/NjESMnorOrVw+k2YBRP1o+flOgm/4NNauJudqFev453CIlIrqc/eTYxcA
         zE4Z0BwSxoPxRW4n5uMZw8MDN1bITITJzJ3z5/fmwbcn3CAuxuhxxirEKticFCcl7gq7
         9+TDbIf7BRURx2dT05Q/o6rO4/56nACBQ+e3U8a8LMGdR8MxGKbTlU40n/sJ4aryAbWk
         SALNFzYxNnOhWbU86F04nOnFLMf6xu+4QChEgEzW+hyfuoFJB6h1ka39L5l7mDASOWbu
         mubDontYYop5C47EvI3d491Ur7cpkf9sxLM1wC7n58KexT2A9FXf5hqMw/N1pWcSmhD0
         5Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015387; x=1758620187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZI+p/HjCJtJq0JzOCCKrajA0dwNrvxjKZSrCzW8MW4=;
        b=pRy48WxwvOi9def/2vrqDBtJgTmfZDh/D+yZ0FvULCUFhtog61lVC84cE6Z9ojlc2V
         Ya6Na4zQz0Stfwpxd+8phl0Cm4pgurjZdf3Rsj7DduCt86otnG297c6Hj5ah7DPHni1r
         /79Uz7/TDERZrYAm3g2VWzVZq67vKGPrXoBfLeV3B0JWkeePNX3Pw22JI0M3+3K3tMvB
         yuo0MJ5Bu/BvKd93tK9hJemKVXdrEBfeUeWG8VTkTfPWZAnr4nF5Js/HaGUxxvlQh0AO
         YPbfLnxDB2qrCn4uUZ3HErRDJFv9UBHZPLS5DrBcRuIypIeb8EH3dddeWQhgww0F9C6e
         D27g==
X-Forwarded-Encrypted: i=1; AJvYcCVOh0aq6zHPnfVr1RuLkrALHk+3/1AFYNzcAa+rD8TQdFhfxik18Wmoh1WzdjQw/bpyqX9UEABb@vger.kernel.org
X-Gm-Message-State: AOJu0YwgyIuU37DJUrjvdrlYcl2i4C09CPknbmY/NRtKyCHqeEGf/MyT
	u6ZtdlAizhzhmf2mQdo4RtVKd9V/OvvnPfKp9eLQXzkEoj4rJgPFL7IfwWXdQuDXSWA=
X-Gm-Gg: ASbGncv/g2Ed8YzH4mu6AfuJCkVKSnntJrqnfl36v98IAR9+gEvMKwLicuTWomd2dg8
	tRJ9i/Il6/q1svEZZV3YH51cjZgxPsYQBR6K140BAHt1jWvY/fw4/2A1z8jrUUObD/6YkGpzuCK
	hzGc9w7V7hiFEskeXPn9+qEIgNHBhjDu1kqt100UTAfJhnJMm/DZ2nZTc9P2aZkjBUyGYGm+7hB
	rg4BeJuvHJ6d2kYXYv0Q3kolFg2BEasSgWw7WtAlQ7or4XxxIWFfs2HZGxsQAL8PVdiQSxWz2kR
	qVPPlXbv5sYcQGI07kcCcEqse8LvfWn7WfqMrMgU1y2QGS9/T0VvCgtYFObT8iZ6lVrB7RukgQ3
	NEGcmVvQLkZ6ZOw+6tir0HdPqgqqXuWSI5gGWWlkS8G4=
X-Google-Smtp-Source: AGHT+IEKU1Rm4HZ+0ksdNHYojrzjut6lvIe9tNcd3eQTCHaEmO/AaBdarAUSFEFHY8YENNUIK/ZOKQ==
X-Received: by 2002:a05:6000:438a:b0:3ec:4a0d:a09f with SMTP id ffacd0b85a97d-3ec9dcd3a43mr1279882f8f.1.1758015387278;
        Tue, 16 Sep 2025 02:36:27 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm6057510f8f.54.2025.09.16.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:36:26 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:36:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrea Righi <arighi@nvidia.com>, Johannes Bechberger <me@mostlynerdless.de>, 
	Changwoo Min <changwoo@igalia.com>, Shashank Balaji <shashank.mahadasyam@sony.com>, 
	Ingo Molnar <mingo@kernel.org>, Jake Rice <jake@jakerice.dev>, Cengiz Can <cengiz@kernel.wtf>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
Message-ID: <pmsodjam5jjih3v3fogokfyshn44izvouhihkijvfxazmmbqoo@hi7b3klfk7nv>
References: <20250915081942.25077-1-bagasdotme@gmail.com>
 <20250915081942.25077-3-bagasdotme@gmail.com>
 <duppgeomaflt6fbymdk5443glmw7d3bgli2yu7gx6awb7q2dhn@syjq5mmia6pb>
 <aMgJPWETGVt_AE9i@archie.me>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ncpdxclrgscw6h4s"
Content-Disposition: inline
In-Reply-To: <aMgJPWETGVt_AE9i@archie.me>


--ncpdxclrgscw6h4s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] Documentation: cgroup-v2: Add section numbers
MIME-Version: 1.0

On Mon, Sep 15, 2025 at 07:40:29PM +0700, Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> > Erm, so in addition to keeping manual ToC in sync, we'd also need to
> > maintain the section numbers manually?
>=20
> Right.

I mean -- that's not right. Either generate all automatically (original
approach) or simplify maintenance of the manual ToC (as liked by Tejun)
by stripping (meaningless?) manual numbers.

> > What about dropping the numbers from manual ToC and sections? (If manual
> > ToC is to be preserved.)
>=20
> Nope. To be fair, we also want section numbers for htmldocs readers, thou=
gh.

That'd be better automatic too
https://docutils.sourceforge.io/docs/ref/rst/directives.html#automatic-sect=
ion-numbering

Thanks that you look into this!
Michal

--ncpdxclrgscw6h4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMkvlxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjgdgEAnUOZWh1sOndo34Yf+kdQ
nJWfCzO40QmFo4d9a9aif8oA/A3mZT4zM3qn1jWrba7Cj5rstgqg0P8UeO0B5BKp
xv0N
=7YfS
-----END PGP SIGNATURE-----

--ncpdxclrgscw6h4s--

