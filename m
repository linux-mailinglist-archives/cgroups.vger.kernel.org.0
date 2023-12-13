Return-Path: <cgroups+bounces-945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16E8119AD
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 17:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71E6BB20F80
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 16:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8773C364AB;
	Wed, 13 Dec 2023 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzLYDsBP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18688E;
	Wed, 13 Dec 2023 08:38:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d348653591so11433665ad.1;
        Wed, 13 Dec 2023 08:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485518; x=1703090318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WngvNIIdUAOImz6VKCR6KlDDLoKgFI0GBra4+hjHdaY=;
        b=NzLYDsBPHGzS50irHggm2iGtEK3B4zIDR0Bq+Uc0Yv6/W5Tpp4LCsJn1MxEErCUNJ+
         MTgsiDSJzhWpDuEQPfpN2GWEl0GbqzqKUrm7WEpPbByTIXYH5dbReQAi3GXZn0yroXMI
         x2vKWxSDFr0t3xs2AoAdC/odWnsiqbLQvCB5jcBeOoymtfTRgFJF2KXDdvtC8QCasbnN
         NY5Weu5dmhKIhyjxJ165kthOjz3+zoo53I8NB4/vKWfqr8HVE3eq1MczJ4jnhG2TJcan
         BpltIBFY0BsCnL8qP0m+j0GpL4Xr2BQZxQXZ742USicR3YvBQDm7fqhTkE4mvhFSqaXk
         aoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485518; x=1703090318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WngvNIIdUAOImz6VKCR6KlDDLoKgFI0GBra4+hjHdaY=;
        b=K800IrK64mE0Ew6GYDR2t02M0fDrBFg9l3YhTgbY4u5ZoDpuXO3hSCVr5qBSrkfPtK
         2S+ZD2A390ebOWPXzLgfso2TmG/BDvarbPXALl4QsfATc5r0dAqtb/AA0mehgFwpz5Q6
         JGBY7M6gNNxxlf3Zrg9Zyxz8xEjHdcbcDpn6QrZtA78RxQY0jQ5UlRdqIGPGsr4vwJBU
         n+e6QLwICRFy5t3jiHO52WORTwCXIU4HU8zJNTlD+dW0jlAU65GHoRun65VqRU1WkXYX
         BJ2l6vMSxFNkuTLJqyKP2HEzFO85LGNvpnBAPQIhsUElAcD7EMmZ+VvdHE1MW7xyE3BV
         F2Sg==
X-Gm-Message-State: AOJu0Yz/8cQzqNhlXt+njLRzfxGYzsHpxKNtOgWSIXOm+C7NwRklS6TZ
	2QjMegyb6etjzrs82fS6XNw=
X-Google-Smtp-Source: AGHT+IG40cDam0iwIQQ0yixGvC12xVks7Auh91vEMpA9cC4FQkIMzHTpnOC5tJomQzgVmo/Fg54fjQ==
X-Received: by 2002:a17:902:e887:b0:1d3:3768:90a0 with SMTP id w7-20020a170902e88700b001d3376890a0mr3641678plg.40.1702485518164;
        Wed, 13 Dec 2023 08:38:38 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:4500])
        by smtp.gmail.com with ESMTPSA id az4-20020a170902a58400b001c71ec1866fsm10810814plb.258.2023.12.13.08.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:38:37 -0800 (PST)
Date: Wed, 13 Dec 2023 11:38:33 -0500
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
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
Message-ID: <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com>
 <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>

On Tue, Dec 12, 2023 at 07:05:36PM -0700, Yu Zhao wrote:
> On Tue, Dec 12, 2023 at 6:39 PM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
> >
> > Allow proactive reclaimers to submit an additional swappiness=<val>
> > argument to memory.reclaim. This overrides the global or per-memcg
> > swappiness setting for that reclaim attempt.
> >
> > For example:
> >
> > echo "2M swappiness=0" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 0 (no
> > swap) regardless of the vm.swappiness sysctl setting.
> >
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> 
> NAK.
> 
> Please initialize new variables properly and test code changes
> thoroughly before submission.

Could you be a bit more specific? The patch is compiling and working
locally but perhaps there's some configuration or behavior that I
haven't been testing.

