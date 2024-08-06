Return-Path: <cgroups+bounces-4101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D8948B22
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 10:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8080E1F21D9F
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5717316B722;
	Tue,  6 Aug 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mx3umcsw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC613C092;
	Tue,  6 Aug 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722932399; cv=none; b=FpBd6ntOIQrDgUfbir8erI6wc9s8qvhvmtrJYAl8pm353vojUMvnyCzwa6u6F5vcvqkeEJdnjYHkegICmz3hzoiZIjplEUe7KTr0OQpg3EZs6/VD9qj1ssdeQ7IoDgX4/+xPe29E9j+kj/NFGrQ0DKfLEZkBiMhiV4dx+K7Jx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722932399; c=relaxed/simple;
	bh=SyGxnGyC6ICq4ml8/rvgZWL+NhnuYgaPfzYh/fRYTjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXIG/r5vk54xzoNjgq2VDp5g9VhF2fgC773c2xqepXPKmFJ1gK8c9dH/sUSj5RKQurmjLx3cnyQAd3JitAUMntPaTLJk/IHKqVOD/eWnhKYFBfX9gQs/vLXHdF3ClXxxMYGlhP4W4w1mNaEe4GCn3Y9MLKo+7JskUbzjlM8hX8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mx3umcsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43339C32786;
	Tue,  6 Aug 2024 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722932398;
	bh=SyGxnGyC6ICq4ml8/rvgZWL+NhnuYgaPfzYh/fRYTjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mx3umcswp4/foWvsYQvzWJ2zFmWjjNzO2Ko2mEphYYZt2hwcY5FeE6orw0COIHSpE
	 IeD4r9cLlUYFJEATFeKwpNUg+ZqyzaC9hqOQmpI27tgjIKe7Zk8ZKXzGIsvL4KVoPT
	 7P8KN0el7G7BJQvR6iY9rLykUhfjSj/5OQHqM3EaGUFkzRvpxSzmLxx1wHKTEuUnfx
	 hfMZZShMGPJjtCDuVXojeaQtWvocyRsgsBN+P0qpE783XjlD1fN8nU9CHlBBlmZkVP
	 tw9h+gBMX0+6mv1YPfzqKG23K6TvvfP+on9NnIQVz+BB06oNhOyIgKpLmEzUeU55B8
	 Bxp0aukY5AjHg==
Date: Tue, 6 Aug 2024 10:19:56 +0200
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
Message-ID: <20240806-poetic-awesome-impala-fb6c2f@houat>
References: <20240627154754.74828-1-maarten.lankhorst@linux.intel.com>
 <20240627154754.74828-3-maarten.lankhorst@linux.intel.com>
 <20240627-paper-vicugna-of-fantasy-c549ed@houat>
 <6cb7c074-55cb-4825-9f80-5cf07bbd6745@linux.intel.com>
 <20240628-romantic-emerald-snake-7b26ca@houat>
 <70289c58-7947-4347-8600-658821a730b0@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqepzngcvumclfgj"
Content-Disposition: inline
In-Reply-To: <70289c58-7947-4347-8600-658821a730b0@linux.intel.com>


--bqepzngcvumclfgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maarten,

