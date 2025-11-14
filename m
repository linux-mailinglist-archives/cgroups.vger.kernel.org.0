Return-Path: <cgroups+bounces-11960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65098C5E564
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E91A3A1147
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C3329386;
	Fri, 14 Nov 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SB6MVX9x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D86329367
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 16:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136891; cv=none; b=X7yvehmiWOJ3lCjtIeI8852fSknDwPrmNyenD28OnFVGsZNJX+6JFB+g4+e102uIGrCF18hZJEGAFwtXmql6qTcdDsKgYtoQJxWt+CY3LpkCo9WUmSvjGlrVMTZKoCSL6d5Mivx9BePueK+nH71V1qrbQyEzA0p0s6YT+HTtv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136891; c=relaxed/simple;
	bh=3ym9hcDcavEyVb71JBBWRlFTktspLEDiAOi0d3d96PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQJKWX2vJLbVOiPygh7VhxoxoRDPKoWJui3AevX2xKX2FkkNdSBh42PffOhQs/io4Ew2NUMflvbMcePnTKV4MQkhG8jNIGmCX3LYDD0SWgwmSM6qTIfCR6KgMtPEdIwHW45FMkA5QRX7qZcTtu82bhQBtllNdvz/URF64HNNYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SB6MVX9x; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so453485e9.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 08:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763136887; x=1763741687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9bbGFOxixkcmKzkjDLBUH8YjYM6lGTpT38wHmTm2Z4=;
        b=SB6MVX9xNg5Fvq4kjfFTDBNswzy618qEcnYFYFrOizMCYiPU1DqWqp7UEeIvptQ3Ko
         5VYp8ccSUb4HtUsfvmwepmkgOixTGzz2UdUxGioM7I68K14AdL7or5DDN0NToxBskr4F
         EiJlEwJ0pZovjpTYU+DMVhiMBDKmCaK/MHUROIj6flRALJ8b5005exK+Uxw6q6fKHwbr
         63d3NCTasUHhQ+5uEljpe2gzQt9YByHsDAESKbX+jZjq/rU2p8YsyWeRA+hDfKwIAPUG
         rY1EKB/pvFLH/evXDUePtYLGXUJd3iHGo3iCUPdPbAPdPeRykvPl3HWD4Qqir/FvNU3J
         L9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136887; x=1763741687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9bbGFOxixkcmKzkjDLBUH8YjYM6lGTpT38wHmTm2Z4=;
        b=NJBbMzacmcFofcMHUrQ8+WHFClBS9aa5nzSFkCRm3dGhnwPvTJdff61Cc1BbxPE5so
         TmFidqo5+IRLr94wCWpWXietXG8i1vz73EU0CsI8rOl6AYxsOixPdTzSM3h+/GxOR0sW
         oA3ldj1zl8b4Ze81wdJc8918AtLvBIYq68JKvjpmGX7Wxf4xw5yMpfs5P/0Zzycww1A5
         QzRCmVOSjEJEt+PzyBWQFdS2aWSAFH5PNnj3taMm2N2p9nTjlk7YC/6Ixhg7QCpTyJam
         w6qmplv0srSxKgRoZ06jtlj3zFUiSBJyXcNbOKdutob8fjmtSdMP1M4KXbdHyVwxg0lU
         3BfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUeZEQBOOPx33Sw9g1sHjWNCTZWGHcLBfkzK0Xr2eULgEoims2tY65QoThSegXlh2p1QV0aQIw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5AUn9NdlCZpmsTCmihj+gE5EwcfKjPdd+KoOnWKshgynaB6ed
	H+iZDXJcqESQxfGlzQIPU9KPjEOH7jVkIpmuyOJNamCNFA2P+0i125fN9jsUkbh8YYA=
