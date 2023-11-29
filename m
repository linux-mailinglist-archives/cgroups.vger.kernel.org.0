Return-Path: <cgroups+bounces-658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8C7FCB47
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 01:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CEA1C20CEF
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172541374;
	Wed, 29 Nov 2023 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xcHA59Qn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25C19AC
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-549070a04baso8221902a12.3
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701217543; x=1701822343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=xcHA59QncnY+Jv5eqouYZKNUuZW0aoF9Jof6A1bjrsdKHtRECct4Zg1bBoZuhtAiAs
         eDRd8YtgVh7xlGORJ5ik2i5WT8Khd1X/Khl036jDc2owBQnW9vGFQsk8n1//4iJk20Ij
         knXLHE/EoQ9OG5SLPBxU97xc6DClatRt1hZYG9ZJMlwGdEfykWl8gGFXeM9xchBYgFBG
         PYDmsAKkHzX1hZwvaLDs+HLY/uEVXTfTdh4bH0Q8uHa2qyMdpa8FRdkz4w4Up3OkPl7t
         bBR5GE8ZjrWU5M6EqY6zjloTX+utPy2o8BcKt/NNvCnOgRFksFYhbs8Lca1GI1sp1062
         wn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217543; x=1701822343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=hNRiP+NSZ7420p2O+wO7N3L+2FtP1qYnN9/CEPdyDKtBtd2vc2BoCWcI1a06BoN4MF
         4Nl+BMDSD3OuNRoaeNfe2ly+t05wfcr1EsjGrHl2AJifv59h0U0qFRr2WMwFvbH5kBir
         /ZMmJviTm7hC8xpavvXAlYQOgxlDHe1U34CuhP+tuAHzvannItteAkewTnsi2NlonNxs
         5e5DXRWsZnD6zDw7qnxTTXQWxwWNPOMhpMZrXCrRYJoDNG30cXJIKZySh2I6UDOe8Pb+
         8mvLSihUXx0TqXxM8k+Dp+6WNw2hDdsW2WgjfPDBg/TAHFOhhg8ustyqvYV4GqvCdQ3U
         WfJQ==
X-Gm-Message-State: AOJu0YxAvHeyRNwu2llGy/ABcgfxZWVFoCEOibA+b590rFDGtfp0sSNx
	Z4RhxWUoVOQIC4aFM1avQMfoJZOzUA/YiXtvTbC2Pg==
X-Google-Smtp-Source: AGHT+IFhvJD8pcFDSUkXj7rCXo1krioxrjZU+Fh9ydxhF7LIckb5ecLVgf1lGuB42STpvzRSm1nEjeoSzXAsfJKhmOQ=
X-Received: by 2002:a17:906:1091:b0:a0c:c09f:65fe with SMTP id
 u17-20020a170906109100b00a0cc09f65femr7312731eju.38.1701217542589; Tue, 28
 Nov 2023 16:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com> <20231128235214.GD1312390@ziepe.ca>
In-Reply-To: <20231128235214.GD1312390@ziepe.ca>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 28 Nov 2023 16:25:03 -0800
Message-ID: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org, 
	alex.williamson@redhat.com, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jasowang@redhat.com, jernej.skrabec@gmail.com, 
	jonathanh@nvidia.com, joro@8bytes.org, kevin.tian@intel.com, 
	krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, lizefan.x@bytedance.com, marcan@marcan.st, 
	mhiramat@kernel.org, mst@redhat.com, m.szyprowski@samsung.com, 
	netdev@vger.kernel.org, paulmck@kernel.org, rdunlap@infradead.org, 
	robin.murphy@arm.com, samuel@sholland.org, suravee.suthikulpanit@amd.com, 
	sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org, 
	tomas.mudrunka@gmail.com, vdumpa@nvidia.com, virtualization@lists.linux.dev, 
	wens@csie.org, will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 3:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > > Yes, another counter for KVM could be added. On the other hand KVM
> > > only can be computed by subtracting one from another as there are onl=
y
> > > two types of secondary page tables, KVM and IOMMU:
> > >
> > > /sys/devices/system/node/node0/meminfo
> > > Node 0 SecPageTables:    422204 kB
> > >
> > >  /sys/devices/system/node/nodeN/vmstat
> > > nr_iommu_pages 105555
> > >
> > > KVM only =3D SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> > >
> >
> > Right, but as I mention above, if userspace starts depending on this
> > equation, we won't be able to add any more classes of "secondary" page
> > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > the subtraction in the kernel.
>
> What Sean had suggested was that SecPageTables was always intended to
> account all the non-primary mmu memory used by page tables. If this is
> the case we shouldn't be trying to break it apart into finer
> counters. These are big picture counters, not detailed allocation by
> owner counters.

Right, I agree with that, but if SecPageTables includes page tables
from multiple sources, and it is observed to be suspiciously high, the
logical next step is to try to find the culprit, right?

>
> Jason

