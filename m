Return-Path: <cgroups+bounces-8206-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E20EAB7BF1
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 05:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FC718946D7
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 03:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C154B1E66;
	Thu, 15 May 2025 03:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUeCSdok"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22BA27BF84
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 03:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747278142; cv=none; b=GSka+UGZi5UAf2A+/7MWb90j1zEYFjIDtdisae8s9ntG1QFwyErcFEtMiQ3TK/7YrKlg+BV8GPEXr9vx5mxoX93FukRHgiamph7E+U1NEB9hwHNywHtafWtyWRmecrj4j4A5TbYX4P91WTWUA6+My1rrifFapyA+jH2RVbJ/Kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747278142; c=relaxed/simple;
	bh=86XbXvTLz8UDUISxlcsp2p/PExbaUXdKcv+lnR4Z9Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0nyJmV2EF1tl74um0n+PrpBMW8QPCGZUD0ZTcTC09lyNjkAd2xh9cv/DKi61/dkwFZZb5c/8dCoOpdxiaRYxzIZyYYfDhbrrdhoYK+BSLIoumjIF7npn9ZKDoAehg3ExXaU0bRL2eMq5iWEcuvaJgpRWT/QPOPskGrz40U0Ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUeCSdok; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so984191a12.3
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 20:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747278139; x=1747882939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86XbXvTLz8UDUISxlcsp2p/PExbaUXdKcv+lnR4Z9Ug=;
        b=PUeCSdokaF4F38qvszonMbHeMzg9ODvEkUYvgazn60LqNnQnrglP99+KkqAAE28nbJ
         aYgTh6dFJGeaK+lUlUcDZ+3V3Sc045mxjq+OH7r3hICvjmoUTcr6kQFJVyBM13dyetvt
         vj8rjFQCEis9n3ElugH8nWglI+yle+hi0v/28jTTn3yb/nD3Ueohv8wrWIO13TLgwEQu
         9WOqCJmtjH7e3ROkW6WaHtZj1FnnMhyJNoVN4VzSts5kS3VA/xnMlQzdhAo7DlPQ9KDl
         qwqSPDFTTk6DgjQ2/lxm7q9rQh52+pCZ62jPofG1gmrep3SknwdAcKqBjXPGHPbasuvV
         x1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747278139; x=1747882939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86XbXvTLz8UDUISxlcsp2p/PExbaUXdKcv+lnR4Z9Ug=;
        b=PpzZHzDrPiyI7OCGqwA8C3OXuPZTFSNUgEkzMsowvocPQv26xvTKwlkFx7PJa5SyyW
         j7xOkw2QhdgZItzCNwH48pN64bCQ6mTUkEtb+5YWXDpC+FpdFF0n9nulx8HPaiwAaNCP
         wRe56ctnl2nRTbHjStgRhi3YbnfsIO8xeKmtGKkV2OpDYcR4FfBBouJDp+znmyFaeziu
         l/117rUemxQvzpm4Rbk2yLN+PH6dXr0dNZ4aTCg0Iu/xgPO/EnHHlwKB6J9qMg4G6Q5X
         6l38/ZtxDF1dv3KRp1BJskvadpuaEOP74YRsRpfJIHFbCjaAZCQoK/RLz+W8tLyyXpdS
         RFGA==
X-Forwarded-Encrypted: i=1; AJvYcCX0OQSCP9rBl2RGV7P2IDI79ISFiUXKapiYfmsQCy9IRAkGVn+yD0v5ES7740JzZOKF1m1SMDzE@vger.kernel.org
X-Gm-Message-State: AOJu0YzETOPtx+nr0yi9uS+7pyJsZbH84Gr6JXvxCShlxD02R1cgz8tr
	IyD6TsTQ0U/RBnNe2yxMGePPnWr7RrPu0DQJ2hOSalqJY2xTCEdNSBybQRR8jm3pukKyw/kg0dY
	o0sq7ffVt3H7jOYqfPsX9vYhsrdY=
X-Gm-Gg: ASbGncvt7ckpcNqrOZNCUSLVzyUEAhh1Go3Wz+cPcELdMlRzUYpTI6aC79owv6aGdo+
	61bu8FmRLocmjoYvP9gPPV1So1+BjuPJgmx9Mr/uvEzdSJOrdcU8HTAS4dmuq/ha5fV/xQRnSXT
	HNWOCnDVtghRnADDFgS0nsnLuN98OkFamr
X-Google-Smtp-Source: AGHT+IHmHCtGkDKttyJYJP7nyhj7N2BAS3mMwXtsLwVd2476Wp7qLIklhWa5dLJzilk4UQF/RAhFy5inlK0B96f5Ego=
X-Received: by 2002:a17:906:730f:b0:acf:b9bd:300b with SMTP id
 a640c23a62f3a-ad4f70fb961mr525124366b.11.1747278138894; Wed, 14 May 2025
 20:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502034046.1625896-1-airlied@gmail.com> <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com> <20250513075446.GA623911@cmpxchg.org>
In-Reply-To: <20250513075446.GA623911@cmpxchg.org>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 15 May 2025 13:02:07 +1000
X-Gm-Features: AX0GCFtQ8ZvmRW_pqvYiNr7wclW0HCf8f-YoFeASKT106nOB_Wm8_IwXdZtQM98
Message-ID: <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"

> I have to admit I'm pretty clueless about the gpu driver internals and
> can't really judge how feasible this is. But from a cgroup POV, if you
> want proper memory isolation between groups, it seems to me that's the
> direction you'd have to take this in.

Thanks for this insight, I think you have definitely shown me where
things need to go here, and I agree that the goal should be to make
the pools and the shrinker memcg aware is the proper answer,
unfortunately I think we are long way from that at the moment, but
I'll need to do a bit more research. I wonder if we can agree on some
compromise points in order to move things forward from where they are
now.

Right now we have 0 accounting for any system memory allocations done
via GPU APIs, never mind the case where we have pools and evictions.

I think I sort of see 3 stages:
1. Land some sort of accounting so you can at least see the active GPU
memory usage globally, per-node and per-cgroup - this series mostly
covers that, modulo any other feedback I get.
2. Work on making the ttm subsystem cgroup aware and achieve the state
where we can shrink inside the cgroup first.
3. Work on what to do with evicted memory for VRAM allocations, and
how best to integrate with dmem to possibly allow userspace to define
policy for this.

> Ah, no need to worry about it. The name is just a historical memcgism,
> from back when we first started charging "kernel" allocations, as
> opposed to the conventional, pageable userspace memory. It's no longer
> a super meaningful distinction, tbh.
>
> You can still add a separate counter for GPU memory.

Okay that's interesting, so I guess the only question vs the bespoke
ones is whether we use __GFP_ACCOUNT and whether there is benefit in
having page->memcg set.

>
> I agree this doesn't need to be a goal in itself. It would just be a
> side effect of charging through __GFP_ACCOUNT and uncharging inside
> __free_pages(). What's more important is that the charge lifetime is
> correlated with the actual memory allocation.

How much flexibility to do we have to evolve here, like if we start
with where the latest series I posted gets us (maybe with a CONFIG
option), then work on memcg aware shrinkers for the pools, then with
that in place it might make more sense to account across the complete
memory allocation. I think I'm also not sure if passing __GFP_ACCOUNT
to the dma allocators is supported, which is also something we need to
do, and having the bespoke API allows that to be possible.

Dave.

