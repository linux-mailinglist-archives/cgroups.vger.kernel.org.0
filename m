Return-Path: <cgroups+bounces-5454-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B759BE44B
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 11:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE08EB23702
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2024 10:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A111DE2AC;
	Wed,  6 Nov 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRUQaZZs"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A941096F;
	Wed,  6 Nov 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889111; cv=none; b=dvJdCHgXAo0GabmFuvVbXLJgbezdVF/o9JMZnSlwKf2+juM0RgHMY93oLlNyIAJfNeCwtFL3CFZwdBGHogYHDMjdH3CbiGhlygPWhiI7jXkY4/9BmhIvRzCCJSeeSn2e2VFxiQx1gp2FCHVD10BPgapWvYC5uf0/xvO99ehesHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889111; c=relaxed/simple;
	bh=oHqr3gxUoIGYJ2KixhmpeKBg9wdNtYv16Buyeyh1wWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2TpJEQCtTS9IdHxNnH3OmvQam8Tc/Hr9Oi/F+bM6YUWNpUWX/Lkw3hnBO7VmuZfL7dLmQM5Y+zZtdVMOjsyKlIW4OqF0Xi1bpuboqcSpgaalGYwez7lFJuEla1DRiQ1/jbPLvqexOr+fDf9HFmPRB4hpPwcBlWIiq9qR+cnC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRUQaZZs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26785C4CECD;
	Wed,  6 Nov 2024 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730889111;
	bh=oHqr3gxUoIGYJ2KixhmpeKBg9wdNtYv16Buyeyh1wWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sRUQaZZssmmBTYP8KFopE+hRjOYsrsUhcT9tahmG2sD12UrL8K+ThjXKqpMH0m9Ke
	 kQ+fSB9UnLYsnJjW8VSmMmuEVWT6l7suwousaZH6Q1VA7D9Bxnz5cE5cimUpa05zyN
	 /zH0YQBZDaH8/mQa/9GmhgqQbziIr/zuGwePwu+eWqeI0nusdtJmEgopYnb5ZoB/X7
	 hKRgY7FYk7tSHFwIqu+Fzpwy+tiZ4inBHTExIhZFT34WE7tBV+RxAo4HDymrUceEbn
	 ixhsQpFrz12Eu5kKEXSG9TisSur4zh3XIAMb3TAWsunGv1opItQTB3GOGDqLK4bn0p
	 8yJuAHmK49caA==
Date: Wed, 6 Nov 2024 11:31:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Zefan Li <lizefan.x@bytedance.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <20241106-vivacious-eagle-of-gaiety-44a419@houat>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
 <20241028-meaty-mega-nuthatch-3d74b1@houat>
 <20241029203834.GA636494@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="bvfw2tu3syzyhtms"
Content-Disposition: inline
In-Reply-To: <20241029203834.GA636494@cmpxchg.org>


--bvfw2tu3syzyhtms
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
MIME-Version: 1.0

On Tue, Oct 29, 2024 at 04:38:34PM -0400, Johannes Weiner wrote:
> On Mon, Oct 28, 2024 at 11:05:48AM +0100, Maxime Ripard wrote:
> > On Thu, Oct 24, 2024 at 07:06:36AM -1000, Tejun Heo wrote:
> > > Hello,
> > >=20
> > > On Thu, Oct 24, 2024 at 09:20:43AM +0200, Maxime Ripard wrote:
> > > ...
> > > > > Yeah, let's not use "dev" name for this. As Waiman pointed out, i=
t conflicts
> > > > > with the devices controller from cgroup1. While cgroup1 is mostly
> > > > > deprecated, the same features are provided through BPF in systemd=
 using the
> > > > > same terminologies, so this is going to be really confusing.
> > > >=20
> > > > Yeah, I agree. We switched to dev because we want to support more t=
han
> > > > just DRM, but all DMA-able memory. We have patches to support for v=
4l2
> > > > and dma-buf heaps, so using the name DRM didn't feel great either.
> > > >=20
> > > > Do you have a better name in mind? "device memory"? "dma memory"?
> > >=20
> > > Maybe just dma (I think the term isn't used heavily anymore, so the w=
ord is
> > > kinda open)? But, hopefully, others have better ideas.
> > >=20
> > > > > What happened with Tvrtko's weighted implementation? I've seen ma=
ny proposed
> > > > > patchsets in this area but as far as I could see none could estab=
lish
> > > > > consensus among GPU crowd and that's one of the reasons why nothi=
ng ever
> > > > > landed. Is the aim of this patchset establishing such consensus?
> > > >=20
> > > > Yeah, we have a consensus by now I think. Valve, Intel, Google, and=
 Red
> > > > Hat have been involved in that series and we all agree on the imple=
mentation.
> > >=20
> > > That's great to hear.
> > >=20
> > > > Tvrtko aims at a different feature set though: this one is about me=
mory
> > > > allocation limits, Tvrtko's about scheduling.
> > > >=20
> > > > Scheduling doesn't make much sense for things outside of DRM (and e=
ven
> > > > for a fraction of all DRM devices), and it's pretty much orthogonal=
=2E So
> > > > i guess you can expect another series from Tvrtko, but I don't think
> > > > they should be considered equivalent or dependent on each other.
> > >=20
> > > Yeah, I get that this is about memory and that is about processing ca=
pacity,
> > > so the plan is going for separate controllers for each? Or would it be
> > > better to present both under the same controller interface? Even if t=
hey're
> > > going to be separate controllers, we at least want to be aligned on h=
ow
> > > devices and their configurations are presented in the two controllers.
> >=20
> > It's still up in the air, I think.
> >=20
> > My personal opinion is that there's only DRM (and accel) devices that
> > really care about scheduling constraints anyway, so it wouldn't (have
> > to) be as generic as this one.
>=20
> If they represent different resources that aren't always controlled in
> conjunction, it makes sense to me to have separate controllers as well.
>=20
> Especially if a merged version would have separate control files for
> each resource anyway (dev.region.*, dev.weight etc.)
>=20
> > And if we would call it dma, then the naming becomes a bit weird since
> > DMA doesn't have much to do with scheduling.
> >=20
> > But I guess it's just another instance of the "naming is hard" problem =
:)
>=20
> Yes it would be good to have something catchy, easy on the eyes, and
> vaguely familiar. devcomp(ute), devproc, devcpu, devcycles all kind of
> suck. drm and gpu seem too specific for a set that includes npus and
> potentially other accelerators in the future.
>=20
> I don't think we want to go full devspace & devtime, either, though.
>=20
> How about dmem for this one, and dpu for the other one. For device
> memory and device processing unit, respectively.

dmem sounds great to me, does everyone agree?

Maxime

--bvfw2tu3syzyhtms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZytFjwAKCRAnX84Zoj2+
dhP6AYCLAglFPvJTI7NGiWfJ2DaM+nbOstOAHbYN8sfYzbvWrwbe/HTF9LjCb4ra
bdtt0isBf2uIVUakd0G5jxopBS0m3BsyUHYUKIjwYyAj9biATDBhXwkx/64FxALG
qHcA0gz17g==
=rI1J
-----END PGP SIGNATURE-----

--bvfw2tu3syzyhtms--

