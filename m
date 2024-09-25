Return-Path: <cgroups+bounces-4946-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D714986596
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 19:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6E1C242CF
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5F34E1CA;
	Wed, 25 Sep 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bfhhwJr3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300C210E9
	for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285355; cv=none; b=aGOJmptWVf3Y1JHeBbLuPlVPrlcd2+s2pz5TrxRANTzt5J2dKad8OM82Kn1SKer7Eoc6Hja6JdUqsamFyC/ZJTWz7xXPJ2qYHwzDEwvOnJG3s2g9DvEzaYWrI3ldysMQumhYMhyPgGg/XqMBvEw1YfvLSuR7gER/vpJWNkQhdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285355; c=relaxed/simple;
	bh=BIwz50/6Uw+mVr/SE5DXa8BeYPqSSCGKoWKdAD38z/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXhjJLopLeYxc00QYoGIBPmmKzOH76evRmcerfhB0c+FclUcCoK5uEXWWbbhcYVhA7xzdq1BPRLO8VcHpe1Xc8AXSADFWY3huHxhyUyTbknWLroWq6j4CbZl16Qp/zFuNYedFp954AneBn5AMfXdShfeLBUs4JcO97ZWVxVbPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bfhhwJr3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso261749a12.1
        for <cgroups@vger.kernel.org>; Wed, 25 Sep 2024 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727285352; x=1727890152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVbfrbs+M41Wux+dZB4Njd+AGGryn2VPSVJ3JHD6LzM=;
        b=bfhhwJr3t4Nrftny5usYvCg1rvUX8Ti4uuPMePVtZrQACbBgdOqvgrSHp+pfUofyxS
         Bzfno8/GYhm/bNugV5BSgIiQqfGI3yZMToGGm23ENsf8aQDx0o+pcSSuRY2VQxgE30DD
         XWGhx3P7RY22QeD6R+8oyXwGjGiof5A1GeKCiZlhlGrjTJN5Exc/fc+A6NMoGqSyed9v
         bBbqkpVGMzqB159e9yypwuPpgYRXOWcYump4J9UELoviovbRsLfVlUJQNkSaSNjN4Pi4
         1dc0hUY7vRjRB2/Pl7ZyCImbtwm1xuBuUl0K58ihAIXyCHK/sKnSUQmnMFn5u8PcTiP0
         hxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285352; x=1727890152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVbfrbs+M41Wux+dZB4Njd+AGGryn2VPSVJ3JHD6LzM=;
        b=TFFWAkIrvcdr04u6Fsor3lAKuSw/0RarzcQR7lmOkIhTtrS6cn5Yp2LQgcoG3IiGYL
         wkcH2OIe1XWuxJPVVlMLMmL2tZWRERt5p6hQ9gWB4mrr+QuzJ09DF9LMh4DCZ7hX3V3F
         XTDMtvxRMCLnonaYnGILH3FzXksOCbBJWsgbnK60RrFgQV29DX+k1Q6CqEC52tYu9g5z
         LOAIETcunecEhVUoxVf+pVMqyUDRUYm8uuTFfk3FTaWwY7nWrK8EXhF+f2UOtea8Ixmo
         8qhOXL7Ip7fbMEu4PzvByxJ6MvO0tSLWPph1c39kMx4nPqOLeC+QbEwZj76qMzXl9NW+
         T0tw==
X-Forwarded-Encrypted: i=1; AJvYcCVluZwNBhL7yfeGCqAbGSmViuN32tK5aUkp31QBtMNkxOK8rfGd67+Vz/qCzzaP2kBluB6GfP30@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8niqBiFBq8IM46Z65K52APa9hxruy8OBjK5VuM9oYOYSF5Pk
	LePtorVbwLA97nj+3lLqhYFI8ttrISR1/yx6Q4KoxP51dZTX9aOZC9hs0DMZcq4=
X-Google-Smtp-Source: AGHT+IFvi4iN9m1uiUrppWML4F7ZmKzoJG0QDweV/Wxu3XsrO9mOtT3CL280b6fMoOQbGtz9wanx5Q==
X-Received: by 2002:a50:c907:0:b0:5c5:bda8:8635 with SMTP id 4fb4d7f45d1cf-5c8777c8d32mr491116a12.8.1727285351929;
        Wed, 25 Sep 2024 10:29:11 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c877a6c985sm89944a12.80.2024.09.25.10.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:29:11 -0700 (PDT)
Date: Wed, 25 Sep 2024 19:29:09 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	longman@redhat.com, adityakali@google.com, sergeh@kernel.org, guro@fb.com, 
	cgroups@vger.kernel.org
Subject: Re: [PATHC v3 -next 1/3] cgroup/freezer: Reduce redundant traversal
 for cgroup_freeze
Message-ID: <ce55tpeerhhlq57k3tc5xwffos2ys5qsl7kdnxdcf4xct6vtaf@yxwk7n2cbo7h>
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <20240915071307.1976026-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g76p4w2iepm2nmzs"
Content-Disposition: inline
In-Reply-To: <20240915071307.1976026-2-chenridong@huawei.com>


--g76p4w2iepm2nmzs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 07:13:05AM GMT, Chen Ridong <chenridong@huawei.com>=
 wrote:
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  include/linux/cgroup-defs.h |  2 +-
>  kernel/cgroup/freezer.c     | 30 ++++++++++++++----------------
>  2 files changed, 15 insertions(+), 17 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--g76p4w2iepm2nmzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvRIYwAKCRAt3Wney77B
SeyrAQD6t/jRjEIxm6XWBFIIuir4X83ZY/iU0FKtcGvHZkJ15wEAznAfx/PlYVqE
y08N19hpge4alc8eOb6J2wfQ2NVt8AQ=
=LszV
-----END PGP SIGNATURE-----

--g76p4w2iepm2nmzs--