On Mon, Jul 01, 2024 at 11:25:12AM GMT, Maarten Lankhorst wrote:
> Den 2024-06-28 kl. 16:04, skrev Maxime Ripard:
> > On Thu, Jun 27, 2024 at 09:22:56PM GMT, Maarten Lankhorst wrote:
> >> Den 2024-06-27 kl. 19:16, skrev Maxime Ripard:
> >>> Hi,
> >>>
> >>> Thanks for working on this!
> >>>
> >>> On Thu, Jun 27, 2024 at 05:47:21PM GMT, Maarten Lankhorst wrote:
> >>>> The initial version was based roughly on the rdma and misc cgroup
> >>>> controllers, with a lot of the accounting code borrowed from rdma.
> >>>>
> >>>> The current version is a complete rewrite with page counter; it uses
> >>>> the same min/low/max semantics as the memory cgroup as a result.
> >>>>
> >>>> There's a small mismatch as TTM uses u64, and page_counter long page=
s.
> >>>> In practice it's not a problem. 32-bits systems don't really come wi=
th
> >>>>> =3D4GB cards and as long as we're consistently wrong with units, it=
's
> >>>> fine. The device page size may not be in the same units as kernel pa=
ge
> >>>> size, and each region might also have a different page size (VRAM vs=
 GART
> >>>> for example).
> >>>>
> >>>> The interface is simple:
> >>>> - populate drmcgroup_device->regions[..] name and size for each acti=
ve
> >>>>    region, set num_regions accordingly.
> >>>> - Call drm(m)cg_register_device()
> >>>> - Use drmcg_try_charge to check if you can allocate a chunk of memor=
y,
> >>>>    use drmcg_uncharge when freeing it. This may return an error code,
> >>>>    or -EAGAIN when the cgroup limit is reached. In that case a refer=
ence
> >>>>    to the limiting pool is returned.
> >>>> - The limiting cs can be used as compare function for
> >>>>    drmcs_evict_valuable.
> >>>> - After having evicted enough, drop reference to limiting cs with
> >>>>    drmcs_pool_put.
> >>>>
> >>>> This API allows you to limit device resources with cgroups.
> >>>> You can see the supported cards in /sys/fs/cgroup/drm.capacity
> >>>> You need to echo +drm to cgroup.subtree_control, and then you can
> >>>> partition memory.
> >>>>
> >>>> Signed-off-by: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
> >>>> Co-developed-by: Friedrich Vock<friedrich.vock@gmx.de>
> >>> I'm sorry, I should have wrote minutes on the discussion we had with =
TJ
> >>> and Tvrtko the other day.
> >>>
> >>> We're all very interested in making this happen, but doing a "DRM"
> >>> cgroup doesn't look like the right path to us.
> >>>
> >>> Indeed, we have a significant number of drivers that won't have a
> >>> dedicated memory but will depend on DMA allocations one way or the
> >>> other, and those pools are shared between multiple frameworks (DRM,
> >>> V4L2, DMA-Buf Heaps, at least).
> >>>
> >>> This was also pointed out by Sima some time ago here:
> >>> https://lore.kernel.org/amd-gfx/YCVOl8%2F87bqRSQei@phenom.ffwll.local/
> >>>
> >>> So we'll want that cgroup subsystem to be cross-framework. We settled=
 on
> >>> a "device" cgroup during the discussion, but I'm sure we'll have plen=
ty
> >>> of bikeshedding.
> >>>
> >>> The other thing we agreed on, based on the feedback TJ got on the last
> >>> iterations of his series was to go for memcg for drivers not using DMA
> >>> allocations.
> >>>
> >>> It's the part where I expect some discussion there too :)
> >>>
> >>> So we went back to a previous version of TJ's work, and I've started =
to
> >>> work on:
> >>>
> >>>    - Integration of the cgroup in the GEM DMA and GEM VRAM helpers (t=
his
> >>>      works on tidss right now)
> >>>
> >>>    - Integration of all heaps into that cgroup but the system one
> >>>      (working on this at the moment)
> >>
> >> Should be similar to what I have then. I think you could use my work to
> >> continue it.
> >>
> >> I made nothing DRM specific except the name, if you renamed it the dev=
ice
> >> resource management cgroup and changed the init function signature to =
take a
> >> name instead of a drm pointer, nothing would change. This is exactly w=
hat
> >> I'm hoping to accomplish, including reserving memory.
> >=20
> > I've started to work on rebasing my current work onto your series today,
> > and I'm not entirely sure how what I described would best fit. Let's
> > assume we have two KMS device, one using shmem, one using DMA
> > allocations, two heaps, one using the page allocator, the other using
> > CMA, and one v4l2 device using dma allocations.
> >=20
> > So we would have one KMS device and one heap using the page allocator,
> > and one KMS device, one heap, and one v4l2 driver using the DMA
> > allocator.
> >=20
> > Would these make different cgroup devices, or different cgroup regions?
>=20
> Each driver would register a device, whatever feels most logical for
> that device I suppose.
>=20
> My guess is that a prefix would also be nice here, so register a
> device with name of drm/$name or v4l2/$name, heap/$name. I didn't give
> it much thought and we're still experimenting, so just try something.
> :)
>=20
> There's no limit to amount of devices, I only fixed amount of pools to
> match TTM, but even that could be increased arbitrarily. I just don't
> think there is a point in doing so.

Sorry, it took a while, but I implemented what (I think) we all had in
mind here:

https://github.com/mripard/linux/tree/device-cgroups-maarten

It's rebased on top of 6.11, and with plenty of fixups to (hopefully :D)
make your life easier.

Let me know what you think,
Maxime

--bqepzngcvumclfgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZrHcqwAKCRDj7w1vZxhR
xXnkAQCmJVnMNyKrRw+63aZYJyNabEjZdrabgiVeTtigB3aDVAEAm0JgXIztS1rY
4d633eaGD7BBVCPnEawqpsLem2SalQc=
=PvlN
-----END PGP SIGNATURE-----

--bqepzngcvumclfgj--

