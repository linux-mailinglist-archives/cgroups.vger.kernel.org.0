Return-Path: <cgroups+bounces-8548-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D553ADC5CE
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5CD179789
	for <lists+cgroups@lfdr.de>; Tue, 17 Jun 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803C290BBD;
	Tue, 17 Jun 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fby11LH4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DD29008E
	for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151305; cv=none; b=Y8a0xbVFx3z0cI3/nhCoyhqanWgAl4EigjppsVAWKCDyjFR8XtqJlFT/re6zyB+BG1jD1wsX6XI8COzE2ckIPkLb3i2LBdFqOxmyQMVLG1X8fN3hYacvAkpMZvZOcC1t7dlZeDof4eL85WHpSTSxSSdsT347ibZVLGwOE4SnQOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151305; c=relaxed/simple;
	bh=z0fKOYwV+dsFs21nS2jxYOO5t4aC6ljU0NF3BjIkz5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llBtBM/NMsr6KfTGfPLK+hPgBXFfjwBrAoIDVSc7k4KBOX5lCAZHO5kzVeotAwfAntCKNOQGPaYH1P2sTwghq8uU3eV6zN12Ewkh+spkQSZyzukUHRzL14wnwJWL3IFSbio/Bm/2o30DSOx53bCc+pPkUTFjJu3TOUOyt0g8Zgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fby11LH4; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3729960f8f.0
        for <cgroups@vger.kernel.org>; Tue, 17 Jun 2025 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750151302; x=1750756102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gKAD3svXOw7buq7HtIEdYKllqfFeijr7NxfdlNG4wcY=;
        b=fby11LH4Wt3FtCM6ebjWHIb+SlIvq+3hOl1Vyr23S8WpyRU9CU7V96JQujTyJsIpVo
         jfxLDPyovDLDvY+4LqXuNVtKDlEDME2dzx9TPdb1jwrvv7ACVCNm0Qy0HDaLHusdncdV
         eT9dZvtN7Fe4DQTVXbr78dGf1Q9Y8ouop9sOz+rLPaBID/hedM5EZT6oKwwkwP8ccqoO
         FiR51C7qvCn+FXbDwJi+rawRsEFl+H2ZzLjvBn2Ey00SFept7ACNSwlhOtspPwoytK8l
         L3A8b7fBAU8MmcsjAyvuKvxpSfwSQpHJe78PUj50WO6w3qk8K/kdRUP7XrQI0Qh+6sOI
         lG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151302; x=1750756102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKAD3svXOw7buq7HtIEdYKllqfFeijr7NxfdlNG4wcY=;
        b=YMXDMrBaaJZ05VI6awWu1qlhW45Lqpf4CcL8PG2JLmBw5eqAlWWxMmiz2ywwmnLgN8
         HwFSaROmC+0+aZZVDkH0n360NzwXlmAbifsdUGtJtqZ41fEv8N9tZd6ts9Bax1jxYgKZ
         zTe2+8U9KR4HSiaTEcJcH41A/pkfdm61bM+xSjZI/A3N3tvnqH6DPAO1xDBKJsKwhBIn
         qf2r/KxHlHi/pNhQXpmeBBeBG3XnOa9x2uXbOh5un0GZ5PbZhBL6vYgvtLWdWjpcFoNA
         f+ntGExifHVtkyx9B4c1nf/9ItU83zdJ0Q+6DRvqVMjxTAv56yUksnLUhUT2Oh5daCh3
         /Ceg==
X-Forwarded-Encrypted: i=1; AJvYcCVyEVo1IwyffXpx5921mX6IFlTVsViEuyEPD1JpWOYs6McPq960H+WcSHMVoYQPVct5ra+HjKtT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsb7nZw2MXhHfDZSisLEFGy8oWr5C+WamHlyvvNTuLMbwDvASA
	0FInRHq+IUqgMAP7Au3+Fi7yl9fpzc0Noe8etL5CQ+nCSCV/LyvRKT6BxEATFB22UpT3467hU3Y
	O+ITWaet1bQ==
