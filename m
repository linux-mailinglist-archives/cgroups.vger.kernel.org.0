Return-Path: <cgroups+bounces-9578-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C7FB3ED93
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99052172413
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2337320A38;
	Mon,  1 Sep 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZG1gY2ut"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6531986D
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749491; cv=none; b=CSXqd+1+2KJshrIED/DWFGDFOqkYATU1hPbaxZ3/UCwv3JM5ymYt7Ve7tbq8GcF9JOH9ZHVSCRiNqHV/zYyKWRAAfn6D8hOp39Gmym2HCipeQQdY1ZDJAYDRzsLTjxxn2nxQyRSNT/cnJhNcqbtuFFLOiN6Auhuv2a0OWHvx4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749491; c=relaxed/simple;
	bh=3byL/Fj0HJ/ZBpYR43St9uLQGKkKDjP2v7oMiVkvnmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8/1DYAZYZrT9W8+a/SvgUlWajSp8mrgquX8FiiYyXoPZjpeMdwx/5fxoLr0PYDEh/s1LVS1yck2SmIii//ICF18fsquswa6KY18291gxF4seRdHUXbE+IQ60cuYZauiQAWXxOacPDOrSH8P16NkktTgIVeS3wlsn8UiSi37WmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZG1gY2ut; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so553623f8f.1
        for <cgroups@vger.kernel.org>; Mon, 01 Sep 2025 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756749488; x=1757354288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=ZG1gY2utY2Efkm9aWHKJRfTIui1Gpb1ubIUJp2PsMFnYGvHfo7FgdKlKFkMLwS12P6
         Q6tPJ+pQpOwa2CP4AkK9HSBhskatqOmM1ymsUHD7Dw0amPtUUIjwgMQ9MoHVxEX+yIN5
         X0oX1wTTonJmb5MYRiwHjaPuqmgRdmYXHvqhl2xG9iq8xc575YDtiKMqe3ID4VqlPQqA
         qNU28X+CUp8gUzVX3kXtoGHyYszGnLUu72AY4SuQhDun9NIKXM2Pjk3vTKE3eYDbFEjl
         xMP04CV710kMyP/EkIHiAzUJnsjg02lvE5fEkx/5CgAr5TGuwItnRkK30vUY7ILFnbHO
         pW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749488; x=1757354288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBrUlowGaoMISX9iJ5RVVV/ygG/eI+RUk2vTf+rH8qI=;
        b=YS021ocRt9vQqogH3vsjqFORdhgzviRTAnPIErN7uKkq97ZzBq3RHvfGReeo3ownBR
         UZHbnlB6ylsQIyo96gIcW3/rjvYzYOW8P5JzYQ+JdVMXQCyOSdg9knKaZC5ddlnV8p+s
         4OuiFSKom+0KRfbKoKXsU0zWsKTOMcZGgHSYLFCEXbj1ZdBzGqA/+8FX9x4gy7+dX3D9
         mEZA3P+fQyOsFse0SkWTWcVFiIELiEXwVBCSvckgm542cTU2N1cA3IqhMD7RVlLbFYm3
         sP9oqLmxLOo49363U3U8TqoKTpIXuj1vU8aP0RE3X0vl1dtNc4GWgxZRs8B2Pz7e37F5
         4SwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV38sCJzdR0i2vuE+UIy4GTWm21fkJpamtJhMm5nihtReWJGlp7dxhFxHFqXFqxGoI56szSEZym@vger.kernel.org
X-Gm-Message-State: AOJu0YwosukUcxyOWKlqrALTm/UncAEaueSWFNMObF0o3bhToAG32hj6
	xdhbBKBFmC+05kpNEGG+X0iwAlGjvvZTbM4N8mlUHkePBwfVQkETORbv024kduasDyM=
X-Gm-Gg: ASbGncsFOOBr5+hNyDdVh4wS/uC+ED0oxMdLFptAwJVMs3kRqw+e592G3aIKGUiojV3
	u1HmUvsCpF3K+LzHfAmouFJVJVbv4idDz0oow1iNSJyXFNTYDSorBdcJ7du4wF9IyOzWnrdJAXP
	QtTPOsOtadXlLss7BXAMpSuuDXJZOKP4wZP9HDlhf1we5LRwZCYc4Sr4cxfZXDB4QdqIP6CMHdE
	ty16y+rGYpO4vZdULIVGidV+OLq4YF3CJAlKKvg8qrWViqzpDXxJv4SasW3I5M+EnStQrBYL+8S
	GiHHBeZL8zfL5YaZyeDnaJcQB4v26wK/8I6hN5jWrAzx+V0GOGh9DcjhL65QXU91O/y3CA9YdY+
	o9IZNX5zERA1L7lV1SPWsB+jLBOHjQ4FotX9p87C9zSKdhdMowbhJ2Q==
X-Google-Smtp-Source: AGHT+IEKDAoZsVvcs49zoW6IewZ0iCEshtHwmKL7QaW26/0FEP2utdDdAE4fZYnG+d5xmXCXfom+zA==
X-Received: by 2002:a05:6000:1ac8:b0:3c7:244:a4be with SMTP id ffacd0b85a97d-3d1dd04e24bmr7849050f8f.10.1756749487957;
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a5asm15994104f8f.55.2025.09.01.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 10:58:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 19:58:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <y7nqc4bwovxmef3r6kd62t45w3xwi2ikxfmjmi2zxhkweezjbi@ytenccffmgql>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lkdsthcjr73q7k4e"
Content-Disposition: inline
In-Reply-To: <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>


--lkdsthcjr73q7k4e
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:21:22PM +0200, "Gustavo A. R. Silva" <gustavo@em=
beddedor.com> wrote:
> Because struct cgroup ends in a flexible-array member `ancestors`.
> This triggers the -Wflex-array-member-not-at-end warns about. So,
> while `ancestors` is indeed a flexible array, any instance of
> cgroup embedded in another struct should be placed at the end.

Oh, so TRAILING_OVERLAP() won't work like that?
(I thought that it'd hide the FAM from the end of the union and thus it
could embedded when wrapped like this. On second thought, I realize
that's exclusive with the static validations.)

> However, if we change it to something like this (and of course
> updating any related code, accordingly):
>=20
> -       struct cgroup *ancestors[];
> +       struct cgroup **ancestors;
>=20
> Then the flex in the middle issue goes away, and we can have
> struct cgroup embedded in another struct anywhere.
>=20
> The question is if this would be an acceptable solution?
>=20
> I'd probably prefer this to remain a flexible-array member,
> but I'd like to hear people's opinions and feedback. :)

I'd prefer if cgroup_create could still work with one allocation only
both for struct cgroup and its ancestors array. (Cgroup allocation
happens many times in a day.)

The increase in struct cgroup_root size is IMO not that problematic.
(There are typically at most CGROUP_SUBSYS_COUNT roots with gradual
trend to only the single cgrp_dfl_root.)

Note that it'd be good to keep it enclosed within struct cgroup_root
(cgroup1_root_to_use could use struct_size()), however, the
cgrp_dfl_root would still need the storage somewhere.

HTH,
Michal

--lkdsthcjr73q7k4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLXeqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhNuAEAjKx0omIrhaMBlA3ec6KY
kqg6f5iLg7LyrRkia3U31fMBALYGUaC9K1uFILkO5S/s3uVVR4mEqpN44csiQoP0
Y/kP
=jkIf
-----END PGP SIGNATURE-----

--lkdsthcjr73q7k4e--

