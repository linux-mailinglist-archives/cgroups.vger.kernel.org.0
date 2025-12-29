Return-Path: <cgroups+bounces-12800-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF53CE6691
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 11:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FC21300769E
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 10:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC96242D6C;
	Mon, 29 Dec 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DyaLcaAo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81E194098
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767005601; cv=none; b=CJxr1ZlZ2GRRXYMJoqbOXb2XofFl0LwrXqXx6dLn7s2oydPmn1wprvk1YkgBDnPBki0fO+AZD3rzltmNBBRzvrdMKxbGV8g8Tzxu0eY6yC0UgeDkjG2wrw88xzHG0TtDAtw8AbNxrVR33GGyTIrK6zKtPglK30CMRrmLDMBBcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767005601; c=relaxed/simple;
	bh=u659i9CjwAmmMF9S2IE3CU7qD+oW9Q2rvtmB89/XJAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAsvHmuhATco9vICI2BaMfqtTuX28d2M9T30nDeTIau8lp4LFpucZ9ionik5KCNameM3LoeVT0gm/FfZBrHRbVa1H1D+2Gmqfp+S0a4KfEv7bNd2j/1g4yQAwBB+nEfxD47Hyi8B4zTAEWcjcC6bRyuEaRzxWoxWYAho9eoiIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DyaLcaAo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fed090e5fso4142689f8f.1
        for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767005598; x=1767610398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkwE6228mnRy5innvr4FWjSNZPYoF0wgLDMAwQ6QHo8=;
        b=DyaLcaAoq8D2sOX8r3NnBFd6oOkwyqvRsR8ujQ6w+LoZpg/kuTAe8iR7GV3JuQ22QK
         dPV0uTcCF8wjor7zAHDTMs2qHtmFtXHVFm1Og0SF1uuaBwBv4UapsIYLQppZMdJsE+kr
         X+aaE/IBoL7ll6z34sc9E7cqw+rbqpCxCmzC7rGGLhywtbER5iIcOG4YkNjxBA8WTWfN
         9ZUY9bWvGDVLjSQuWQ1ZhgOq8wPw5DhrAi8a6b41GJPVmlvwNd07/3uNsXPA8DFvxJ2l
         xso+g75cVxoSVRzq500mZkTduGUFXyfbrHTN6h3gaEnvVVObU7lN59jfTXnRR0kpgKuY
         373A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767005598; x=1767610398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkwE6228mnRy5innvr4FWjSNZPYoF0wgLDMAwQ6QHo8=;
        b=R2IOh5I/qbjz8EgBB45Zg0kAKTdANni3pz9dtOIAQxgvKrJkh+L/djFB/zz75bxXcP
         it72A0E1/DDoy39TBGAS5UVftsI/VK4VtPqCmbF3Gicu63R3reFogZvycnBdheAYEGzm
         ypwW8mtovjI1a6qtj/ehxZk2mY3TTA1lGJ1P2PhQbvJ1fkwiiiVmkh3FHOtLIwtyXJjb
         f1lxs7XD5CAY8/LL6BZGeKBS5S1y9m3POiaTr1SUrr6yIy02xWmsNBECf7b7lE/NvMGx
         YIVst26anSCkhZqw2xq31mEjiiRRjdWLwQuCekQSqDjadRWqzbM4WneFZXnik27aw9AU
         ktxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0JWyz+U1A0fwE/PiZXsH/2v7AyN1nIsLSRdr2Z7gETIxvhhCTOQtoW2CYh+eGHi79C0kFeuH@vger.kernel.org
X-Gm-Message-State: AOJu0YyNjl0mq3A8XYC1EnWOHVPS3m4EdeAlSmFAfBwV7VMJZ3CQ4n8Y
	aXvdvVjdVhEr/VrmbZ/dsEgWxS5ca43n86tpCtcSwezi9/Azaj3DQZB5tkwBX19YjWs=
X-Gm-Gg: AY/fxX7KDiw2KfKGM211JdJocjY4tYR67e8a+VfZdu0xYfLBBolN1by1906vG7lzq96
	/VsTkB6CudZweVXTqrvvzPQOX0Foi/JOSXPCt5imA/K38oU+Otn16OhHI/Rbw/5FqaWEZMqB+WF
	0/QBU3nTXSEfeD2WA3ZuGMFQOH/R9wzSiozwshYy6xahDgidUXjw8c0Pf67awKw6JnipyJtxKqX
	4NzQfumEXQjG5C/SkZ+EMDCcFRZeV1b+NczeHD1ZuEgNAmHovoeAansqqycLxXksznVgKZLxEZA
	3lNTw54ssBFHK+DKHYuhOhkuxp7TSpDqfVV+KamXt5cQvaSuWDbhsWiv+Mlry9RNjmvnp39Zka0
	tzL53fmYWWLFiMAJQKoXp/EfSOCLpmBxBnW6e+FFOdQj6zQ4lesXqJrv7kEMtwVwySGcvqiOHOC
	lO9mKkjRMb8xTdVA2M4SHd8V00NJDthY4=
X-Google-Smtp-Source: AGHT+IHEnj09VtCvhEI1Mnpju384PM/PFXJ6IVisB8INMmaBJgtKDDRSEQKzdcjFHiZGq8ztnAkNxw==
X-Received: by 2002:a05:6000:240d:b0:432:86f2:791b with SMTP id ffacd0b85a97d-43286f27a87mr8136274f8f.63.1767005597667;
        Mon, 29 Dec 2025 02:53:17 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea2278dsm62489855f8f.18.2025.12.29.02.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 02:53:17 -0800 (PST)
Date: Mon, 29 Dec 2025 11:53:15 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <a4fzkz4lznq5hrf3mmrhpt723rb2sl7puo6ziwg32ye6jh7rwk@baexbljj3duu>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5>
 <vsr4khfsp4unk73a75ky7i35nzdjqsbodyeeuxipu3arormfjr@awi2srdwawfu>
 <1264fd2b-e9bd-4a3b-86ad-eb919941f0a4@linux.dev>
 <aVJDuObeV2Y99em-@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qya2ibtxqvkulq4p"
Content-Disposition: inline
In-Reply-To: <aVJDuObeV2Y99em-@hyeyoo>


--qya2ibtxqvkulq4p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
MIME-Version: 1.0

On Mon, Dec 29, 2025 at 06:35:22PM +0900, Harry Yoo <harry.yoo@oracle.com> =
wrote:
> > The memcg-v1 was originally planned to be removed, could we skip
> > supporting v1?
>=20
> You mean not reparenting LRU pages if CONFIG_MEMCG_V1 is set?

More precisely it should be dynamic
	!cgroup_subsys_on_dfl(memory_cgrp_subsys)

> That may work,

But would it make the code actually simpler? (Keeping two versions at
multiple places vs transferring local stats at the right moment.)

Thanks,
Michal

--qya2ibtxqvkulq4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVJdmRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AjcmwEA40zUj0sp6cAAd3bXgrQF
sR0AqL6ydZGZfdd4i1DDccAA/0xU+vWaUPKB0gC3zq4HkdYA+8vTysTe6W9hZxPW
eCII
=A4Sk
-----END PGP SIGNATURE-----

--qya2ibtxqvkulq4p--

