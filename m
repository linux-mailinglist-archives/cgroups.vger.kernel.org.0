Return-Path: <cgroups+bounces-4673-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45AC968993
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 16:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713DE283B6D
	for <lists+cgroups@lfdr.de>; Mon,  2 Sep 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9619F11F;
	Mon,  2 Sep 2024 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="Pz+Rc1H6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EDE19F10F
	for <cgroups@vger.kernel.org>; Mon,  2 Sep 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286440; cv=none; b=VAm2tU4Wu2Vgs9brA0iWNfQOoJks8NWZctdrPpI5CIeFspfYqPWQzglgDD9hDgH/apkHeohPKvcxNOq3GhDP952WBQEzulO2+1+JHEdCICsGIyDV+Fj8Tf/kKq8IYAVgAq2hm6Qnnl3X7l0m2t/XpX73AJ2StM7c5I7T2rAUTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286440; c=relaxed/simple;
	bh=uGPV9tAR75BtaCLwmnuCOAw4KGDFFnJEqjWSWmwE5Gs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5ZXEG+oCzqkpPKmyBNmo2Mc8a88LdXELC9OUQixmTNa6caYJv7MPO3X3IP5vEyxRsEnkqZAP2bad3Aurv0Fv3VaIQ238/qkE/cVXw+X0IcMMuwcPuuZgnkQL4XDmEPTYxW8Kr0h4r/v6IFBVsgHNq6ds0vN5U+pb3Ua4CkhLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=Pz+Rc1H6; arc=none smtp.client-ip=185.70.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1725286429; x=1725545629;
	bh=uGPV9tAR75BtaCLwmnuCOAw4KGDFFnJEqjWSWmwE5Gs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Pz+Rc1H6l8xE+LNq1VflhrnR6hZy/Zy65dlMYNFu0Q8+2bXbIZ8uwxqaYPoqjRD18
	 eHNaNmifT8ruB1nWzp4M976xXzqEIpjnI/i8sg906lFytRLJH5mLzDehjT3c5dNfeH
	 olHtHEN6vipEHN+87gDxRj1iVr3lLiZVKbig94IjnwUcfcYczG2oPfBkF2OFiAy7pO
	 PsHkX1Wx1+KZeSTOogz0TkTPux4oi5KkSfScEeXHulppwGMkWDrNXzeiHZNbRBsVwi
	 SAxKg2a8G+fqZcYOA0Q4/R+0sOE95H+JTuSkM6W1mHWMUuMRxmcWsm+nhDRIkWr0Qe
	 JWO4oYs9ILFfg==
Date: Mon, 02 Sep 2024 14:13:43 +0000
To: Andrew Morton <akpm@linux-foundation.org>
From: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation/cgroup-v2: clarify that zswap.writeback is ignored if zswap is disabled
Message-ID: <d305db940e461c92a618dd26224144a5105274b3.camel@yhndnzj.com>
In-Reply-To: <20240823162506.12117-3-me@yhndnzj.com>
References: <20240823162506.12117-1-me@yhndnzj.com> <20240823162506.12117-3-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: 1b059982da0bd1a3cba5619155b6e8cc6ca71b5c
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> As discussed in [1], zswap-related settings natually
> lose their effect when zswap is disabled, specifically
> zswap.writeback here. Be explicit about this behavior.
>=20
> [1]
> https://lore.kernel.org/linux-kernel/CAKEwX=3DMhbwhh-=3DxxCU-RjMXS_n=3DRp=
V3Gtznb2m_3JgL+jzz++g@mail.gmail.com/
>=20
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
>=20
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> ---
> =C2=A0Documentation/admin-guide/cgroup-v2.rst | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst
> b/Documentation/admin-guide/cgroup-v2.rst
> index 95c18bc17083..a1723e402596 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1731,6 +1731,8 @@ The following nested keys are defined.
> =C2=A0
> =C2=A0=09Note that this is subtly different from setting
> memory.swap.max to
> =C2=A0=090, as it still allows for pages to be written to the zswap
> pool.
> +=09This setting has no effect if zswap is disabled, and
> swapping
> +=09would be allowed unless memory.swap.max is set to 0.
> =C2=A0
> =C2=A0=C2=A0 memory.pressure
> =C2=A0=09A read-only nested-keyed file.

Hmm, Andrew, it seems that the commit messages of this and the previous
patch are somehow reversed/mismatched? [1][2] Could you please confirm
and fix it?

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
unstable&id=3Deef275964326760bb55803b167854981cab97e55
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dmm-=
unstable&id=3D42c3628a37400c2bc4199b9f8423be701646d4e0


