Return-Path: <cgroups+bounces-13017-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC6D0B28B
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 17:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA3C305BD72
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716E363C6C;
	Fri,  9 Jan 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GFIsCHdg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571A363C66
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975164; cv=none; b=dOmi5QC8gg4i2hqXUH3twmrNJlgAJfaL6rcxNRmsaqcNITt+YUQmGwh+C0znKElSAsFA4IN/BhY4Z5cTPLi4K8jDYR7fSuWPlUcoCaPYu3s5bQvALE0zsm49Vq5LsrqSSeTtR6DkQCBQrFreoVsJ3KcMXRhTKJyTrteRPtqp3A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975164; c=relaxed/simple;
	bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvMb5d0Qm328yH1NaNQ6Fd3ImRRSD5rfSrYeoFaT6TcQ1d+iY8Ulsj3piiRJkXXN5nrPPejSAvZ74/E9Wp61/peqvyfWFzdV4h7nLpg6igNrdLho/SM5HdHKQ1CwJ5otYvKGogbFWwKEs2ECxxuVMpc8d558rBsxj72HsnJ5oMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GFIsCHdg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2261141f8f.2
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 08:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767975152; x=1768579952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
        b=GFIsCHdgo5Ew5jPavjDOBmjvuUgGrcZgeEHM2cksiftSXsFTCs3j/BsRwC8pbJhvl0
         czCoa0b3YuiV3xIUk/NrXx0FiL4ffHPe6ZEjeFNR3sI/K3jWw4rFR69RL8sQfOq9tzuZ
         8KxrYa4DqKDh5CU4Vmax+EFJMfp3ZCUCfEMIJza9rXFSbtY4kg7PtABE28AFwuQx7nYv
         4tyG1bWdQFsilaDRL5E9DL9Y+mR1dS8Qqr7fX84dNjFKkpteucnOPOE5hOZGBYEWhU0V
         k2Wpue9SDW1oAQ6jxO9VkKZanKFqqMACOs71h3dG8Cm92yDb2nSqDe9MlvuxUL6LUk2j
         1rRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767975152; x=1768579952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nYTkLWPl1UM8TZDYNKBL/hfXO/2Wa7x8HBtreZOD0U=;
        b=JirppSGMujrtMn5RcX3bPALvrZ8nXGVm21ZOSm0NANE4dMO0sxOTq9UI0c+7AUVOxN
         RJ6ZC6N0HzAjHRSq229nVnV0kKZtyg5dt8SYEjbrSjFOhIT/MmrcggsdRoD3ExZMtUf1
         on1RhUpcW8w50QyNHeZpINMqmt6XvjaUJVOFw0c2WhAlK8+5mR5O5ycyanYRZQ3XV0Dk
         ynViMWJX4ntgo/Y+CF+HbtNaoonLz77llTINDARFJpmYOSeyzCGrEm5KmrkL38MdA7y/
         +MOoiSAmZLHNx2b1sIkX8ydfvV8lUF7nOdCl6o/5/kPrPLWvsD/9oSSGehAxcC7ikoSm
         Snsw==
X-Forwarded-Encrypted: i=1; AJvYcCX73BFhs2OVlfQ9cOkxCWCyCVJwDu9sEJJgGEmsMVtmEufyk/CJxNwCP4qlqzr+0ySsTNOYP5ex@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWNIR8q2ufsVKRJS9IQOCs92i9auKCb+rfmUbCjOvvOBTf9rK
	B9qQSpj2O1b5cholM5V9xb7SMlNnHmIJP/M76hMqianiXcbzEgPQHmGhy3ga0hXC0M1G9PmvlqU
	IXGhn
