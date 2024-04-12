Return-Path: <cgroups+bounces-2446-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B898A3475
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0846AB21BAE
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0B14B08C;
	Fri, 12 Apr 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="TjDnn+YL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576814BFB0
	for <cgroups@vger.kernel.org>; Fri, 12 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941650; cv=none; b=rDWzzFIUmO5z03tEScUTuZmIKskSze3GBzIMwm6w/XTUECRfb8tySMpF4RNP89hmR6RK+q5cu6V3Q9xQcv+z8aryaDxwubRGABstYhi5aTjtqlZEq8pZBbbOlTQrvClbv/OvW0azm8hx8qv+gHEyz+Hp/1Aatu1eWEFsI525S+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941650; c=relaxed/simple;
	bh=5JFuYVePpmhoWdZk8WbeOoqlnSWSkoUYiXSyfRvyGWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii7ELmMO6H5RwV8ZQYW66t8iJM0933uSE7mv1OQRG0gilmOzHuiFq3gljQalcCPSHmYbNR1YpLj1Fu8r6Pgz9RZIjF4ru0CJv5zq5WMugmb5hyrwPcsDNcN2AsCp/OVg8+0eYXGe9hQwHAMrYNMTQmv5mzahZ1lf77CM8VJ3dr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=TjDnn+YL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43446959b33so4133601cf.3
        for <cgroups@vger.kernel.org>; Fri, 12 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1712941648; x=1713546448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=TjDnn+YLc4Pkh/akCRL4/SqjYG7P8QtAKysCpTbW8BKrCh58n6xjndCzTQrFbHWqZe
         OVzj89ZGTc3+N2dTGLdSzwWPsZXQeznKMurGiBv4i/fgFNuMGFqSDVbmMObKeH7RRebc
         NrjYo16o6FCAlwz2HOgVJoJKnRZQm3OZ5CqtE2uHNqEG64NJEzIi3SL+c2iW77RoUIwO
         eKBkIUEv4B2BgQjStijlqQWZtcpbwpGDjMQeGwtQAO23uAcSsqnP6nYP0rPJbOuNkTvd
         EIUwBn4o6Pz5hN/8RGiAUOtkcgfE/hLtdet7qZ/Vy5309XMhHtt2bnWVQ54xb9bQvrAU
         PnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941648; x=1713546448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ICZfIsGcQEVbd3Zt1qoYBnvko2GDh9Nz2dJVHbfGpSA=;
        b=XfJ/Cukr3XgjnQ6s8ilxswJ+7MjjqL4iTLr1wZNdEjbK7ew6JG/LaQEpl/hI0ubFwz
         4bTbULSb4tvitsDw35fh4Tc5c6ucViWyEpPsjYweVIe/WyOd+mDo/0WvA8F7f+JJZe2p
         bJCvW7mbmS5o26lzbG00FTPEcLlnx1RiYRkcJcKmgErNYh07pfO4tzL3U5TwhfIDqL2x
         myBSsvJjKR4ndmjHQy4218rqXc0KrangHx2teMS0FOiLBLl8RgNyGKLlD7f072s4KYWN
         2e/ocwGRht9tUWgQ2BQUfMv1TYSFlxhB/zM4fbZht/BPzLekN0w8t6E+yhtlNLDUsA4Z
         bVQA==
X-Forwarded-Encrypted: i=1; AJvYcCXgZoueiupfA4Y6tPtyPmCcaGBSii8WlsGQP4eG5u8+kG0JDr6fO3qfhTXMkflnQkObW/BqnR5mm2Mmw1GYgdrjl2GPYWc10w==
X-Gm-Message-State: AOJu0Yw9LykcgwQ1qTeoTAW0cPNUsVN7G0zFQXflxB63PS0o9FvtW+EW
	idtR5QY9v/yX2LjTusqZz4l5guzwkfAGhJajfVpP4oPVPgqnxNcgAXRuqD2hh/9yZICfBwaKT+F
	rsw9wsYniG48solfQiOfTse/tVwDNcarAQEggWQ==
X-Google-Smtp-Source: AGHT+IEXzcV5Ah/di4pWjeRuzI8bp8L5qdlySBiHU1tn4/tN30fitecIDCoiEvXNx6whVxsKgO+qRvqVW4OxECf95F8=
X-Received: by 2002:a05:622a:606:b0:434:89af:bd3b with SMTP id
 z6-20020a05622a060600b0043489afbd3bmr3794375qta.40.1712941648259; Fri, 12 Apr
 2024 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222173942.1481394-1-pasha.tatashin@soleen.com> <ZhkIhtTCWg6bgl1o@8bytes.org>
In-Reply-To: <ZhkIhtTCWg6bgl1o@8bytes.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 12 Apr 2024 13:06:52 -0400
Message-ID: <CA+CK2bCjXGTP7ie=rFtXrmRaWxn_6VmfZb5BXR13z9a3scfETg@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] IOMMU memory observability
To: Joerg Roedel <joro@8bytes.org>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	bagasdotme@gmail.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> Some problems with this:
>
>   1. I get DKIM failures when downloading this patch-set with b4, can
>      you please send them via a mailserver with working DKIM?

I was in the process of migrating from google domains to a different
registrar, but I think now the issue is resolved. I will verify it.

>   2. They don't apply to v6.9-rc3. Please rebase to that version and
>      are-send.

I will.

Thanks,
Pasha

