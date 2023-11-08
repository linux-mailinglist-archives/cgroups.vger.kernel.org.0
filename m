Return-Path: <cgroups+bounces-238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282B7E51BE
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B131F28144C
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F0D537;
	Wed,  8 Nov 2023 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mr20JlNs"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7872D52F
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 08:15:22 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929ED79
	for <cgroups@vger.kernel.org>; Wed,  8 Nov 2023 00:15:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so11157249a12.2
        for <cgroups@vger.kernel.org>; Wed, 08 Nov 2023 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699431320; x=1700036120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FKYvrBE119KQzoa2wyjzJbw+x+PQ+UBi4regXf/m/8=;
        b=mr20JlNsfPdyHm/N3NMaBuUpd9vnUJEltIvlNBpeQ/RDEjXziV+W+aXWM5m/t2nMFJ
         H5qDpykm4dUDTrT4AEVg7BuV6TuTBQI1EN03gL6+SG7WIw23yJLVaX4O13FdKqzpsxZ4
         Wxf5nKo7YIZbVZrZyhC7E52PrBmuJWvp0gLWaiEKTDs4L3LY0fh/0no2SkrYaiQZLk5y
         aoM/7oRLtDxTEoYJhdtty10HKx1lsZgYxHbOzalza/gv9xYrneBKZcvqToVMsBjI6F1a
         FrSlC/ZSUp1tGr4LPKaz1l4KrSFamLEuG/w+RcvGFmcYdDXrLf2FX+OqipuoUwVpAbar
         ueLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699431320; x=1700036120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FKYvrBE119KQzoa2wyjzJbw+x+PQ+UBi4regXf/m/8=;
        b=wrtXyXkA0xQhRw93IevKlw/MoWRaFUt3VU0DRhpZSPQOauFvczyyqLM4sC5NnEvA+i
         gWnnQ1nbgREc8w2wRAEE7118dgWX9qXiDJ4HdVk67wQpOgaaj0Rs/X1U/9G9qQ9s1kLC
         VEGq9N6CFET7LRUS2UshBlfe7PKARA4nFtqw2QcdnzbMSjbkm9sgRNucgBbM2WsZGsJm
         RsgmfS/DTcqOBiUEWzFzWF3Z2eqeq71miA5QLHRVDcq9SNg89CP21Ap+EZfLQCRCN5X1
         bCz5LuEPJNgf/sFZYMv+3bzkbSB3AD9XPm67JKJcv0L7pJ6urWhdSz4Sw0xp10M/K/xA
         a4aA==
X-Gm-Message-State: AOJu0Yz/JqbNpNRLF6ZDQSjwaHhrPCdhDqyabsY/BOejmKSceL1AN1hA
	f6mTRoFOGAZs+JCBr3H049dlC4WAqQ2k/SGDlpWo0Q==
X-Google-Smtp-Source: AGHT+IElW6cSCNI2mjlOLKAQpiHS/RxO47h/3ylrXY5GAAJz8eQxZfAIV+9yyvxvBU6Bp67ABA0MLFRnF34NBV0dtuw=
X-Received: by 2002:a17:907:5c7:b0:9dd:b8ba:1640 with SMTP id
 wg7-20020a17090705c700b009ddb8ba1640mr874063ejb.12.1699431320292; Wed, 08 Nov
 2023 00:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108065818.19932-1-link@vivo.com> <87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com> <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 8 Nov 2023 00:14:44 -0800
Message-ID: <CAJD7tkY2iOeaYfzjRp__kVDyYYK5_KycS6PnMTtudUHghTnZLw@mail.gmail.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Huan Yang <link@vivo.com>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Liu Shixin <liushixin2@huawei.com>, 
	Hugh Dickins <hughd@google.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 12:11=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Huan Yang <link@vivo.com> writes:
>
> > HI Huang, Ying
> >
> > Thanks for reply.
> >
> > =E5=9C=A8 2023/11/8 15:35, Huang, Ying =E5=86=99=E9=81=93:
> >> Huan Yang <link@vivo.com> writes:
> >>
> >>> In some cases, we need to selectively reclaim file pages or anonymous
> >>> pages in an unbalanced manner.
> >>>
> >>> For example, when an application is pushed to the background and froz=
en,
> >>> it may not be opened for a long time, and we can safely reclaim the
> >>> application's anonymous pages, but we do not want to touch the file p=
ages.
> >>>
> >>> This patchset extends the proactive reclaim interface to achieve
> >>> unbalanced reclamation. Users can control the reclamation tendency by
> >>> inputting swappiness under the original interface. Specifically, user=
s
> >>> can input special values to extremely reclaim specific pages.
> >>  From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
> >> swappiness.  So you need to add that firstly?
> > Sorry for this mistake, we always work on cgroupv1, so, not notice
> > this commit 4550c4e, thank your for point that.
> >
> > I see this commit comment that `that's a different discussion`, but,
> > to implements this, I will try add.
> >
> >>
> >>> Example:
> >>>     echo "1G" 200 > memory.reclaim (only reclaim anon)
> >>>       echo "1G" 0  > memory.reclaim (only reclaim file)
> >>>       echo "1G" 1  > memory.reclaim (only reclaim file)
> >>>
> >>> Note that when performing unbalanced reclamation, the cgroup swappine=
ss
> >>> will be temporarily adjusted dynamically to the input value. Therefor=
e,
> >>> if the cgroup swappiness is further modified during runtime, there ma=
y
> >>> be some errors.
> >> If cgroup swappiness will be adjusted temporarily, why not just change
> >> it via a script before/after proactive reclaiming?
> > IMO, this unbalance reclaim only takes effect for a single command,
> > so if it is pre-set using a script, the judgment of the reclamation ten=
dency
> > may become complicated.
>
> If swappiness =3D=3D 0, then we will only reclaim file pages.  If swappin=
ess
> =3D=3D 200, then we may still reclaim file pages.  So you need a way to
> reclaim only anon pages?
>
> If so, can we use some special swappiness value to specify that?  I
> don't know whether use 200 will cause regression.  If so, we may need
> some other value, e.g. >=3D 65536.

I don't think swappiness is the answer here. This has been discussed a
while back, please see my response. As you mentioned, swappiness may
be ignored by the kernel in some cases, and its behavior has
historically changed before.

