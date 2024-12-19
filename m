Return-Path: <cgroups+bounces-5970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C039F7ADC
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 13:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E587A3206
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ECC222D7C;
	Thu, 19 Dec 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTXlrd9m"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285E22146F;
	Thu, 19 Dec 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609718; cv=none; b=mQ7ntEsh/OE5FO9eIaxsGjFJFfNm9QtcPAojEosn+C4xfM09heva1cPExY46Lf2S61o6GlFxmAsP7rsyHZa9og+5U+tgTynCQq/UdOEe9TPy4RSyr57cjqO7SIZH3yYVkXuINM+oB4wX8+dMspSnmbLfnhCHqE+Pnq0aH0GVdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609718; c=relaxed/simple;
	bh=mmSG5jmvIG2IQz8h4oPfiL+yfIQ6E1uV4JAbWmJ+e1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBsOdOXa/Gy38wx1jLf8biMd5Zq6J1EYwjGwJvPAWtUf35xGIMK2pmyosuX5NJb7n0/z72w8F6e+bDGsrdLHT5+Oqf7OtJtII8vDByfDrRSNiUjQB8d3mLHNBaqm3hSsyjCZ3r62Fwv+JwGLIAhkTifzPVtkxEziN8r3b7DXdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTXlrd9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884AC4CECE;
	Thu, 19 Dec 2024 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609718;
	bh=mmSG5jmvIG2IQz8h4oPfiL+yfIQ6E1uV4JAbWmJ+e1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VTXlrd9mX2AtoGsMuWQEnYN+Leb0Ph2/db+NrKfLeO70FAXMd7qSLKGyn8zdIpWlI
	 cMF5nLg3ZEiMJZqoxU1oHiyyF6hO7cYPniY4EAN9pDP+57OBp/874axiYg4NHkULDN
	 ptYPqQ6Jk4GYS/dpgJdM/8hwlEbZHE+GABY6vSGzsBo4PQtoSd8LWF94CJl+7ORetY
	 P2nLCIxXSVOhV3/dp83pMQJYZ03jEpdYxxgb2mcdhYXBVJS0lpZsLaXtjF0t+Jmdi8
	 oo8w1Ndg+xfSYueLd+CZI248gXOnzlmmw7oOHU44V4aElZPrmZF8QBHzjrI8ywYV+Y
	 T3U6iuq8pu0rg==
Date: Thu, 19 Dec 2024 13:01:55 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 5/7] drm/amdgpu: Add cgroups implementation
Message-ID: <20241219-bright-oarfish-of-vitality-a8efba@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241204134410.1161769-6-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ggsfrfgw7sj3junq"
Content-Disposition: inline
In-Reply-To: <20241204134410.1161769-6-dev@lankhorst.se>


--ggsfrfgw7sj3junq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/7] drm/amdgpu: Add cgroups implementation
MIME-Version: 1.0

Hi Alex, Christian, Xinhui,

We forgot to Cc you on that series, sorry. Could you have a look at the fol=
lowing patch?

Thanks!
Maxime

On Wed, Dec 04, 2024 at 02:44:05PM +0100, Maarten Lankhorst wrote:
> Similar to xe, enable some simple management of VRAM only.
>=20
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 7d26a962f811c..f1703a746cadd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -24,6 +24,7 @@
> =20
>  #include <linux/dma-mapping.h>
>  #include <drm/ttm/ttm_range_manager.h>
> +#include <drm/drm_drv.h>
> =20
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> @@ -908,6 +909,9 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  	struct ttm_resource_manager *man =3D &mgr->manager;
>  	int err;
> =20
> +	man->cg =3D drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev=
->gmc.real_vram_size);
> +	if (IS_ERR(man->cg))
> +		return PTR_ERR(man->cg);
>  	ttm_resource_manager_init(man, &adev->mman.bdev,
>  				  adev->gmc.real_vram_size);
> =20
> --=20
> 2.43.0
>=20

--ggsfrfgw7sj3junq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2QLLgAKCRAnX84Zoj2+
drsmAYDbmxPhzez3f9e9kFd347WH3ntcM31sY9m9CBi5u9GgRqZ4KPX7cVSDDNzI
2hYAxVgBgP4Y/7904CdByUIhUSux6420o/rh0nJMdvs2pNkYOdk+GWJ+Cl1zPHfA
FOcqatwDfg==
=eaig
-----END PGP SIGNATURE-----

--ggsfrfgw7sj3junq--

