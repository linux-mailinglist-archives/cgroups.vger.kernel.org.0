Return-Path: <cgroups+bounces-11875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836CC53B4A
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013ED5011DF
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E6342527;
	Wed, 12 Nov 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZJPka2Ui"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1FB270EDF
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966161; cv=none; b=HzoNwHK/ERomM7LfvBmscpbKRjnnNXXaHba9GLTb8d9rQq5mrEk2PeWuF2HubB/cVfrmlzLlYKDCh3vb8MD7Od9JFnUCq93+SD8X7aLuLkhQNqRj1gQoIvR1ZlfucaEBsGN6lOdhWewv7RTZTQxmJxVS+IRToJwqFrUDHtxpP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966161; c=relaxed/simple;
	bh=ocjgmOq2r2CeRbmaOZmy+2wQjfSaH7CPWfef2kPWtHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzEUkfIm4cQBFU+mDxcAffyQ1hxwKy/SpExzpdtJrSX4zHNpxlaK8crga0HCip6RaOu7ThDtU73UcsapQL4K8j4cfdrQrTxLXqmoNDbqV17Q2dOLT7wdq73SaEhtGfT9QWorwpHkI6TjjZQhaK+Na6C0A2h+DaIxetLM7ZeBT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZJPka2Ui; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47118259fd8so8092325e9.3
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762966157; x=1763570957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rELu8QfTahohG8UeRTTZdScar8ilG8ipHKhe/QBZ+Kg=;
        b=ZJPka2Ui2OPMNLyHosa3SAEey2dQBrr3PPt8xj4SYXjT+yun5+ODGHl+h0c6TxCIEa
         jc/q3bfNKUG3mVheRjUwL2rQ1OV0XQ+ZnjJ+2QEfPDTiXH+Ap2NHLPbltJhGHQ8f+rL3
         Ul4O0kMwzuGmymQ4mHa2i2IauVsmrptuEwQzQ0YAgLxvGCCiGZ25Yz4F+zzrIJvBg4Bc
         b68RTg1C7fXld3lxEOy8bqwZM1EaaTHx8wDKOnyLm81uDH0lWox3gL3PrldNzHywZo9U
         0Pmj4KGFWF+yOWiBOqK9NmurPGSmrs+h0YsDYxBd7Q+WXk+vcSFI+IV/S6dCBvwmpPUg
         IMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966157; x=1763570957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rELu8QfTahohG8UeRTTZdScar8ilG8ipHKhe/QBZ+Kg=;
        b=BVn+y7g67g/uZ3NJ/WHu1E5g+9M33K3WqG5QcPaUGLIWo4tUTg7WDEDDIfgaPQxYRn
         Q+ntL3SyNeOSJ27zcr980P3ZAgbVZW4IcClhZ0m+CW/fmFwfpyx7QK+Xv5rkCeK6g47j
         iWRLArjb+4rE5enr+++IvberrPmfaUTljNVP59y5iDjCEiQ0qmGuVEHfVDn1x1+YTQPT
         Ek08kdgZXV5Jnq7CBtD9bpDRBrVPNGGxk+Tus/9fpoy37R34G7FRfN51xEGSYJ3YIMgQ
         SMVbGBO/ccmqxM7+sftNo0njbZEWLQ80dVhrbtxw+BlPY99i56JZoqQmvRXqkid2sOBq
         LfTA==
X-Gm-Message-State: AOJu0YymB15VXZL8HxBXosD1fbW/gkVOhwwqwvkcGaEOPVkyxjY7UYlw
	pFMBkupSDPhMVCtR4m24l1eQkFBOc296XYpvUZ1Y8lddCZhhwN4PUoJzX1pOPiMU8479q0V/t4o
	LMhvE
