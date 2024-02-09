Return-Path: <cgroups+bounces-1414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BE84FC8C
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 20:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B37282A46
	for <lists+cgroups@lfdr.de>; Fri,  9 Feb 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD58612C;
	Fri,  9 Feb 2024 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=soleen.com header.i=@soleen.com header.b="YrISHW17"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A684A47
	for <cgroups@vger.kernel.org>; Fri,  9 Feb 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505324; cv=none; b=PG2ps/ezJH6dhjnAh5IlFMpdjlxYAK4QFywyzAVM4LSLHdJEhHOro4GNdQQSPteZFsQUqItOd9BwZqeFJBjN0SNm2aapfRDumR8GQqmUuqipmV+d3MU5qNVFeZTZkYlKz95tXXsVu4B6ymnFF5YJqd/eS9O89R3qemRUNiEQF4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505324; c=relaxed/simple;
	bh=r2GAPlcgJGDaQINPFrlt1R7Ny0c1Ad/P9P2yI23KbDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rV3PCXgCm12DjtWK7m+LrCBTlB+cOMproR//+7ZpwFJaSTpVxoGqmhTdg0QhbKcIorwDPzWF/dYDiJGWoEF4GC3z+qBcH1UWHTx6VWYMAU4Oka1rVW14UAlT4AypHbrFSvoLUHTjmItYPoocjWxzgERjFNoCtM/hx9/ZeGjdtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com; spf=none smtp.mailfrom=soleen.com; dkim=fail (0-bit key) header.d=soleen.com header.i=@soleen.com header.b=YrISHW17 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=soleen.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42a8a3973c5so7802321cf.2
        for <cgroups@vger.kernel.org>; Fri, 09 Feb 2024 11:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1707505321; x=1708110121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2GAPlcgJGDaQINPFrlt1R7Ny0c1Ad/P9P2yI23KbDE=;
        b=YrISHW17lCS/ho4//b4p9TqA8m5OjeuDgKDgXz2T9RvjLqJMDjuxgIo0sijLNlnvbw
         vlbxBsbVIkA1cbwtLh9in9xFo1B4OsJA0GK8KZWWdHvOBSe5wPtvUL146w7QRZY9MQGr
         NEW5JhuUvu2EeSXDCMubEXBxZWE+NnF6BbEMvRNFUugYnfCRkJrf80B6e9HDwpGNXcsU
         PKEXQrVV6iloQuodAuf5jDgLu7zt+VWUHsH4xY31Z4+MZkdqqrszFzl1HE58BU0sqGjE
         XjYLaGRX9jwOCKgEY1Q8HKkMLe12wEj+BgZXxmorOV5bUdfuVgOPnV2+qch5gHTJV4g5
         u0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505321; x=1708110121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2GAPlcgJGDaQINPFrlt1R7Ny0c1Ad/P9P2yI23KbDE=;
        b=GFNeF/TrLreop+0zavjlmlfqFwXvSk67flTzxjDsXLxw4TSkHcVPUTm7nrKGI2QFiy
         ah75kjQkdKgYpq0lF+1SQ67p+qj1qk8M3wIfbaWpZZb7crR76Mz3l+c7KEajNLhj4v+Y
         2iBhWRzBl56lVAxJioiXviaPTtWIrJPLG3pWmRRcLVWiBF49CV4MFsrLYqKFstST/3rt
         QS39s6PV6GBBK0qX0TLTc6jLISVnuuzcRIhfs91zSpMletvh+P6y4eGjgGGlYNJsmtcw
         l9bwOfB9M80o5hleJGqfX2pZLrTZ46ChR+tkiHVgiwM2JR4EIA8cjPv99Tv3bZmLl9AH
         oVqw==
X-Gm-Message-State: AOJu0Yy2xzPa5bsa/lz/Q1+amd19mkrMgYhdbofr/ofbbTU+C5Nesk0C
	huX8w62QJctvJkkwrho4BW+3ksj36ZsazT8g4boQDEpEdyWIHXKIFRlo07FRp+pDxO/jzj72XPP
	GTraGBlTrVVBRxg1Jn8kz8rrr2kdWQOdIbqHE8A==
X-Google-Smtp-Source: AGHT+IH7/mZBjs2EjvojqcpcvFrKDkqXbLzePQwHXjWI3pjuKzeuKKYp6aDXpqli+cr6MKqGXO43wFaJScoTxBnZMCE=
X-Received: by 2002:ac8:5e51:0:b0:42c:5f0e:6411 with SMTP id
 i17-20020ac85e51000000b0042c5f0e6411mr85445qtx.25.1707505320844; Fri, 09 Feb
 2024 11:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207174102.1486130-1-pasha.tatashin@soleen.com>
 <20240207174102.1486130-8-pasha.tatashin@soleen.com> <2718393.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <2718393.mvXUDI8C0e@jernej-laptop>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 9 Feb 2024 14:01:24 -0500
Message-ID: <CA+CK2bBqzd4imzKxGJVUn3SkvDBPk_=CLA1Fm05kz3DqSE2gpA@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] iommu/sun50i: use page allocation function
 provided by iommu-pages.h
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: akpm@linux-foundation.org, alim.akhtar@samsung.com, alyssa@rosenzweig.io, 
	asahi@lists.linux.dev, baolu.lu@linux.intel.com, bhelgaas@google.com, 
	cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com, 
	dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de, 
	iommu@lists.linux.dev, jonathanh@nvidia.com, joro@8bytes.org, 
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
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:55=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec@=
gmail.com> wrote:
>
> Dne sreda, 07. februar 2024 ob 18:40:59 CET je Pasha Tatashin napisal(a):
> > Convert iommu/sun50i-iommu.c to use the new page allocation functions
> > provided in iommu-pages.h.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: David Rientjes <rientjes@google.com>
> > Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thank you,
Pasha