X-Gm-Gg: ASbGncsehzbF1vN4z4V+Wwsm3txBQjOwNgfamAF739Uv27AXMhbo+YslNZ/ks/8TOpL
	iMucIfI4ZYKJVC6xhfWlZKizsBHdzV6AElfdc1p6594V7FEoP3fe45WgjRI1pXoZPqNO/t6TeiF
	kmZ7tZjOxEOTADvfsK4d4lWRsojjFeEgmz/Bj48jboMzZY4OF8NJj4WFc7R5dWJaBMeHNGf5fkV
	109k4hEWxw6eO19mzJjSg8hXBBfViZuTDrEx9ASBT471+z0Lj5yHHjY9XsZVJ6cx0lKsc+rMmj0
	pbhoF40AmbYRHasxnzumPP3apANkjX0cvnKIawI4Hxd8UNbOfCHDE/058cibz+xSVkhhDdfFFwA
	9XMXLcIT3mYkOYEY5WwmJ561GCveEvUfrUg4egp3SxhE6URr3BSg4U02U4ATkGNOot5s/xFCLGR
	b9IBUEnJyInujbUqwX1EwsAh3NJNHxTEA=
X-Google-Smtp-Source: AGHT+IG1E5IWAEk6xijIYXYbonIi0wedCVbGGYbaWBp7CoJXlMlxjmDDO+6DHCoaGNcrjRMlvoQNgw==
X-Received: by 2002:a05:600c:3587:b0:477:79f8:daa8 with SMTP id 5b1f17b1804b1-4778fe7e760mr33380215e9.17.1763136887123;
        Fri, 14 Nov 2025 08:14:47 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2bcf9sm158015055e9.3.2025.11.14.08.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 08:14:46 -0800 (PST)
Date: Fri, 14 Nov 2025 17:14:45 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Sun Shaojie <sunshaojie@kylinos.cn>, llong@redhat.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Message-ID: <4gzorntzaig4vnskzkumnpvpqfbqrzaahlkn5c33cgtjdm5eef@gtvm3p2rihm7>
References: <20251113131434.606961-1-sunshaojie@kylinos.cn>
 <lhfcykirz5afdzdc6wnroubsdhasww4gsfri4dxpzagiejjbep@322rtmyvwiyd>
 <2ca99986-b15b-45bc-b2ee-23d9e5395691@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eicmwaue5zpkfrwb"
Content-Disposition: inline
In-Reply-To: <2ca99986-b15b-45bc-b2ee-23d9e5395691@huaweicloud.com>


--eicmwaue5zpkfrwb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
MIME-Version: 1.0

On Fri, Nov 14, 2025 at 09:29:20AM +0800, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> After further consideration, I still suggest retaining this rule.

Apologies, I'm slightly lost which rule. I hope the new iteration from
Shaojie with both before/after tables will explain it.

> For am example:
>   Step                                       | A1's prstate | B1's prstat=
e |
>   #1> mkdir -p A1                            | member       |            =
  |
>   #2> echo "0-1" > A1/cpuset.cpus.exclusive  | member       |            =
  |
>   #3> echo "root" > A1/cpuset.cpus.partition | root         |            =
  |
>   #4> mkdir -p B1                            | root         | member     =
  |
>   #5> echo "0" > B1/cpuset.cpus              | root invalid | member     =
  |
>=20
> Currently, we mark A1 as invalid. But similar to the logic in this patch,=
 why must A1 be
> invalidated?

A1 is invalidated becase it doesn't have exclusive ownership of CPU 0
anymore.

> B1 could also use the parent's effective CPUs, right?

Here you assume some ordering between siblings treating A1 more
important than B1. But it's symmetrical in principle, no?

> This raises the question: Should we relax the restriction to allow a cpus=
et's cpus to be a subset of
> its siblings' exclusive_cpus, thereby keeping A1 valid? If we do this, us=
ers may struggle to
> understand what their cpuset.cpus.effective value is (and why it has that=
 value)=E2=80=94contrary to their
> expectations.

Not only users, not only users. I think struggle is reduced when
the resulting state (valid/invalid, effective) doesn't depend on the
order in which individual cgroups are configured.

0.02=E2=82=AC,
Michal

--eicmwaue5zpkfrwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdVcxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Aj9KQEAvVj4ecJeL98Rh6P23PUx
4wFEX14ZytH0qFiWOYbQjnQBALxgQqhQ6t/VDKfQjQqqj+GjUaVI+5IDwkXg0Iyz
//8M
=KFha
-----END PGP SIGNATURE-----

--eicmwaue5zpkfrwb--

