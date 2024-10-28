Return-Path: <cgroups+bounces-5289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF099B2C4C
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413691F22660
	for <lists+cgroups@lfdr.de>; Mon, 28 Oct 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364001CC8B2;
	Mon, 28 Oct 2024 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaOhBppD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B418B46E;
	Mon, 28 Oct 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730109952; cv=none; b=QrMwNNFLo8J75LV0VejoOagbp1KnaSyFaM1PeG5bukGpeFJJO+RayNtXv5IZJpabNsI6lyXjhsoUiQ5jPg0+GPYQcbuQMGmihgPen34fw+yjYBFVaLtFyXi1ED5i9dDJWTnSzO+lojZGqIwfeZd7NvX+VIZ1E5V12/sadvOu5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730109952; c=relaxed/simple;
	bh=Z2fr1jJxkc2nUFejeQVSYNaVA/Ey1sprE8dbblumJVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otf5gTIAr8e+G1QCLGj8SklV2echMfNTPGNSgH/2WzZdrcnf8Y9mUn+c6satpe+L02XGrdEChsgl4iFr4EKpRMq48u92RdPlCmrxBqzcda+yEjp0cgA7tlj6a7MdeLnjPNJtER7TBRu3bpxYhD6NL82hnQyETx6iVsYlrf1HD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaOhBppD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E927C4CEC3;
	Mon, 28 Oct 2024 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730109951;
	bh=Z2fr1jJxkc2nUFejeQVSYNaVA/Ey1sprE8dbblumJVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaOhBppDvy01NoN85ZBGyg7R9bgjbbNHd4ZXHKnG8ehSDkfnYt/1UXzrme1sAUxnq
	 3FHCpVXmGmvwdkzsimAutjlw3P9mE+f7JnSxV79dEFVlx11rDEq7Ebvc7uPMxMsTRH
	 tUhZ3zPo9VmkJm2zP4zG4iAH2AcMlK39dZJsf5ca0QSzF95x/8bq2N9/Won3Xgwuhd
	 mcKIjNcLmvlMW4Ygz4UmhUNChHC4wPut7umYjDwvWG3cVNHVEK9Dkl7K27NLFd4bT0
	 zYBzKutajMYcOLdqhT7mYVLgTAjKDE0aLjJefVlsHMa6Q0bpPvwJDhDUWfqC6BbTOg
	 gUkurUyWh/9TQ==
Date: Mon, 28 Oct 2024 11:05:48 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <20241028-meaty-mega-nuthatch-3d74b1@houat>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="t7lydr677wzslm3o"
Content-Disposition: inline
In-Reply-To: <Zxp-nLXOJXoSy8BN@slm.duckdns.org>


--t7lydr677wzslm3o
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
MIME-Version: 1.0

On Thu, Oct 24, 2024 at 07:06:36AM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Oct 24, 2024 at 09:20:43AM +0200, Maxime Ripard wrote:
> ...
> > > Yeah, let's not use "dev" name for this. As Waiman pointed out, it co=
nflicts
> > > with the devices controller from cgroup1. While cgroup1 is mostly
> > > deprecated, the same features are provided through BPF in systemd usi=
ng the
> > > same terminologies, so this is going to be really confusing.
> >=20
> > Yeah, I agree. We switched to dev because we want to support more than
> > just DRM, but all DMA-able memory. We have patches to support for v4l2
> > and dma-buf heaps, so using the name DRM didn't feel great either.
> >=20
> > Do you have a better name in mind? "device memory"? "dma memory"?
>=20
> Maybe just dma (I think the term isn't used heavily anymore, so the word =
is
> kinda open)? But, hopefully, others have better ideas.
>=20
> > > What happened with Tvrtko's weighted implementation? I've seen many p=
roposed
> > > patchsets in this area but as far as I could see none could establish
> > > consensus among GPU crowd and that's one of the reasons why nothing e=
ver
> > > landed. Is the aim of this patchset establishing such consensus?
> >=20
> > Yeah, we have a consensus by now I think. Valve, Intel, Google, and Red
> > Hat have been involved in that series and we all agree on the implement=
ation.
>=20
> That's great to hear.
>=20
> > Tvrtko aims at a different feature set though: this one is about memory
> > allocation limits, Tvrtko's about scheduling.
> >=20
> > Scheduling doesn't make much sense for things outside of DRM (and even
> > for a fraction of all DRM devices), and it's pretty much orthogonal. So
> > i guess you can expect another series from Tvrtko, but I don't think
> > they should be considered equivalent or dependent on each other.
>=20
> Yeah, I get that this is about memory and that is about processing capaci=
ty,
> so the plan is going for separate controllers for each? Or would it be
> better to present both under the same controller interface? Even if they'=
re
> going to be separate controllers, we at least want to be aligned on how
> devices and their configurations are presented in the two controllers.

It's still up in the air, I think.

My personal opinion is that there's only DRM (and accel) devices that
really care about scheduling constraints anyway, so it wouldn't (have
to) be as generic as this one.

And if we would call it dma, then the naming becomes a bit weird since
DMA doesn't have much to do with scheduling.

But I guess it's just another instance of the "naming is hard" problem :)

Maxime

--t7lydr677wzslm3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZx9h9gAKCRAnX84Zoj2+
dlU+AYCxActcJs1M7HcXNvi88y4oVEf4bnodKMwcVHc/s5JEvI4cja+MhosCF+3b
uptlsFIBgKwWkcuonwZQCL1tmx5YQCFFg4+etI8Oz58IK+o0xVJKfuYCyXvSKQzs
7Ws0CK5uUQ==
=O7zl
-----END PGP SIGNATURE-----

--t7lydr677wzslm3o--

