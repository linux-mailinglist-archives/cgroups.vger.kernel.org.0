Return-Path: <cgroups+bounces-933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBC68107F4
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 03:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E0D1C20E3A
	for <lists+cgroups@lfdr.de>; Wed, 13 Dec 2023 02:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DCECE;
	Wed, 13 Dec 2023 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/PYG8LC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC83CF
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 18:06:14 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4258b6df295so166031cf.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 18:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702433173; x=1703037973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w1+yfAr2SPzVB4dpYvx6YaKAjN+fhfuOqchPg5V3ac=;
        b=G/PYG8LCOvc9QQHCceMnLZDqLs9MpWjTZ0PC84E1dM01lSAK2XCB/tQ1lj8oyXfVjv
         60R42JaFPPlFKDwwS3Y2DrfxHgE651pHMIyFTSonTgfXjdp9MRgIpIzq8HIGru3Hohv6
         OgiTzefahr7uAlaUARWiOYJx/IxtibKhg9C1CsSV2QzMVCVU+KtW9EAjKfJWDyjI5CFU
         5DzUxwTluj3PHQsCuisrfyD71XFgdKSUq9gaFmNi0V4ZwBan5HIburBCx7VkdjnZ/TnA
         5fQQd8F2lwOAZLPAMWi5nqst9wT8SLlPzhAV14Jga3v0rUVqKG62yHnGjMxhM63QX4Yl
         dXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702433173; x=1703037973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w1+yfAr2SPzVB4dpYvx6YaKAjN+fhfuOqchPg5V3ac=;
        b=sTi2pdOIu+yYWva/TLnv+HK+GIZ+AR35dOSnOsdVPDC6raezO7MWCxALkczxmUbzvF
         FrBwJEUdrn8/nd+7jT4krkkjtcA9auvtLZLPRoliMCti9FVTnq+iyAijLYXlJzEMS9f5
         5rlAHlx19CKl4BVt5ZoIQC/asxvZPQjJEhDJ5XVKJ1VwvZ950kpOx+yUw4+h60upyVUH
         qYsYgsdKaHKi5MDbgxsugdvJiJCJ6zvDOzJubIccwuKKc+jDpOulnmqAQw+XYKwgGC3J
         V+ZrpaOEwoLI+XwA1OtHRs4U9FiQOfiS8iQHyBelI5TBHijfKgFkgCRhtabd3Ngszdj9
         3HfQ==
X-Gm-Message-State: AOJu0Yw2De2fDpTg2nzKL82ndlFrFSQ7tYihRaKpav/C6RgjHhMnqyaM
	PvDBgl0+IeQ8vnNii2orPSzADHjRxG97CrVtbdNgZw==
X-Google-Smtp-Source: AGHT+IG3y4UdjpV0X9gFbF4eOb8+BdZkR190RHWRGUNro5VSrV3slPFDuCaeH/KRi7c4WLSMSpvCPYZ95Vd4vDp2clc=
X-Received: by 2002:a05:622a:303:b0:41e:36cd:4284 with SMTP id
 q3-20020a05622a030300b0041e36cd4284mr1355674qtw.6.1702433173482; Tue, 12 Dec
 2023 18:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213013807.897742-1-schatzberg.dan@gmail.com> <20231213013807.897742-3-schatzberg.dan@gmail.com>
In-Reply-To: <20231213013807.897742-3-schatzberg.dan@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 12 Dec 2023 19:05:36 -0700
Message-ID: <CAOUHufarKA5-NGErYzvqeKKJze1XSUcMx4ntBHx2jmAUeqAioA@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 6:39=E2=80=AFPM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> Allow proactive reclaimers to submit an additional swappiness=3D<val>
> argument to memory.reclaim. This overrides the global or per-memcg
> swappiness setting for that reclaim attempt.
>
> For example:
>
> echo "2M swappiness=3D0" > /sys/fs/cgroup/memory.reclaim
>
> will perform reclaim on the rootcg with a swappiness setting of 0 (no
> swap) regardless of the vm.swappiness sysctl setting.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

NAK.

Please initialize new variables properly and test code changes
thoroughly before submission.

