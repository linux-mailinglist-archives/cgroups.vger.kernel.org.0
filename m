Return-Path: <cgroups+bounces-1051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74909821EA4
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 16:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED59FB21C16
	for <lists+cgroups@lfdr.de>; Tue,  2 Jan 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB651428C;
	Tue,  2 Jan 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWGD1kOA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCA14A82;
	Tue,  2 Jan 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bbc648bed4so4365347b6e.3;
        Tue, 02 Jan 2024 07:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704208906; x=1704813706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8mXfI+Pa+/2538bxiWOCU5JAZ3tBBfS6VdnJQwfuuiQ=;
        b=OWGD1kOAup3AS7HYb/6FhsaHVh3Rc6wH7q8FYC5ChOToAKzlVCaxaQA7L8B5uiT2pI
         0jKxOEgHKq0VCWg30VL/wCDQQk1y28FYrKNRKiRQNLspdMqdO0YP5xSG4XPit3M9q3fV
         SlwMtpvwV/w4OsBdGWvtLXlblqcFafpu4B1NfMGSgUAeuUDyDXnCca5/W/6fEeo2J3ve
         dyhZqxXyAt6BFq7qRZWhT/Npo1ZS9ghhlOUUhFhWzMAjwwjnc/s9nB7/szLknoglWhDs
         We4SSz7rJvnNvCiZVCCpiHSwLrbMCpe+M3tZk1WaPEHD1DUHYP85UzXL4rFiOkFSZh7Q
         VJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704208906; x=1704813706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8mXfI+Pa+/2538bxiWOCU5JAZ3tBBfS6VdnJQwfuuiQ=;
        b=iah4LG9N8rIO1C5ctV2nhhtm9BiwGTFYqcp+wvpoTjt5HkRaLQkKrRKr411q3djI0G
         m/lz3M/rXAx0sJOCqnKmc/W8Y554FqEXy4g2wGerOLLN/s3NQEgk26xlPUoY3JMev/dH
         Un1e9j9bX5lbjQw8Auuvg9RYfWXSrHO3z7nLx5UHk4EPYqZcac+nYZ6LjbfqMCggB8vS
         cOJUguNvsegpEb38aXrKSF28VH2Ig+wzLeHg3QID6B0wIbk+l4j4Couj1Muymjg6yYSu
         b8g/DPY6JtNOHKV+f4byeyFxXb4o1gsQwOLoMEtk6udNcG2UwRW8C65NoHie11JFijGW
         MEhA==
X-Gm-Message-State: AOJu0Yyq2/jl+tbIYjMSYMuolJiZuw9du9qJjbQab4qrEidZESghAncW
	/oj3q4ZOX/LC6rFWEalp5os=
X-Google-Smtp-Source: AGHT+IEDEQZBgWCakwkRkT8r55noIAFs0Ef/ABSeweIOPhM7RCXjN0/RfoYrRDsN3OZm2jx3zJoOqw==
X-Received: by 2002:a05:6808:318e:b0:3bb:d768:b776 with SMTP id cd14-20020a056808318e00b003bbd768b776mr11448221oib.109.1704208906563;
        Tue, 02 Jan 2024 07:21:46 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:66d9])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm10072029qvb.100.2024.01.02.07.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:21:46 -0800 (PST)
Date: Tue, 2 Jan 2024 10:21:44 -0500
From: Dan Schatzberg <schatzberg.dan@gmail.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	SeongJae Park <sj@kernel.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Nhat Pham <nphamcs@gmail.com>, Yue Zhao <findns94@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZZQqCHmocwUFvuTz@dschatzberg-fedora-PF3DHTBV>
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com>
 <20231220152653.3273778-3-schatzberg.dan@gmail.com>
 <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYwPzZ7k=ecFkxaw+26hUkiTODEnmKM8b3=Lk=n+bm29w@mail.gmail.com>

Hi Yu Zhao,

Thanks for the feedback, sorry for the delayed response.

On Thu, Dec 21, 2023 at 10:31:59PM -0700, Yu Zhao wrote:
> On Wed, Dec 20, 2023 at 8:27 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > ...
> 
> The cover letter says:
> "Previously, this exact interface addition was proposed by Yosry[3]."
> 
> So I think it should be acknowledged with a Suggested-by, based on:
> "A Suggested-by: tag indicates that the patch idea is suggested by the
> person named and ensures credit to the person for the idea."
> from
> https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Sure, will do.

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d91963e2d47f..aa5666842c49 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -92,6 +92,9 @@ struct scan_control {
> >         unsigned long   anon_cost;
> >         unsigned long   file_cost;
> >
> > +       /* Swappiness value for reclaim. NULL will fall back to per-memcg/global value */
> > +       int *swappiness;
> 
> Using a pointer to indicate whether the type it points to is
> overridden isn't really a good practice.
> 
> A better alternative was suggested during the v2:
> "Perhaps the negative to avoid unnecessary dereferences."
> https://lore.kernel.org/linux-mm/dhhjw4h22q4ngwtxmhuyifv32zjd6z2relrcjgnxsw6zys3mod@o6dh5dy53ae3/

I did have a couple versions with a negative but it creates
initialization issues where every instantiation of scan_control needs
to make sure to initialize swappiness or else it will behave as if
swappiness is 0. That's pretty error prone so using the pointer seemed
the better approach.

> Since only proactive reclaim can override swappiness, meaning it only
> happens if sc->proactive is true, I think the best way to make it work
> without spending much effort is create a helper as Michal suggest but
> it should look like:
> 
> sc_swappiness()
> {
>   return sc->proactive ? sc->swappiness : mem_cgroup_swappiness(memcg);
> }
> 
> In this patchset, sc->swappiness really means
> sc->proactive_swappiness. So it should be renamed accordingly.

Helper aside, I disagree with this point about coupling with the
proactive flag. The fact that the only user currently is proactive
reclaim doesn't imply to me that the interface (in scan_control)
should be coupled to the use-case. It's easier to reason about a
swappiness field that overrides swappiness for all scans that set it
regardless of the users.

