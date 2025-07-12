Return-Path: <cgroups+bounces-8713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A57DBB02A41
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 11:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261AE3B2B1F
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B232749F2;
	Sat, 12 Jul 2025 09:28:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BD10F9;
	Sat, 12 Jul 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312517; cv=none; b=N5YIOcCh6xu3CfGGum327v+e1FT5EW9NiUFO5OPZh/G+kubKacWtxeC9bOQl42PloYIaDJcV3BnkkznvnJtyiEt4fmbk2c0y/hA1PrFj9iRaJgqikIEiSYkuKGwo/vfgSDMLAqj6HI316gepACwbTXcesSP74NftfnCos1xykuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312517; c=relaxed/simple;
	bh=66rkmNeVc8f0LWo+esLRdoAYjmYfw9JJovnnEm1Te3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vd4TXbqEwDFyGNFSe3QtnpPlLkKTp9f+afbLYuLgmOt+88mvT3vagPIJ3ibLrKN3e28jSF2nA6yyc6L6eOMOw2sM3R0UpL7pYoI8ekrcJMc+P3DEY9+SKrVYgdl1yRbUp6GocSpzvyg1hc3FNpXXD/jgDVKy2FAX1zWtXkd8unU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [89.234.162.240] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uaWWv-0057Ds-02;
	Sat, 12 Jul 2025 09:28:25 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uaWWt-0000000052m-2W6X;
	Sat, 12 Jul 2025 11:28:23 +0200
Message-ID: <534accb98e487e4891cb58e846bd556f5f40192b.camel@decadent.org.uk>
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
From: Ben Hutchings <ben@decadent.org.uk>
To: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  Tejun Heo <tj@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,  Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt	 <shakeel.butt@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Andrew Morton	 <akpm@linux-foundation.org>, Chen
 Ridong <chenridong@huawei.com>, 	1108294@bugs.debian.org
Date: Sat, 12 Jul 2025 11:28:13 +0200
In-Reply-To: <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
References: <20240909163223.3693529-1-mkoutny@suse.com>
	 <20240909163223.3693529-5-mkoutny@suse.com>
	 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
	 <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cT6qxrHnB9rp+OvPm40I"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 89.234.162.240
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-cT6qxrHnB9rp+OvPm40I
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-07-11 at 15:10 +0200, Michal Koutn=C3=BD wrote:
> Hello Ben.
>=20
> On Wed, Jul 09, 2025 at 08:22:09PM +0200, Ben Hutchings <ben@decadent.org=
.uk> wrote:
> > Would you consider reverting this change for the sake of compatibility?
>=20
> As you write, it's not fatally broken and it may be "just" an issue of
> container images that got no fresh rebuild. (And I think it should be
> generally discouraged running containers with stale deps in them.)
>=20
> The original patch would mainly serve legacy userspace (host) setups on
> top of contemporary kernel (besides API purity reasons). Admittedly,
> these should be rare and eventually extinct in contrast with your
> example where it's a containerized userspace (which typically could do
> no cgroup setup) that may still have some user demand.
>=20
> So, I'd be more confident with the revert if such an adjustment was
> carried downstream by some distro and proven its viability first. Do you
> know of any in the wild?

The revert has just gone into Debian unstable, targetting the upcoming
stable release.  So at this point I can't confidently state that it
won't also cause regressions.

Ben.

>=20
> I appreciate your report,
> Michal

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed
                                                    - Carolyn Scheppner

--=-cT6qxrHnB9rp+OvPm40I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhyKq4ACgkQ57/I7JWG
EQkKhQ//eWfqhXyOWqMzlP2vxVnhpiFkPwgsE1Ywa4rklf/VGeZK0SJYWy0762UK
liXBG2Dmnr0428I/QRIZxviHgUciBL8deyV60DpL4IrlFTmOuRjw0WKF+9AFWBVj
sZNWvS2F75T3zK5H+reRgW3kBWKh2TVKorRTw4EuHNJrOso+BmZP4Rv+ZVcj9/Vj
5SDCpsKuX5BMfUwp5xjcHklESqUQS2/t4p5jGsGXq1I4bIwfff4uwuRGhO6au74Y
FVAvrnvLyODtQSONif8X8WlQVb0sJ7lr/onQVbHqwZ9DFYL6Yv21IeVTXk3cpWgf
yfMtsAvncubsF9o9HCvisGsenD0ECNKk8fIcs1C3vjc2GD2NezfIfMsDMpO2AYdv
eGOb/at7gYHuE1/3XrIEf2Cf+SoA0i8iOWzK6HnmmZ9B0LhvvPnQLTXTb7CahPtG
eDsLlVUa4KoNv88f+27bg65BJ0iqR2RQDhTRBL2/IdQyG567p5BXi1PPIH62fTqn
e285UgQIsStvftnpiqiwLt2E6oD+FTenOnY/JVUIw+XffneMc5dnjXRJgIYjLTVE
SKU3fstQs8aoLBtmGj1E8CnBdyHAs7B8rmxYCXuXkriqGEHIhnHRHHkiw4rVg/DX
7m43mQeDYXE62pRK8v4vaoTGfI/v0hoU/ASxrLM21kGwf3BPMRo=
=jcEx
-----END PGP SIGNATURE-----

--=-cT6qxrHnB9rp+OvPm40I--

