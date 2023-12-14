Return-Path: <cgroups+bounces-956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97A812677
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 05:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7491F1F21AF3
	for <lists+cgroups@lfdr.de>; Thu, 14 Dec 2023 04:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78826FB0;
	Thu, 14 Dec 2023 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ7iI1c0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38810A
	for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 20:29:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso40218066b.1
        for <cgroups@vger.kernel.org>; Wed, 13 Dec 2023 20:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702528171; x=1703132971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrJKnh7rQalxBTETxx0mDtTP7C8D7JFwx9paPElxJ0A=;
        b=iZ7iI1c0bscnoDKVDtwt6c43pv5OEWCCzNMHqdJwwZWhs4XPkRWqmhmCMtuogzGclX
         V4GZTR/6x0nTqrcQnogIj+ab8/Tx+y9oGkMZuU5ZDcm+GRuZDQvuIpi+LtSHH5FdfZfk
         gcnl5c+1x4ZSyiW6pwzJ9dLAUdhmChWU1h2M2CcDcYEfE9YJ09Kf8oSfo7Nt1PtogDJh
         h6q+X9l5aG3vgS91hXRqZdQiXxtVir6jSmhXTfiAk0ayrCNck0G5cekK3SkClUU9kVjV
         pB8sT/3Ij6JuHrufjr1UaAiWy5XHUEEwEPzRcKPBzQMwFmunPuUR9ewUYLdbV2ASvLL5
         6R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702528171; x=1703132971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrJKnh7rQalxBTETxx0mDtTP7C8D7JFwx9paPElxJ0A=;
        b=gigV8XeVGseqRVcaXGpXk1rbps7D8ZSWfqsB6TXClVKry5+AmRClix1gF2Ed4R3/Cr
         QaKZo6szNUGUV7DIYQIV31/v754jM+WSvEVUhm2lBxu9BmdXtz0zFT5hFkbxnEL8xdVf
         V9ngJrfIc64RuDRCPQIvP2NegSRgyguLMyAvjgyhbG1JGW/cm3/wabSNZFhSPPPruZ5g
         A1vJzXSbQMNNPvNc9Yhr15waM0LKhG3d8KSqoLtsPyTH4F4XJMcG+khNuE8OPcC1hiKy
         M1VA4rGlh2VZvc+eImLaMilyxFgn+IRQ4yrbsvpKSSX47aVZcqqAG4BogAUiRVkwdBtv
         T+og==
X-Gm-Message-State: AOJu0Yy7s4AxM+NoDXGW14ivP7khCg2siwGfhzulbmi/9fPxC+kKQKmf
	5tyA9F45r/DVNmM+ZDO/Kbj4TB0UbIPgfbECSq+RRI/OIstapLzLha2aYQ==
X-Google-Smtp-Source: AGHT+IF2ysdaKi0/4cWuvP0ESjKBjqyr35uOzZgLtm21MWAnyPwgiig7C13qI6K6cwlt+VbUCfaj23WiFvcTno8KwPI=
X-Received: by 2002:a17:907:b5a2:b0:a1f:6ead:c119 with SMTP id
 qx34-20020a170907b5a200b00a1f6eadc119mr9472498ejc.21.1702528171233; Wed, 13
 Dec 2023 20:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-3-schatzberg.dan@gmail.com> <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
 <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
In-Reply-To: <ZXneCaeJjHvFvecK@dschatzberg-fedora-PF3DHTBV>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 13 Dec 2023 20:28:53 -0800
Message-ID: <CAJD7tkY3t92A2ky4788hNBBZFafNeOjy_F6+E+62mySB5UGYug@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 8:38=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Tue, Dec 12, 2023 at 07:05:36PM -0700, Yu Zhao wrote:
> > On Tue, Dec 12, 2023 at 6:39=E2=80=AFPM Dan Schatzberg <schatzberg.dan@=
gmail.com> wrote:
> > >
> > > Allow proactive reclaimers to submit an additional swappiness=3D<val>
> > > argument to memory.reclaim. This overrides the global or per-memcg
> > > swappiness setting for that reclaim attempt.
> > >
> > > For example:
> > >
> > > echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
> > >
> > > will perform reclaim on the rootcg with a swappiness setting of 0 (no
> > > swap) regardless of the vm.swappiness sysctl setting.
> > >
> > > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> >
> > NAK.
> >
> > Please initialize new variables properly and test code changes
> > thoroughly before submission.
>
> Could you be a bit more specific? The patch is compiling and working
> locally but perhaps there's some configuration or behavior that I
> haven't been testing.

scan_control.swappiness is only initialized from
try_to_free_mem_cgroup_pages(), which means that swappiness is now 0
for all other types of reclaim, which can be a huge problem.

It might be easier to restore a special value (-1, 201, whatever) that
means "use mem_cgroup_swappiness()".

