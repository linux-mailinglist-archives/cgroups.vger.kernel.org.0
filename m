Return-Path: <cgroups+bounces-918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6980F80B
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 21:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555E3282087
	for <lists+cgroups@lfdr.de>; Tue, 12 Dec 2023 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B33464133;
	Tue, 12 Dec 2023 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFusca8X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0ED9B
	for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 12:45:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a1ec87a7631so550666566b.0
        for <cgroups@vger.kernel.org>; Tue, 12 Dec 2023 12:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702413901; x=1703018701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kE8RZVsLlDqV/tHQsV0pBVubgKNBa3FvWZVPRZsHSAs=;
        b=LFusca8XEG6vrc3V0kseEDVsm0MbUCjDN0LEI/ctRNOu2pVNuRhQOWy3mZHsoa3t+I
         adrd2ru3IIB+y2uQMG1rHZVp/l1KHFDF5Z++MoHSE81mkunSvf4gENnnlT27Jwpot/RG
         dEZB3MM63a1laGc0nDLEaUBqKz97rcHNwTYP8ZbidsVeRO1LjOuVLzIO2U6S2fyxRLiR
         YctSEuzLUuvrJvn64LY/3uKRMNmI72fF7yYRvyL3jDSLbR+6nLjSr3Olat/YtcT7HZtz
         iXKMU+eBQCN6hq1U3t5cOukwJpQTTz6x73eLXqQD2lnCRsOvjStapkMc8XRPm1mmYqJI
         1Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702413901; x=1703018701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kE8RZVsLlDqV/tHQsV0pBVubgKNBa3FvWZVPRZsHSAs=;
        b=nn0wLf1jknYk5R9xiPzulpRnE4iFh4xyQWs9RNlQ/vnDEzpA4gu5kraMukvhl790Md
         qDFo6xodnLaA9fYzrMRTCNrtX9Me+em60/J42qrWafy1zkKajRqPR30AE8vGT41amwQm
         +pO4eMGYpf4+s+JweIO89qYJUIaDswyHzwYw/OtKap/kSV83f17DJux9aCBKRGcE3uSM
         BjAo4xt9pEqqz8ujMNySBgiUuC5eNnzRjhNhZrbwQb7W1nBujIqP44wBgExH8db91brM
         P6q+DCf+m/rWPQyNSchiFRwsPeIc8u7J84zEQs+A7MDIvRjOQ8K7n407tLj94V/5+e9h
         /HMg==
X-Gm-Message-State: AOJu0YwWvP8GIotdUFgxDg2hcO3wVL+Bf1qx/ZGS1xvbmuXExk4Fijb9
	N4erqs9xRH2kgVgmnwyCRI5l/YPYd/Kfdf61c+byvQ==
X-Google-Smtp-Source: AGHT+IFAT5lsVwBH0E1qAd8i6cYOV214omt1/uBJz3rz4Sjo68LKbG5FT2JF7Tj9rLm3fl0eLDj2fJFUKGMgaDUislQ=
X-Received: by 2002:a17:906:5992:b0:9da:ee00:a023 with SMTP id
 m18-20020a170906599200b009daee00a023mr3752550ejs.30.1702413900702; Tue, 12
 Dec 2023 12:45:00 -0800 (PST)
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
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 12 Dec 2023 12:44:21 -0800
Message-ID: <CAJD7tkY-+2OzncG7kK=rkw3sAK6oAMHkoZuv8+vnxmt6N3ECgw@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeelb@google.com>, Wei Xu <weixugc@google.com>, 
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

Looking forward to that :)

