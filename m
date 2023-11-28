Return-Path: <cgroups+bounces-653-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE6C7FCAE2
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 00:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA805B2179C
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 23:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11105C3C5;
	Tue, 28 Nov 2023 23:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hAjmDOgU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FD210D7
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:32:58 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-423e8145018so737291cf.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701214377; x=1701819177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5E8YxJ+6DFizX8w/tjdr1Q20AjeSOztly1v+T84HO0=;
        b=hAjmDOgURwcCKRyzsQ2r9G/hrW5XB5oPAgH+truRdM7Ubd9bwhx+SUNOk769wz6aTr
         VYfsuUmPAUDpDhIramOnNZVkmzbTcE1UjeRmD5rqVTIW9Q/tz+C/MvLNj9eOiZz8qsGp
         +W6GO2qUsEaJy2fEIylTKL+Xx1ZDQQkwQ0zT405NTPg3borX7TjETTNniEkz183RclQt
         60Kvw5avLZcFCPd2vHJhiHAi7jNEPvFiNyGXUg6AxM1NyQ95U51usNeoyOM0Xz4qTxwS
         9F58JT1vDhwM60ZIjXHSSHHZeWT5IrJ4U3G7m2fIhWwODX7PcRzchcRkIZ7xRhpL3pFh
         TUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701214377; x=1701819177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5E8YxJ+6DFizX8w/tjdr1Q20AjeSOztly1v+T84HO0=;
        b=CJk8Et9iyUoEyNqIq0CVtRFVZhw0AKNNKFTqiqgnFkQOv1fMiK4Obj1is7OoUxzNv1
         ThB/Uoc0yxJgDvQ5G+vrFSV1491ycZm90SLJvOhpVNcXPEIHRiOS00sAhifQRKdh+sv/
         HLb65niGmgjyS3MRAHvKzlf8Mzg+S1FoQn76R8RSWcEH/jdz9hIz+fPZSE1yCufg2IkB
         YIDOmDQMTrYeY5B9Op3kYRVHag+DLJhPSEHvonnVelRsH9VcQA3ZPc7P5KjXUrkE36I4
         WUxtdOW/gHeuRc9YUgDBZk+y+SiPicS7QAvd60TK7yV4JJmTaISdut0PWE5hFupw4Z1K
         PPmw==
X-Gm-Message-State: AOJu0Yzl++4ZxOfuZTUMM8J7MVRi7aFXfKCaYYEkIlWMI4sGD1/V6Bh6
	XO1vsGVl0bW1wrAcXHRkkX8QkTuIKRKkHEk/f6c7zg==
X-Google-Smtp-Source: AGHT+IEOuxWHhR77aLWnHKpzlrX1TcnL7YFPpFLtYSrpaVGNIqLOq9dSsp5P0HO6NZm9ZocGV6nook5EATgkphMBWlk=
X-Received: by 2002:ac8:5c06:0:b0:419:a2c6:820e with SMTP id
 i6-20020ac85c06000000b00419a2c6820emr19578443qti.12.1701214377257; Tue, 28
 Nov 2023 15:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-6-pasha.tatashin@soleen.com> <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
 <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com> <6f9ff0aa-7713-4de1-869e-4725828942e4@arm.com>
In-Reply-To: <6f9ff0aa-7713-4de1-869e-4725828942e4@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 28 Nov 2023 18:32:20 -0500
Message-ID: <CA+CK2bDKaXqemr2Hp=MRxxMB_=AoRnUK_D2SGm9cDkKa+JaT7A@mail.gmail.com>
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
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

On Tue, Nov 28, 2023 at 6:08=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-11-28 10:55 pm, Pasha Tatashin wrote:
> >>>                kmem_cache_free(data->l2_tables, table);
> >
> > We only account page allocations, not subpages, however, this is
> > something I was surprised about this particular architecture of why do
> > we allocate l2 using kmem ? Are the second level tables on arm v7s
> > really sub-page in size?
>
> Yes, L2 tables are 1KB, so the kmem_cache could still quite easily end
> up consuming significantly more memory than the L1 table, which is
> usually 16KB (but could potentially be smaller depending on the config,
> or up to 64KB with the Mediatek hacks).

I am OK removing support for this architecture, or keeping only info
for L1, I do not think there is a reason to worry about sub-page
accounting only for v7s.

Pasha

>
> Thanks,
> Robin.