X-Gm-Gg: AY/fxX7KXEOY7odKv4YkXfvI75y7EKV4JacEhvLOX1TEvnOF+zG6TMZAZRpvydTTXfs
	u5i7MEX2dUfmscjxtUPLonGkHITxUpC6tOmPDau0S5dlVjyA/eFTJ1uNyYFDFoFNy5WJUTVeGgr
	N998EZPmBZsvc0oRjvcNGuCaMe4praC9WqvbTkUc4aOdjzuYRDq/5UVZ3lUNA5ZvzqSpgN/+MdN
	I14aWFbKuasPzf3bBfnSmE/FA9ZMW/WsOHgwwHYtS8wnOVGo0BAHzXoJ647QkdXxOvgB66Yj+ZV
	5FNFZyoSksK+aPtdl/cmVCihQKEhbVoRi1FexMTxIg1auNrY7TqVAzQ1Wiw5dVmBk05SEX8ABt8
	djdFS8k+2m4mYwhK/q0Qrt3m0j96IvbFdTN17rL72Sbfw4f5DjET80aarbESYXi8BbQJ37Gbsll
	v1gOlKD6SO1/RDnm9PDCAVhPU9v/REjGU=
X-Google-Smtp-Source: AGHT+IGqi0WGxFAcDFwR5qEinbKBaTRMIfIyWMKP/Zy/UAYWvqJ9DVeTS3bRLdcV05itFpZa0N5HLQ==
X-Received: by 2002:a05:6000:40e1:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-432c37a50aemr13205705f8f.44.1767975152120;
        Fri, 09 Jan 2026 08:12:32 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee24esm23190979f8f.33.2026.01.09.08.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 08:12:31 -0800 (PST)
Date: Fri, 9 Jan 2026 17:12:29 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Sun Shaojie <sunshaojie@kylinos.cn>
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
Message-ID: <oaewv3tyxpufdn3d3tnb43d2qyhqxlorl7fbbp3vwbw3j4jxn6@lonmplwkfumn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-5-longman@redhat.com>
 <chijw6gvtql74beputm3ue2zu2vmrwvtg5a2bn3wabgkqldq4d@obrdh4znejaw>
 <990be63e-3884-4933-9ad7-bfd9f2be05df@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2bzswrle4z6exsi"
Content-Disposition: inline
In-Reply-To: <990be63e-3884-4933-9ad7-bfd9f2be05df@huaweicloud.com>


--c2bzswrle4z6exsi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [cgroup/for-6.20 PATCH v2 4/4] cgroup/cpuset: Don't invalidate
 sibling partitions on cpuset.cpus conflict
MIME-Version: 1.0

On Fri, Jan 09, 2026 at 09:30:08AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> > Concept question:=20
> > When a/b/cpuset.cpus.exclusive =E2=8A=82 a/b/cpuset.cpus (proper subset)
> > and a/b/cpuset.cpus.partition =3D=3D root, a/cpuset.cpus.partition =3D=
=3D root
> > (b is valid partition)
> > should a/b/cpuset.cpus.exclusive.effective be equal to cpuset.cpus (as
> > all of them happen to be exclusive) or "only" cpuset.cpus.exclusive?
> >=20
>=20
> The value of cpuset.cpus will not affect cpuset.cpus.exclusive.effective =
when cpuset.cpus.exclusive
> is set.
>=20
> Therefore, the answer: only cpuset.cpus.exclusive.

Thanks. (I later arrived at that conclusion by studying
Documentation/admin-guide/cgroup-v2.rst.)

> If cpuset.cpus could not be used for exclusive CPU allocation in a partit=
ion, it would be easier to
> understand the settings of cpuset.cpus.exclusive and cpuset.cpus.partitio=
n. This means that only
> when cpuset.cpus.exclusive is set can the cpuset be a partition (it has n=
othing to do with
> cpuset.cpus). However, for historical and compatibility reasons, cpuset.c=
pus is considered as the
> exclusive CPUs if cpuset.cpus.exclusive is not set.

I reckon this is the difference between local and remote partitions.
I.e. non-empty cpuset.cpus.exclusive is what makes a remote partition
together with non-member cpuset.cpus.partition. Where the latter may get
into the way as an uninteded local partiton.

Cheers,
Michal

--c2bzswrle4z6exsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWEo6RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjISAD+PtIh8Hw7ChSTbbpB9n/I
EZmtcsvJGLy+zKIi8ieqW3YA/AgypfRIytJKhva0dZqwrLB0OhLD25ULmEUPQMSf
S2QA
=tOrM
-----END PGP SIGNATURE-----

--c2bzswrle4z6exsi--

