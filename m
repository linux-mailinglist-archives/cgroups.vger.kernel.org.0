Return-Path: <cgroups+bounces-8970-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BC7B17A4B
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 01:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7EB174912
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 23:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58585289E1F;
	Thu, 31 Jul 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcEJ7yDa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AC42A9D
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005917; cv=none; b=FWx/ikKHSFE5F0fyTrxtxwzi3/pWwnARtPuip5QzDF/69tICCB3YrBMP1D1vk8OMA0PlDSM7/xh2rkEXDKLnPwFloCh6szgRHPm/I1UIzBLxUvFg5YiRC2Z6zWOpDVvKWeSvX6vlGwxTns0A1jV9eCJ0rVl4eGN50c4nFnMVUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005917; c=relaxed/simple;
	bh=TsBYoTolo2tufsEqEbhWRrPEmFDJFyPBTlMs+f63jG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmIryd0xbOOPcx301ie32q7OJQAH0Q4KlV1mbgT86XV251fVFoHe+JvOJSn38+BNMUm2R3/2j9zcYN175Esp738vegOOu6x+P83wZ9BKm8nqoe+Tch79skAA6B66frVGG2nmpXXWHkvK5gp9O6DrL2rdFnvUs6pIGj9LwxFF+Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcEJ7yDa; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34c068faf8so1658263a12.2
        for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754005915; x=1754610715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1pY4t9vVS5jlHwuXly55Cv9xSzwUaUm6zW230XbJ2A=;
        b=XcEJ7yDaZuHQjfkq0QrQf1aDe/RHu/DEdpHje7s/wCLKHw2IUPWqOG4Bj5C5ABpmsr
         ZqhFWQxgLkomwIXTOgorIrehdjw1vmdo/9VEKcfg1D6iSx6e2bAytScsvlq2ZMMMjd7f
         PvBfFyDfw+Qs1g7G6wjWNloRYvpBku8sE7ddLjA++gnCI+OzhAhBO6rKScl0qPg4lvby
         rcUPeUzv/57PO99ZOuLiIa2xQRLJkgM+9Z5+mABlkNNIkpZczSMsCCVXTEBUC7aA+mVc
         lBC5m7vGTwf2eAoFGGg9Yqao8MfeK0xIsqJ8w07vbSxGcWX8CwmP4OWTlqIQg8/6Lbia
         b7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005915; x=1754610715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1pY4t9vVS5jlHwuXly55Cv9xSzwUaUm6zW230XbJ2A=;
        b=WMD7GkfGrjLnyj4EX7P3su5KmpY1akzweZBU4opcgQcBiF49ZMir0dvXGisGoK810E
         ADhIjV8ApNCKeuL2SbLjBsSla/qb8uzc2WyXWmTxIClDggaqmgMU0tM0fO7buBTV0Rpt
         vcUm42I6ik1ZPIMga44NGoJ76CG8LvbppIsHcNB1HbwMqyfazoTFdl4OTNAvR8psAIUn
         P+8Pyh3XPvIjDjiver9NvS9fQdscLz4oD/aaVySedribrER0iwe/MPaMpr+spwjCG2Yg
         wadc15OKizTILbMbTXIeuzANmKbL1kAoMn4yPRANsY4eWEa2Vrxa0U5i9lfokprxrE7E
         IN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXw9uLzts3+Qg1kGddez/C7Xo0zHSG6KJ0zkQdTZQTInxsMjGh5S1aACejxqnvEx1YPFlBeZWSH@vger.kernel.org
X-Gm-Message-State: AOJu0YwCo0yVk/0pPL6Od3tY/S3Bm/3PkSPr5IHaDF1dk3MEyw/lTHyb
	UnXgehhf6x8lH4564FComPD7/7cM9wBsg4EITvIksvyRy8idKcI2hvu2cIC/U3zpQjhU6UyvOd8
	KQmlWPGTJXsbmYIVoVGj3Jpx/eItRiIyOn+H876zQ
X-Gm-Gg: ASbGncuSam9Ua1D8THn+NpH9W4B6IV8iN0MvRGKeFZ7FRdbZxFfkMe1Z/7LaOwrW6up
	CCIws225fPPuP8EoVh3+ybwqFND7da/3d2ibQ5GTo4pMIJ6mp0QZ9GA7guPlJmQBhKwXrCg/jBR
	rX780KF0Y+UAAcW/wTQLnKrSRlwTZNPB009985olxJ+xhvybHg8SXxhssLEQEiAS0pa2CN4V5tJ
	CPM5PwfosDkHVI43ecm2UH5xXs3KGDbSICUIpwo09iRlJRw
X-Google-Smtp-Source: AGHT+IGMdr5+ZltYc/B0msRqSn8S05vopIUSrPrZpbCyE1ibrXKKkFxzUCv9+aOryf0B15tqU6r7DGOpYwl+1TOpJ8U=
X-Received: by 2002:a17:90b:3952:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-31f5de4197dmr12628654a91.19.1754005914820; Thu, 31 Jul 2025
 16:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
In-Reply-To: <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 31 Jul 2025 16:51:43 -0700
X-Gm-Features: Ac12FXyRo64aj2tAOXgVRHN2Olp9-pPfFQKxGBKy5bgLlQjCQOCZQOdKisc5o28
Message-ID: <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:39=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > Some protocols (e.g., TCP, UDP) implement memory accounting for socket
> > buffers and charge memory to per-protocol global counters pointed to by
> > sk->sk_proto->memory_allocated.
> >
> > When running under a non-root cgroup, this memory is also charged to th=
e
> > memcg as sock in memory.stat.
> >
> > Even when memory usage is controlled by memcg, sockets using such proto=
cols
> > are still subject to global limits (e.g., /proc/sys/net/ipv4/tcp_mem).
>
> IIUC the envisioned use case is that some cgroups feed from global
> resource and some from their own limit.
> It means the admin knows both:
>   a) how to configure individual cgroup,
>   b) how to configure global limit (for the rest).
> So why cannot they stick to a single model only?
>
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits, especially in multi-tenant environments.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and a single workload
> > that opts out of memcg can consume memory up to the global limit,
> > becoming a noisy neighbour.
>
> That doesn't like a good idea to remove limits from possibly noisy
> units.
>
> > Let's decouple memcg from the global per-protocol memory accounting.
> >
> > This simplifies memcg configuration while keeping the global limits
> > within a reasonable range.
>
> I think this is a configuration issue only, i.e. instead of preserving
> the global limit because of _some_ memcgs, the configuration management
> could have a default memcg limit that is substituted to those memcgs so
> that there's no risk of runaways even in absence of global limit.

Doesn't that end up implementing another tcp_mem[] which now
enforce limits on uncontrolled cgroups (memory.max =3D=3D max) ?
Or it will simply end up with the system-wide OOM killer ?

