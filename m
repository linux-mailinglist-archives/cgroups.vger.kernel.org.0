Return-Path: <cgroups+bounces-7151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A56CA689AF
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61EC218886A6
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB09253352;
	Wed, 19 Mar 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyNvGu/D"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AB533991
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380400; cv=none; b=h5CYM3pUHrmenpQnyISmb3UQ5UicmJMiY91V3vSClxmA7ELe5YSSHBEbODZ5LGWDOKq8CPigAHX3iNy8389urz7yHY2lGRdavE9FZyvCDwHven+9duC7A9vabPiodjJ0Skh83+bghwliFe8c5XCz07C+trfQymD6T1nMSTXaWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380400; c=relaxed/simple;
	bh=Z692E4Us4bwCPQMfgiKqOm+CDl4LPK/+OBs3OKkVM5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpKppW5lJTbwL6TUX/e1Mu9AAfFCf3FDy/F1dxO+qUWE1Co61DAtEXFXnmsj7ETnVp8xgDDbiWpmL2l0PX+ZxUzIJkBZTaKftSPtYptDqlTPAHRaqw42jufJXtpB9kvTLBXT/Ai3w9HK3nXBFYfC0+oTITCrVb7KMPHnwWsvI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyNvGu/D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf848528aso36092555e9.2
        for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742380393; x=1742985193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHUFNCIIO10GyL2uIfpwlNVW74wFOFO/xZ1QWqgzYRs=;
        b=XyNvGu/DUsb0ALzvJ1GlXEioewz4XGRtj/hx2tgeh4HwsmBNiHVtrQKlp7c/oIhiV7
         MDIX3r/xOvXIUjjmlTJzQrkQG5viSxMLGX2oDkPKoU09Nmk1AXqW4CmpRSg8iMBhGC3E
         wRHALGKRiGiOm4ABLHvPGI6a+O07vjONfZKoe+fA6nbox9ptzCY10etM001XAnakZIpI
         2HtAYbaQMg4jkJ2GYk0E3bYqCPB9fNb4lhv7FrEzvkH1lAPAp0m5uImzeDNB+sReQbkh
         jmC73feY6eqt2FvIP6NZePtii3KCCyhk5kCU4niYy1nneY2XBiy1NG8Wpf3U08Slyy4W
         ObCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380393; x=1742985193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHUFNCIIO10GyL2uIfpwlNVW74wFOFO/xZ1QWqgzYRs=;
        b=tQi+/ztQ8GgAkmGQrlWIzoI4wfhSGHs1OvQ1tZWAGSpej09j7TnR4lIez1L6HBiOby
         bb9dgpRTznd46/2Pnoyy1PQD9FGQou3Jt/MdrtWQvU91OzfsbM+LZCfP8KoCTm8zX+ke
         co3LTVljMZPiruh68UQLAPYd6JYeQ11eDKGwdKJEXcX4fd2VczHleT8x84VuTmqlgYYl
         QGCH5umzP5CKKJfawccHjZPZX8dVoBViJ62cRgO7iB1TEgq082fHyXBadXyov/5sDFCd
         i5fQXkm24QL0nuxdWJQNBonvMCvJGO2vK57tsOc2pT3zrgyu+dKdRc6d02GJ/KAN8njG
         tlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhQie/Hq4mXyom/9wbn8unVSujzkCVfyRH8bF3lkEX2B83uqn71ycDdfd39GTSbvkXlOMclK/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy3hW9UrpF0glizWGNCGcZcjogdqKW5IBBFKPW0k+KONVXE7Gk
	TYmfS27+J1n/cTBe5BHL5pg3Vc2yPi8NyNpfwwj+xuGKi6g/rLAekqBKBT+A4gM=
X-Gm-Gg: ASbGncuphr4dS+3Z7Ebdee1h8t1oL2/v/3eNwunSVx7hAYGAMSDFjQBzDmXvuEcCNYJ
	RHCflN0VZMsA09lClV/1Ag0OVBM6QYVOI3o4op/VYsiv/v8UvyLKUqa2Y1IQnClsE+lCUO4v+yd
	Sss+1zP1mpQm3TS9pQ/Cv/zLKpFvBZYuJt1UHbYyS6KotmxS30ZS/0/A3lharSt8pt80v6WNs4z
	2USmmEn61w+eg4/NRf/9D+97fFbMHW9NNE7aTCzRToLFLuy1WXRAMWBVOobGb7Su21ub5yoWHCK
	LhV6wS/1OhU/jCsF60D+uKGgJ1boSWP4OzTh7GNzb/EOEUk=
X-Google-Smtp-Source: AGHT+IEwlmcO/Nsy2vMvC0TJIU6rQJVpXquecxaeZ4cOXlH7OaHP55G2sGoqGpVHjHr9T/l+vWkvLA==
X-Received: by 2002:a05:600c:4fc2:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43d4378bfbamr12087425e9.8.1742380393287;
        Wed, 19 Mar 2025 03:33:13 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4453227dsm14414315e9.40.2025.03.19.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:33:12 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:33:10 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Hao Jia <jiahao1@lixiang.com>
Cc: Hao Jia <jiahao.kernel@gmail.com>, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, tj@kernel.org, corbet@lwn.net, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
Message-ID: <rxgfvctb5a5plo2o54uegyocmofdcxfxfwwjsn2lrgazdxxbnc@b4xdyfsuplwd>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
 <20250318075833.90615-2-jiahao.kernel@gmail.com>
 <qt73bnzu5k7ac4hnom7jwhsd3qsr7otwidu3ptalm66mbnw2kb@2uunju6q2ltn>
 <f62cb0c2-e2a4-e104-e573-97b179e3fd84@gmail.com>
 <unm54ivbukzxasmab7u5r5uyn7evvmsmfzsd7zytrdfrgbt6r3@vasumbhdlyhm>
 <b8c1a314-13ad-e610-31e4-fa931531aea9@gmail.com>
 <hvdw5o6trz5q533lgvqlyjgaskxfc7thc7oicdomovww4pn6fz@esy4zzuvkhf6>
 <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r2xghzya6xc4nema"
Content-Disposition: inline
In-Reply-To: <3a7a14fb-2eb7-3580-30f8-9a8f1f62aad4@lixiang.com>


--r2xghzya6xc4nema
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] mm: vmscan: Split proactive reclaim statistics from
 direct reclaim statistics
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 05:49:15PM +0800, Hao Jia <jiahao1@lixiang.com> wro=
te:
> 	root
>   	`- a `- b`- c
>=20
> We have a userspace proactive memory reclaim process that writes to=20
> a/memory.reclaim, observes a/memory.stat, then writes to=20
> b/memory.reclaim and observes b/memory.stat. This pattern is the same=20
> for other cgroups as well, so all memory cgroups(a, b, c) have the=20
> **same writer**. So, I need per-cgroup proactive memory reclaim statistic=
s.

Sorry for unclarity, it got lost among the mails. Originally, I thought
about each write(2) but in reality it'd be per each FD. Similar to how
memory.peak allows seeing different values. WDYT?

Michal

--r2xghzya6xc4nema
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9qdYQAKCRAt3Wney77B
SSAOAQDscRz1ZK2hjaZeAzcmaHDL4+BU5iqRrEbfZn7B5FsPTwEA4guBl5SiFtw1
e1egLefaDOYhMuPKh+O7ZQAYqh+S2w0=
=6EjW
-----END PGP SIGNATURE-----

--r2xghzya6xc4nema--

