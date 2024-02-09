Return-Path: <cgroups+bounces-1413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437AB84FC82
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E221C261DC
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56AD8288B;
	Fri,  9 Feb 2024 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="QjH4Tz9d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E664A80C18
	for <cgroups@vger.kernel.org>; Fri,  9 Feb 2024 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505277; cv=none; b=ALYO9Nid8Ivg+yynlbK4P7ZIyAarawCawGEbBKfqTxDCUihkRf0UO5GASCY/EwVfQH5I46B8/6sgiP1Ci9ptE5pkoRx8CM4yjXntnPAjp60/oRKro+OOfStJKDABUTwrzlfbpoWYCzLWJP9nDfl9Sz7ENvir44mrRu725RaKpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505277; c=relaxed/simple;
	bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdivthW3pugWdJOlJ4TWDOkFDn/vYR5evsPJf8Xk+Rsu9Bf1Zp/jnxGMXZcxu89rN4zwsgP4epuskj9aJw6fEVsoYdJpYUt9c+VORUMexEDIljWCggOuV761+EsRMioDn3bgUq/a2T3aN0JmgoxsMa2QwIjOB4LkTY+uAXnlBL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=QjH4Tz9d reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e12d0af927so808527a34.0
        for <cgroups@vger.kernel.org>; Fri, 09 Feb 2024 11:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707505275; x=1708110075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
        b=QjH4Tz9d+y5onMYkIxLLxqn0XMOp51rpc21fBqX/T6NMpHVrOFT1XCWvWjhnjozecp
         KzxtI4L124U2yykx6Gav8jT2xv1InuoiBFEqYu7jqhNinpwz31qmcWSQMUMRMF329SQb
         h25odb6c3n0zElyVXFZoI7QvoxbtNpjp0rcpYIRo6lGu0J0YsvKHXgy0D4/ir3xzRjph
         J/3/AmMOOOXC74bOedxaT9rYBAByPbX/aeRxJmcqwm2ZGrBX110eZyPNMpjZHdzZl0Gf
         bfHPVHb2nArw/o10GvwtEEbZi2LXNbBrxO5BAJrjYTCdXfz0HOsYOA5KDvYDvymflCIX
         6w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505275; x=1708110075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6nixm9+pytVx29gZ1u6InMe44RI3ah/j/zSFqY5qPg=;
        b=FLlsvQNSDqlpCHCvZSxS1XZdtyLmRwZcCo92UU7hC/4jnEtp/Jls36f55yPNI9SHFZ
         mLXizTZE3GaCeAz84AwN8pvepYamfFGzJl2lNDV4QzPUs7ukG8c+9KsfGysgHbhDj4p/
         3OoYJiFkxY4vVamg11hswN6vBoaf6B1PD33ojYqQeurvME/Egn5jAayAv9m9iW7fn6BS
         EtPnhvIG2dAoAmf+cYQOYtyecY9s2LlmlGkypvcWwKCezJfZGpH1RQaT8e4N/mmb4RjE
         rfkQFN2HwQA86/Cl9WtbpFg0qv0PAOIpPzmUc3kSf1FZhuwS0z59n3J066LnadE/gF0l
         TtrQ==
X-Gm-Message-State: AOJu0YwqZDracIHFBE3nJ9xNFYCEk3ZFq82j4FgXZy8ll0Wenm03Eu/c
	bnsOs/r3ZLfv5tkHseQXBWt1rQNHyElPSPy66vhbJFeXZobcvxuZjKeZuCckbOkYF1Wmo/Pn7AR
	D6/J5+iD8arJQmuWjrQvWaqWkAyuHy0leocHSFg==
X-Google-Smtp-Source: AGHT+IFk85AK/GUYg3sBgSG/PbDJz6nuE4vk8ZoEGio36nkbZvD4VZo1ESUanwCzArrVosJa8bsMEnRS+HyilbasQKI=
X-Received: by 2002:a05:6830:141a:b0:6e0:faab:cff4 with SMTP id
 v26-20020a056830141a00b006e0faabcff4mr3036212otp.13.1707505274772; Fri, 09
 Feb 2024 11:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <CGME20240207174117eucas1p237865b0a39f3a6d1a6650150efe22e83@eucas1p2.samsung.com>
 <20240207174102.1486130-6-pasha.tatashin@soleen.com> <a1c452f9-c265-4934-82c2-8c9278d087ec@samsung.com>
In-Reply-To: <a1c452f9-c265-4934-82c2-8c9278d087ec@samsung.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 9 Feb 2024 14:00:37 -0500
Message-ID: <CA+CK2bCax2NVhVwiVdyWG0Fpj7W8gi2Tmz1guNKOFNf9O1tfng@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] iommu/exynos: use page allocation function
 provided by iommu-pages.h
To: Marek Szyprowski <m.szyprowski@samsung.com>
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
	mhiramat@kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, rientjes@google.com, bagasdotme@gmail.com, 
	mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:26=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> On 07.02.2024 18:40, Pasha Tatashin wrote:
> > Convert iommu/exynos-iommu.c to use the new page allocation functions
> > provided in iommu-pages.h.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thank you,
Pasha

