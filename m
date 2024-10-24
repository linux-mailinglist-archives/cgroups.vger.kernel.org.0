Return-Path: <cgroups+bounces-5217-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF289ADD7B
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 09:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F011F2245E
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 07:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F318A947;
	Thu, 24 Oct 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzz1vsgY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88C189BB3;
	Thu, 24 Oct 2024 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754446; cv=none; b=tHgvdzdLUeBnawfWe76b1Doc9bFek/RNMT/20fSBqFN2HCYYSU0/uO464ov6WpWWash5g6XEpc80JumsFCHGr+1Q67pVPYJk1OvGctFHzlLx8HziytNdW9lGfnHFheEmdGeHRYZH6vSolq0H5BclLa86vfut6tklZ+9EJ3gLLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754446; c=relaxed/simple;
	bh=LR1LZ3CSRozgUjzx0t7w7Gn9212nLYiLXlkoAsdr8HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkugEjqdb2YcAME1Bc2VYeXToxlyl6ErIQtis8fdq5YmIqMPMOjmiTVCKj8qNNyC7igL8+qwh9z73as5ZaE09VyYFdUxLZmskjvoTMw6SYTTySTwcpPtiyn2G3hXXGuNNutwgOqtMm3Ti8BROJvo4sKvutHhZNznj4ymH7PniWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzz1vsgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0CEC4CEC7;
	Thu, 24 Oct 2024 07:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729754446;
	bh=LR1LZ3CSRozgUjzx0t7w7Gn9212nLYiLXlkoAsdr8HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bzz1vsgYeJqxYsK9+eDf7kMxZK/M4s6G+t1xvYk/JmC6Tj5g/BAduwh++eLiA7bL0
	 8I1E1yUKMUJ7qqWH4IVu2LGv8rcEf9Y14Ov8/1oCRuduyXOcW6BmZnpZP7hUGlMq+9
	 0C44DJw7jbCaGNQMAv6aewqv11xbQmBCunMTz/RYSmEj58slP0EtxdpcWl0mcqa6ra
	 bsibUS4+6bPpVC0VPYd/iC4exPI/mE3qLOkZAzhuMqtEtQEbSoOnmV+UpOfSUcLpbZ
	 JL/UkfFq/VGGc3y+Bbdm33XZkvzlJd3qRNuiKIMewBsC3o5iZtC0EStbdE7+LJr5ua
	 mwRiK2bpn18Fg==
Date: Thu, 24 Oct 2024 09:20:43 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
Message-ID: <20241024-beautiful-spaniel-of-youth-f75b61@houat>
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="j6zj4jbcyydfxuo7"
Content-Disposition: inline
In-Reply-To: <ZxlRLMwkabTaOrjc@slm.duckdns.org>


--j6zj4jbcyydfxuo7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
MIME-Version: 1.0

Hi Tejun,

Thanks a lot for your review.

On Wed, Oct 23, 2024 at 09:40:28AM -1000, Tejun Heo wrote:
> On Wed, Oct 23, 2024 at 09:52:53AM +0200, Maarten Lankhorst wrote:
> > New submission!
> > I've added documentation for each call, and integrated the renaming from
> > drm cgroup to dev cgroup, based on maxime ripard's work.
> >=20
> > Maxime has been testing this with dma-buf heaps and v4l2 too, and it se=
ems to work.
> > In the initial submission, I've decided to only add the smallest enable=
ment possible,
> > to have less chance of breaking things.
> >=20
> > The API has been changed slightly, from "$name region.$regionname=3D$li=
mit" in a file called
> > dev.min/low/max to "$subsystem/$name $regionname=3D$limit" in a file ca=
lled dev.region.min/low/max.
> >=20
> > This hopefully allows us to perhaps extend the API later on with the po=
ssibility to
> > set scheduler weights on the device, like in
> >=20
> > https://blogs.igalia.com/tursulin/drm-scheduling-cgroup-controller/
> >=20
> > Maarten Lankhorst (5):
> >   kernel/cgroup: Add "dev" memory accounting cgroup
>=20
> Yeah, let's not use "dev" name for this. As Waiman pointed out, it confli=
cts
> with the devices controller from cgroup1. While cgroup1 is mostly
> deprecated, the same features are provided through BPF in systemd using t=
he
> same terminologies, so this is going to be really confusing.

Yeah, I agree. We switched to dev because we want to support more than
just DRM, but all DMA-able memory. We have patches to support for v4l2
and dma-buf heaps, so using the name DRM didn't feel great either.

Do you have a better name in mind? "device memory"? "dma memory"?

> What happened with Tvrtko's weighted implementation? I've seen many propo=
sed
> patchsets in this area but as far as I could see none could establish
> consensus among GPU crowd and that's one of the reasons why nothing ever
> landed. Is the aim of this patchset establishing such consensus?

Yeah, we have a consensus by now I think. Valve, Intel, Google, and Red
Hat have been involved in that series and we all agree on the implementatio=
n.

Tvrtko aims at a different feature set though: this one is about memory
allocation limits, Tvrtko's about scheduling.

Scheduling doesn't make much sense for things outside of DRM (and even
for a fraction of all DRM devices), and it's pretty much orthogonal. So
i guess you can expect another series from Tvrtko, but I don't think
they should be considered equivalent or dependent on each other.

> If reaching consensus doesn't seem feasible in a predictable timeframe, my
> suggesstion is just extending the misc controller. If the only way forward
> here is fragmented vendor(s)-specific implementations, let's throw them i=
nto
> the misc controller.

I don't think we have a fragmented implementation here, at all. The last
patch especially implements it for all devices implementing the GEM
interface in DRM, which would be around 100 drivers from various vendors.

It's marked as a discussion because we don't quite know how to plumb it
in for all drivers in the current DRM framework, but it's very much what
we want to achieve.

Maxime

--j6zj4jbcyydfxuo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxn1RAAKCRAnX84Zoj2+
dhOFAYDnvKCdtdyZtwff6yW6hwWh0NyRRb2B3Gl+YlgcVCEGJ4qVIO4uviaD2Pzc
m1KnTrMBewRZ74IdWG+6paWjlbKquoDIPMwSmvXh2qaS8OsgoVJqlXVFoJp6wzt/
3ARaU1tySQ==
=b4FA
-----END PGP SIGNATURE-----

--j6zj4jbcyydfxuo7--

