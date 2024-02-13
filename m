Return-Path: <cgroups+bounces-1510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0CA853505
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 16:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E38F1C2636A
	for <lists+cgroups@lfdr.de>; Tue, 13 Feb 2024 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF0B5EE77;
	Tue, 13 Feb 2024 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vmj1mmLQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2B5F564
	for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839133; cv=none; b=lHACK+dvlmUPmusgq5oY7cderss5CsjVbeav8Jx7ZUr2J6l1A28ltamyE11c5LxYCh06lf90JI9G9KwFXY5BrQaB4EWRU9yN8zbZVBZtwpknP3RAtPwRID/qrJL8Iie40Cdeyeobk480/9x1rWGHDTEvyuXkXiarZbIXsqyEq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839133; c=relaxed/simple;
	bh=Mb7cfkVoTPe9SpFqQPiRQCgZRgp43WdceLq+nhIl53M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUZZr80vE5iFWrsFtCsSwwlmeNDQI4G2t7x63PghucZfUOGRgnkgA3PBTea9tD+77mMteMInGmjYjPRHqp06M9fWoQi8csX138deMePiKA2OmSl1U510dLXOrOm3/GTozAWE4o+5OLuROlpm0eQrydQMEGt1ipOS+rNTrNYFsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vmj1mmLQ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7872614af89so8779685a.0
        for <cgroups@vger.kernel.org>; Tue, 13 Feb 2024 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707839131; x=1708443931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r+5lFm1GOYo46btsIaJvA6S/B+CQsp17IG3lccG/v6g=;
        b=Vmj1mmLQ4yhugjb/lPfx3+kxHd1E/h0Kv5YjC6n1verDh8bforL8WJmTrmhqdYgyPX
         56y9RZo1Mc5U/mF8FPCurWhd+rExv7UZueNkedhf/F3UMF4+TPDSL5z8wNhEeajGsva1
         RCpTP8BbUJksyQEqy8waWFK14wWRVqePBgqfNsbDvyEJP5lN8zOpVxyRtyXGGxCqS9c+
         eqSxQH/KlzMgGlgL+X73aBsTzO3bzsCM6zp8Bgti1AKInfQCsdy01WaodSCDPOx/76N3
         k9pq74Hhw6oeQhYWQr/K8cMbwAzbnEL8K3HilA2scUgyGNxbQVBZCq4/4ORbpCYcCO5L
         CfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839131; x=1708443931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+5lFm1GOYo46btsIaJvA6S/B+CQsp17IG3lccG/v6g=;
        b=lOFvGEORy02ZbRcvqJ2gMrEzKMq2IlCRdlNNthdi+w+JOe8BH963zHuKS+f9Hp4xmw
         mARkyDSAVfdXikm3IJWQSfMocgq6IvUDE9rWlCmL9y39M71H79jWCSZtHHIHTXgEzat3
         Q0ooQbEqtEym0nnWM/bz03fE8X+0LiwRaEQt91ZxPP/C7qsVKBt68KlE5aAXDAB0ooUV
         z6gDGOVEsGPQRook5esM6ADAR8iGYE1Ksam8o/jlLGKXqjAiuqgpZoSflIORTFjyowmk
         7vA9xuQKcZOBp602a4lYHLuHZWlQvMFCHqaax0AYdIOSiPK2u3reoD9TDE6VEUShO0lH
         hD4w==
X-Gm-Message-State: AOJu0YwJtNKVQUjig6qlTyioBQsZavrLB49cgbju/1I1K7tXrgsUG9Xf
	XF8vdQLd8ri85hHnBRHQl9tN1qk3+KxmsE2RlaBexjzJe+3KH+CQ76Dcs5L6tNNbB5T3SSiWxw7
	cPP06oKtJAjHvX+LTAYlaF4BriiTlTN0Eu7lLlw==
X-Google-Smtp-Source: AGHT+IFqChznTFjr/EeidSN571ZA0nQfVJvF+Fp0E+Y2flaP6eNCXc4z1s3ADkdtr1CrUfrPgpTF+9pex3Z052b1w5U=
X-Received: by 2002:a05:620a:618b:b0:787:1db5:f0de with SMTP id
 or11-20020a05620a618b00b007871db5f0demr2991955qkn.26.1707839131046; Tue, 13
 Feb 2024 07:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com>
 <20231226200205.562565-11-pasha.tatashin@soleen.com> <20240213131210.GA28926@willie-the-truck>
In-Reply-To: <20240213131210.GA28926@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 13 Feb 2024 10:44:53 -0500
Message-ID: <CA+CK2bB4Z+z8tocO79AdsAy+gmN_4aVHgFUsm_gYLUJ2zV1A6A@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] iommu: account IOMMU allocated memory
To: Will Deacon <will@kernel.org>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jernej.skrabec@gmail.com, jonathanh@nvidia.com, 
	joro@8bytes.org, krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, m.szyprowski@samsung.com, paulmck@kernel.org, 
	rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org, 
	suravee.suthikulpanit@amd.com, sven@svenpeter.dev, thierry.reding@gmail.com, 
	tj@kernel.org, tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, 
	yu-cheng.yu@intel.com, rientjes@google.com
Content-Type: text/plain; charset="UTF-8"

> >  SecPageTables
> > -              Memory consumed by secondary page tables, this currently
> > -              currently includes KVM mmu allocations on x86 and arm64.
> > +              Memory consumed by secondary page tables, this currently includes
> > +              KVM mmu and IOMMU allocations on x86 and arm64.

Hi Will,

> While I can see the value in this for IOMMU mappings managed by VFIO,
> doesn't this end up conflating that with the normal case of DMA domains?
> For systems that e.g. rely on an IOMMU for functional host DMA, it seems
> wrong to subject that to accounting constraints.

The accounting constraints are only applicable when GFP_KERNEL_ACCOUNT
is passed to the iommu mapping functions. We do that from the vfio,
iommufd, and vhost. Without this flag, the memory useage is reported
in /proc/meminfo as part of  SecPageTables field, but not constrained
in cgroup.

Pasha

