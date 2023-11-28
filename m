Return-Path: <cgroups+bounces-647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8C27FCA64
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 00:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914DBB215C8
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 23:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705E57323;
	Tue, 28 Nov 2023 23:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iQIZGxjh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABE51990
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:00:50 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41cd4cc515fso33926011cf.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212450; x=1701817250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5qTeYLca2e2he2/h7lciNlkt/VVLJwBuHOteswziYE=;
        b=iQIZGxjh0foWJg/CGAbMcibkR4os5g7s7CaChq2dHp+MXixf2jJXZqcXoRPMHpy9Vl
         UwLO6Az5DGsyq7saw5+8u5qaAb+M+GDBB9zIBkOG4AVOmGFgHICGyZgkXk6TQwVEU2Mm
         1JbO85hj09WFDD8ip9oBulPJ6vBH+qj5MhA8HoKag6jw3yk3JcKrqIa1WPXtr5kmaTnX
         ZotF2sHL/PkCKZ5Cmb2Se05DHGyn2ZowpCQZAAUVslvnX18SplilIlXwGVE0U/0dZNvI
         WtLIxG61b7CFmheHVQdn2/igox6t1ZTe6LxXBWA17Og1eO3QiSSjMGKGy32jDBZEI6bK
         rhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212450; x=1701817250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5qTeYLca2e2he2/h7lciNlkt/VVLJwBuHOteswziYE=;
        b=agIgjVjB7khVYFSqHJ13c0PogzQlwQupMWjHCVIntXoB3Qbx+/cP1zExLLzq9wF1p4
         /KdskF4UIE4rbYQeV30oSHLMENAzuLm6WEaSthfGYn6wIwylzZvWvC9n8Vee9MiSbrCB
         HWdSYJHRo+iFrPFwsM/fL0sRMZ/VurkSM6xsH8nUFA05EbpUwPFc2mT1wIePzYKtXgR4
         85Ol2YpEa+uG8nKPmsAsZwZl0yHcNnIV5bXrv6s9F2hbJ7V2WfsUgp3+tWw1ArGbD8+a
         cs7IKoGaqbEa2OniRhUPeLjpvK7br78WfuVWnDkj1yicp3vrDjLPeh7zsgvBeSG/qIqJ
         KMTg==
X-Gm-Message-State: AOJu0YzwbIU8Rn01EJGOPcxtgrkiHOCBVmTlJjBY49ri7Nvvei4pV0EE
	gkTYi7gGebXAP7oAX8g1/3Gu0DDaeHzjYfwxgevNfQ==
X-Google-Smtp-Source: AGHT+IEPyMHIunggDlyG5iB0FMPH+mJhboCaVsS2S6rrqwyBMR/AatdaxBsSOQb0215dRYgwc4yOM/dAMVD+X08yuok=
X-Received: by 2002:a05:622a:34c:b0:41e:213d:3c8e with SMTP id
 r12-20020a05622a034c00b0041e213d3c8emr18601609qtw.32.1701212449795; Tue, 28
 Nov 2023 15:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-9-pasha.tatashin@soleen.com> <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
In-Reply-To: <1c6156de-c6c7-43a7-8c34-8239abee3978@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 18:00:13 -0500
Message-ID: <CA+CK2bCOtwZxTUS60PHOQ3szXdCzau7OpopgFEbbC6a9Frxafg@mail.gmail.com>
Subject: Re: [PATCH 08/16] iommu/fsl: use page allocation function provided by iommu-pages.h
To: Robin Murphy <robin.murphy@arm.com>
Cc: akpm@linux-foundation.org, alex.williamson@redhat.com, 
	alim.akhtar@samsung.com, alyssa@rosenzweig.io, asahi@lists.linux.dev, 
	baolu.lu@linux.intel.com, bhelgaas@google.com, cgroups@vger.kernel.org, 
	corbet@lwn.net, david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org, 
	heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com, 
	jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com, joro@8bytes.org, 
	kevin.tian@intel.com, krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	samuel@sholland.org, suravee.suthikulpanit@amd.com, sven@svenpeter.dev, 
	thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com, 
	vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org, 
	will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 5:53=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-11-28 8:49 pm, Pasha Tatashin wrote:
> > Convert iommu/fsl_pamu.c to use the new page allocation functions
> > provided in iommu-pages.h.
>
> Again, this is not a pagetable. This thing doesn't even *have* pagetables=
.
>
> Similar to patches #1 and #2 where you're lumping in configuration
> tables which belong to the IOMMU driver itself, as opposed to pagetables
> which effectively belong to an IOMMU domain's user. But then there are
> still drivers where you're *not* accounting similar configuration
> structures, so I really struggle to see how this metric is useful when
> it's so completely inconsistent in what it's counting :/

The whole IOMMU subsystem allocates a significant amount of kernel
locked memory that we want to at least observe. The new field in
vmstat does just that: it reports ALL buddy allocator memory that
IOMMU allocates. However, for accounting purposes, I agree, we need to
do better, and separate at least iommu pagetables from the rest.

We can separate the metric into two:
iommu pagetable only
iommu everything

or into three:
iommu pagetable only
iommu dma
iommu everything

What do you think?

Pasha

>
> Thanks,
> Robin.
>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >   drivers/iommu/fsl_pamu.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> > index f37d3b044131..7bfb49940f0c 100644
> > --- a/drivers/iommu/fsl_pamu.c
> > +++ b/drivers/iommu/fsl_pamu.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/platform_device.h>
> >
> >   #include <asm/mpc85xx.h>
> > +#include "iommu-pages.h"
> >
> >   /* define indexes for each operation mapping scenario */
> >   #define OMI_QMAN        0x00
> > @@ -828,7 +829,7 @@ static int fsl_pamu_probe(struct platform_device *p=
dev)
> >               (PAGE_SIZE << get_order(OMT_SIZE));
> >       order =3D get_order(mem_size);
> >
> > -     p =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +     p =3D __iommu_alloc_pages(GFP_KERNEL, order);
> >       if (!p) {
> >               dev_err(dev, "unable to allocate PAACT/SPAACT/OMT block\n=
");
> >               ret =3D -ENOMEM;
> > @@ -916,7 +917,7 @@ static int fsl_pamu_probe(struct platform_device *p=
dev)
> >               iounmap(guts_regs);
> >
> >       if (ppaact)
> > -             free_pages((unsigned long)ppaact, order);
> > +             iommu_free_pages(ppaact, order);
> >
> >       ppaact =3D NULL;
> >

