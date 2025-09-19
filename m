Return-Path: <cgroups+bounces-10286-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34813B884A2
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E649164677
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350B2FDC50;
	Fri, 19 Sep 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Urc4/gz0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EF2FD7B1
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268582; cv=none; b=AaBLElpor3AFlFLbcpIr2O0SYnSDuP6gL8zgcq8tnD9Uoq/Ww9DpsHWPT1O5T+q6+p4BHUYMr8kilH74h4gZ75+PTGvgZi3voKLyi0DCCvxKZXiyP6av0rtKw5nXDgOQwDpVZPK/iIl2qPkca56mB54erdm3xgylu85oGeVIoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268582; c=relaxed/simple;
	bh=7ccBLgFEC7dh2afh+ptzbIu09DTxwapC7nbQtYBNSiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5VcyZDpWv6SIhl5qUCxv1y3zJE8O/jD2ds1fe50WRdxwMoJ/VdAWGGoOkKZWUPESKNPhBNVAW7GfxUYuH1UonUqB7o47asP3TnLMYyBhk42JbFJ+c0ZpAHljrjMnelhIYXa7q8YA/Cxs58uscUqQm9SxjYYArWxrox+j8k85Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Urc4/gz0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso752518f8f.3
        for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758268579; x=1758873379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e503uYi31si7FxNgvQI9cCy05i3B7jWTsXXdNcfAPKM=;
        b=Urc4/gz0hdBVhGx0eAXMCBmHb5wyqmmNp/JCi8yehCLuXxKJEJ9UKkz1STtG6TuZqK
         xP0a3JBcmJo4CCSQkBGyRigT34wyemFV+8pogjkxv2vDDA4h6q9Q9/4qNpzdrppCVLYA
         xZtCkBwoWxUJKrCZLKNQLk29Igdg3bXbg/QU2y2be//ubETr6hka4B1VZpFyTpubJu+J
         XxKhynRXHIIw8RCPe+7bytBp2EyniCRMs8orCanejQabobArkYMRxj3SpyFmRWU3w6De
         ZRxi9zf2O8xT407Km3bfUJIw4boOT2w/+uMs4hF8wI8l4N8UR6ytWXS/ow115JnrMGhy
         x6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268579; x=1758873379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e503uYi31si7FxNgvQI9cCy05i3B7jWTsXXdNcfAPKM=;
        b=Rs1DfAD3UX8RukZb2oEBmOGNyMn/yD02R3o/DXptgcbYDVzb1nqydCwHpZTE6sCbFg
         NTqx+2uVi5TTurwQBrqQZt8eEkIX2qmEED55Q/rEfWa85DBTRmZKG1iOd4qUbZn89vwq
         MqTGL9R51g0snaqagsfC47ttvGl7EQ5eGCwjOw4l1bzh4K+kXPlkIRe5aFh20a2z+v7I
         fRxlfMlEiybPumWWFEbzS4QCG3FtfWd+VmWhd+++AOPmoRsseLIbHuCH1UT5f/bV/9gr
         1G+3eZNS+hJh+9foyUn6sdIG3rtCKJR0yuR2PgLVXe/KRUTonff4f2HHLkKFCuwn+DD/
         6dTw==
X-Forwarded-Encrypted: i=1; AJvYcCXlEXsqFdB8NmaHhucwI1AQUzTPm37NiC3VMpxQuyVQDPn45KpLzTF8+6zEEyqi/HvKDKSUBFUf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JoDGAw5QiN90K1qrMV5cyjlQFkwwELuyVEuV5fW1/IDzyvtc
	82NPy4U/EoCQ8Cpr46gvfPkriWBTrNoq+i6lpbHmAwFnnTy4Wewbto1bdGL3v2dN2aI=
X-Gm-Gg: ASbGncslG5lGl/pA2hMrWJPIqtfERB8jiTTaJt2/qVa1XsODyBjcmV63YwpLvSOCNSH
	ZE5ApXeXxUE3XUG66e+m5sPKmXKaF5Wvb8uXdfddL+FpX4Q8sNKTcEegabqiIOMgCS7kl8nGh3Q
	Isq7quzLYMB7gipyK+BfU6LDChUTSQ/RqEh2IZabcuKqMJy/K9iURP84Nf5x4wfc76QOpe7fSE7
	ddMkJxkMOkrvIT5mO+v/0VH+OLCJkkfa5NV5R7H+WVZIQ/y2A7Tj01YmNG/6Lil7ej3Gm5YHASH
	4LSl61eRvcv1LrCrVty8FmI4E1X3xYkkXkK1Eo7JVFr1hBRuekc+QUScyIfYvFiVu9r2AhMnwIE
	IZA/lrk9xmY2a6lRLUPG0xl2Iat3nvuUc4oG/MwVfOSM=
X-Google-Smtp-Source: AGHT+IHQdbdvJcdlZ1odGX9276uxFwXiMh4AQ8Ux9QXmXyA3pQnyte0qOr5U4+PiwJeFdw4dbYpkyg==
X-Received: by 2002:a05:6000:2881:b0:3eb:dcf:bfa4 with SMTP id ffacd0b85a97d-3ee868a75b0mr1446794f8f.54.1758268579005;
        Fri, 19 Sep 2025 00:56:19 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd64dbsm6409147f8f.50.2025.09.19.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:56:18 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:56:17 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux cgroups <cgroups@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4] Documentation: cgroup-v2: Sync manual toctree
Message-ID: <irevezhj5fuuc42fwyhnbj7ki2bsxwxiu7z2by2ot4goab32gx@e6a7eyrudwaq>
References: <20250919074347.33465-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="id2skixzp2ud7lyu"
Content-Disposition: inline
In-Reply-To: <20250919074347.33465-2-bagasdotme@gmail.com>


--id2skixzp2ud7lyu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] Documentation: cgroup-v2: Sync manual toctree
MIME-Version: 1.0

On Fri, Sep 19, 2025 at 02:43:48PM +0700, Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> Manually-arranged toctree comment in cgroup v2 documentation is a rather
> out-of-sync with actual contents: a few sections are missing and/or
> named differently.
>=20
> Sync the toctree.
>=20
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> Changes since v3 [1]:
>=20
>   * Keep the manual toctree and sync it instead (the same approach in v2 =
[2])
>     (Tejun)
>=20
> [1]: https://lore.kernel.org/linux-doc/20250918074048.18563-2-bagasdotme@=
gmail.com/
> [2]: https://lore.kernel.org/linux-doc/20250915081942.25077-5-bagasdotme@=
gmail.com/
>=20
>  Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

Thanks!

--id2skixzp2ud7lyu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaM0MnhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AgxXgEAwIBmBJj2El9uDu+ScgTj
Hhpx7G+THHfpcIEoUvjKhNgA/2QlaHXdxJyHXYesHnmM+kA/4u73m8acdKfTpCdS
HHwL
=WVGN
-----END PGP SIGNATURE-----

--id2skixzp2ud7lyu--

