Return-Path: <cgroups+bounces-6132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA1A10A32
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 16:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EC1D7A4F0C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDD12C7FD;
	Tue, 14 Jan 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URlfct9Y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB9156257;
	Tue, 14 Jan 2025 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866984; cv=none; b=s5JWUtgw2R+9fCSame+xV8bPcz5R+gGXbHJK5wg4WVbsPu00nduQY9KryU2UlO2jXS2XetxIMuN0i/uOtQT/rEo573fNyM80V9/Uqy73ByUrxsJUgrtLEvixzlS22GODOmnFcfhENL5phuH0HC0BYBlIWOfoVFuutt6hiFkQW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866984; c=relaxed/simple;
	bh=Ys6TZki56tDCl2Iqz9+k9TDB2n8cXuHzRpex00I8ID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbaJJ5TN4OBGLg+fZJpSTkqlK+oC+aZiIWdUA5hmXUb6R8eiyxhz+FfgzedunYrLtNymHpXh8x5fgA3jzo6R1v023fYbD/fnry4zAbsevu9VklyRwLwsLz9w3r4zSC1lZK6JkSQnpqA+3C1i3VN//VqZwZc0OOeKklcMRFjhx+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URlfct9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E232C4CEDD;
	Tue, 14 Jan 2025 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736866984;
	bh=Ys6TZki56tDCl2Iqz9+k9TDB2n8cXuHzRpex00I8ID4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URlfct9YJqaCHMfnvi76VcNlxhY51joRzzHph9loq/d2Q/pKszxxgOLguc64tiCih
	 cAGsOoms572Sb5BRTvk6Ib70hTLgeuXYefdsrAWTlcnOS2GTTQFFnvEfHCGzb9iU7U
	 Xqy/5YByO9TdP5sAMXXKYf8hz+aBnZ+HFn+BOvbgEmCVjqhG+G4SAMkJqi3BQe2Zq1
	 oLO7Om/wVRcbHZBwjESL0OidcEAwIQSMym5uNiwo6zhNrATc6w+Z01F2YwqaY9H7ZT
	 er/czM1F9xnCnLDslXWFRDOq9mdy2dysINPv+y4PI/v0OWygxRbRZWl4hW1uBP4wcY
	 QKSXar0uGKeMg==
Date: Tue, 14 Jan 2025 16:02:55 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	cgroups@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
Message-ID: <20250114-convivial-axolotl-of-performance-7c2f63@houat>
References: <20250113092608.1349287-1-mripard@kernel.org>
 <Z4Z6Y5Xy5m4wMu_l@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="3l7n5s5omoiahcxy"
Content-Disposition: inline
In-Reply-To: <Z4Z6Y5Xy5m4wMu_l@phenom.ffwll.local>


--3l7n5s5omoiahcxy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/4] cgroup/dmem: Select PAGE_COUNTER
MIME-Version: 1.0

On Tue, Jan 14, 2025 at 03:53:23PM +0100, Simona Vetter wrote:
> On Mon, Jan 13, 2025 at 10:26:05AM +0100, Maxime Ripard wrote:
> > The dmem cgroup the page counting API implemented behing the
> > PAGE_COUNTER kconfig option. However, it doesn't select it, resulting in
> > potential build breakages. Select PAGE_COUNTER.
> >=20
> > Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgrou=
p")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501111330.3VuUx8vf-lkp=
@intel.com/
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
>=20
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

These patches have been pulled as a separate PR into drm-next, and I'm
not sure how we should merge these patches.

Obviously, we'd need Tejun's, Johannes', or Michal's ack, but should we
backmerged drm-next into drm-misc-next-fixes and apply them there?

Maxime

--3l7n5s5omoiahcxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ4Z8mgAKCRAnX84Zoj2+
dr5vAYDoVfvuLFW0YdrzngTEoDlH2y2HB/djdCXbgfupA6v4CGYlRFSIcBUR8B88
+QieR3UBf3Ooz7bg38Ff1tKLgHtCYEvii99CoYudDRMxdFpdt2sBYMS4NK4uXifH
vtE3uEWy8Q==
=OE5k
-----END PGP SIGNATURE-----

--3l7n5s5omoiahcxy--

