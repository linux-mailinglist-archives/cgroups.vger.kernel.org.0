Return-Path: <cgroups+bounces-652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A37FCA8D
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 00:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388F2B21718
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 23:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539358AC2;
	Tue, 28 Nov 2023 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="L2M2Qprf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D519A6
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:08:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-423dcd5e86bso5791461cf.2
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212928; x=1701817728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwfH1boRaqUSm7vYG/zdQBuuZhpN21nmfcJNTWlLUDE=;
        b=L2M2Qprf4E13EmuQfMCiF96aDL6KRUKn30A8AJ9b64X816aPXJAY9oxw7B1ln8iZHi
         48FDR+YptH8ftAV2+eOX/vl7Oe5bDpdaafnB96VWxqu5tkeNY7SunuexF2cs/fzyj/PF
         52SOZGEcxMRPEPkYoIZQOTGi2wnFe8v/w1oF10w6RQwekK+EzxkxlYt0qcfzwiJQts+H
         2tMU1YUY+TjpQSYKZH1l+OlSp3m7dzueKnbvTL7NXjfpV4JEEkxClWrtUUf4jcXVj6jt
         e7sejvPKLZx1EPf+lDFFwqdwpKQonrOaiVG5Lue0KJdEEO6Oz2qRGuU1t6eH92/gwk6X
         Cj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212928; x=1701817728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwfH1boRaqUSm7vYG/zdQBuuZhpN21nmfcJNTWlLUDE=;
        b=bGPrORYvbc9fCMtGVvh7LinpLUTmFS/admRfx70C0bQjewNntMWUc9TpwcQEweK6ip
         YsOgAhIjXYQhyBQpj5dWe2lAJoT3QAujDm8lw9tURgXmLvOl0aHrdGapo3pS8sR2g8jX
         A1Yz2+vAeYBL661P7ku15f6TkWK2Yl4PqoHjLF2GoFIaQRGFRxd59ZsoS8Jjln2Yylcz
         H6e4v03Xjo9LQt9j9+GjsXLhjHlHHaitAalW4OIA7Ej6FDd++KtXBr8Vyk/DKyfVYDL4
         H+aDrf6v3P9SXjapg0+0E8KhXsea+8Cy7Ozou4LVV1JJBKmt/lHo5vyLdSM9AcCSf937
         DkoA==
X-Gm-Message-State: AOJu0Yw1M36z1FpZC/4TE/ws4uKNwYe55myp8vBjr5ekCpw3yQbkRwYt
	he2a4Y4fjQXkA4OfddhBpRKpf2S796wvGxxQD2l4hQ==
X-Google-Smtp-Source: AGHT+IH+DSzeg4H32kbSmeDdX42LwmFTBbiExz1cQ9Spo9pVMTh9OFSxf1oX9/Sr0tuUo1qYELK4l02okd8aqJLSMys=
X-Received: by 2002:a05:622a:d2:b0:423:7f91:3a17 with SMTP id
 p18-20020a05622a00d200b004237f913a17mr22124861qtw.21.1701212928489; Tue, 28
 Nov 2023 15:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-7-pasha.tatashin@soleen.com> <d99e0d4a-94a9-482b-b5b5-833cba518b86@arm.com>
 <CA+CK2bDswtrqiOMt3+0LBb0+7nJY9aBpzZdsmrWRzy9WxBqKEg@mail.gmail.com> <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
In-Reply-To: <79c397ee-b71b-470e-9184-401b4b96a0d2@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 18:08:11 -0500
Message-ID: <CA+CK2bDZUHSLWB=ec6Jdjbi+y6fD8=j96bK-kPHYKc1uiVLZWw@mail.gmail.com>
Subject: Re: [PATCH 06/16] iommu/dma: use page allocation function provided by iommu-pages.h
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

> > This is true, however, we want to account and observe the pages
> > allocated by IOMMU subsystem for DMA buffers, as they are essentially
> > unmovable locked pages. Should we separate IOMMU memory from KVM
> > memory all together and add another field to /proc/meminfo, something
> > like "iommu -> iommu pagetable and dma memory", or do we want to
> > export DMA memory separately from IOMMU page tables?
>
> These are not allocated by "the IOMMU subsystem", they are allocated by
> the DMA API. Even if you want to claim that a driver pinning memory via
> iommu_dma_ops is somehow different from the same driver pinning the same
> amount of memory via dma-direct when iommu.passthrough=1, it's still
> nonsense because you're failing to account the pages which iommu_dma_ops
> gets from CMA, dma_common_alloc_pages(), dynamic SWIOTLB, the various
> pools, and so on.

I see, IOMMU variants are used only for discontiguous allocations, and
the common ones are defined outside of driver/iommu. Alright, I can
remove all the changes for all no-page table related IOMMU
allocations.

Pasha

