Return-Path: <cgroups+bounces-9424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81904B369EB
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 16:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FDD1C234BD
	for <lists+cgroups@lfdr.de>; Tue, 26 Aug 2025 14:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420843568E4;
	Tue, 26 Aug 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="exxnCfz5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537834DCD2
	for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218230; cv=none; b=OIZpZWuIacYlO0i4wGYcebEkHIxPZ8x/d8lipKOu2P0gWwpaBlWnYMt5yZp4XdfiifS+a9UHftCNLnDZAGx9PVi/PbRxGAAPGYv2bFdzotVacqNv6QPMFciOWWmF7nsM6n0XkeafVFTGe1c5ey8UB+0GGGLx3YPnm2nsw5xa7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218230; c=relaxed/simple;
	bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud4v/xi/dlg18bqNVtkxgxKtNA2yizdKStKOYSCRnhU2jGppK2tTo1TnkWH6vfbUPolklPIzGdRPDoua8gY8zmnCAYJx/1OvgskjdtiMfTEvxPdf11S7JEKQ86AL/IDW79yvAkYX58+9fQfbw1h4F2vaIRgZ3vVBSRpEL6ZOSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=exxnCfz5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c7ba0f6983so1434416f8f.0
        for <cgroups@vger.kernel.org>; Tue, 26 Aug 2025 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756218226; x=1756823026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
        b=exxnCfz5CRhh3zvyhNX+hb09Wkm+MFlJw174YJMBoBIxxzQ+vZU69RPyqA41VAalfO
         Q+X5R2ENXNBrYUmNmxKWTJSL89WylEOOclFn2XDB7kN80mrzqrZJ+lnBykh3Y+KLKIFF
         QZIHDNsF9CrpHn/mG9x1E0VTTFmvbR/ZHRuIaGQkJweX8cEdOZ/cFAtAUuYFO9ftCCgN
         plnwScVAcJP8KEmPPuiLJtRTPeX1ye0pCCgg4V9AKKk+chnkrJfQ3ph+ychUBVcPCIqX
         dhEZvZ3nyXAb6iVUSAEVVyzHUZZoqABzAE1L/4wTJVLWzKLAAD3wIno5XDLWjibg1Bpl
         v4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756218226; x=1756823026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD1Rkv0S6PHMLGByF520S77rRy4Hnx+nEEIQ7LpCzKo=;
        b=Ogcjx0wJps/qgnJvuQXPQMFyX9/lIQRZ9AoXd2dGO/o8DNnxWmvHG+mC5crUMBbUxG
         epUL26yQIuHxX/riiJFnY8w2Ad9FHeQDAN/KDYnqGMwPwuiedCkdmCdayJBBPkQdQYxr
         I5SfzAoTWV5xcwdBM7pIbo7DVOdCbPQt+cGGS0E2ahM8Fs7vo/AWs5Gf7CPJL27PSSgz
         3OjxGWjVvxhneY1UexD9pDxtE0qXnuAa2jvpELLr/UQZ3iPstbtr6ySSiw9904yzTyGp
         /nPZ4eJCKUrPkQxP7FO6hk64Mb43gKCv409PRwoOPQeFrXERODwMxSU9iATNW5gq65pp
         Uh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUC0XDf0189Xw5yOjt72MbhqZCjHhpwboa3i3eJv88ULNEZZbtqYDYReMThT+AlugBz1/pt6zU0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2KPH7C8eyF8Cr2CbLZvIWaqr+vQ8lwmYoL5TbDGzaMBNlhItC
	7g+exeIYlzlmvCaS6pqXXy56MBRbIRaDd66cjHr/GkTJUAP4VJmvpKhzk8dM1sXbVCI=
X-Gm-Gg: ASbGnctr8Y/1DBP8NfOBLCXjQtYl6CQFWDKPYhtl0uv6zn6t02XgVtDR130w22XGRbH
	cp/NRuS3Gy3zIOPW+yNbuWvp0J5qucLcRYfSV6j1kvqaDRrQRyEfTam+FrX+koU/rsvagquOOGi
	N29ug1ONuxdxG7H/sFpNiSKtzOaQDWPrhOvSgVJPXx/g+JxNDib+cPB1LUz5Yp1xOjl+4Yz1Wtb
	LkuvgQTsBdP0hDUaFzPQhPYOnYvFaE7wWVIuFAzhIM171gPa2FhTD2cdLdrmFT3TT6E86t/7pcy
	p7JLqem/NkRLNH761latZe1rJEpgBzUqrCwOmheUUr7dmrOrlEo4BvppruHCxyl8pNSj+mGfHUX
	xJ8mCObOPDlF4EhRSSXQ92U1dtk7wYhDUFFi/nD8kGh0=
X-Google-Smtp-Source: AGHT+IHNbU375z1HM3iO0OTASldmwJtv+PMpWsx2AugmIMC46UnJiLI3kABi4oagejSfypZU/JGA8g==
X-Received: by 2002:a05:6000:4006:b0:3ca:2116:c38c with SMTP id ffacd0b85a97d-3cbb15ca336mr1713006f8f.2.1756218226148;
        Tue, 26 Aug 2025 07:23:46 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770402159aesm10800319b3a.82.2025.08.26.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:23:45 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:23:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
Message-ID: <luegqrbloxpshm6niwre2ys3onurhttd5i3dudxbh4xzszo6bo@vqqxdtgrxxsm>
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
 <20250825032352.1703602-4-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7bzqvomqxrybdnkq"
Content-Disposition: inline
In-Reply-To: <20250825032352.1703602-4-chenridong@huaweicloud.com>


--7bzqvomqxrybdnkq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next v5 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
MIME-Version: 1.0

(I wrote this yesterday before merging but I'm still sending it to give
my opinion ;-))

On Mon, Aug 25, 2025 at 03:23:52AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>=20
> Replace repetitive locking patterns with new helpers:
> - cpuset_full_lock()
> - cpuset_full_unlock()

I don't see many precedents elsewhere in the kernel for such naming
(like _lock and _full_lock()). Wouldn't it be more illustrative to have
cpuset_read_lock() and cpuset_write_lock()? (As I'm looking at current
users and your accompanying comments which could be substituted with
the more conventional naming.)

(Also if you decide going this direction, please mention commit
111cd11bbc548 ("sched/cpuset: Bring back cpuset_mutex") in the message
so that it doesn't tempt to do further changes.)


> This makes the code cleaner and ensures consistent lock ordering.

Lock guards anyone? (When you're touching this and seeking clean code.)

Thanks,
Michal

--7bzqvomqxrybdnkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaK3DZBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjaDgD7BWwhODnaF23DEYFz1AQE
g4NAFCp5eUn5EZgaV/iKRuQA/07xZOfgw3gsWo0zYipmhPX/dR80gfIZW2VRCQYP
RIEG
=raww
-----END PGP SIGNATURE-----

--7bzqvomqxrybdnkq--

