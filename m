Return-Path: <cgroups+bounces-3450-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59691C04D
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 16:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C8EFB24428
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ABE1BF313;
	Fri, 28 Jun 2024 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrZl5nCo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F71BF307;
	Fri, 28 Jun 2024 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583496; cv=none; b=DOR/dwrscrxeyWzxT43Yd9MQRYRn1mw609QH1DC2MCsSnRW0U1rzZ5FUK/+c64enej5nUXuFTeDbrGvYGIpkELFhn2FHWkwcsIIcq0z9XsFZcIap2R0S7kcDVp6Bmdz8oEkiP3FLBzSXDGsWqpbC8HDoohHHNHX0Dfpyyk4/gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583496; c=relaxed/simple;
	bh=gPsBksBd9/r5KyiQkMqtaVzJ3Jnw9xxaAJaOJd1IL5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilb2V4RRqJJZe8D6BRBLn0Ksj2DRI9kAXwa2Pn9s4FdQnkGmItVoROYnK3zlje7SHrdAmEteTr94yyCCw97XXwRG5HKr5dSgEAN6hYm/dmodlwEfIvEHZRfZZJVmALarqr4a/ZHd7WhzJHZZUQarM1vu9FjN3MRGcEgVvDRg4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrZl5nCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FC3C116B1;
	Fri, 28 Jun 2024 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719583495;
	bh=gPsBksBd9/r5KyiQkMqtaVzJ3Jnw9xxaAJaOJd1IL5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrZl5nCoSOg1oFczaYNXOld1XvShBNSqpPU19+yaDf6ERI30kJ5Dorzs0krZKwCBX
	 oETKiAlQbjACn116sCeEjTwKL5u4AH4m943lebVVjS8pc3ejDEUrBsFdc+0gXFgRm1
	 vU2W/gzhdm9dudHQSSQpaPEew9f1v4vyUOOa4dPaQCx0PIMX13Sl2SF1rs+yZNCa/o
	 PDHnlDCgSwVaGcAzxdt+Coft0zyfppm/k9KrjJ+aJoYnxsdJO7OFGeKc3mYsvBlavD
	 unyIJDu9Xzf7TZiwSoHgPgGhF4XEdPdWJ/SAWYmEX404qo0FB/O8kkJoNSIX9xSyMU
	 Jm+53XnRA8tKA==
Date: Fri, 28 Jun 2024 16:04:53 +0200
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
Message-ID: <20240628-romantic-emerald-snake-7b26ca@houat>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>
 <20240627-paper-vicugna-of-fantasy-c549ed@houat>
 <6cb7c074-55cb-4825-9f80-5cf07bbd6745@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7fymz6tlpfxqxwqn"
Content-Disposition: inline
In-Reply-To: <6cb7c074-55cb-4825-9f80-5cf07bbd6745@linux.intel.com>


