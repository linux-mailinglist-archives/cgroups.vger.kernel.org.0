Return-Path: <cgroups+bounces-8965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C01B17231
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31113A7BD6
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE892D0C82;
	Thu, 31 Jul 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8AovRPG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEDD16419
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969143; cv=none; b=S5cUvoiaDptxuO3DhQCYCxFNi+mW32PL6Jc4nQf1ajZKQz8WL7wYCT1MRE2aV0C2+m7ioHVTqBtyil9OtNAddb4KQf/yZ2IrCiPlgSqbAZs0yk1Yg7ff/nXMwMb5J6Nd8TlDuGeLLG74VdSCSNev2uYuC2w4tuKJUKjQEpbPkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969143; c=relaxed/simple;
	bh=kOpGIhGHdpLiDUIPN5tfSWZvVyiUegYsJVHK2hDz4Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaXsmZ8SUNdl3OEk5qESzk+jDq4WQgK/ImiQEQiBxlDVU3v1q4KRl6MlJCI9DEa8jPghi5gXdMwLs69WEwTj7XIIdSIny2QHXYPX03JC/5jkRI7vRTcVYOZgTWzUJjYoR9yVMBlUxXFZuQJwKgyFahalcq++euHtrVHJ7LV6G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8AovRPG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-456108bf94bso5802805e9.0
        for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753969140; x=1754573940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=S8AovRPG45f6NhxVcuX//ZvxSrIcsANJtq5pFbo0l/nMYuky+MCcCw2h5nDDixhMc1
         tqkqlofVIeel11Cx0GCsU9jmWlLbctw8FmXC+Q8dLjYJTm/kpVCQ+uiLZP79SuqVk59g
         nXbqxqFiY9YkfX4Xl++Xm573IE5DoU3QqrGPyguGc6sFJh/MQ7JtswMXIvruqO8Kg8qH
         9+yPQJNSzyOSJxBpZTHU1vmMlD1hpFXNvagu48inn8ndWEMAjVC1xpVuKJYNQFrBjb3b
         yHHLbEI/xWt3rHTvqBVhpBnhsSz+HgluW8dBya1S0BGVx1+uzJ9rstpw0Md0nKzXgIcA
         lgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969140; x=1754573940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnez6DValapR3ZUUqRysmzvL+YRs62blvNyrOJaANrI=;
        b=aaC8k/7A+jKvaGQLINhhzTJt+evBnZuX34JL9GHbyB68NVUXOsx1+unKm2jdq4Cj3b
         o75VK3NX2tuyx75H8aEfuvEFpFGZ3lU39MoWVrKMLp6ZD8Pw4uUV8PDwjgAZjcjBQq14
         e10LxKLIjz89cbX6UzQSurzU+Kt4XTEtwIJ1XH9tpVrL2pvXQhPJ2KpKRTdpnHe1bz13
         fWkJQC6RIvCGvffsTVHZ9O7t0T4n7u4MFww/uiFa0e97VJH0JduSAi6WzSf0Wl2jl8bS
         wQA/XxoXH+NhFnX0XDqqMOhX6zObCg/IepoLf9pwTyvTwFJuJ7T6aw89GJOBtm9KBnHO
         dDSg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RMI+u3Y/ysrTOFnHFn1w3RtuTJg9FJdKPKpDQdRlmgpePFrM0ur+7TQJHfXVnYIavfpGOhit@vger.kernel.org
X-Gm-Message-State: AOJu0Ywit2WwclMvXQzTMFRuAjtTw03TBSTepCjOPAC+UM/yespGV/rG
	oEPK48qWmeC6e8f5CaXk7UK1n7l0Iw5G9qn/l5NvTSa83viuH42rWZzJsGqvWCinMfU=
X-Gm-Gg: ASbGncv6ODg/yfbL5KgjarQZeq+VwpW6uqbXl1w+xR9hZIJm1LnN7fgmSWX2nERnauV
	KopaZykWXgrOHLr7zCR9MMqZCHI9FFHT46f2woHAVQSIlbu322w31pQR/fvSohkRk9PLhfEzXic
	qT1oyR+bqpQhz7KB1mCA8cwD7/U2iQ5fcIbP+LIKt3w83XVhCR4qAC7uFfVG/mBZC1DGv9/8mg8
	hK23u5/NlcdrkGEm9ZKg4K0Otw4oNNX1RSJEcvJZuBXzyMfEL80cUujDBDK519QHj45+X7f0RTr
	yDM/9TFvnvD4/LQRUwHUHkhnSCOpMDFHpaOPIyinx8YG4FO6Gppy68rc658ppsv3dNZ+8/C0Ok2
	Z+L3uyG4vgyrPV3owfH1urAkzYNXTodeTrJkRs+J5Hw==
X-Google-Smtp-Source: AGHT+IFFm9zky0SxbktFrrzQ+NTv6G8i6eERwaMpUiFW2QYSxbmEiN7oSr8vkltvo3nUOZWrxX7dIw==
X-Received: by 2002:a05:600c:8114:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45892b9e4bcmr69774445e9.13.1753969140187;
        Thu, 31 Jul 2025 06:39:00 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4534b3sm2409107f8f.47.2025.07.31.06.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 06:38:59 -0700 (PDT)
Date: Thu, 31 Jul 2025 15:38:57 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2gxvsfqre7jriys5"
Content-Disposition: inline
In-Reply-To: <20250721203624.3807041-14-kuniyu@google.com>


--2gxvsfqre7jriys5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> buffers and charge memory to per-protocol global counters pointed to by
> sk->sk_proto->memory_allocated.
>=20
> When running under a non-root cgroup, this memory is also charged to the
> memcg as sock in memory.stat.
>=20
> Even when memory usage is controlled by memcg, sockets using such protoco=
ls
> are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).

IIUC the envisioned use case is that some cgroups feed from global
resource and some from their own limit.
It means the admin knows both:
  a) how to configure individual cgroup,
  b) how to configure global limit (for the rest).
So why cannot they stick to a single model only?

> This makes it difficult to accurately estimate and configure appropriate
> global limits, especially in multi-tenant environments.
>=20
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
>=20
> In reality, this assumption does not always hold, and a single workload
> that opts out of memcg can consume memory up to the global limit,
> becoming a noisy neighbour.

That doesn't like a good idea to remove limits from possibly noisy
units.

> Let's decouple memcg from the global per-protocol memory accounting.
>=20
> This simplifies memcg configuration while keeping the global limits
> within a reasonable range.

I think this is a configuration issue only, i.e. instead of preserving
the global limit because of _some_ memcgs, the configuration management
could have a default memcg limit that is substituted to those memcgs so
that there's no risk of runaways even in absence of global limit.

Regards,
Michal

--2gxvsfqre7jriys5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaItx7wAKCRB+PQLnlNv4
COjkAP0UcZBWkhc+vB0FfA1p+pH/BzzZDKA27tR3sA4T4P3PBQEAyknqdHl6GIJ5
yIxBX8DBx92ijoCOGSF1vaocgD203AQ=
=iTKX
-----END PGP SIGNATURE-----

--2gxvsfqre7jriys5--

