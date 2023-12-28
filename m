Return-Path: <cgroups+bounces-1046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E88381F92E
	for <lists+cgroups@lfdr.de>; Thu, 28 Dec 2023 15:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB71F2271C
	for <lists+cgroups@lfdr.de>; Thu, 28 Dec 2023 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56610DDD0;
	Thu, 28 Dec 2023 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Eb6bljNs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51CCA50
	for <cgroups@vger.kernel.org>; Thu, 28 Dec 2023 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-427e83601c4so10203341cf.0
        for <cgroups@vger.kernel.org>; Thu, 28 Dec 2023 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1703774244; x=1704379044; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VU21beHWoGJM/Oi2NFAV2MrwGlZZbvr3br6yMg4QftQ=;
        b=Eb6bljNs2u44uqRtI3F141CcYYeJZC3I7ik1RRd01ohigNe0el8ZFd7Cnff6P4p5FO
         aZAK6iTT9No1CYD8uJVofrbZE0hzm2tvFCR4F5VzJqv+AAV4p8dX7L9h4BpcNOXTe1/7
         tpFSx98985TYua2Vzxoz4ao2I/2RsU0xL1A1Td4tHxbb4ylKrN7eXDL5mYKP+Tthw+Br
         d9KV9wJqK0aPta7Mn4fLNoJ8+B6MOdlZNgDY2zK7EBeCCQtP5N5vWkeLWnyHYvENIiAq
         f4PnXZt0fAiMifTf0Nfiecxl9T0/Og7/UUnXkTJVM7sUy4KojKg3/+Kt+V8Q9Bx952Wa
         rECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703774244; x=1704379044;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VU21beHWoGJM/Oi2NFAV2MrwGlZZbvr3br6yMg4QftQ=;
        b=OvUB46BOIp4saeWeM17DDeBEcbfJdxKcNcssOywuXpyu9f6GYrVlEdJA3RsuiTffRB
         b9p04E+4UQIwMoxKulcD3uLGFap2sK91qo3ZSXAVViSHmq5X3Wi9IE2OLtY86aF416sd
         xyiqu66TWs5ApfDPo7vonHM8xTpHar7mq6tVPDPTXKMkJKhb6fLaJgIDGStoQ2hbJG5X
         pQaFp8GbskNbGrB2GDq9XtngirDgdglT7wUGmfdHANcwHEDo3Xhbi8NBIfVtRJgDSdR3
         T219ul3UBXMlQns40r2I8VuhQmQLSIJ0hb8wArx7A4ncetmAe8DN/wU1418CF39Yz4EZ
         wWVw==
X-Gm-Message-State: AOJu0YyNWexCtuP9kzu40D3GrHSpkm81fy/vwkMfudGZWs5HegmQ0sh4
	y6T4uLtQPS4gS8TDM03o8P2tx1Xl8aflNeBVz+eGhEf0lkuJlQ==
X-Google-Smtp-Source: AGHT+IG/UmSKlDQRlBa0+Is4JntOVZHhkiYS93o0FbAPPReWbU+HuVGCau4VX0GkprQKsQRXjMZhGZwl3l+vLHMY8rQ=
X-Received: by 2002:ac8:7f54:0:b0:41e:a62b:3d18 with SMTP id
 g20-20020ac87f54000000b0041ea62b3d18mr11492563qtk.59.1703774244502; Thu, 28
 Dec 2023 06:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226200205.562565-1-pasha.tatashin@soleen.com> <ZYv3BIeEgY8LnH7U@archie.me>
In-Reply-To: <ZYv3BIeEgY8LnH7U@archie.me>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Dec 2023 09:36:48 -0500
Message-ID: <CA+CK2bCSB46sZUrx+jsCCtGb-DFUuU9wvCaTamYtKnDAaG9eVA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] IOMMU memory observability
To: Bagas Sanjaya <bagasdotme@gmail.com>
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
	will@kernel.org, yu-cheng.yu@intel.com, rientjes@google.com, 
	Josh Don <joshdon@google.com>, YouHong Li <liyouhong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

> > This series encorporates suggestions that came from the discussion
> > at LPC [2].
> > ----------------------------------------------------------------------
> > [1] https://github.com/soleen/iova_stress
> > [2] https://lpc.events/event/17/contributions/1466
> > ----------------------------------------------------------------------
> > Previous versions
> > v1: https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com
> > v2: https://lore.kernel.org/linux-mm/20231130201504.2322355-1-pasha.tatashin@soleen.com
> > ----------------------------------------------------------------------
> >
>
> First of all, Merry Christmas and Happy New Year for all!
>
> And for this series, no observable regressions when booting the kernel with
> the series applied.
>
> Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thank you for testing.

Pasha

