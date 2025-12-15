Return-Path: <cgroups+bounces-12360-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF9BCBEDCB
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 17:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33CEE3011005
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5030F7EE;
	Mon, 15 Dec 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uq9ds2Jm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAEA30ACF2
	for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 16:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765815536; cv=none; b=lwfYTp8x7b232zhc5sH9apij7pjo/jCwLt9/b0FUdx8p2AEAWmkkVQZphrNOGyc5C/QPpfMJDGO9dJaitzqGt2UWPZ4E2j5CaL/q/iYcgLlIYQpqfytsUqiSx4MAU9SaRWm/VKcVaizmwGwoqBsCbmAqxT7GBnMDKBVFiNsy2vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765815536; c=relaxed/simple;
	bh=a3PggOap/t9l6ReN+INgXfZpwcU2E7Uq+RppSoZ6FD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1bEyQujKfkbUcajlwuwT+xKGBN0XjNIr2N1gkNLRxH1fI0+dD8351lb4+l7R1yk+MPqkUExfjtHV6EzGBzkXqrSmiVPZWbVwFnNM8du8DqxvwJWM+lnGYS3MyDtR4o2Fzvqz/p7NWQxskZYd/mzlH7CY+DPjPj40/dHpc5+lMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uq9ds2Jm; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so837355f8f.3
        for <cgroups@vger.kernel.org>; Mon, 15 Dec 2025 08:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765815533; x=1766420333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQYbuy/AGCx7oClZHTrxvnDLHD02xFmPKDiNkJdAECE=;
        b=Uq9ds2Jm4gKi1CNlN8PtF+s4+1nae/MRQQ4gS9Rn4ehM33aUaY5mmXn0v2lw/YeYVL
         RJAMxNGST2pObuFcNWvUUmtigIYtspk2nkHX5WmKAvoQjClBbVppco3UPcF9uhviP00O
         vLWdPgOLRSiwbB4MJ7H6EgAQJwYwsYVWqwFCAC3ZmEMXbEpixwGFUpU+hW0B2Ag/kO42
         xyBkI5bjddfPAFO2jkQuQXrMdJofI7hBzkSjUHU3HPeIz+p6/ZMJt7kxgu9QaDH7qDjg
         h/xsle25YhSAW9+Uky6yrE53rNQvLtWlPKIXpeHXfcfuXjQW6IaHvEMPuNtiYMg27RHu
         xDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765815533; x=1766420333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQYbuy/AGCx7oClZHTrxvnDLHD02xFmPKDiNkJdAECE=;
        b=uaFeTrZ2gGu5lciTqLtgFHjwBHqat7S4fxfHtb5zfT2WHJEvy434RnGxNaFRsUZdZd
         ztw7tkV4XNmsCCdEeCSK8IvCKfORYoJkh8XMiiwkA2hnr9V7E0aqG+MwUeXHkHHeDIYG
         Wvk2xzfDfTljX2ZfYWcagfx25vCsTUu49h/dRvsAUUX+Dt6nSJpWvGk/psAiaVGz/yQK
         MjzfOsOT8eEnkYuGXfctHdvlUT4INrCh5LJ0tK2aA9R6nh5kMjqwyOjN7VZ95ZF9rNZY
         VSQeHTScNpi4hmE7gobGI16OVCzUETGP79PmLqNUG1t/89YPwIhIeYI3KiwkTQSJSnz+
         yi7g==
X-Forwarded-Encrypted: i=1; AJvYcCXNMHTGzI6ViVeiRR7U3qOpkIRKmE7ZQ6qk6clUxND7SRcZ4rlH9/C1udGbYoHuuMBZ6HaAeBxF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55JKffzJk99G3ajnbsVyS8ci15oTAmq9TzDCLgV4ADnveIdSI
	gX/mG/aKET1YJF/w7GWvnDtnW88YrL4t6QIIQRrv457tB9LcKYF/Yi3DUIQNmmaeUMU=
