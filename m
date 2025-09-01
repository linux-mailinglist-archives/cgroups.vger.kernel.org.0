Return-Path: <cgroups+bounces-9579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F6B3ED9E
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19AC23BB1E0
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB1530F800;
	Mon,  1 Sep 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NXQDpso0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1032F74C
	for <cgroups@vger.kernel.org>; Mon,  1 Sep 2025 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749895; cv=none; b=S1stZsls/U+y+T0Z513IlKgJW1jOJ73XPt2qp0IRfNluilE3s2qZxWaPorwy835qmte9/9qLAG+BAmoPEiCRO141X6gHSvxPtaW0aF4mAyOFYw0Eoh3Spfb1P/4kZQiGsa9lE42QIr5wq3ezuv+yE4Uk1ACwQowmEklhgQ24A60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749895; c=relaxed/simple;
	bh=LXX4UlSMVwOTvqjWX5B5eOBh7vmGJ6aIXmJVkgBDMuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/dLb4R0y5xOfryczLVVFgohTXu2qhuXs7X6Gic/3Psj+lFiGQr141kDP4XE0T6vTOkUvXoQLJa/Z6GdnazHAZ9kx1XC5lISvTHB5RkVB6Yae4BXvUYJtTvVH8aQLhLnst5w9WGAUhgus2gyKkwHphAaC5qbjS7+USt423k9N2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NXQDpso0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so16705175e9.3
        for <cgroups@vger.kernel.org>; Mon, 01 Sep 2025 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756749892; x=1757354692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l12FS5A7Kj14urTYIhgntISCGkQ3Fjpq742xAOboATs=;
        b=NXQDpso0Kup0uUhUx7IxpqCG5BPIQVm7uiIm+rsTE3KMzfDs/R/8WOjfHnHOkoKIOU
         RLhbEyX/U94qwSvkCFy7Iq3akqYns1jRp8NAxIo/uqSLP7kFXPZvEKWL3rGQfO8dgBtQ
         S3nxysi3BOzq5nIIJRtAzZJofeVMhEsGbkYCxMjYvttQCS04cmvz1+qI8P8LPCMyOQMs
         ugnyM1BxLAVtjpzsBOikLHfGOkSJbKjQlsld7AwiYAnoZ1XRd1stgZhDXIye7tZja3WH
         0/o6PmMUn+cQ17C/lRaYKKd+5U5dWdmiicamnb1Zw4Ye9cj5ucbm7Fkhm53AM0/o/Pka
         21KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749892; x=1757354692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l12FS5A7Kj14urTYIhgntISCGkQ3Fjpq742xAOboATs=;
        b=GqmVCvfNmm/SIlndNesy/4BmPN2LaOApCpe0dCZS2ZwIWV5y4QIlMPC4YVFSn/q21y
         NJZ/EYBPSvaXtH7O2OUJpnZYJ+nwE+1LE+2EnQbPg1DJb/Y31d3u5XQ8s/+qURQ7DqBQ
         VGHQ/+MFv44WbSZNDOS+5YNo2E6mCs/kIWcYBChLf5enete29Oa2y6GV4eULtjCz7hlt
         yfHLcUoqO+T6vpzPCqYwAEz6D3+s3RIG0KOe2NzVrxjtX6jJxHWvSn5K8I4NkHCjIKas
         OGwWqG3CUlAZkXkNW3Whbp+nLXDd/9HNw3BPPHfWzuYtmWBPe+je+7zaA/PdK0qU+Ja3
         8KDw==
X-Forwarded-Encrypted: i=1; AJvYcCXPeogKY0ioMdEBwR44z3o6pSeGqJe2L0J/utewZoiBWsjIPPplKfhYMOiv706D3vjplXK2lrKw@vger.kernel.org
X-Gm-Message-State: AOJu0YyK7yBRG2UAvCKTEJMqAKyvpmOypsiwbV0rzlbM2aCMxNvpzMLG
	Bp3wWVk2wuE/UFkmA4CMqJYIBDqr0I/ETcpTSRTPam/Yu1n8hg+PFhdtzV5WRPuFJu/+gfG1lvQ
	DfvU7
