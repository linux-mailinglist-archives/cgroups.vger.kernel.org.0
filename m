Return-Path: <cgroups+bounces-707-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F737FF9C1
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066151C20FC5
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 18:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7953802;
	Thu, 30 Nov 2023 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d39xz5aC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E60194
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 10:44:27 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d3a1f612b3so8584527b3.1
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701369866; x=1701974666; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=upiPnSdDPUq7hHtl9SwPR71HvOH0YDjoF8X3pVlx4do=;
        b=d39xz5aCp98Lkh7pxGFZZQJMBD1zYF0AJLTaiDVC5H7RTxwh3JnHvby2naCv3aIqA+
         q1mpKQnQsIjTu8IR38LwTPx9TG2UHGobO9Mi5+YIp+j65tw1T6VuCvF8KU3MeqEAWbIg
         tf3ewXbNZQLxcOqFKdu2tx1I59wph0is3ZnYJQgcZSppxa2JuATU+VxES7ClZd0HFF9v
         H8v+WAOf6PGkOqFtxrqhk2gd63/e9skSxiNLYxcMcRQR/tLOF9eZ6qyrI46v5aZnylXA
         FV/lHNXBVwg2A2h5lP9EFhOZWKxLz22Jwn7q0HHwYC1Atu/dUvblLw1ArGhcTUFz/7u6
         tYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369866; x=1701974666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upiPnSdDPUq7hHtl9SwPR71HvOH0YDjoF8X3pVlx4do=;
        b=EHFIsh7OGPExduDvEOkIT/2TjxYiHB2Bz4GMp3UxdZlHk0xcOiaknzdXENLXhhejkt
         9OJs2jeqaY4cPw/PmwdlIaJqSwGZSLz8MbS0oo4PPbP0b1gs+BzEZRyBXtVKT8pAqfoy
         5nY68foXkFPrPtoEQe/4B7nwhw1L+oG769Rxfsj53Vx9AEamrklldv4n9qygwU7a9fsx
         HN7rPB3ZRY6RmVOo86dRxho/Ek5izQEk46I1DFo6UJrlLTpfIOQNpSAPxfw3ws7WFec0
         cuEz87Mj6K65mTdAL+nuGeLFYO1KoB9yka4POp1rBxS6MCqUDpOss4s4GiemPkYqSXDk
         ovFA==
X-Gm-Message-State: AOJu0Yw2GgEi/hZiNC+U/B6Bd+71yQ4uwZRYXhd8ebGiBm7zU5PVjGJ2
	1tXGGrSG+odMP3Z3ih9NHkQp0KqOOCkqig==
X-Google-Smtp-Source: AGHT+IHazLL/GdN9pTlSOqSprD2MGFIuk76VQgPbuz/hebnvjnu/vaByiVZ+ySGXyZ042lDowWFTcrisA+c1Dw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:690c:2e04:b0:5d3:cca8:1d59 with SMTP
 id et4-20020a05690c2e0400b005d3cca81d59mr26337ywb.5.1701369866502; Thu, 30
 Nov 2023 10:44:26 -0800 (PST)
Date: Thu, 30 Nov 2023 18:44:24 +0000
In-Reply-To: <20231130153658.527556-1-schatzberg.dan@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
Message-ID: <20231130184424.7sbez2ukaylerhy6@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
From: Shakeel Butt <shakeelb@google.com>
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> (Sorry for the resend - forgot to cc the mailing lists)
> 
> This patch proposes augmenting the memory.reclaim interface with a
> swappiness=<val> argument that overrides the swappiness value for that instance
> of proactive reclaim.
> 
> Userspace proactive reclaimers use the memory.reclaim interface to trigger
> reclaim. The memory.reclaim interface does not allow for any way to effect the
> balance of file vs anon during proactive reclaim. The only approach is to adjust
> the vm.swappiness setting. However, there are a few reasons we look to control
> the balance of file vs anon during proactive reclaim, separately from reactive
> reclaim:
> 
> * Swapout should be limited to manage SSD write endurance. In near-OOM

Is this about swapout to SSD only?

>   situations we are fine with lots of swap-out to avoid OOMs. As these are
>   typically rare events, they have relatively little impact on write endurance.
>   However, proactive reclaim runs continuously and so its impact on SSD write
>   endurance is more significant. Therefore it is desireable to control swap-out
>   for proactive reclaim separately from reactive reclaim

This is understandable but swapout to zswap should be fine, right?
(Sorry I am not following the discussion on zswap patches from Nhat. Is
the answer there?)


