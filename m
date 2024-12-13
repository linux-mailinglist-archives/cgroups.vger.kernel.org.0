Return-Path: <cgroups+bounces-5888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1859D9F10BE
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 16:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37392162088
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7041E1C3F;
	Fri, 13 Dec 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g62pCwlp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9645C17B500;
	Fri, 13 Dec 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103263; cv=none; b=Z/YC7On7YA9ZQGwbWWMfbMVgWeKHH7fRRblnraf2V7xbCGIIcJmW8Osx1AhbrIoogNLZOh+WEoeISfocjUjHSfDr5yv9Y7y98q7BCkhbRWXgiW3bo0B19xyqwwsR9HaR/UnNqFgq5/HGV3vYDIdloxSoaheDN+UxyidBtFJXI04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103263; c=relaxed/simple;
	bh=0hoRjfL3xptg7GxzD5smNV+qtlkX4Gko2t2HIfAlxWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBS7CdmLkZSLVjwcStrGB8AnWP4LQQZ9r3bzLc3oQO7ClZw8rovTXm6tmzyQaORaraKptWrvbiD5vp+EeZ+jgGQTNf1jX5ftKOjDczJJQX0E3gumxlIHVQTkYHMxPHUxY19Qq6GuDr0YTal1GsEWM0cOl+NRtx2NAB1lejrQdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g62pCwlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2396C4CED0;
	Fri, 13 Dec 2024 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103263;
	bh=0hoRjfL3xptg7GxzD5smNV+qtlkX4Gko2t2HIfAlxWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g62pCwlpvV+LNFMOCzHr2eJF0fLkwLy2Fw3sSp52fkuS8lN2EWsfdq44qB4w6AuVm
	 nptCb8gDstnjiqEpdYf7u+UDwgbM7vb86JS3/hcfwbpOCwg0LeCgPf8LmEDporlrxM
	 tZqedGi1OoNgmDXzSOOiHtUJRcKhRlow0CX9IwaOLy848Er4Hj2W77y52N4pGXQVLF
	 cM8X87F2HadKQ05fnAiSzsetccLLwG86hhhbixmOjtCOSLOQM6Kg9ij0rsuvxlHXrP
	 bjDKV9wBXOibh2PJdhzyyKdK16ahWSbpA//QEWgNTtXZODMVNu7bCuf5kqT3dmDWCb
	 Ae7KLUZXTei2w==
Date: Fri, 13 Dec 2024 16:21:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241213-gentle-glittering-salamander-22addf@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xzucrplgko37cdkx"
Content-Disposition: inline
In-Reply-To: <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>


--xzucrplgko37cdkx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Fri, Dec 13, 2024 at 03:53:13PM +0100, Maarten Lankhorst wrote:
>=20
>=20
> Den 2024-12-13 kl. 14:03, skrev Maxime Ripard:
> > Hi,
> >=20
> > Thanks for the new update!
> >=20
> > On Wed, Dec 04, 2024 at 02:44:00PM +0100, Maarten Lankhorst wrote:
> > > New update. Instead of calling it the 'dev' cgroup, it's now the
> > > 'dmem' cgroup.
> > >=20
> > > Because it only deals with memory regions, the UAPI has been updated
> > > to use dmem.min/low/max/current, and to make the API cleaner, the
> > > names are changed too.
> >=20
> > The API is much nicer, and fits much better into other frameworks too.
> >=20
> > > dmem.current could contain a line like:
> > > "drm/0000:03:00.0/vram0 1073741824"
> > >=20
> > > But I think using "drm/card0/vram0" instead of PCIID would perhaps be
> > > good too. I'm open to changing it to that based on feedback.
> >=20
> > Do we have any sort of guarantee over the name card0 being stable across
> > reboots?
> >=20
> > I also wonder if we should have a "total" device that limits the amount
> > of memory we can allocate from any region?
>
> I don't think it is useful. Say your app can use 1 GB of main memory or 2=
 GB
> of VRAM, it wouldn't make sense to limit the total of those. In a lot of
> cases there is only 1 region, so the total of that would still be the sam=
e.
>=20
> On top, we just separated the management of each region, adding a 'total'
> would require unseparating it again. :-)

I didn't mean the total for a device, but for the system. It would
definitely not make sense for a VRAM, but for CMA for example, you have
a single, limited, allocator that will be accessible from heaps, v4l2
and DRM devices.

If an application has to allocate both from v4l2 and DRM buffers, we
should be able to limit its total usage of CMA, not just on a single
device.

Maxime

--xzucrplgko37cdkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1xQ2AAKCRAnX84Zoj2+
dvY9AYDvYFVqP1m9MO2HUFdjzbDjD9xHT641MNrCjJEZcEFydB/kdB43puOgWw4s
j5W0CqkBf2xtEgx6P3tIKULsVQRjMzYFENFOiTHzJJhIdhdUtLEgPzr+uh7+GqPW
13KbApiKCQ==
=xBfv
-----END PGP SIGNATURE-----

--xzucrplgko37cdkx--

