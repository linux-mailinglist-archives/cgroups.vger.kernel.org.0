Return-Path: <cgroups+bounces-93-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAFE7D7D49
	for <lists+cgroups@lfdr.de>; Thu, 26 Oct 2023 09:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1926BB2127D
	for <lists+cgroups@lfdr.de>; Thu, 26 Oct 2023 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809AF8BFE;
	Thu, 26 Oct 2023 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ixD/WJ73"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97EC399
	for <cgroups@vger.kernel.org>; Thu, 26 Oct 2023 07:06:46 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF218D
	for <cgroups@vger.kernel.org>; Thu, 26 Oct 2023 00:06:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso4430675ad.0
        for <cgroups@vger.kernel.org>; Thu, 26 Oct 2023 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698304005; x=1698908805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMNJftQVf2QXKCuFxZZxgj6EiiH5We62gPsWdhpccM8=;
        b=ixD/WJ73VL6PzyLB/IeIZWO1I9/G+Noqw7o0qSb8dcA0Nt3efnXSui475gBT0UvSc2
         gPcSUfClpcbfvc0BD8ulupLMsglO3uf7mG8Y/19c09D7YnO3GGrGgWqZD5+oH/0SL1yO
         tVhcv6pe3gFAFHquCtVcNL/bagRgHUnAsjWPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698304005; x=1698908805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMNJftQVf2QXKCuFxZZxgj6EiiH5We62gPsWdhpccM8=;
        b=Fk/s2Ue3NX4H4sM32pSy13EaSYrzdOBdxUXQy1NLABLPyJh4NmT7JTeswifBak7FsN
         lFDG0jl3QumitQzmTQ//VrLO6nLdRPVCu7YN3FsINYhyHgEY0JlJNHNEjRc+8Wspqeoe
         qkF0jbjb0fgqWh4akL+SfoT7qVI2m6dpKpqPBI1FpmNsrpGdf6vOaJTWLQ+uABYXzUvY
         A5VvBq4xugNrMGYZX66kUyUQYzZHYiiMHbHqF3Qq3ObRbwbpoMKHLrP0v1Dm0lWK2VLH
         lep1YmmS4UwmW/rew5xCpmmf7yMzjz/SpOFhSY09xpbqpM8vkjiN8/t13K7sh9C/j8hp
         c3pw==
X-Gm-Message-State: AOJu0Yz5ivo7G/WVzauNiV0qduYx6EAj28eCCZk+InHLQ4sYEX4bVf6b
	5zmpioyWfK7g9Cr+vc+MGAgB2A==
X-Google-Smtp-Source: AGHT+IGHuqs6cJxAO05b4OtnwLDo1D2gymVrsLExkse7C+G6Afwt0vVL7asDisJo5osA7Lk44ixdag==
X-Received: by 2002:a17:903:110d:b0:1c9:e508:ad43 with SMTP id n13-20020a170903110d00b001c9e508ad43mr17082989plh.8.1698304004990;
        Thu, 26 Oct 2023 00:06:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f228:3a07:1e7f:b38f])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm10295706plg.126.2023.10.26.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 00:06:44 -0700 (PDT)
Date: Thu, 26 Oct 2023 16:06:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com, yosryahmed@google.com,
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] zswap: export compression failure stats
Message-ID: <20231026070639.GB15694@google.com>
References: <20231024234509.2680539-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024234509.2680539-1-nphamcs@gmail.com>

On (23/10/24 16:45), Nhat Pham wrote:
> 
> During a zswap store attempt, the compression algorithm could fail (for
> e.g due to the page containing incompressible random data). This is not
> tracked in any of existing zswap counters, making it hard to monitor for
> and investigate. We have run into this problem several times in our
> internal investigations on zswap store failures.
> 
> This patch adds a dedicated debugfs counter for compression algorithm
> failures.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

