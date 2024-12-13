Return-Path: <cgroups+bounces-5889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A59F10CD
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B420B1882A42
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DBE1E25EB;
	Fri, 13 Dec 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNV5IYVG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD021DFDB8;
	Fri, 13 Dec 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103363; cv=none; b=ng2kiTcgQK43PD8AICUHe0xoLnnABoAtKtLiB0zwvtKkXWI5JmTOs4c8CDwR8vGioy8XVsm5WWLjYr5XAcS1sV3EEYT7RfoGvGJhxim4+kdvNPuRtHHfQiNGn7xqYUYLfkPQnYyo7CrvSK4OGeAl3LGOTLZsOxn633YBx9DvXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103363; c=relaxed/simple;
	bh=mZZPTQJsNPsTvkisNXOUR5Df8ass8gl+2nYsiM1JXlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUaWIFhsi4hnvmBCb9099w5fzUGG+a1Lqv030Oaidv7h+9zpuYEkJsQ7yQ2fErMLqx/O88fUxDCGV+HMSnizkE5zAda2m6hMdd5aeFljZQZdHqnucHUruZ9hDrXDpd5q0lQPObAr/2ZpuiT8KP4LOiZ3tiFxllzl/VckTPQFrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNV5IYVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06DBC4CED0;
	Fri, 13 Dec 2024 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103363;
	bh=mZZPTQJsNPsTvkisNXOUR5Df8ass8gl+2nYsiM1JXlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNV5IYVGSiAvg4nneLRmM8EESuL1qYoYf1gYdIYPnhhnv375Yc6Po7KvvI5wVwMCe
	 aYoQTdWkXt3NEiY2O8EtAVhAJVg5265KWo8z/ExUjsIk2vpXUFHXLD0HBPWo/xGo85
	 D5iBbgU9KnnF7kj2nTGbkC7YoFuhPk9xa6M49WfnRZ9HxT/Qk4TD5Hv+hH/tcBjsCp
	 jPrr9/+LA+m/8hz33JRd4nFcDFtOpZdQ1P/z06qNTdTakZWJRSNurkxGuLRNHYrOvV
	 VE6KknCGSUAKWjqUn6zFpgNKC1Ll44mFfwwMgMAQ+YTaXEVhR9ymhvez31HSfOKOzG
	 yh3d5lZUj/i3A==
Date: Fri, 13 Dec 2024 16:22:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241213-flying-naughty-marmot-6a82a2@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <29a71119-04de-4c76-a98a-d0fcb906390f@gmx.de>
 <20241213-sceptical-maize-gazelle-fadc34@houat>
 <789d78c1-d16a-4cb3-b4ad-ba5f0ddcacaf@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="by62sis77uqd7vzz"
Content-Disposition: inline
In-Reply-To: <789d78c1-d16a-4cb3-b4ad-ba5f0ddcacaf@lankhorst.se>


--by62sis77uqd7vzz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Fri, Dec 13, 2024 at 03:13:23PM +0100, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2024-12-13 kl. 14:07, skrev Maxime Ripard:
> > On Sun, Dec 08, 2024 at 01:15:34PM +0100, Friedrich Vock wrote:
> > > Hi,
> > >=20
> > > On 04.12.24 14:44, Maarten Lankhorst wrote:
> > >=20
> > > > Because it only deals with memory regions, the UAPI has been updated
> > > > to use dmem.min/low/max/current, and to make the API cleaner, the
> > > > names are changed too.
> > > >=20
> > > > dmem.current could contain a line like:
> > > > "drm/0000:03:00.0/vram0 1073741824"
> > > >=20
> > > > But I think using "drm/card0/vram0" instead of PCIID would perhaps
> > > > be good too. I'm open to changing it to that based on feedback.
> > >=20
> > > Agree, allowing userspace to reference DRM devices via "cardN" syntax
> > > sounds good.
> > >=20
> > > What about other subsystems potentially using dmem cgroups?
> > > I'm not familiar with the media subsystem, but I imagine we might be
> > > dealing with things like USB devices there? Is something like a
> > > "deviceN" possible there as well, or would device IDs look completely
> > > different?
>
> I'd just take what makes sense for each driver. dev_name() would be a good
> approximation.

Yeah, dev_name() seems good enough to me too.

> I agree that cardN is not stable.
>=20
> > > I have some patches to enable the cgroup in GEM-based drivers, media
> > ones and dma-buf heaps. The dma-buf heaps are simple enough since the
> > heaps names are supposed to be stable.
>=20
> I've used your patch as a base enable cgroup in drivers that use the VRAM
> manager. I didn't want to enable it for all of GEM, because it would
> conflict with drivers using TTM. Some more discussion is needed first.
>=20
> For DMA-BUF heaps, I think it's fine and there is a lot less need of
> discussion. I just felt it should be sent separately from the initial
> enablement.

Definitely.

> > I don't think using card0 vs card1 (or v4l0 vs v4l1 for example) will
> > work because I don't think we have any sort of guarantee that these
> > names will always point to the same devices across reboots or updates.
> >=20
> > If the module is loaded later than it used to for example, we could very
> > well end up in a situation where card0 and card1 are swapped, while the
> > constraints apply to the previous situation.
>
> I agree, just put it out there for discussion. I don't think the benefits
> weigh up against the downsides :-)

Oh absolutely. The way to define a stable name is going to be framework
specific anyway. My point was that we wanted to have a stable name.

Maxime

--by62sis77uqd7vzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1xRQAAKCRAnX84Zoj2+
dnZVAYDQQEA9NR6GrqKYw1CvE58OitlLlx9hVBdBfbxT1+FUZK/xhIjhLN+KQYWn
9pAtNrABf2UM3dWX1eT1pN+ZKq5ToTS6/1SQjpboJ/ny+YN6Ir6UbyPmYugJN0AT
+o+OtxQK8w==
=HILO
-----END PGP SIGNATURE-----

--by62sis77uqd7vzz--

