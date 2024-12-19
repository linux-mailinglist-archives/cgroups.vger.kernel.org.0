Return-Path: <cgroups+bounces-5971-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C989F7AEA
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 13:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3958A166946
	for <lists+cgroups@lfdr.de>; Thu, 19 Dec 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB532236FD;
	Thu, 19 Dec 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7Tbwibe"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48E22146F;
	Thu, 19 Dec 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609832; cv=none; b=onpUEd5Ty4YQQzAj7GJVpoz1/FQliCES3zvqoGtZS6rrhOn+NJdvqiVoiXYUJ5BbWhWIXS+QjGKUdyf3yq6ABQ/H97zBwm1ZpuGENIi82SyCN5g4OQHHma7TX420vBIdlQ7ZrWfwmuInxfNBlRg7/IBZ+OTWjBQ7ueIr/rZCBXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609832; c=relaxed/simple;
	bh=8PH/DWN/c9/9fyd6ftKv7/M7QYHtzh3//Hu5Mz/KnLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/mW11MIcuGrM9mvIVgFzQgGGRHPJAvFqoW4M3w5xJmoy9BukLPPv49P++tymETa1xy1w+vfAsp4LWUQ3eyMxuTD4r2eWw/Gt3DPD2HAR2BwKV15u7WzF3zDWq4SLzXfRMRSr22NGvD1s5KvdLQWhhKYgdrWDr08XHEl6G63eSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7Tbwibe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A7CC4CECE;
	Thu, 19 Dec 2024 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734609831;
	bh=8PH/DWN/c9/9fyd6ftKv7/M7QYHtzh3//Hu5Mz/KnLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a7TbwibeVI0NjEa8csMF5UCh16/W5N0o/IA8zcK/qH0nhrO2qQMzSTTu2TAQlrP0i
	 NO4bNCKKLvBC9Dnd5P8lnnfSZN8BDFooO5XHmXspnbK6jEI4K4u/2/wXedieeBl4vu
	 Je8w0fpycJY+eTP48dDWvidxUvIYtRtXsa31OjHVuuro0hQatBHp2SY4WaxnVTjlKV
	 DNs4gIHh57AJt77NvCbkH1jfGfAgIg23V38c1RiLx2otTccQotVbipKeSVdeob9o1f
	 hHUXWLt+2A2WMYj6ijLMuH6VtM6sgehOZOEwI4OPxbLadYDFVIJWPXhfs8BwWPyhMK
	 e2Du5ncTub0bA==
Date: Thu, 19 Dec 2024 13:03:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 4/7] drm/xe: Implement cgroup for vram
Message-ID: <20241219-banana-pudu-of-radiance-aa62db@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241204134410.1161769-5-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="5iyklvofd5jx5ou2"
Content-Disposition: inline
In-Reply-To: <20241204134410.1161769-5-dev@lankhorst.se>


--5iyklvofd5jx5ou2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 4/7] drm/xe: Implement cgroup for vram
MIME-Version: 1.0

Hi Lucas, Thomas, Rodrigo,

We forgot to Cc you on this series, sorry. Could you have a look at it,
and especially the following patch?



On Wed, Dec 04, 2024 at 02:44:04PM +0100, Maarten Lankhorst wrote:
> Add vram based cgroup eviction to Xe.
> Most hardware with VRAM uses TTM for its management, and can be
> similarly trivially enabled.
>=20
> Co-developed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe=
_ttm_vram_mgr.c
> index c95728c45ea48..f4a16e5fa7700 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
> @@ -5,6 +5,7 @@
>   */
> =20
>  #include <drm/drm_managed.h>
> +#include <drm/drm_drv.h>
> =20
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_range_manager.h>
> @@ -311,6 +312,13 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, str=
uct xe_ttm_vram_mgr *mgr,
>  	struct ttm_resource_manager *man =3D &mgr->manager;
>  	int err;
> =20
> +	if (mem_type !=3D XE_PL_STOLEN) {
> +		const char *name =3D mem_type =3D=3D XE_PL_VRAM0 ? "vram0" : "vram1";
> +		man->cg =3D drmm_cgroup_register_region(&xe->drm, name, size);
> +		if (IS_ERR(man->cg))
> +			return PTR_ERR(man->cg);
> +	}
> +
>  	man->func =3D &xe_ttm_vram_mgr_func;
>  	mgr->mem_type =3D mem_type;
>  	mutex_init(&mgr->lock);
> --=20
> 2.43.0
>=20

--5iyklvofd5jx5ou2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2QLpAAKCRAnX84Zoj2+
dql1AYCyzH2b+9id2ZtcdDKPRcjpVHpPPKa9YUlwBXCWZRc2Cp/OdQB0XUAnWdRP
SVvncNoBfi4EkuvuzdkaXRQICUAD2hMvKBypNAKgio0vUTBwF64j2WVhsNWAhFLR
Pj9H6miOCA==
=UMTT
-----END PGP SIGNATURE-----

--5iyklvofd5jx5ou2--

