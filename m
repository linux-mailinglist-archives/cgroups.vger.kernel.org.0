Return-Path: <cgroups+bounces-5943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41E39F54AB
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2113E1710A9
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 17:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFD91F9409;
	Tue, 17 Dec 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJbB4Giy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDF1F7568;
	Tue, 17 Dec 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456876; cv=none; b=f6I0mS4xpmmblCAZKZBLvRL8Zo5Usvm3XbXwKnEmRRPF83Pzb0SBDfjsPhtff0jaCZD63bh63K79f+/7Z2J0N8cx7ujaY+0foOTrz9jt8laFULqooISX9TKc6mM/mVwv7YsN3r68JiVWFpb21PP2OT5AqBS5XBBfBr6nj6UQ1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456876; c=relaxed/simple;
	bh=dbq7HRtwAuOWYe5ZaidZLWtsSdiMIrwx4jElfMk2ARE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9hZ/CO0EO4zcJYwTiz7UCxrIF1dh3fsLV9D/nIdSf+s6hA13lKb4bNw+VRdNghpfmLs+pTH5fgnpf4gsdqNdWJ+X4eOX3LjPMEE55WsHHrCR+Zd5o6wSfiTKEPG3hgF31uZLtVIZjNmoF2IIJP6wCZR2JahX4QH0QICoO7hg2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJbB4Giy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B153C4CED3;
	Tue, 17 Dec 2024 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734456875;
	bh=dbq7HRtwAuOWYe5ZaidZLWtsSdiMIrwx4jElfMk2ARE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJbB4Giyw0ORE0BgfGD0ZHSRO0iXESRcAdMzAJbq1KRFw/D+h6giknSBbW9GdwRso
	 WxuRcExuLtBeKI4cQVwz+paA5r52feGdpc1dQU48wdmf236bVp9hh9KL+9m5/ftKlc
	 wkoaVbxCwcFZDqh88tLzPeplCe4+FDMB598RmX9B6varI4UZZxcLynAsFcTSybsohV
	 rruP1bt9ZfFt9ikxp88w36+P43T9qvYgat6Uf8g+I+hycmDWXTpOuU5lUisSNuZlqj
	 TfgQufN0v5eVKHYlEVccRN0TvqRjkRMZZfY9357Wt+LKBqFfhPYAzWDfP4lgaiMmnA
	 mANNfZWT7krlw==
Date: Tue, 17 Dec 2024 18:34:33 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Maarten Lankhorst <dev@lankhorst.se>, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241217-marigold-cat-of-influence-64bcfa@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
 <20241213-proud-kind-uakari-df3a70@houat>
 <80c49a80-d49c-4ca5-9568-9f7950618275@lankhorst.se>
 <20241213-gentle-glittering-salamander-22addf@houat>
 <5a50a992-9286-4179-8031-ffb514bca34f@lankhorst.se>
 <20241217-meek-bullfinch-of-luck-2c3468@houat>
 <a69a3500-be17-4899-bdb9-c6a63bf8dc81@lankhorst.se>
 <Z2GwpOQDVshpv-ml@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="c6tq2wqscpnuxkrk"
Content-Disposition: inline
In-Reply-To: <Z2GwpOQDVshpv-ml@slm.duckdns.org>


--c6tq2wqscpnuxkrk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

On Tue, Dec 17, 2024 at 07:11:00AM -1000, Tejun Heo wrote:
> On Tue, Dec 17, 2024 at 03:28:50PM +0100, Maarten Lankhorst wrote:
> > Now that all patches look good, what is needed to merge the series? Wit=
hout
> > patch 6/7 as it is a hack for testing.
>=20
> There were some questions raised about device naming. One thing we want to
> get right from the beginning is the basic interface.

We decided on the previous version to use dmem and I believe this
version has switched to it. Do you have any concern still?

Maxime

--c6tq2wqscpnuxkrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ2G2KAAKCRAnX84Zoj2+
dhcUAYDu7JUd06yF9dtpAtSY2xgUUyKiBfittjG2LbIT1/c9CnioooqRQDaKdWa2
o3i7wn4BgIG6Ni/zuzXo1ifLLIxisPArPduBae8x5MlNmXKB8A3GnNvPKtItE9PR
FXyNEY9XAg==
=mI6D
-----END PGP SIGNATURE-----

--c6tq2wqscpnuxkrk--

