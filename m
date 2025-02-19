Return-Path: <cgroups+bounces-6603-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13CA3B78A
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E71317A6FA6
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0A1E5B7E;
	Wed, 19 Feb 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEOXmjRR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE81E5718
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956140; cv=none; b=KHiwVh9iyFzpaCir6I3y5Q1ukB8XZZNAyk9u/hc7XX+giBPn1/i4OyqlX7ZGTpQrw1zxckfBgZxytR59grQHW21qO8KCxK1ajgk7v8lh5CWK0uxs1gdTDNlLj+tX2QdAhkqMm4WrQoLKYfBYvOh8iV7PIFKlBW7GvkfB8NjtXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956140; c=relaxed/simple;
	bh=GI/zZAfXd78fKSLQl9MOP4wo+a0Lomx975UL3xwoalc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLdspyVSRFYqzmdzC0Mgh2Z7Sr4tcMGimTJ+Pdx8Z779hCD0HAGIcLEcflUt9R/maS4napvBgqAvVWd98Q4klxoXUjQoXlJnuv6PSIjpYdPF1M+4AE2KZxpucVhdleMPqY0izFGjVOO8O2XtZyIXMUK6wiFDdEeW18+t4i8aoBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEOXmjRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378CFC4CEE9;
	Wed, 19 Feb 2025 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956140;
	bh=GI/zZAfXd78fKSLQl9MOP4wo+a0Lomx975UL3xwoalc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sEOXmjRRNjmS8T/IBHnQm7EdAeppPgMftJXV9AVnUS/bUMYTOTjN7Itm5MuIAgatO
	 3/1fL/qnmDoo0RGzRkBET9Qbx6xKe7nUY57iZ6YTPMZEBFoX3BCZO/mLueJ0Gy8Bxc
	 nr6afdvmLMTdO9GsKaGUeBoRfQUBPKOnpz6ILWAXEtJR+Dj+kVO9+lX9ZZwnQP4v/Y
	 KMrWFF/Ugc06LWytQ3UWUQFKNae5tmZrbBeXu6qqXCFYZwyNuzvJPXVIMH3TMJVMd1
	 8HwCWpZLCyqQz7u2ybntXWh9EPCzRA7UDJuaBxT73q3DQBOo7w4HZXgq/kHgMZE26e
	 r2NMji12wW/Ww==
Date: Wed, 19 Feb 2025 10:08:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
	Friedrich Vock <friedrich.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
Message-ID: <20250219-tactful-attractive-goldfish-51f8fc@houat>
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <20250127152754.21325-1-friedrich.vock@gmx.de>
 <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>
 <Z7TT_lFL6hu__NP-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="aiqiclpoablwgytv"
Content-Disposition: inline
In-Reply-To: <Z7TT_lFL6hu__NP-@slm.duckdns.org>


--aiqiclpoablwgytv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
MIME-Version: 1.0

On Tue, Feb 18, 2025 at 08:39:58AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Tue, Feb 18, 2025 at 03:55:43PM +0100, Maarten Lankhorst wrote:
> > Should this fix go through the cgroup tree?
>=20
> I haven't been routing any dmem patches. Might as well stick to drm tree?

We merged the dmem cgroup through drm because we also had driver
changes, but going forward, as far as I'm concerned, it's "your" thing,
and it really shouldn't go through drm

Maxime

--aiqiclpoablwgytv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ7WfqQAKCRAnX84Zoj2+
dn2kAYCJ9ZnCoPyW9ORtYScH/UdoOIDhrga7+EkoVHrUCTsmzyrfEwaJ33PRFvK9
fAA2/6ABgNU8qrJvyFhwXN18jwf4F9p0dy6WVLB5w7o4uQjC/u6VZSf8zUI0GW0m
0G7UR7rITw==
=KoGg
-----END PGP SIGNATURE-----

--aiqiclpoablwgytv--

