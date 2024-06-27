Return-Path: <cgroups+bounces-3413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4538F91ADC0
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A841F21C9E
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735BD199E83;
	Thu, 27 Jun 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdT2GY36"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234992557A;
	Thu, 27 Jun 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508571; cv=none; b=atzHD0B2hwXjlIQEHOwJu3VaqRds53J3HI03CWHuSk0DhouIfEuOunNXk5DIBnOMYB19vZ9Vw9aXGcKjhloDeHcN5p2EMkJabLaaesCp5OHDE/CPsisn1IJHZV22L53015xZ/AXHMsKKftXb+EnOrv1H22xgz70Wa66Pw1OXXYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508571; c=relaxed/simple;
	bh=sSeDFPLANRtdCM3W5AaKh+hXR3lM6y6nXqJeEH89EL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMHqe6VYJeMu7pii5hSqzKOvlDuekqmNYjoRom+R//6LIDwiCtb2jiwnFH0L0KC1xXq8r4UfmL8mQ93EQpNcBn8Rf9xcTSWTnzPQ1Jb/dm8DuDrqayOYT6f4jvbsblibjirVRRj1LH0xIQb66v/ZadWAzXo9oghtgwJL5zpslS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdT2GY36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB2DC2BBFC;
	Thu, 27 Jun 2024 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508570;
	bh=sSeDFPLANRtdCM3W5AaKh+hXR3lM6y6nXqJeEH89EL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdT2GY3651qQ8ySaOjVCeu1i6mUXn4kbzneO/06+6TL90hewAkhxeRwFIfQY2C3+a
	 hRPnYCpnbQrMjqi4GjpSn2CqyXE8MVqbgBRTwq9Mat2vjPspxeFhMi1oGL234JB+HW
	 vIvEFfR49tfh7YBT6j6zBoVLacpuKruzBkVjDeVeUAci2DvClA1WRoL8SlP+mYLuZv
	 vR16hFCG8zK5xThzW2Q3wvVlXPB3bdkcWVEir6e8V60E2gSXokjDUXPEEJKtn2+zQz
	 SDzgGknxNP9tUsP9KQkpxeBtklw7JadnygMfF/VyG8pPRiOkVBEn6Y7zBAGXoTBdj3
	 eFiEJ7l0D/L/g==
Date: Thu, 27 Jun 2024 19:16:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] drm/cgroup: Add memory accounting DRM cgroup
Message-ID: <20240627-paper-vicugna-of-fantasy-c549ed@houat>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4x267kq4clbw44gl"
Content-Disposition: inline
In-Reply-To: <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>


--4x267kq4clbw44gl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for working on this!

On Thu, Jun 27, 2024 at 05:47:21PM GMT, Maarten Lankhorst wrote:
> The initial version was based roughly on the rdma and misc cgroup
> controllers, with a lot of the accounting code borrowed from rdma.
>=20
> The current version is a complete rewrite with page counter; it uses
> the same min/low/max semantics as the memory cgroup as a result.
>=20
> There's a small mismatch as TTM uses u64, and page_counter long pages.
> In practice it's not a problem. 32-bits systems don't really come with
> >=3D4GB cards and as long as we're consistently wrong with units, it's
> fine. The device page size may not be in the same units as kernel page
> size, and each region might also have a different page size (VRAM vs GART
> for example).
>=20
> The interface is simple:
> - populate drmcgroup_device->regions[..] name and size for each active
>   region, set num_regions accordingly.
> - Call drm(m)cg_register_device()
> - Use drmcg_try_charge to check if you can allocate a chunk of memory,
>   use drmcg_uncharge when freeing it. This may return an error code,
>   or -EAGAIN when the cgroup limit is reached. In that case a reference
>   to the limiting pool is returned.
> - The limiting cs can be used as compare function for
>   drmcs_evict_valuable.
> - After having evicted enough, drop reference to limiting cs with
>   drmcs_pool_put.
>=20
> This API allows you to limit device resources with cgroups.
> You can see the supported cards in /sys/fs/cgroup/drm.capacity
> You need to echo +drm to cgroup.subtree_control, and then you can
> partition memory.
>=20
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Co-developed-by: Friedrich Vock <friedrich.vock@gmx.de>

I'm sorry, I should have wrote minutes on the discussion we had with TJ
and Tvrtko the other day.

We're all very interested in making this happen, but doing a "DRM"
cgroup doesn't look like the right path to us.

Indeed, we have a significant number of drivers that won't have a
dedicated memory but will depend on DMA allocations one way or the
other, and those pools are shared between multiple frameworks (DRM,
V4L2, DMA-Buf Heaps, at least).

This was also pointed out by Sima some time ago here:
https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/

So we'll want that cgroup subsystem to be cross-framework. We settled on
a "device" cgroup during the discussion, but I'm sure we'll have plenty
of bikeshedding.

The other thing we agreed on, based on the feedback TJ got on the last
iterations of his series was to go for memcg for drivers not using DMA
allocations.

It's the part where I expect some discussion there too :)

So we went back to a previous version of TJ's work, and I've started to
work on:

  - Integration of the cgroup in the GEM DMA and GEM VRAM helpers (this
    works on tidss right now)

  - Integration of all heaps into that cgroup but the system one
    (working on this at the moment)

  - Integration into v4l2 (next on my list)

Maxime

--4x267kq4clbw44gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZn2eVwAKCRDj7w1vZxhR
xReyAP4+9TGUgVyaERT/3Z2Q6QCqUYta9dlEvaZaPjxpE/PzCgD9GtTKU1rmEBJN
XhhmHQ04LONiQxG4Qp4fDvfFOussXgY=
=InwG
-----END PGP SIGNATURE-----

--4x267kq4clbw44gl--

