Return-Path: <cgroups+bounces-5885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CE99F0CF5
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3817188ABE1
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10EC1DFE1C;
	Fri, 13 Dec 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boBHWnff"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CB1DFD87;
	Fri, 13 Dec 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095269; cv=none; b=NeXO4q+/bJ//1stvhyd9wkl22m47V0K1SPLjNoYIhBjYNhUIGQLVCVfRNqL5Ecu+aoUIcdEw9ZL8783LbIJ0PQ0kS0gcO3gnUhxA3+aBzx7x+lRqzs7Q05LsrFmKlzhk82p08MVJ6MZS/9UaKthuc7pKu9vBTOrdA/eWMGoKohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095269; c=relaxed/simple;
	bh=uMeScOuP+OJQ7++MVgDmQiNlrlV1cFBdw7c/2oZGj7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRJMonXMV/tn49tRkgH2JuHLfpqUYiVu+PHysyzN9Mh2tmrGO5+mhff5l6533QwBonAHJYClx4C+cNYC1/tLdW8uEfulQixxHbi1a3DXFTGIeG6NMN3vt7ZgIKJYobpyBZoHge8iCUpg6PetGjxmQlE5hcPF4XuLQQjHd9FXhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boBHWnff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CF5C4CED0;
	Fri, 13 Dec 2024 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095269;
	bh=uMeScOuP+OJQ7++MVgDmQiNlrlV1cFBdw7c/2oZGj7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=boBHWnff/hgF7FYpIcsbAdtTvCOOWyqgQsee2l9hMkLuPWV4IsqpqT/Zol8V/qD5f
	 vcJ08nFVsJudxKOCrDLx9T1Y5+/XYlXgrAtLgSApA2Ww9+2K9uMW3ARAVPHr+A8eow
	 p/9UANhuvy7QD6Ui1V9/9c2FRbbEEkUor1MFWxGq0yrd0hNDxlfYNH0aKfe7qDvLXq
	 UIazpUkuxj8v0414ScUCdzRNaj2WA7GJUo0EeSs9coMoh5uZtOcX8AX329P+qdoFXz
	 ja9Hbp47XFsAbR39aR7Bp2Mu4smGtkouBFVMarZKi7Sal39ezC2CggPXSeWaBFa1QK
	 OPyLB2/6FvJWQ==
Date: Fri, 13 Dec 2024 14:07:46 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241213-sceptical-maize-gazelle-fadc34@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <29a71119-04de-4c76-a98a-d0fcb906390f@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="xokrzpyhqued3d7l"
Content-Disposition: inline
In-Reply-To: <29a71119-04de-4c76-a98a-d0fcb906390f@gmx.de>


--xokrzpyhqued3d7l
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Sun, Dec 08, 2024 at 01:15:34PM +0100, Friedrich Vock wrote:
> Hi,
>=20
> On 04.12.24 14:44, Maarten Lankhorst wrote:
>
> > Because it only deals with memory regions, the UAPI has been updated
> > to use dmem.min/low/max/current, and to make the API cleaner, the
> > names are changed too.
> >=20
> > dmem.current could contain a line like:
> > "drm/0000:03:00.0/vram0 1073741824"
> >=20
> > But I think using "drm/card0/vram0" instead of PCIID would perhaps
> > be good too. I'm open to changing it to that based on feedback.
>=20
> Agree, allowing userspace to reference DRM devices via "cardN" syntax
> sounds good.
>
> What about other subsystems potentially using dmem cgroups?
> I'm not familiar with the media subsystem, but I imagine we might be
> dealing with things like USB devices there? Is something like a
> "deviceN" possible there as well, or would device IDs look completely
> different?

I have some patches to enable the cgroup in GEM-based drivers, media
ones and dma-buf heaps. The dma-buf heaps are simple enough since the
heaps names are supposed to be stable.

I don't think using card0 vs card1 (or v4l0 vs v4l1 for example) will
work because I don't think we have any sort of guarantee that these
names will always point to the same devices across reboots or updates.

If the module is loaded later than it used to for example, we could very
well end up in a situation where card0 and card1 are swapped, while the
constraints apply to the previous situation.

Maxime

--xokrzpyhqued3d7l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1wxogAKCRAnX84Zoj2+
dq5iAX4rcVUShdPwwoe/RfA57qN/7Mx6+hgYbzJMWnzIBnKJz0dn+kbUlv3KGdwz
hWlIPsoBgJvEzg91vZJBiGdsdYRPIlkVHTfuFH/UOtHiSzM1KliMd5zv+JdtITN3
VU2IF4OnZg==
=efDB
-----END PGP SIGNATURE-----

--xokrzpyhqued3d7l--