X-Gm-Gg: ASbGncvxXr06jPOW1qriUvTp77m7bM+3v0aelMBK8pD1eXCDy+sRxabKvI3CHLPSiqw
	hJtFrh1Qof/TiykAagIY8LePaKJryi6/TUdjOPS6Evjic8kk/eCrdERSDiu1WSTzbGTkI48HFv0
	KySAEvaQiOGY1dtTcBvm9KrdnyS1rpKl9TI0khwCvWlZcNluAduuyN7qyGC3tI7IgSdeNBZfSvp
	dcevLomptH8X8LzqGBYyUuXJBSvayAzp74mDXYFKWb+RIYkrxB0CF2W2a2lKG0n87WfUC6nuIrd
	CrQQ+EDw0FENuFhpUI3BqnsZBvJT2ySjUfweULHUYiv7OO/Qnr79ZHjs9zQ3dNcr
X-Google-Smtp-Source: AGHT+IHZD55Cs3Zu1HygCPmxe5Uy/nwrwnFD2un/64EwIJaV4i4CI3mWQiyOSmwe7CiHE9VlU6rzCQ==
X-Received: by 2002:a05:6000:65c:b0:3a5:8a68:b81b with SMTP id ffacd0b85a97d-3a58a68bcc4mr888857f8f.44.1750151301539;
        Tue, 17 Jun 2025 02:08:21 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e16a097sm174029075e9.33.2025.06.17.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:08:21 -0700 (PDT)
Date: Tue, 17 Jun 2025 11:08:19 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jemmy Wong <jemmywong512@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
Message-ID: <2dd7rwkxuirjqpxzdvplt26vgfydomu56j3dkmr37765zk67pd@aou7jw4d6wtq>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="toh6m6x3hhh3r2az"
Content-Disposition: inline
In-Reply-To: <20250606161841.44354-1-jemmywong512@gmail.com>


--toh6m6x3hhh3r2az
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/3] cgroup: Add lock guard support
MIME-Version: 1.0

Hello.

I understand why this might have been controversial but I'm surprised it
remains so when the lock guards are already used in the kernel code.
Documentation/process/coding-style.rst isn't partisan in either way.

Johannes:
> heebeejeebees - it's asymmetric and critical sections don't stand out
> visually at all.
- I'd say that's the point of it for functions that are made to
  manipulate data structures under the lock. Not to spoil the code.
- Yes, it's a different coding style that one has to get used to.

> extra indentation
- deeper indentation =3D=3D deeper locking, wary of that
- although I admit, in some cases of the reworked code, it's overly deep

Further reasoning is laid out in include/linux/cleanup.h. I noticed
there exists no_free_ptr() macro and that suggests an idea for analogous
no_exit_class() (or unguard()) macro (essential an unlock + signal for
compiler to not call cleanup function after this BB).

Tejun:
> There are no practical benefits to converting the code base at this point.

I'd expect future backports (into such code) to be more robust wrt
pairing errors.
At the same time this is also my biggest concern about this change, the
wide-spread diff would make current backporting more difficult.  (But
I'd counter argue that one should think forward here.)


Further benefits I see:
- it is fewer lines (code is to the point),
- reliable cleanup paths,
- it is modern and evolution step forward (given such constructs
  eventually emerge in various languages).


On Sat, Jun 07, 2025 at 12:18:38AM +0800, Jemmy Wong <jemmywong512@gmail.co=
m> wrote:
> v1 changes:
> - remove guard support for BPF
> - split patch into parts
>=20
> v0 link:
> https://lore.kernel.org/all/20250605211053.19200-1-jemmywong512@gmail.com/
>=20
> Jemmy Wong (3):
>   cgroup: add lock guard support for cgroup_muetx
>   cgroup: add lock guard support for css_set_lock and rcu
>   cgroup: add lock guard support for others

As for the series in general
- I'm still in favor of pursuing it (with remarks to individual
  patches),
- it's a good opportunity to also to append sparse __acquires/__releases
  cleanup to it (see also [1]).

Regards,
Michal

[1] https://lore.kernel.org/r/Z_6z2-qqLI7dbl8h@slm.duckdns.org


--toh6m6x3hhh3r2az
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaFEwewAKCRB+PQLnlNv4
CK2vAQD5wq0LatsmiHUSbsmOJCpcGVFHuDfH/0uJGeQSmsKWFAD/bb7kMZdxWv52
HASiX8FCeJv9AO+0Oc7OQOOKl9+Rlgw=
=luDQ
-----END PGP SIGNATURE-----

--toh6m6x3hhh3r2az--