X-Gm-Gg: ASbGncvoKpWA2BVCn/VI9kKg9CR5ePp2hEtqNGGEFsTSRWIHncSCJZYHixP8hkzBD0U
	XYXBF5t/O7Nbu9azAwtOxtW4RP2PUHBUg6a5H7ziv7OV1P5h5T5+bP/urbAfD4iBddo64nWDqIA
	NTxOiMyHVcMOCDtmmbkgL9poGDndr/1hGtafLNbGZMPpmiFggZMMrEHM1rqtga02/h03TExMSHN
	qfIFbdz74ATTn70o7o6aIoTaNckNsnHRr3rb4QfgqUfQEivs3s+EtI1jXnsSvfRmrhJR/eeIdbR
	/dDwdne5ZzHS+17furv4wDMwOmJZGoBLJS0FK801OEvIqXQNBosWJNGG/DMWBTW9jZj+ukicHw8
	9SScn2baZY27mLpJDcqYqbWCuEW9nbzRZ70ScbOVILFrFnv+mbko12+LXowpHarjJSOBMDxHzb5
	e6VGTZien41yN2LiliNX6F
X-Google-Smtp-Source: AGHT+IHb5pTwh5MapkCAJyBKNZb/arSf8Pp0dEcOY6OxkRQ+UaDphTbd5e93H51PqYh/daXUcHaIcw==
X-Received: by 2002:a05:600c:19c7:b0:477:7bca:8b3c with SMTP id 5b1f17b1804b1-477870c5352mr34765985e9.19.1762966157422;
        Wed, 12 Nov 2025 08:49:17 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b35ad7c16sm22261653f8f.15.2025.11.12.08.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:49:16 -0800 (PST)
Date: Wed, 12 Nov 2025 17:49:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: cgroups@vger.kernel.org, Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH 5/5] selftests/cgroup: add aggregated CPU test metrics
 report
Message-ID: <rua6ubri67gh3b7atarbm5mggqgjyh6646mzkry2n2547jne4s@wvvpr3esi5es>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
 <20251022064601.15945-6-sebastian.chlad@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwln4eo7cawr3rl6"
Content-Disposition: inline
In-Reply-To: <20251022064601.15945-6-sebastian.chlad@suse.com>


--cwln4eo7cawr3rl6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 5/5] selftests/cgroup: add aggregated CPU test metrics
 report
MIME-Version: 1.0

On Wed, Oct 22, 2025 at 08:46:01AM +0200, Sebastian Chlad <sebastianchlad@gmail.com> wrote:
> +| test                                      | tolerance | avg_error_%   | min_error_%   | max_error_%   | pass_rate_%  |
> +| ----------------------------------------- |---------- | ------------- | ------------- | ------------- | -------------|
> +| test_cpucg_stats                          |    1      |     0.016     |    0.01       |     0.03      |     100      |
> +| test_cpucg_nice                           |    1      |     0.067     |    0.02       |     0.27      |     100      |
> +| test_cpucg_weight_overprovisioned         |    35     |     1.023     |    0.06       |     3.10      |     100      |
> +| test_cpucg_weight_underprovisioned        |    15     |     0.010     |    0.00       |     0.03      |     100      |
> +| test_cpucg_nested_weight_overprovisioned  |    15     |     0.923     |    0.18       |     2.21      |     100      |
> +| test_cpucg_nested_weight_underprovisioned |    15     |     0.008     |    0.00       |     0.02      |     100      |
> +| test_cpucg_max                            |    10     |     5.886     |    3.06       |     8.35      |     100      |
> +| test_cpucg_max_nested                     |    10     |     7.065     |    4.37       |     13.39     |     90       |

This isn't the output of test_cpu with your patches, right?
Did you need lots of post-processing of the metric mode output to create
these stats? (Sorry, I haven't tried the patches so I'm basically asking
whether the metric mode's output could be adjusted to be both human
readable and have some tabular CSV-like form at the same time.)

Thanks,
Michal

--cwln4eo7cawr3rl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRS6iRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgTvAD/UUeHtG4aqayFMl/jy5DJ
ictIDZ6tiTKesoIQQX8jyY0A/iVhZPq63BGaWV0CHcO8EPzqvn47lYQ+h8m5Yb4s
VRAA
=Xiqa
-----END PGP SIGNATURE-----

--cwln4eo7cawr3rl6--

