Return-Path: <cgroups+bounces-1028-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1C81E8C4
	for <lists+cgroups@lfdr.de>; Tue, 26 Dec 2023 18:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93ADC282B70
	for <lists+cgroups@lfdr.de>; Tue, 26 Dec 2023 17:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1DD4F8B7;
	Tue, 26 Dec 2023 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Rx/Z4nHR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1F4FF65
	for <cgroups@vger.kernel.org>; Tue, 26 Dec 2023 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-427e55a172bso3463371cf.2
        for <cgroups@vger.kernel.org>; Tue, 26 Dec 2023 09:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703613482; x=1704218282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYH7udRxVOWUuYR1uviT4nzog+O468I+tsZ16QY52lY=;
        b=Rx/Z4nHRY1rSniKB7ojzBTzchlS2er2VU2zu6k5/FnO7NMhFsGCtuVNSYt48bBzIUK
         ij4DxspKTtvkJw2rpHMDZyOEonUoz5HeKb+hWX2utOvlr/xPxySA9cMQuIWIHDI13TuF
         bJqKEtiWP+VYYe4QdfnU8x30DHGrT/bxxwCa726sfWqYWXPxhtRIz/VATzKaxTXXpEuQ
         +20EeOcvHa6zPq5v/gWGKcf/gLTxOpnnVj3IoUH8Gx8ADZqJugSDmg2CxzCe5gAnNGVD
         WKUlXr0g3eBOh9Z39Ati6EXzd69lD5HtiDdcW7l17KFZ7iZnn/iQ/pq3AzHVqUmNbJxp
         7dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703613482; x=1704218282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYH7udRxVOWUuYR1uviT4nzog+O468I+tsZ16QY52lY=;
        b=YfBwDBis6sRjKrUsH4NloPjcodZBngr/NQ32XqgziBzyUPG9soWrrUzqtsdLpEG7vr
         QWtlq8Y+LGrmXWe91u+LgRdqn5wdmHpcYTkehHQnxs3clnoIXaoBqvzL+s2FWJMBoMI4
         fpfMI3vnmnST18uPYlkzL/FZrbZ+RBeQLgfKB1a6xrJN1erKQ/kYziMvhcyXEgq/+MP4
         0wponehBy9riNqR/Tw2VqK8pR443cA6EV72UVCslr4n2G9PMC+3tr8mSPQOnqj9L9Fg2
         CahYjbeVfpkZWpUlb89O2SYzpWMlwW8Vucd2WTsewYVkCKiFIGw1yv0DeMcHOJn1hHML
         Nm8Q==
X-Gm-Message-State: AOJu0YxLleAWWB/Mp2q2m6s0o3y5nIj6op9BqNsnmwBIjp56rnnuW7t7
	LuNlbhKKTuSxbMnaI4qaLFPqi7EzzOwJgORje1QMcFiDo+DEoA==
X-Google-Smtp-Source: AGHT+IF1mJ8zM3mxpNM9KsLehfwPoH0iCOIzFR/lBXLAAhZkeLDmK9jCB4DCOG5yTSpoP8aUapffGpK3Rjo+EEYkWKw=
X-Received: by 2002:ac8:5915:0:b0:427:9fad:896a with SMTP id
 21-20020ac85915000000b004279fad896amr10235427qty.56.1703613481775; Tue, 26
 Dec 2023 09:58:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com>
 <20231130201504.2322355-2-pasha.tatashin@soleen.com> <776e17af-ae25-16a0-f443-66f3972b00c0@google.com>
 <CA+CK2bA8iJ_w8CSx2Ed=d2cVSujrC0-TpO7U9j+Ow-gfk1nyfQ@mail.gmail.com>
 <1fd66377-030c-2e48-e658-4669bbf037e9@google.com> <ZYinEGCdl8mZjmXi@casper.infradead.org>
In-Reply-To: <ZYinEGCdl8mZjmXi@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Dec 2023 12:57:25 -0500
Message-ID: <CA+CK2bDWRN__FBw1N9j9RD3EE+0pca89ASKROA6tK_CGH17gNw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] iommu/vt-d: add wrapper functions for page allocations
To: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, krzysztof.kozlowski@linaro.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	lizefan.x@bytedance.com, marcan@marcan.st, mhiramat@kernel.org, 
	m.szyprowski@samsung.com, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 4:48=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Dec 24, 2023 at 01:30:50PM -0800, David Rientjes wrote:
> > > > s/pages/page/ here and later in this file.
> > >
> > > In this file, where there a page with an "order", I reference it with
> > > "pages", when no order (i.e. order =3D 0), I reference it with "page"
> > >
> > > I.e.: __iommu_alloc_page vs. __iommu_alloc_pages
> > >
> >
> > Eh, the struct page points to a (potentially compound) page, not a set =
or
> > list of pages.  I won't bikeshed on it, but "struct page *pages" never
> > makes sense unless it's **pages or *pages[] :)
>
> I'd suggest that 'pages' also makes sense when _not_ using __GFP_COMP,
> as we do in fact allocate an array of pages in that case.
>
> That said, we shouldn't encourage the use of non-compound allocations.
> It would also be good for someone to define a memdesc for iommu memory
> like we have already for slab.  We'll need it eventually, and it'll work
> out better if someone who understands iommus (ie not me) does it.

I was thinking of adding an IOMMU page table memdesc, at least by
starting with Intel implementation.

- For efficient freeing on page-unmap we need a counter.
- We might also need a per-page page table locking (aka PTL type
lock), if the current approach I am proposing is not scalable enough.
- Access to debugfs (I am studying this now).

However, iommu memdesc would really make sense, once all the various
page table management IOMMU implementations are unified.

Pasha

