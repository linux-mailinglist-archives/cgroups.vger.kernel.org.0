Return-Path: <cgroups+bounces-6462-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C3A2C62E
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF616D0C3
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE586238D31;
	Fri,  7 Feb 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5SyRgTi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBF238D25
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 14:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738939856; cv=none; b=d+IHpEkMHiZCWhBeA1UbAmmu6UnOQ5kibLLyyGc51loc+nZAqF3TlFDAP+FUpWsXxw+wvaKPuUD7E5uUrKvQ7Z76MNQ6Ra4xFVvSb2hH/fDCrni76x7C99WdKF1BMLiCiCHMmeSEDsjq4m9DH8joHoqEfYN4smnZ5DF8+1r+ikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738939856; c=relaxed/simple;
	bh=SHsXvu9HmZA6Q8iCwk/0pfH531ikoAHLG+ddTSJt3fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7lHkUSfNqPTjuC2dB99V2Wz6Dt64rcBAj9T/xXXaT5BomcG1lOFSASqMCuKbio1E6RRr7wx2kcLRRhUzB8qjgXBhEUDNYA8Pv9HFDIcZht7njsTXF3RSMd/mGOkgkv9WsRGl8YxAfLsO8fMpf/XfBRJZC7dasAQeQBs60mKgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5SyRgTi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de34b72ce8so2779817a12.2
        for <cgroups@vger.kernel.org>; Fri, 07 Feb 2025 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738939853; x=1739544653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWC0dBLUzkQks2Cokls4AXc4KprtHZkdxVdLKhBll6U=;
        b=A5SyRgTiea3RUxMToPVzoKk9pQWlflk8p36bofwmqwIrH+sPFRkzRMI0mulxxJnZga
         1J1K9aj8IrGnwBNw4NkxlI+Rpi4hojPADAb2L7iDZkLUFPpY5lixvic3PxvABsOR3zxL
         JVQzKXQLwxsH8vUnNPVL3YP9F6VUiNE46NsTa7pZ2VCgWdoXXJ8cfOX7bqd1qJFydYCW
         l2vWkofLQV55xrXHY2mCxtOYzR47pTmM6bQlSEyg0iVI/t2gj37yWcW5fkZSKwQEbDpW
         FHJ2dV6IPzojKa3rEAc5I2C11S/8ufK/n+MlijaV1GN2r+RgTcbPsy30ewGqdBcUJHdX
         /5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738939853; x=1739544653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWC0dBLUzkQks2Cokls4AXc4KprtHZkdxVdLKhBll6U=;
        b=OTiufAGxGYTKbk1ovComEQTrGk0WpKMI2JsVbahRHBgSWQRnV0F5VdW13GRMH96PxU
         7d5p2Wt5SOF3OL3/9+1hao5ibPROieYd80QLaTWw1Ee8dQQHAL74jVp0zCoYo88Z3Cpl
         0yxJ2sn9xA8lAOxvdggH3x4RmYb9P8TcqUSHpnBPEm0qJ/h0DL55qXo8dWK3bdj8FRWS
         cd0y+4pkKzZcbsG+bcQ8RUl1zMtfW5iwfiuyy/3enVfJdRIZdg5clB6O9CBhqfkKtxRK
         VMfjdlw03oPXjh2wJq4zQr72ia7Sq6p4cIdlVXuZZxbzRX6GV967E0BiuUOSAtnFtbiv
         XNxA==
X-Gm-Message-State: AOJu0YwF4DPfn6+2abK/cRnp8VmutHExbvR71RPBI02idxrOh1YsZPaq
	PPtC8M3iKCFrRPr/zi1ZCWcl6dK1IPeKWxYf1IR7MT5AsBconlW4ebDVhGSJ0zY=
X-Gm-Gg: ASbGncsoc3TVczgCozAwL/h1fExD+qPrK5ZH3S7LkZMKzAMbydJP1RePU3XG6Vr30vF
	Eip6fiayxwMf/QLG5jybbxVyaMlCPC+EN0UG/FkArMfmA9vW5UipD4WgxFp/gaY5hiqJNA6Px0X
	cPdha1YIaeZjWx4eWQqfe03n1YMTeRHoZdxKJgMnBbDACEFpPcclsd0WD7iK5SZJikIRB4IhimI
	9/MzaNm8AkobEQcsKCQYW/OZ7CHmMO5Y9Udn2D5q4/q0OJaDJFqVCaDe17DQJwvfMzitMTO6Jpi
	FT/K5O1dtjMDd74SGw==
X-Google-Smtp-Source: AGHT+IGIWlrLM7/bzi39tNGeSzpuh2KXAvHc6/pHC+kuwidNzPpT0NGW1Vwh5ZAR1xXRU51OyC6wrQ==
X-Received: by 2002:a17:907:9717:b0:ab7:5a5e:b652 with SMTP id a640c23a62f3a-ab789ad9e4fmr361067166b.15.1738939852683;
        Fri, 07 Feb 2025 06:50:52 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7733374a8sm278141466b.138.2025.02.07.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:50:52 -0800 (PST)
Date: Fri, 7 Feb 2025 15:50:50 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Muhammad Adeel <Muhammad.Adeel@ibm.com>
Cc: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, 
	"tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, 
	Axel Busch <Axel.Busch@ibm.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2] cgroups:  Remove steal time from usage_usec
Message-ID: <zrhc77j6fcvr2esewqo6wbm5uinhrxnu6vinyiw3bi76ciz3tq@cyjffklmwdof>
References: <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
 <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
 <CH3PR15MB6047F418ABF4B97ABE64B9A080F12@CH3PR15MB6047.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dj7tcn443ae5nhwg"
Content-Disposition: inline
In-Reply-To: <CH3PR15MB6047F418ABF4B97ABE64B9A080F12@CH3PR15MB6047.namprd15.prod.outlook.com>


--dj7tcn443ae5nhwg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroups:  Remove steal time from usage_usec
MIME-Version: 1.0

On Fri, Feb 07, 2025 at 02:24:32PM +0000, Muhammad Adeel <Muhammad.Adeel@ib=
m.com> wrote:
> The CPU usage time is the time when user, system or both are using the CP=
U.=20
> Steal time is the time when CPU is waiting to be run by the Hypervisor. I=
t should not be added to the CPU usage time, hence removing it from the usa=
ge_usec entry.=20
>=20
> Fixes: 936f2a70f2077 ("cgroup: add cpu.stat file to root cgroup")
> Acked-by: Axel Busch <axel.busch@ibm.com>
> Signed-off-by: Muhammad Adeel <muhammad.adeel@ibm.com>
> ---
>  kernel/cgroup/rstat.c | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

--dj7tcn443ae5nhwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ6YdyAAKCRAt3Wney77B
SXVvAQCzvJWGrL7/mM8/6k7M8o+JCddZoz2x9ZtK+aFwzMZasgD/TQPk2tjIUhG3
5N74sFW6gURy7bC6X2AV9CeNaKqBogU=
=cTnH
-----END PGP SIGNATURE-----

--dj7tcn443ae5nhwg--