X-Gm-Gg: ASbGncvBcXxOSbwKR6kOaZUQ2IIw5RaAn+cDBhcOO/y7uikrXbYLiAIm4u/t4mgTe4p
	vXX9fMwZ6hNcviNTY8RgE0gEiBdpGwf+IQDdL/8zE0Y3KaeZMoABfKMVbLoeYkObzadKU4KpXRl
	Lu1NDYiE9LibtHxqahSxMTOvjilVKseGbnvjDPq5JGag1A/65vx9XXkz1KQzGQ+gKzzEznOxHcA
	+QL6AU21UsNTVtf/hzlRGwJmoGX1NaMKfH+zRnM32qxRFlAPK5ABvk3C1w6uELTlF2LtbNGtZ01
	evC1F5k9mfmBDeakwoDWepcIewMGp78faRpg4Fir7p4uUGJfxyVcLIEbO775G0UZ9/0S8RbPgpG
	eBPQYsGCpAfByUS7cWtZLIrUTJYC1t51pLdKRFH5lVsM=
X-Google-Smtp-Source: AGHT+IEIPbML0WpZyjUyWFk0CKu2It519a87MynXyVGMeesQEMVKVhve3MonxOXqezGGGsk+FaFwYg==
X-Received: by 2002:a05:6000:2908:b0:3ce:d43c:673c with SMTP id ffacd0b85a97d-3d1e03bffc3mr7460950f8f.46.1756749892082;
        Mon, 01 Sep 2025 11:04:52 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d0c344f6casm15352996f8f.36.2025.09.01.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:04:51 -0700 (PDT)
Date: Mon, 1 Sep 2025 20:04:50 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
Message-ID: <6ailuetf6jt66q2suzlnqo6ersf4tdqfllgltw6ef3gulvvd64@v2rg6wkulzrc>
References: <b3eb050d-9451-4b60-b06c-ace7dab57497@embeddedor.com>
 <wkkrw7rot7cunlojzyga5fgik7374xgj7aptr6afiljqesd6a7@rrmmuq3o4muy>
 <d0c49dc9-c810-47d2-a3ce-d74196a39235@embeddedor.com>
 <4546ce0f-8f29-4708-8af6-82fd1003e4bb@embeddedor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z65f7sc4bps2vxql"
Content-Disposition: inline
In-Reply-To: <4546ce0f-8f29-4708-8af6-82fd1003e4bb@embeddedor.com>


--z65f7sc4bps2vxql
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] cgroup: Avoid thousands of -Wflex-array-member-not-at-end
 warnings
MIME-Version: 1.0

On Mon, Sep 01, 2025 at 05:44:38PM +0200, "Gustavo A. R. Silva" <gustavo@em=
beddedor.com> wrote:
> Oh, a correction about this. Actually, if we need to use __packed, we wou=
ld
> have to pass it as an argument to TRAILING_OVERLAP(), like this:
>=20
> -#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS)                      =
       \
> +#define TRAILING_OVERLAP(TYPE, NAME, FAM, MEMBERS, ATTRS)               =
               \
>         union {                                                          =
       \
>                 TYPE NAME;                                               =
       \
>                 struct {                                                 =
       \
>                         unsigned char __offset_to_##FAM[offsetof(TYPE, FA=
M)];   \
>                         MEMBERS                                          =
       \
> -               };                                                       =
       \
> +               } ATTRS;                                                 =
               \
>         }
>=20
> However, in this case MEMBERS is only cgrp_ancestor_storage, and it's cor=
rectly
> aligned to __offset_to_##FAM[offsetof(TYPE, FAM)]; inside the helper. So,=
 we
> don't really need to pack that internal struct.

My intention with the attribute was to prevent a gap (padding) occurring
between=20
	unsigned char __offset_to_##FAM
and
	MEMBERS                                                =20
which would make the address of the first member to mismatch the address
of FAM (the example in struct cgroup_root notwithstanding).

(But perhaps it's guaranteed that first member's offset in the struct is
always equal to offsetof(TYPE, FAM).)

Michal

--z65f7sc4bps2vxql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaLXgQBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhpTwD9E7RIx42k+0sEUTSNWW9f
sEt2Fl/TcjJlOKrl2TinGTEBAJOtsKFN44H18yq872KTqoVnfYoVHW9fmSrz22X0
O9UM
=tbUQ
-----END PGP SIGNATURE-----

--z65f7sc4bps2vxql--