--7fymz6tlpfxqxwqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 27, 2024 at 09:22:56PM GMT, Maarten Lankhorst wrote:
> Den 2024-06-27 kl. 19:16, skrev Maxime Ripard:
> > Hi,
> >=20
> > Thanks for working on this!
> >=20
> > On Thu, Jun 27, 2024 at 05:47:21PM GMT, Maarten Lankhorst wrote:
> > > The initial version was based roughly on the rdma and misc cgroup
> > > controllers, with a lot of the accounting code borrowed from rdma.
> > >=20
> > > The current version is a complete rewrite with page counter; it uses
> > > the same min/low/max semantics as the memory cgroup as a result.
> > >=20
> > > There's a small mismatch as TTM uses u64, and page_counter long pages.
> > > In practice it's not a problem. 32-bits systems don't really come with
> > > > =3D4GB cards and as long as we're consistently wrong with units, it=
's
> > > fine. The device page size may not be in the same units as kernel page
> > > size, and each region might also have a different page size (VRAM vs =
GART
> > > for example).
> > >=20
> > > The interface is simple:
> > > - populate drmcgroup_device->regions[..] name and size for each active
> > >    region, set num_regions accordingly.
> > > - Call drm(m)cg_register_device()
> > > - Use drmcg_try_charge to check if you can allocate a chunk of memory,
> > >    use drmcg_uncharge when freeing it. This may return an error code,
> > >    or -EAGAIN when the cgroup limit is reached. In that case a refere=
nce
> > >    to the limiting pool is returned.
> > > - The limiting cs can be used as compare function for
> > >    drmcs_evict_valuable.
> > > - After having evicted enough, drop reference to limiting cs with
> > >    drmcs_pool_put.
> > >=20
> > > This API allows you to limit device resources with cgroups.
> > > You can see the supported cards in /sys/fs/cgroup/drm.capacity
> > > You need to echo +drm to cgroup.subtree_control, and then you can
> > > partition memory.
> > >=20
> > > Signed-off-by: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
> > > Co-developed-by: Friedrich Vock<friedrich.vock@gmx.de>
> > I'm sorry, I should have wrote minutes on the discussion we had with TJ
> > and Tvrtko the other day.
> >=20
> > We're all very interested in making this happen, but doing a "DRM"
> > cgroup doesn't look like the right path to us.
> >=20
> > Indeed, we have a significant number of drivers that won't have a
> > dedicated memory but will depend on DMA allocations one way or the
> > other, and those pools are shared between multiple frameworks (DRM,
> > V4L2, DMA-Buf Heaps, at least).
> >=20
> > This was also pointed out by Sima some time ago here:
> > https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/
> >=20
> > So we'll want that cgroup subsystem to be cross-framework. We settled on
> > a "device" cgroup during the discussion, but I'm sure we'll have plenty
> > of bikeshedding.
> >=20
> > The other thing we agreed on, based on the feedback TJ got on the last
> > iterations of his series was to go for memcg for drivers not using DMA
> > allocations.
> >=20
> > It's the part where I expect some discussion there too :)
> >=20
> > So we went back to a previous version of TJ's work, and I've started to
> > work on:
> >=20
> >    - Integration of the cgroup in the GEM DMA and GEM VRAM helpers (this
> >      works on tidss right now)
> >=20
> >    - Integration of all heaps into that cgroup but the system one
> >      (working on this at the moment)
>=20
> Should be similar to what I have then. I think you could use my work to
> continue it.
>=20
> I made nothing DRM specific except the name, if you renamed it the device
> resource management cgroup and changed the init function signature to tak=
e a
> name instead of a drm pointer, nothing would change. This is exactly what
> I'm hoping to accomplish, including reserving memory.

I've started to work on rebasing my current work onto your series today,
and I'm not entirely sure how what I described would best fit. Let's
assume we have two KMS device, one using shmem, one using DMA
allocations, two heaps, one using the page allocator, the other using
CMA, and one v4l2 device using dma allocations.

So we would have one KMS device and one heap using the page allocator,
and one KMS device, one heap, and one v4l2 driver using the DMA
allocator.

Would these make different cgroup devices, or different cgroup regions?

> The nice thing is that it should be similar to the memory cgroup controll=
er
> in semantics, so you would have the same memory behavior whether you use =
the
> device cgroup or memory cgroup.
>=20
> I'm sad I missed the discussion, but hopefully we can coordinate more now
> that we know we're both working on it. :)

Yeah, definitely :)

Maxime

--7fymz6tlpfxqxwqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZn7DBAAKCRDj7w1vZxhR
xWlJAP0UNWQ0gcwWNN/Im1DgFf7X2Yi5sSP1W1uEZE9I0hrrPAEAuZ5tF02to94P
dCchG/vB5gsWEnB2EerIOPqG6gW4tw4=
=J4LC
-----END PGP SIGNATURE-----

--7fymz6tlpfxqxwqn--

