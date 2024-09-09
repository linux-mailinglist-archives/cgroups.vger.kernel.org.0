Return-Path: <cgroups+bounces-4778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BBB97224C
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 21:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA731C21EC2
	for <lists+cgroups@lfdr.de>; Mon,  9 Sep 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36918990E;
	Mon,  9 Sep 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QJ9smbBF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8617588
	for <cgroups@vger.kernel.org>; Mon,  9 Sep 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908653; cv=none; b=sk4CZRM5ClVPkFh/+VrZZqdwBtox6ErnkCfLpuBllNd9PFrRTRvNihtsLelQ/0y6/RIbG0cmlEvzRaR/WkkOT60PgqrYOk/nMnwwS91JspcK8u5so2PCrFGlOW0khtnloz6S2Oj+1Jjfn5vp1Grmt5K+3MPoG0jQbA0aIp1c30c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908653; c=relaxed/simple;
	bh=HJRALFabSahOw6O7YrbmbnA8mygQh4RymsT9E2kM6Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtuBbt8EgzwA1aLo6q31KtVGrgMUSdROsNvFzYqbrM0VpIMQm/7cVOYZRQKmyub8QHDKYRs+1Emk4DXrgKtr5Givh6bIAT5TkXwfSU2/DMJVqRVmc+mXI5oLz0sOBYZBV4LM27Krbb+6imIXu/G+1gZbfkY9yIYf/d3b8jHkFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QJ9smbBF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374b25263a3so2760436f8f.0
        for <cgroups@vger.kernel.org>; Mon, 09 Sep 2024 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725908650; x=1726513450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9kb1Fz7H2zPFhq7PFWYyaIjfAaW62wT0Vn+rFA0880=;
        b=QJ9smbBFj2RPbADuLyjI/ecX60SjuNogJL98nhDjJbb56G3Ualyee9vt5V+0Fr3OAw
         x2mhLLPiG1xFYnx07J/gWVIRu7Nou96dr9wKqXPl6wozC++Tv0+k1b7FUvdOGvz915AR
         LX30jmPf3HDb8TZxM+OdDWKon9aiEycmMb1cnIE7RS4BWhucfj+TSCDGhdsgCfl3ohe4
         NfjpZQX+qpYeuVbdJHGuvi/S527AjCcsKI2U0NUhwUrsbKG1vnkX9Kb6/xxMWgnAKOdz
         7zHuXoLTld3LuGx/CMwoWSiFIwkUmWadnz4PDPB84NPZq1MYr9Fu7s3HB7lYj1ujWqIK
         pj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725908650; x=1726513450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9kb1Fz7H2zPFhq7PFWYyaIjfAaW62wT0Vn+rFA0880=;
        b=ZF+/lOx9jeAirj2M+JoaVr/YFXzg8c8EmamxapUpDA6qIY+3/2AkUklUjr3AI3P58X
         kb21ALphnOrwNlsHbKXJ+91uDnxIAv9KpJt1Ne9t61IrYGjiRBd/jyMbTytUyjGvOAYd
         dQ7kT/HdW9KVm9/a2iPdlDRk+aor9zanugSEVnHPQ070/zs/yQC6AziVv24fDhoWecsn
         NQQnDUgNbln65Mi4XflislTlp1d6mhU+GtuHXHmX9KOJ2GIhu5O64Hj2vw7O2laMsbaB
         t3fhd3vOx8EuGcS2ONEEZ/r5CPonDEeJOomJ+oGooSfhmzn/fP3Ew1rNoUJi76mBXBvY
         o+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtVt6xQVGS/9N2Ect4FgMqlZ0I4tMRI7NZ6C2CoQKKq6+1+wZMHn0Ut96srRwnoKFZgRPAiwoi@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvfCHh4FGMS+eOqoSdFENge4x779rC3bsmWQqxlJPYR9UQZvE
	Es+d0XPki2sNNK6XCj+x8dOaDKPiPBcEwvVYN4fRbv4REiIVde8QXyRWUPhnudQ=
X-Google-Smtp-Source: AGHT+IEE97d+T/QiWwEI+EJ4xhLwao8mU/NpalAXfxnIgV/L6Ur5tDghFvv+1tlnBclTwDIWW6iKdA==
X-Received: by 2002:a5d:6892:0:b0:377:2df4:55f6 with SMTP id ffacd0b85a97d-378949f7ab0mr4721176f8f.17.1725908649869;
        Mon, 09 Sep 2024 12:04:09 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de00fsm6703254f8f.99.2024.09.09.12.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 12:04:09 -0700 (PDT)
Date: Mon, 9 Sep 2024 21:04:08 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, chenridong@huaweicloud.com
Subject: Re: [PATCH v1 -next 0/3] Some optimizations about freezer
Message-ID: <dl4j67yzzipthp2quj2cl5i6g2cbtiv7ssmhpz2vbcixhig4sc@wfx65evjb4ca>
References: <20240905134130.1176443-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="unfvkduvjjcsaklm"
Content-Disposition: inline
In-Reply-To: <20240905134130.1176443-1-chenridong@huawei.com>


--unfvkduvjjcsaklm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Sep 05, 2024 at 01:41:27PM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> We optimized the freezer to reduce redundant loops. We add a selftest to
> ensure our optimizations cause no harm, and we confirmed that the
> performance can be improved.

I think these patches have potential to make the code also cleaner and
better to understand (the numbers from optimization don't impress me
that much at the moment).

I post more comments on the individual patches.


> We tested the following subtree: D, E, F and G each have n children.
>         A
>        / \
>       B   C
>     / | \  \
>     D E F   G
>    /  |  \   \
>  1-n 1-n 1-n  0-n

(Why is the last one different?)

> Our test is to freeze A B C D E F G, and then unfreeze A B C D E F G.

I would say measuring freezing/unfreezing of only A would give better
idea about the impact of the change.
(Going through all descendants manually would unfairly show greater
improvement.)

> We measured the elapsed time.
>=20
> 	BEFORE(ns)	AFTER(ns)	SAVED(ns)
> n=3D10	142679950	139666014	3,013,936
> n=3D100	199832160	192773032	7,059,128
> n=3D1000	488595100	414901570	73,693,530

How many tasks were there inside cgroups in this benchmark?

(I assume in practice the freezing time would be dominated by waiting
for tasks' response, so it'd be good to note this beside this result.)

Thanks,
Michal

--unfvkduvjjcsaklm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZt9GpQAKCRAt3Wney77B
Sap8AQDN80XYn9ro3Rz3pe9DiqIcJ3xK28llXDd7KglbGAkzMAD+IVfjgWjG3X8K
HhHEoDnhjm7drbCLpDIREyqa8ZCK7AY=
=kN5S
-----END PGP SIGNATURE-----

--unfvkduvjjcsaklm--

