Return-Path: <cgroups+bounces-8657-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F95AEE5FE
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 19:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19457AB846
	for <lists+cgroups@lfdr.de>; Mon, 30 Jun 2025 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0F2E5408;
	Mon, 30 Jun 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F0MsI79S"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF72E4255
	for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751305193; cv=none; b=esYiHi6Q/8C+IhIR4YzZdz5ypB67hYWbQdyTNQ1yl0VpAsjUqVw92SZN5zIQMg35ysEXcA63Bf7ctzU2lkMl8Rkpxea/UwOH7SVKJeBLaYPsUgxKwzj2fzpfjtUwgC/EWgYrNqM7zMLt16QAAjNSE2Sk02oNEMbtwEYEP0CtK/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751305193; c=relaxed/simple;
	bh=2Y9uMTwID9j6ls06ernf7fmJNC/MA8FlRHuc49tIeXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em2fZ6jyw2yh91qZTHa1J1ETAMWsNNK8LtUFfRi5s39dlxloFv0Mw43zuUNkALHRUQC2Dur0pgcbOUpduyVWzcZMbs29RA9CUOoVZEP7C+AUzHOJc1CBkMxhWrZMk2TJMTBFcLdvVM8dtxxdMCEJayLEGTCKydeCyqLReFcY86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F0MsI79S; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453066fad06so32101945e9.2
        for <cgroups@vger.kernel.org>; Mon, 30 Jun 2025 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751305189; x=1751909989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Y9uMTwID9j6ls06ernf7fmJNC/MA8FlRHuc49tIeXI=;
        b=F0MsI79Svly9l7hdwSJ1OTrFDSUBy+wqbufyOlCtDhDGkACxNPNI7Bm6buxPGyHRdk
         Ea0OMhNtnWdI7ojFcy2oPlKu0B/5iGWiDHHc/LvGeofggStKan7SNowxK/gdjnvFWJA0
         vY8WgDKRxqy3DespFezjas+aiBDj8rvUwQIIOE7mFFzQzfsMplgmDJcyETUerymqHogV
         peWpw0w49K2XAdRDk+rKU2nqwxq3KiJmXa50Qs1w6ESZSamwju0YnjWJLv3tC96flZLy
         0YR9PLgiF7l40kaay6Ybl1mu0FWEhwgX0LM85Hhm7+eX99hWqW81wnBTQ1jG8tBs1aw/
         NrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751305189; x=1751909989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y9uMTwID9j6ls06ernf7fmJNC/MA8FlRHuc49tIeXI=;
        b=WCqu+9q3/J9oLA339MHI/Y1kmvTBl/yyjPMHiQ80qC8Bzwapf3W3Evyq2+Cj7Zv59k
         hg6QeWo5Nk8Gs6d91FVar31/SRTA5RwjDrI0zTr6io5HVcRRFAD51oDQbD13NJeuNgWX
         b6lUVItU9xhzqYmelnDnMo7Lg0O+CfGXER+QFU5IEK+MfEDe2jS6DM7XZur3v8AMm5Kb
         p3LE8Pm5RZaTQzXT/HZJ+wW9vdE6r46NR+rtGD+woRwvWml3om9/78LU5Kg36AKvhEOs
         MqlMCpvsXx5TidE52tgji7JtPjIoU6vv++luOFEp1dpNx7LmZAy7KCMX0LdIcw2KimPW
         Uw1A==
X-Forwarded-Encrypted: i=1; AJvYcCXXedJHgy5K8Sz3hTq29s305Hma/duAWjsQJtMbaYDJ2Za3F7VluFgOS3XAJoPPdEQQVV7X7zmx@vger.kernel.org
X-Gm-Message-State: AOJu0YzEQRZJ+zOjbcobvPJ5Sj5268aXslswInwoph5dw4TtVTC11PV6
	lVBKbiP2qlehnxzBKPbVjnvzBTb5ubn2WN5jqY4xOQIt9VwZhx6fX5/fBfE2e16ZYYQ=
X-Gm-Gg: ASbGncuz0LqnKVg6DWhqBi7k9X6PUb8KE07nR7LqcKh3HyMLv/sdJ3CSxNHepVzcBjY
	o9upPbyA4t5jOpPcc9ttT5GHFdDTEwf1uTPjRuQQum2sl4Ta0uyIHZlvttwyBffizeLz8z6YwUl
	Re8NPlEbN3kfFDjSIqcAid9Ob2tFQkz2KH/0h4Nphd7h9ft17n+NwKMF3OTt4mczm8InFJfMmEx
	jRKT8ijIc61Oq0N0pE78xShfTzK6Yl3GSV4DGbaOMJuc5oaMzgjLrYMbq90fbxb7cbSecPOWICL
	Nj8vjBnFgdncojq2Jg8M4ZGa6S1zTCBZt3lQTt0Huzc5I5N6YNsLz9O+8zIDQkF6
X-Google-Smtp-Source: AGHT+IHJy4btGv0fVS1tLOScDjwEh+rbzrQMUABP+ayXSxOTT48qfvdOfpAA/8f2BAYnhuti0aw65A==
X-Received: by 2002:a05:600c:c4ac:b0:442:d9fc:7de with SMTP id 5b1f17b1804b1-4538ee85615mr124990995e9.22.1751305189383;
        Mon, 30 Jun 2025 10:39:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453923a22fbsm100856365e9.34.2025.06.30.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:39:48 -0700 (PDT)
Date: Mon, 30 Jun 2025 19:39:47 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
 <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpnjag4xaqb26ddt"
Content-Disposition: inline
In-Reply-To: <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>


--fpnjag4xaqb26ddt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
MIME-Version: 1.0

On Wed, Jun 18, 2025 at 09:07:51PM +0900, YoungJun Park <youngjun.park@lge.=
com> wrote:
> This is because cgroups can still restrict swap device usage and control=
=20
> device order without requiring explicit priorities for all devices.
> In this view, the cgroup interface serves more as a limit or preference=
=20
> mechanism across the full set of available swap devices, rather than
> requiring full enumeration and configuration.

I was wondering whether your use cases would be catered by having
memory.swap.max limit per device (essentially disable swap to undesired
device(s) for given group). The disadvantage is that memory.swap.max is
already existing as scalar. Alternatively, remapping priorities to
memory.swap.weight -- with sibling vs sibling competition and children
treated with weight of parent when approached from the top. I find this
weight semantics little weird as it'd clash with other .weight which are
dual to this (cgroups compete over one device vs cgroup is choosing
between multiple devices).

Please try to take the existing distribution models into account not to
make something overly unidiomatic,
Michal

--fpnjag4xaqb26ddt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGLL4AAKCRB+PQLnlNv4
CI2lAP9cNd8Fw/efDHTo0CbYimuJjQR8y9PUoLFpqTT1zfv2CQEAmh2uxUSEceTY
Y2x0oL70yfEQ4Y16HdkMDSN3MpuANAA=
=Xz7b
-----END PGP SIGNATURE-----

--fpnjag4xaqb26ddt--

