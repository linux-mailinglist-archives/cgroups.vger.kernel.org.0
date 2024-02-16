Return-Path: <cgroups+bounces-1643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE3857330
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 02:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF601F221BA
	for <lists+cgroups@lfdr.de>; Fri, 16 Feb 2024 01:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CFDF53;
	Fri, 16 Feb 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fMkLOjyd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF406F9EA
	for <cgroups@vger.kernel.org>; Fri, 16 Feb 2024 01:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045594; cv=none; b=m92ocs8iMm/XWZMSAl3ZPirxfMn0Y386E9UoQnpZ8NMWN2UYhKX2y1pS2CTd4bS2KwdWb8VnxWbRqQA8VnNwCppz7qEVGPISiO1ZGAmUhP9N5C/2FWbyQBKwUU3tLwSRbGRYmyGQdiAZgcKZcTuWnWFw5UQA/9pLNRAZvx9689E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045594; c=relaxed/simple;
	bh=pdX4YFmXvkCYJozarbc5NuAljGq2QKgP22r5bHoyo6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKMXOO8JsG/2JaxSvebfCvGUJ/hY8Y5gyYf2xd6HWV94gQ7UBX6AjV5+pA+p78RpVy44Sz00u+7k7HqC9+UK+2mvlUiKWrL3U9kFYHewVVWxU70nMmYcM+rjdtbj5u4PTwbfLO4FIUjYLN6V+mISSpVhKRFXxgslZ/DoPdgdMxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fMkLOjyd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42db60ebcd7so10223501cf.0
        for <cgroups@vger.kernel.org>; Thu, 15 Feb 2024 17:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708045592; x=1708650392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJOk5GBoNGjtYX6UP2FD6x8pshcgNrZex6zZ50AbGYM=;
        b=fMkLOjydWFzyo3tHChBuLpbIRXKs2SDBgSpHot0H0eZk+Mn7aohqz4yAeUXkcGbukN
         tCIyuhwdsqBRQMkUJXoPVDVF1XEmf3gseQlQC4LZsyeSgnD5/KuSxFf45nfB3baDvU0i
         C3vubDKbbYUj4B/0Kk0lhrHTVw6Pu9dI7ta4oTFx3U/1bPUWwN5LLwGjBvNM82vY5qDq
         zGuZ5kAmJ3+rohu93m7E5zvDGTt0jy6rL1mV1jk8Ue7zRP4fK0U7ZsbSgVGTk7M4StmG
         /L6CKRwJHr8psQ+pYeuWTvk0XGY/cPu5VBSKAEtGccMgdzH09vKaNVqiLW1lRTbzrLY9
         y9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708045592; x=1708650392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJOk5GBoNGjtYX6UP2FD6x8pshcgNrZex6zZ50AbGYM=;
        b=WBrJ3cDUTKVNRACchTNJd2Y28e2kUSv5TnLzHqtB7Wsml/gGBW2d5PCDt8ZjyEpcjP
         4AhE+DPOIsyt72/n9NIx04p4x0rMI46N179lebPQLbU2bj6WgdQRXsaYdMdaE9kcYKAV
         cDMxd0c3FlBBDTweQMqEjPNu2WGawG+wbCbC96ZYZFufEDJXgyl1Z4UaPgD9tuYQxglM
         ZA8NR9QgDOqgpl1HKibRQwWy5jlaRVzF7kQCT1IWwO2qHCmLjeYi57bigLjljVRaFukd
         EhOSfE+UtNSEOnFGYIP3TfAkcqFphkFsIBkNMmRxLFjL7zqwCtvui4hREnhVbcpvhvBj
         vRzg==
X-Forwarded-Encrypted: i=1; AJvYcCUGCPSvXKyUspgwASr6kkySmlEs5e46I2i+5e5290L4Ir3Z/ejWwzSOeJbIF3pPCS/mDwgrtOirwanmdiw2jfOSoPMgoK/0pQ==
X-Gm-Message-State: AOJu0Yx9LaxJPCOQ5TZnb5l0tKyslH9I9NqYB9TCSMKlvmw8nRYJtZnT
	XVI3LN4M1ZUvp/VZ05PfC34UbpHmsR4IFELZax0PDO9JOFSmTczEQRg2XGAfJvHr1oIv+YYmJ8O
	IffyQh7t/7dCvQPg997JxcfiHgP/hRd6itVVdFg==
X-Google-Smtp-Source: AGHT+IFn+h3r/AaoF4MfmIEWnQLUDUmnx1Kec57gXxwxEXHIeMLPIowE5fZkN66KK2rAD8UQkIaND2e8M33sIsMCnhQ=
X-Received: by 2002:a05:622a:1048:b0:42c:798a:a053 with SMTP id
 f8-20020a05622a104800b0042c798aa053mr4373943qte.55.1708045591818; Thu, 15 Feb
 2024 17:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-2-pasha.tatashin@soleen.com> <8ce2cd7b-7702-45aa-b4c8-25a01c27ed83@arm.com>
 <CA+CK2bC=XyUhoSP9f0XBqEnQ-P5mMT2U=5dfzRSc9C=2b+bstQ@mail.gmail.com> <b008bd2d-a189-481f-917d-bb045c43cb07@arm.com>
In-Reply-To: <b008bd2d-a189-481f-917d-bb045c43cb07@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Feb 2024 20:05:55 -0500
Message-ID: <CA+CK2bBTe93nXzY3Qhty+821LrkjBVnQDxro3m7Y-GVihSP18A@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] iommu/vt-d: add wrapper functions for page allocations
To: Robin Murphy <robin.murphy@arm.com>
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
	rdunlap@infradead.org, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org, will@kernel.org, 
	yu-cheng.yu@intel.com, rientjes@google.com, bagasdotme@gmail.com, 
	mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"

> >>> + */
> >>> +static inline void *iommu_alloc_page_node(int nid, gfp_t gfp)
> >>> +{
> >>> +     return iommu_alloc_pages_node(nid, gfp, 0);
> >>> +}
> >>
> >> TBH I'm not entirely convinced that saving 4 characters per invocation
> >> times 11 invocations makes this wrapper worthwhile :/
> >
> > Let's keep them. After the clean-up that you suggested, there are
> > fewer functions left in this file, but I think that it is cleaner to
> > keep these remaining, as it is beneficial to easily distinguish when
> > exactly one page is allocated vs when multiple are allocated via code
> > search.
>
> But is it, really? It's not at all obvious to me *why* it would be
> significantly interesting to distinguish fixed order-0 allocations from
> higher-order or variable-order (which may still be 0) ones. After all,
> there's no regular alloc_page_node() wrapper, yet plenty more callers of
> alloc_pages_node(..., 0) :/

The pages that are allocated with order > 0 cannot be freed using
iommu_put_pages_list(), without messing up refcounts in the tail
pages. I think having a dedicated function that guarantees order = 0
pages allocation makes it easier for the reviewer to follow the code,
and ensures that only these pages are put on the freelist.

Even in the existing code, the order=0 allocation is wrapped in the
*alloc_pgtable_page() function.

Pasha


>
> Thanks,
> Robin.

