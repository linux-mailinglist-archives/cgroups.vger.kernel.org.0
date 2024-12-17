Return-Path: <cgroups+bounces-5929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8819F456F
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A581188A677
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 07:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EDC188CDC;
	Tue, 17 Dec 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgBBwHHY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF826A29;
	Tue, 17 Dec 2024 07:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421573; cv=none; b=nv2vEvD/cJ0tmzMlq3TLltB0k2mrN+oidltclKPnwI11AzhN6FpFG9dGQwlR6IyGCw8+0wEu+Gsv/FNLg5kiVyofvOOC03KKDePOfzY1WHYbXzpA5kkL74nc8Ch1QI9zldLHYYkuoUykj8eQ6MZg+ZiLOr5Np+gABA79dHy3PpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421573; c=relaxed/simple;
	bh=+Vm+eC+xSgbsQqva2V7i7wuDgSImt8XYpxOEXdlLywg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdhQdRnhSEx9IdGjdGWM9IxpWJ1cCE3RL7hkqAQIH3coyQyc2s9fSABHJvDhxd6qLKJOrDEpkFJ30SMjt3T9vUJh0UL/9zVQ2iiFDrXTPFXaOvGs+AtcsuoOWsVzNNCsfWEkotsHE4+qpFoQR0LX+we0T3TIe5KOnXqnzcoeS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgBBwHHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A37C4CED3;
	Tue, 17 Dec 2024 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734421573;
	bh=+Vm+eC+xSgbsQqva2V7i7wuDgSImt8XYpxOEXdlLywg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgBBwHHYKZI1UfSFS9QBhn7KVCPW6yXxW25zCAViHTsGX4H2PU6XBB6pcGua9ACFC
	 lDp1RIf8KYS1ML5amD4Y3t4q5JdEG+aLKWhGuvLt7KRt3/EuY4iuQM5+aNCwiqG0W2
	 owCVnCyvWHwb6Y06ZOzMpZilfZH2vDPBfzPYVMJRSw/C/LykUeH6ihb4K/+Nw3LppA
	 P+24b4InOPyMWOE7YuQop6nU29CyJo4mg5t/F1KciT10WDePp35gH4aW0vEYEM2rlx
	 ElZkOKQhMbFAUFnm8zh9pTDiQZ1npXDIwGLROYYfTnd6aRrl9DJwzQKW24QMs0rdrr
	 IzZgEnd1p4RYQ==
Date: Tue, 17 Dec 2024 08:46:10 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241217-meek-bullfinch-of-luck-2c3468@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="moaynkbohx6mdcjs"
Content-Disposition: inline
In-Reply-To: <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>


--moaynkbohx6mdcjs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Fri, Dec 13, 2024 at 05:06:05PM +0100, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2024-12-13 kl. 16:21, skrev Maxime Ripard:
> > On Fri, Dec 13, 2024 at 03:53:13PM +0100, Maarten Lankhorst wrote:
> > >=20
> > >=20
> > > Den 2024-12-13 kl. 14:03, skrev Maxime Ripard:
> > > > Hi,
> > > >=20
> > > > Thanks for the new update!
> > > >=20
> > > > On Wed, Dec 04, 2024 at 02:44:00PM +0100, Maarten Lankhorst wrote:
> > > > > New update. Instead of calling it the 'dev' cgroup, it's now the
> > > > > 'dmem' cgroup.
> > > > >=20
> > > > > Because it only deals with memory regions, the UAPI has been upda=
ted
> > > > > to use dmem.min/low/max/current, and to make the API cleaner, the
> > > > > names are changed too.
> > > >=20
> > > > The API is much nicer, and fits much better into other frameworks t=
oo.
> > > >=20
> > > > > dmem.current could contain a line like:
> > > > > "drm/0000:03:00.0/vram0 1073741824"
> > > > >=20
> > > > > But I think using "drm/card0/vram0" instead of PCIID would perhap=
s be
> > > > > good too. I'm open to changing it to that based on feedback.
> > > >=20
> > > > Do we have any sort of guarantee over the name card0 being stable a=
cross
> > > > reboots?
> > > >=20
> > > > I also wonder if we should have a "total" device that limits the am=
ount
> > > > of memory we can allocate from any region?
> > >=20
> > > I don't think it is useful. Say your app can use 1 GB of main memory =
or 2 GB
> > > of VRAM, it wouldn't make sense to limit the total of those. In a lot=
 of
> > > cases there is only 1 region, so the total of that would still be the=
 same.
> > >=20
> > > On top, we just separated the management of each region, adding a 'to=
tal'
> > > would require unseparating it again. :-)
> >=20
> > I didn't mean the total for a device, but for the system. It would
> > definitely not make sense for a VRAM, but for CMA for example, you have
> > a single, limited, allocator that will be accessible from heaps, v4l2
> > and DRM devices.
> >=20
> > If an application has to allocate both from v4l2 and DRM buffers, we
> > should be able to limit its total usage of CMA, not just on a single
> > device.
>
> In this case, I think it makes more sense if CMA creates a region, then u=
se
> that region in both v4l2 and DRM instead of a separate region for both, w=
ith
> CMA being responsible for lifetime.

Ack, thanks for your feedback :)

Maxime

--moaynkbohx6mdcjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2EsQQAKCRAnX84Zoj2+
dhn2AYDyBKh4PeDUj5bFOj4p/RKKL9uN/KUtyl6G3J1+sEdZdLohr1MKIZ5CF7Tl
eUwVXYwBf1HikKKaUe7ZktXkTA34hBlVGvwJz/tHr0CQiuScjRmWjVDwjbQEMBUf
ubiGLbrddg==
=2+Ct
-----END PGP SIGNATURE-----

--moaynkbohx6mdcjs--

