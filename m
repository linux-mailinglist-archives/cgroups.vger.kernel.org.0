Return-Path: <cgroups+bounces-4407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483F95A291
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 18:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D91285849
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2024 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC1414E2F9;
	Wed, 21 Aug 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KfRA2nxG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64414A4CC
	for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256898; cv=none; b=h18xFvYnSFSACJ+CMPsvTENnzn7Z429LnvC0xWAN8Lw9eZLmPr/R/PFm5s7kj286lkMbrquR2EXYMxAmh4W5yVIhNfmAWsTwOyvK8VOuueXAB99wb4T1+J3l21ngOa1KbvEEk+O8xYVqNEOe/AoBvsvu//2QOYoGQ9w6rp4r1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256898; c=relaxed/simple;
	bh=3B3ALkUJRLi8cP97BvdTswBNw7yjt7O7T6fDHWanx2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ew4AenHOAle20keR9byFt6ulq3Yq2A3jEzFnszF1gA9/MaSSlRuLHANS3rpkwoVflm7Zm7o/DN8inM+LD/FDe8DF2qCev8edsP9LB4UkozXxv2c+qBe50kkj+87HtTzTRtXtmC6dFTESPkW3rxXL04jiKFlH3BwO/ZNjVkDdYGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KfRA2nxG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5befe420fc2so4442200a12.3
        for <cgroups@vger.kernel.org>; Wed, 21 Aug 2024 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724256895; x=1724861695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3B3ALkUJRLi8cP97BvdTswBNw7yjt7O7T6fDHWanx2k=;
        b=KfRA2nxG9eFnTITS9+f6djJugvVkGtqwMTTEti+r4cPD069mFtlLwGRGqJPMCIqT/p
         kWvvBY+c+Jbux2JstevC5rr2TEF7N7nRbx0wrz65qqcuzKONn+8LXcb6Tr8hNCpcCC5H
         Sphdsjbob9un6PUXz3ntm6PeWKiych+pI3TCjVLOB098wqAtqzjpM4peXGkm3T6TIka+
         c19o8EaVqcPuiURZOnWfRL5552/MJCna5G3HZFiBcYPmU7CeFm6IsUgfpLEYEUH+Aziz
         4qgjLNrgpHuTS1pfOl440mpFsgl1eZoReG5sfnyMTPsPM2t74GWALgnueJJvEKSbtmeU
         K6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724256895; x=1724861695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B3ALkUJRLi8cP97BvdTswBNw7yjt7O7T6fDHWanx2k=;
        b=OWvI8XT2m8C0jPnsISUkOXRGIJozjuQNXzbW44zAYjrvPREhcyGfLHN/7o2nhh8MtV
         cRvgKvbqyMleUPhpqnhi12ookEPWf5vYsX1OtxXDOeObmjUMJEJQZAwQ0e2447OMEQgE
         JN2sk807gbhZgPppUZJHAyrinq5hUJj/e/gMk/6QFcCrKG/FzRHRXn8I9oxILz5FSHUG
         RJLouck4eOpKkj7eiif5Au91VGScNe+IUE/o3bJT2ig6ZecYdlzs8GjGQJQZGTBCNnFk
         cXGovaWpwM9orxBJJRtLn8/tO+I4TSUNVJ2BgTkkJTZgMrFVFESXSY2vTVnbXjm5Zy0x
         Yvvw==
X-Forwarded-Encrypted: i=1; AJvYcCXt7p1hM5NUDtDPhtra+VczVZ7gSTGA6gWse+1ECksbBSTp99fVI/z2BRL30LNXorK1eZZY7Aio@vger.kernel.org
X-Gm-Message-State: AOJu0YxAs9wgw/BxFpG39YXkGyugJ2x0Z/ULaUZ5ZT80j2BWvCRh2Vbb
	3iwHn1QiQjfg0E2pVYVYNkdqQXVG5P+TxE5t5hR2w9504fu1LmFPw2xijRk85qw=
X-Google-Smtp-Source: AGHT+IEI+eXfST3mbkFSu/qkebOWpBDb0aMdGwOlC5TSPXexz9gK/qw7N9fxUdKgisyC7icFsMINGg==
X-Received: by 2002:a17:907:6e94:b0:a86:8a89:3d86 with SMTP id a640c23a62f3a-a868a893f37mr11440066b.36.1724256894628;
        Wed, 21 Aug 2024 09:14:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb24sm915722966b.68.2024.08.21.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:14:54 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:14:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
Message-ID: <zsj4ilkso7p43qexiumk42bkzuqt5bxi3u5pys5arfpjodqszd@4jomnqwf4vim>
References: <20240814171800.23558-1-me@yhndnzj.com>
 <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
 <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lu32mhkwlc2ceo6f"
Content-Disposition: inline
In-Reply-To: <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>


--lu32mhkwlc2ceo6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 01:22:01PM GMT, Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> Anyway, both use cases make sense to me, disabling writeback
> system-wide or in an entire subtree, and disabling writeback on the
> root and then selectively enabling it. I am slightly inclined to the
> first one (what this patch does).
>=20
> Considering the hierarchical cgroup knobs work, we usually use the
> most restrictive limit among the ancestors. I guess it ultimately
> depends on how we define "most restrictive". Disabling writeback is
> restrictive in the sense that you don't have access to free some zswap
> space to reclaim more memory. OTOH, disabling writeback also means
> that your zswapped memory won't go to disk under memory pressure, so
> in that sense it would be restrictive to force writeback :)
>=20
> Usually, the "default" is the non-restrictive thing, and then you can
> set restrictions that apply to all children (e.g. no limits are set by
> default). Since writeback is enabled by default, it seems like the
> restriction would be disabling writeback. Hence, it would make sense
> to inherit zswap disabling (i.e. only writeback if all ancestors allow
> it, like this patch does).
>=20
> What we do today dismisses inheritance completely, so it seems to me
> like it should be changed anyway.

I subscribe to inheritance (at cgroup creation) not proving well (in
general). Here's the case of expecting hierarchical semantic of the
attribute.

With this change -- is there any point in keeping the inheritance
around? (Simply default to enabled.)

Thanks,
Michal

--lu32mhkwlc2ceo6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsYSeQAKCRAt3Wney77B
SexGAQCl22OTYWCFYBCcunWFQ+6cMCBJqqHzu4PPL+EdAji9RwD+NVmEGm7Wpc5h
bvRkzLD1JhQDEhGkNrS7UA8ozjDdAgI=
=UvMP
-----END PGP SIGNATURE-----

--lu32mhkwlc2ceo6f--

