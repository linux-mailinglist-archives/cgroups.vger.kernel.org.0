Return-Path: <cgroups+bounces-917-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EA880F630
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 20:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980F71F21802
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB918005B;
	Tue, 12 Dec 2023 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwK8wiEl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD316AF
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 11:11:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d34ae77fbaso8495ad.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 11:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702408307; x=1703013107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIguWzkvYltOpnG/cXi7wP26kF3E2cDcptp5e/K12Jo=;
        b=XwK8wiElneYQmXQCEI0uagFXqXTIlXCPeUtQPeaRulax3ajANE6SN0FXuG42DyxADf
         JYqTdjFPcfFfy3mRXtoCzp25wPc2BgTL+qU6d2O6gUxoSTm3tv+Zdhur1hHVXEDJBldN
         crPO15PNVePWr79483AfOJlHCGunkos+Uj5p/6F4++YXIK1+Q4xAPZg5Gg+s5RAsSv8O
         QvhnRRBesVNHPsSusITfD3/GJnm5bRsItDrOp8Xe8I01SU/i58AO6UjsLK8yS8wNGXsC
         suCZ03qz1Gx2Fr3cF87WR6fOQIwMidtHGMITWJcgImiAPHH7P+hOJVzHIGko04zPMFCY
         JCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408307; x=1703013107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIguWzkvYltOpnG/cXi7wP26kF3E2cDcptp5e/K12Jo=;
        b=HXYy0ukSJqPrw24AHdKX2CAFQOZ9c8KP2RwHNSpY0hCWer4OvCCE7zg4puU8V1YvBJ
         iK9dw/M/f8kxN2OKAmwPE6PPNInNDmbdxQaRU/ZSwTj4mo8oK2QQZLW3W+09vJs/2n7f
         hDdQgi1ELt2uILGAFJzqvva6uTR6heMddJJCK9avpWXdEeDBOWKIoEHugHen4/SbyOlg
         5mSin505Tee/VbWetRELMUcCb3WdUtPno/Sz2OkwFvlBL9RThOSGL9QxcBTVVIWWvAH2
         Nz1BgLvTDWY26z+tsHF3NjVL3KNLyZg4GVDVN0YbkDWx4skTBKTfgp1kNiTsCUFDA2+l
         KWjQ==
X-Gm-Message-State: AOJu0Yy2CqkKDPFGXj83pblLPNaw4CqlSa8dO54Jb5J9FpYDxImKH3Mb
	BWHmHpM6zQTNmFMvamAlKwpAGGYkaLfzpsWfmROP0A==
X-Google-Smtp-Source: AGHT+IHt0Qmog3mUK5T+kUE0Q2Kof6YqrUXeTpM7Ux6Zk+sJp0dumG1J+s5VjauZ8OeIU0gS8MCxg1ZOOAnY4ZGrZCw=
X-Received: by 2002:a17:902:dacb:b0:1cf:aa8f:56b3 with SMTP id
 q11-20020a170902dacb00b001cfaa8f56b3mr896582plx.24.1702408307029; Tue, 12 Dec
 2023 11:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
 <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
 <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
 <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
 <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
 <20231204235856.k4izppfsrpg2rng7@google.com> <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
In-Reply-To: <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 12 Dec 2023 11:11:35 -0800
Message-ID: <CALvZod6LcJbAQYpV6jnX=tWbJe-4i9guAax1E71gG7Q6OfVoBg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Greg Thelen <gthelen@google.com>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:43=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 4 Dec 2023 23:58:56 +0000 Shakeel Butt <shakeelb@google.com> wrot=
e:
>
> > On Mon, Dec 04, 2023 at 03:49:01PM -0800, Yosry Ahmed wrote:
> > [...]
> > >
> > > From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 200=
1
> > > From: Yosry Ahmed <yosryahmed@google.com>
> > > Date: Mon, 4 Dec 2023 23:43:29 +0000
> > > Subject: [PATCH] mm: memcg: remove stats flushing mutex
> > >
> > > The mutex was intended to make the waiters sleep instead of spin, and
> > > such that we can check the update thresholds again after acquiring th=
e
> > > mutex. However, the mutex has a risk of priority inversion, especiall=
y
> > > since the underlying rstat lock can de dropped while the mutex is hel=
d.
> > >
> > > Synthetic testing with high concurrency of flushers shows no
> > > regressions without the mutex, so remove it.
> > >
> > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> >
>
> I'd like to move this series into mm-stable soon.  Are we all OK with tha=
t?

OK from me.