X-Gm-Gg: AY/fxX6IHOoB+PYjQVfgo0UWMIcX8Lb6e1F5g7FfsmwDX3SPAdQH8twevVs00gSDgHu
	KnVoRDQH/m9d3P6extUznyShI/WAsnn/1JifCyoxrPPH0S9TA96n7Dn0KEYkCgmfxBuijD0p56O
	KoDhka2zU8+VLPzw+rBATIIqu0kuRxuoSC+yfjc50QV9lrvKqvl2CdAc5Q2pMLL1ADbWkEsW7la
	95sybc4otlVL0eoYqYX39SxQSNs2mQ3jaN1JKZlL29kGZ7hs+c1SqckoEnYQU82cwwVorECQZDa
	3SaAtmNCwEneMdB/4YyvgPQJxNWdyRQDWxxZ2RGGu6H2nhqYxMZ07w3Wo+oyEeSw21am+HWqo6o
	NJ6pWqVh6Z3wqXa/db3EDZfBeLiO7Q6jaLTLUI7bMkRrWzsRgW32ZwfWaGHQd4ctj2dJYZBUXtF
	zeywWvOdHM1+/PEjGap9wE6cq4W+9yk70=
X-Google-Smtp-Source: AGHT+IHz3DRccVTH0qEnEXmkQ3WMt4897kh6Ax9dU31ug0/MvMOQlOP1t29k+dTkjNzkUa4aYrlpgQ==
X-Received: by 2002:a05:6000:310f:b0:430:f704:4ef with SMTP id ffacd0b85a97d-430f70407bbmr5833954f8f.61.1765815532434;
        Mon, 15 Dec 2025 08:18:52 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430fdcc6bbdsm6333447f8f.14.2025.12.15.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 08:18:51 -0800 (PST)
Date: Mon, 15 Dec 2025 17:18:49 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, zhengqi.arch@bytedance.com, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 0/5] mm/mglru: remove memcg lru
Message-ID: <oa62a226nagmrqbc23kys3yw3ouxkn5spcizyqqevsuhkurbsv@tvvwqlgu5yum>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46t23aecoxgyn33q"
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-1-chenridong@huaweicloud.com>


--46t23aecoxgyn33q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next 0/5] mm/mglru: remove memcg lru
MIME-Version: 1.0

Hi.

On Tue, Dec 09, 2025 at 01:25:52AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The memcg LRU was introduced to improve scalability in global reclaim,
> but its implementation has grown complex and can cause performance
> regressions when creating many memory cgroups [1].
>=20
> This series implements mem_cgroup_iter with a reclaim cookie in
> shrink_many() for global reclaim, following the pattern already used in
> shrink_node_memcgs(), an approach suggested by Johannes [1]. The new
> design maintains good fairness across cgroups by preserving iteration
> state between reclaim passes.
>=20
> Testing was performed using the original stress test from Yu Zhao [2] on a
> 1 TB, 4-node NUMA system. The results show:

(I think the cover letter somehow lost the targets of [1],[2]. I assume
I could retrieve those from patch 1/5.)


>=20
>     pgsteal:
>                                         memcg LRU    memcg iter
>     stddev(pgsteal) / mean(pgsteal)     106.03%       93.20%
>     sum(pgsteal) / sum(requested)        98.10%       99.28%
>    =20
>     workingset_refault_anon:
>                                         memcg LRU    memcg iter
>     stddev(refault) / mean(refault)     193.97%      134.67%
>     sum(refault)                       1,963,229    2,027,567
>=20
> The new implementation shows clear fairness improvements, reducing the
> standard deviation relative to the mean by 12.8 percentage points for
> pgsteal and bringing the pgsteal ratio closer to 100%. Refault counts
> increased by 3.2% (from 1,963,229 to 2,027,567).

Just as a quick clarification -- this isn't supposed to affect regular
(CONFIG_LRU_GEN_ENABLED=3Dn) reclaim, correct?

Thanks,
Michal

--46t23aecoxgyn33q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUA05xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AipLAEAnlYbPrFblvbBsF7840Nm
UUv9SDFSYzdEcMfrtpIpBBUA/0OUjcdXVkH5G6MDTafhw6RikY5Fc6vWy/IdPFm+
6b0B
=4hsa
-----END PGP SIGNATURE-----

--46t23aecoxgyn33q--

