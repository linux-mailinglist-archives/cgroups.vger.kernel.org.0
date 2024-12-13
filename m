Return-Path: <cgroups+bounces-5884-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5109F0CE6
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 14:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A752830C8
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128D1DF97D;
	Fri, 13 Dec 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muRbWLIT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C05A1A8F85;
	Fri, 13 Dec 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095032; cv=none; b=BGu+8Ta8esTR/Y48Th70CwjVGcThDuEZszRobBdhw9g5BTmpF83AopdLMDCqE6eFJuVzOUqAphuXN9vklShMEK2yqaFd9HfNap4DSsTuru8X/u3yJ8Gq/eegOSTxNND4lFeyn1v/62hTg7fvQrKWVjzpeYo+Z/Ipy/nT1vKEW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095032; c=relaxed/simple;
	bh=E8l4/W5Vj6WHbW+ezaL5t0klk/Ev76XzGMo/Shf8G/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPyKc27qWwY8TOjL/DYJg1o0huAMGuZ2F7jpyDYJFZnlGYibSrjKIx/7KCTNvoG1816tsSry/mrCjV4+RdIXH1NIlLTnjRagHx7jZbfkwDvzZBezOgawNIbG30DBacoHhmjFAlvdEA2po5UysdtSIzuyU8usd1WfmxpaLDB8CI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muRbWLIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B099C4CED0;
	Fri, 13 Dec 2024 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734095031;
	bh=E8l4/W5Vj6WHbW+ezaL5t0klk/Ev76XzGMo/Shf8G/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muRbWLITHPb5lwoB/0q0VOTFMIQl2ch9xucudEk9J1F2K7B7nX9DdQVQqKiCYhaWO
	 dstxCA+16QH3U5/B/j5RQ2HtPiLB9hGyHQ8+jSjlI4wnIdVMlIa+xPaOddKuEwfAdi
	 oBN8WuhypVIbW2ihzmkaE5+vz/QE9ADSlp6lIp0miMY4tKyt6tdwklE445koHYXedY
	 o0o2JaptVxtZVtilanL8m/gXUOZJyMpYXBEhZpQJpbckK8S42pw/OxzOmT1OnoPoG3
	 EGOohYwj83z7uZiLv/JZCNoHcz0c48grsG8a8xuSoBuXjawDGqX9OSzxiUJSQHEcVx
	 wl9252A6VG8aw==
Date: Fri, 13 Dec 2024 14:03:49 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
Message-ID: <20241213-proud-kind-uakari-df3a70@houat>
References: <20241204134410.1161769-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="qnhyf4plgwmkdxao"
Content-Disposition: inline
In-Reply-To: <20241204134410.1161769-1-dev@lankhorst.se>


--qnhyf4plgwmkdxao
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] kernel/cgroups: Add "dmem" memory accounting
 cgroup.
MIME-Version: 1.0

Hi,

Thanks for the new update!

On Wed, Dec 04, 2024 at 02:44:00PM +0100, Maarten Lankhorst wrote:
> New update. Instead of calling it the 'dev' cgroup, it's now the
> 'dmem' cgroup.
>=20
> Because it only deals with memory regions, the UAPI has been updated
> to use dmem.min/low/max/current, and to make the API cleaner, the
> names are changed too.

The API is much nicer, and fits much better into other frameworks too.

> dmem.current could contain a line like:
> "drm/0000:03:00.0/vram0 1073741824"
>=20
> But I think using "drm/card0/vram0" instead of PCIID would perhaps be
> good too. I'm open to changing it to that based on feedback.

Do we have any sort of guarantee over the name card0 being stable across
reboots?

I also wonder if we should have a "total" device that limits the amount
of memory we can allocate from any region?

Maxime

--qnhyf4plgwmkdxao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ1wwtAAKCRAnX84Zoj2+
dubaAX422121RCTAGgG1ZhjlmSQKxIe/7lpqNfOY43zO3XA2J1x2bouiIlciUVOf
5N6YqssBf0N8tl9+MriuHzFtTkKuEwIZ2qRWklYOh61j1RkGgiz/2sorYylAXlYp
4KKGLABCEw==
=ehhw
-----END PGP SIGNATURE-----

--qnhyf4plgwmkdxao--

