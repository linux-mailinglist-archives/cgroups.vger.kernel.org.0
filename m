Return-Path: <cgroups+bounces-8857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB760B0E08F
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02401AA2C5B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E6278154;
	Tue, 22 Jul 2025 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOiQZgSt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360927815D
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198456; cv=none; b=qyKpYACHRCFGC3v2L2wLwn8soipQLLNOzvj2e8vyNIVo/AZIW0SoWQckS8m/2achg7ElH1n7J8zodWlDSTxju1e1EHCZqAhw3q/CDGpVewc+YbyT640fUE4J0EMXYkAwvgdRyb6GfGmJJPSWrvNtEi3UyV6KkzxhTqI/mPyAzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198456; c=relaxed/simple;
	bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkTf2a+XbTradO7qLawZkwkllwOHk/Kunc7S+t+ixzPmihCtfYA/9IU/zod/AbCB8JA4dz5PkJYmsKE1+ZtvIdTdmHQrxsycxAntX9eD60clRh2R68PH8SzH/m72Nq+ES3x7/2VGUon3tqS6iVht69Pr2PwBE5DxlY8rzggM4hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOiQZgSt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4aba1bc7f44so37371cf.0
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753198454; x=1753803254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
        b=sOiQZgSt1cxtf3sU73R3MoUBw0Btp7mx41W4G2hBu+N/t3FbCvZsLroNL5YNRvjd+P
         VA02EnuIu+Er+03JqtNZH96LQNsr8FTcCzrSePhOfQ7ur2EBU8ksVbXa8yzhB3OWh1dw
         H/5yuZjFS46Y+ibg6PQjXdV7geG4PjXPsrsWU81V7XjfWkqdaqfitKuqXeglsCI3Sy4s
         6zzYKRYmzBRRxCaV22/rcC1s2za2wImZeiy8fHUIu0EL8eyFkVnu9X/Zo/N/veAnr1vw
         E4LBilU07paWEQBPahghEzKjxU8KiEqLGp2EI05Gpvtixre1zL4e5qUK915snOVJLa/u
         rDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198454; x=1753803254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6huNDu8PBiF4Td2REk21Di2p4ZXL2OnE0DDZsCTZnFE=;
        b=KPWAwt61b0jlGf9pRrqe5Q7YI5a95afjVT/8N6/I1UsaTNuOs523N4D7iwCzOfEEmJ
         ahuXogmK2jRk03XYmowBRh8r/t8F8OS7NFHHCd5LpIVvyRDvlsoTA9676LMNjcFKO52N
         LTDhQMqVPUCxZ1E4LxorOVrtjdTA1eQgJNAZZ1oaWiKCQzcdn/RoC9QahE2s48bTV+bG
         RRpXIiQd3feI5qZKAmmXQfP4Ekmaz3vfZDQfbZcxv/Ia2v1MM/a7kGB8zhuS7PI+bDjV
         c9weltc/+D5uZA6ylcmOSjmZbETaEjZ5my/Dv7iofQnul5dw3qdlM9Qv/OJETTHJHH+y
         pOfw==
X-Forwarded-Encrypted: i=1; AJvYcCVgbjCvAKNohn3MCLSIwMLwZIsS/QZ3aW21HLaqnFZJ0V1OZUwMuZey2osAGggxNaTgpO4CLEc0@vger.kernel.org
X-Gm-Message-State: AOJu0YwM91xR/fVhnBSQpoDvKRnj+GtzwpJNvIY5uoroQzB7Glt//GT+
	GmWyP1hJi2Pg0sgJ0sxEmebTRaOMCk4x2X+nd86kNxZs1ywOlTT9JxGCtSPAh5ZZ8fItSwkftNn
	Usa5aHCVSrN63S7x+4HEyN3qptdVZVFBfAOLSr5+I
X-Gm-Gg: ASbGncuBw2dwR3KRIdot6ikgmO7hZc327jzakV98g/3B0vyotuCWYxjGIDu3iYeXDgI
	i7KHXjzC9S2TE6FGoomyNPFafFKEGHJ3RFpYRTkk28BGRHwpp0F3m+FcpS1kklO/4JxoxcYKcuw
	NzMcrlc45ar2ikE+zkNGHyzG7MQQz596iCh+ojfS2rqJTg+L0VZiDsof4VWP8rDHJrixrd1p5BM
	OoD8Q==
X-Google-Smtp-Source: AGHT+IHT/XoMTVLR/CLnQtYrPx5F5saubWGu+acQeXgnXHryN0gYdGmeEzUDX46mVUnYlwqL4F5dGGyi/ToV0NINlD4=
X-Received: by 2002:a05:622a:549a:b0:4ab:c0d5:6f63 with SMTP id
 d75a77b69052e-4ae5b68cda6mr48360891cf.4.1753198453672; Tue, 22 Jul 2025
 08:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <vokpyz3p5pbv7ja4ltipxapq4xjemqmv26gayezeekcyq7llyq@6kahz7tldhfz>
In-Reply-To: <vokpyz3p5pbv7ja4ltipxapq4xjemqmv26gayezeekcyq7llyq@6kahz7tldhfz>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:34:02 -0700
X-Gm-Features: Ac12FXzA4jvGkBqd2_ryawomXPZvKp3tJLaT4sW3pMPuwr_h2pU1RQnRsS7pTbc
Message-ID: <CANn89iK0zqP0OYa4S=5-X4seUG6wAsK+-qGEpbpXQgSzNJQaog@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg from sk->sk_prot->memory_allocated.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 8:04=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:19PM +0000, Kuniyuki Iwashima wrote:
> > Some protocols (e.g., TCP, UDP) has their own memory accounting for
> > socket buffers and charge memory to global per-protocol counters such
> > as /proc/net/ipv4/tcp_mem.
> >
> > When running under a non-root cgroup, this memory is also charged to
> > the memcg as sock in memory.stat.
> >
> > Sockets using such protocols are still subject to the global limits,
> > thus affected by a noisy neighbour outside cgroup.
> >
> > This makes it difficult to accurately estimate and configure appropriat=
e
> > global limits.
> >
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > can be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > However, this assumption does not always hold, and a single workload th=
at
> > opts out of memcg can consume memory up to the global limit, which is
> > problematic.
> >
> > This series introduces a new per-memcg know to allow decoupling memcg
> > from the global memory accounting, which simplifies the memcg
> > configuration while keeping the global limits within a reasonable range=
.
>
> Sorry, the above para is confusing. What is per-memcg know? Or maybe it
> is knob. Also please go a bit in more detail how decoupling helps the
> global limits within a reasonable range?

The intent is to no longer have to increase tcp_mem[0..2] just to
allow a big job to use 90 % of physical memory all for TCP sockets and
buffers.

Leave the linux default values. They have been considered reasonable
for decades.

They will only be used by applications not using memcg to limit TCP
memory usage.

