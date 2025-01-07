Return-Path: <cgroups+bounces-6064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846BA043E0
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CF33A4930
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB021F2C46;
	Tue,  7 Jan 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC56uEAI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1331F2C39;
	Tue,  7 Jan 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262812; cv=none; b=q0R6ICtmenTXJLpQjzhv+Q4bIm84NACGnNGRsHWGhtcpDMT0KW4BRZ4eZTcNP1qasZac6cnU8t9dLFb1nJMq9yLSXluXj0nYiaCGbWHaX3J+cefoqbRoodiHdmAuidY0x1ncFQlyXizk52Zg2PE4yabSfP3tZ6VQ9C3WVPMdIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262812; c=relaxed/simple;
	bh=VsVYm09H19ojgrIIsfyk9qwaXLbxKyDUg5Eo18dSfkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGy5ttsDSSTRJshSRmjQVNSzxi7CoM5Wmb3xdTl6r/9kbEE5vDuAkbrYPXIiFxXJ5pqQU6hlMNLqCcStg0wj8Pl8SpM8CPue51TPUFXF/gZ5qrXKQ+z6ueQKsDJooktep6CKaovvVwbsu3dd9mf+efniwB2PSFYizuQrFISZtkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC56uEAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26162C4CEE1;
	Tue,  7 Jan 2025 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262811;
	bh=VsVYm09H19ojgrIIsfyk9qwaXLbxKyDUg5Eo18dSfkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC56uEAI6rUyWA3b2XO+3g/RB//+0QMApISXjr0YQEFwdb+GoqKPNXWn43vOM2uD8
	 T4BE4XGaxGGEeb9TRRhVFJoizC5D1CuiVt1WWCP8vMZFcunXz2cjgqgToOSEFVHjX7
	 Mfc0f5uxoydD2u1HF/nbXtudFp4upG1S+vTfJ+EZwK735emOepfwvC/JWmWOQTBAuK
	 UOfUipHfOMZpdF2TC0eo6lUBjXV1EyoS0YAlXLbk41GK72npSkgarU9NbjMlhss7Ts
	 VWtoU/ZWBwNtOY1V8bXnCnl25bNH4cyOJqnvp0GDQAiZ7rfdlygwOLZ10jidH1NwJd
	 tHfi3OSrb57Nw==
Date: Tue, 7 Jan 2025 16:13:29 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Tejun Heo <tj@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20250107-aquamarine-nautilus-of-freedom-bc2208@houat>
References: <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
 <Z2GwpOQDVshpv-ml@slm.duckdns.org>
 <c0a539e7-0f1b-496a-9848-73a7ada66bfb@lankhorst.se>
 <Z2HBqtKDSTkd1lST@slm.duckdns.org>
 <61b95c08-a3c2-4f92-b6e5-df77fd2491e2@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="pv3xxe53a32ls35b"
Content-Disposition: inline
In-Reply-To: <61b95c08-a3c2-4f92-b6e5-df77fd2491e2@lankhorst.se>


--pv3xxe53a32ls35b
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 09:17:24PM +0100, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2024-12-17 kl. 19:23, skrev Tejun Heo:
> > Hello,
> >=20
> > On Tue, Dec 17, 2024 at 06:37:22PM +0100, Maarten Lankhorst wrote:
> > > Den 2024-12-17 kl. 18:11, skrev Tejun Heo:
> > > > On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
> > > > > Now that all patches look good, what is needed to merge the serie=
s? Without
> > > > > patch 6/7 as it is a hack for testing.
> > > >=20
> > > > There were some questions raised about device naming. One thing we =
want to
> > > > get right from the beginning is the basic interface.
> > > >=20
> > > > Thanks.
> > > >=20
> > > I believe it was solved. The conclusion appears to be that we go with=
 how we
> > > defined it in this series. drm/$pciid/$regionname. With the only regi=
ons
> > > defined now being VRAM. Main memory will be a followup, but requires =
some
> > > discussions on hwo to be prevent double accounting, and what to do wi=
th the
> > > limited amount of mappable memory.
> >=20
> > Provided Johannes is okay with the series, how do you want to route the
> > series? If you want to route it through drm, that's fine by me and plea=
se
> > feel free to add:
> >=20
> >   Acked-by: Tejun Heo <tj@kernel.org>
> >=20
> > Thanks.
> >=20
>=20
> Thank you!
>=20
> I've discussed this with the DRM maintainers. What was suggested is to
> create a topic branch, merge it to drm-misc whichwhere it will be picked =
up
> into drm.git during the next pull request. At the same time the topic bra=
nch
> can be also be merged into the cgroup tree if needed.
>=20
> The drm-misc tree already handles dma-buf and fbdev core, think DMEM could
> fit in there too.

FTR, I sent the PR Maarten mentioned yesterday:

https://lore.kernel.org/dri-devel/20250106-shaggy-solid-dogfish-e88ebc@houa=
t/

Maxime

--pv3xxe53a32ls35b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ31EmAAKCRAnX84Zoj2+
dgqwAXkBqOY80d6YfAI9M6lwC4qCdnkRHsUmVYNK6lBeBimVK5KwjQEv+0pvSl1N
asN42usBf2tjGAs/PAC3dEudEYLnkyhZxzTjSTWkr9DSpNuRWLC+kJP4KCBWKJTK
BxZ7dZiYdA==
=aJ4q
-----END PGP SIGNATURE-----

--pv3xxe53a32ls35b--

