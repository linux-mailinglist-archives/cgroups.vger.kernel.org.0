Return-Path: <cgroups+bounces-10501-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B3CBACC57
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECD57A8822
	for <lists+cgroups@lfdr.de>; Tue, 30 Sep 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF752F83B8;
	Tue, 30 Sep 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AKxD38i0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820F2343C0
	for <cgroups@vger.kernel.org>; Tue, 30 Sep 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233944; cv=none; b=GeVTlky4oxMtA5+DT3s866O0ZEIe/cAgDCNpPZ5X4pBVIm+B/1v8kSaVTFMXDpm6i8R8pwgW36WbrnAtqlFvVcbCkD1Sf6hFVLYT5RLDlEej2MXYeK2QZRAcN6kbHOaek5Y6KOG7OS11q4pp5MJout/X5GHYeLWD5fhBh4EtJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233944; c=relaxed/simple;
	bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+bKytBvOdlLu/B5G+VFJ0qbrRoImJJ/RooGAmiSfO6B2HlbY4OVvfX4eukPG1FUYc3EfWgCUh2CSSrKcykpEjOsrZJjLt76KlVsoEs+aQirRtlTNBYo6QatEzkwQupfbq/N4SEsfotGeHnVLTmKPiBwUvBSEwb2S7hQMaV9ELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AKxD38i0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2e363118so56254165e9.0
        for <cgroups@vger.kernel.org>; Tue, 30 Sep 2025 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759233940; x=1759838740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
        b=AKxD38i0Q2/tGPsme7jZ1+EbLReWbmxy++hjSikKeQIuaYTCfSyp/7agdBuna7lm5C
         M1JnA+a5m2Iow9RuQZVbDot/h/3IXbX7flg8/WdP2fBCZgFTmYe6A+VxJSdIv7+NN9sp
         DaVnNxBbTjpVPGBHwzSr6i3lF4EHD/NX9Nn9x8NOUg1KJsOae+sHTUj8kfr316s7RoQZ
         aTBCUcAm4NUY1VcZeNkScz4AA4j7DzsMUxK2U690rm12bfPmuphSnpejNJc6qmHLsqFM
         t81qPlTwPIERT+3HJivfqeQi4YhzLBhrUr9pk3IY0uCxcIcvVc9brkuvz7Vb5zIorWbt
         PDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233940; x=1759838740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLCedYn1+Pe/8KNo6L8zO2RVgMSCUsKDpJC0WGve6/I=;
        b=c5ElvZixxsVbDCbZvDwzbJfmOeATmJTq9eWdNCfmn/tP75k7lWIYh4PYp8F8tX+xNU
         ALwBJCOEf106ObdBc0oBR5tOo4Jp8/7HWbrPgjbXR096JEghT1T5Mjt+ErK1oltNc4ub
         C9zmLth1/McvUTvH2NJ0u5U3JaYA/WfLbG+5Fq0Obtwy92WAKdGTcINP4sVaC/XhsDHb
         ub8kzYVhz4a22M+/bLKdx4TenJ96F2cyAqLjy5xtqo4GR3SEo3ayIurvm+gdPsQ4dY+L
         xNwm2xoePe+FSSNyEk6zXM55VR/bpsDVU0/3fCZb2o+Z2c92YFc8bFOD+KU0B+jDuc6m
         gjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcdl7Du0Cv4a5FM+Lp0gUGY9ySnA3LAIugc1DP58S+Dz/NfJa4BqM9Raty3HU8vEhKbi57lpGB@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVu5WfwApw8SpJYBSuEpEGp38vUi4fTQTm4koiHNTHh9SDS73
	J1t7aAxfk7yt+6eaM4ILQFGHun01iLHHYxtsGONbmPN9aXv5jJ8O2mlG/aCY9Zdd3Zk=
X-Gm-Gg: ASbGnctnJgA92eyZw64VN12UtHeMD/LMxe/FT7uTyVyiEJGAQygKve8EGSA+DlGFj8Z
	WPj2tqO87oKeuIsHEV8WWQGWiulvi5SD5LVOlKbkbkbopZH92Iaa7TGlat7Oyv1YSEkuvr7/6q+
	Ex6ZrY9RJato9p9PdUnhstTqG2mkcavbwOtc1TIosHrypEMMgpGdER9AC4ysfTWCjIpFYYJNo0G
	iTKttvFB+GgLy4obSAzCla0IxAkKAliolJCPZVWOO6Kxu2FnuWOc7ehHaqlHLZXI8JShCKPVbmd
	vHUv6wQJxmZozp0O+NUp/zleQ0AhOAEcOlVzx8ekFotVn8eCTDKqTLLErw/aEYlgLK9ntQByfNf
	RZetfolpo1qvn8YagSXWSVYKZs7+uCQhF8/1FoPU6Q5Bblj1mbpPlC3qkGkkECLPtKvQ=
X-Google-Smtp-Source: AGHT+IFZ76r97SBznLgxVm8yCuTausgRSw7E3S71YyAviZVyfhtqjrZ9q86ZcZJDn4o7nlRc0TwdsA==
X-Received: by 2002:a05:600c:138b:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46e329a0e52mr163822455e9.2.1759233940334;
        Tue, 30 Sep 2025 05:05:40 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4c0321sm11443795e9.8.2025.09.30.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:05:39 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:05:38 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: llong@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
Message-ID: <wpdddawlyxc27fkkkyfwfulq7zjqkxbqqe2upu4irqkcbzptft@jowwnu3yvgvg>
References: <20250930093552.2842885-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fcitis6hrvtt6osy"
Content-Disposition: inline
In-Reply-To: <20250930093552.2842885-1-caixinchen1@huawei.com>


--fcitis6hrvtt6osy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH -next RFC 0/2] cpuset: Add cpuset.mems.spread_page to
 cgroup v2
MIME-Version: 1.0

Hello Xinchen.

On Tue, Sep 30, 2025 at 09:35:50AM +0000, Cai Xinchen <caixinchen1@huawei.com> wrote:
> I discovered that the DataNode process had requested a large amount
> of page cache. most of the page cache was concentrated in one NUMA node,
> ultimately leading to the exhaustion of memory in that NUMA node.
[...]
> This issue can be resolved by migrating the DataNode into
> a cpuset, dropping the cache, and setting cpuset.memory_spread_page to
> allow it to evenly request memory.

Would it work in your case instead to apply memory.max or apply
MPOL_INTERLEAVE to DataNode process?

In anyway, please see commit 012c419f8d248 ("cgroup/cpuset-v1: Add
deprecation messages to memory_spread_page and memory_spread_slab")
since your patchset would need to touch that place(s) too.

Thanks,
Michal

--fcitis6hrvtt6osy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaNvHkBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhT3AD+KHlYLmIxNmdExRmJBIHo
TrWz6vCQ6NdEpP571RS+KR8BAKhTUtg/9ODujOOm6TZW+z9qjjc7ovQYhj0rhduE
upQC
=rm/V
-----END PGP SIGNATURE-----

--fcitis6hrvtt6osy--

