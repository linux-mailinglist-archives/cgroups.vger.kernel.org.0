Return-Path: <cgroups+bounces-8856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CCBB0E072
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1301C82689
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5522A2676C2;
	Tue, 22 Jul 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6AY6WIk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474A263899
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197878; cv=none; b=Z8/1TzJR0F8X2/HMm6hICi0RM0aTBySmODygY+UqhuWMGRGouOpOMEpXmc/y/S4ee+Bkg4LLk+SN13cjHq6MjXBOrU0n6pIgAAKA+RnIVCVcgNyzXEyOTyQreCVwqvRzJa1bRPP0+zS7N5k8gVO5eC/UOKJy5unpPqARz2upFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197878; c=relaxed/simple;
	bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOXP0CqGNUytjEPppzo9377G8oQ95F6L5RhybI7TtrBGu/p60jVPf4lFGebERui2Jfp7HvQqzGHNlJhvMTXxbjzRSgyeIZpmL7mSIyxFPrpBAmZfHtwen6vNu3oJKsS2nqub2TyO73zyQO/gaSsnUACU+OhUcMzYqnkjOspINkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6AY6WIk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab81d016c8so77987671cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753197875; x=1753802675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=J6AY6WIkYuozsulcwA+OG++HiPMxHiwi5GZpVV15L5v2xxDchNcbm4D1RiusAnr/K+
         8XUL+tNpSiL2UEaFqnmf5uf8zNFlsCvCLrHvXIR+Gdu+e/gZwEaJRDWqnGDP1ldgGdXo
         YiC45swlwO77lgubGT+xVxK6ilEFg/aND3suJ/vE8ATTkNcXmR83vovvEAsE7K5chqTK
         dyW+/2VGa6DKNs4EYzBxD4bIf3MLZUb/oXfuU/Q807ucc2E6NZLwGwQwApwFSEYA/bHT
         8A5I19hQjAONyRk87u6kVNQSPZzpsDsuWWzLfiW73sVXRuheUTsmAnbGxFvAapBWl7Vt
         OrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197875; x=1753802675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kV049ZvyH8bug7lCu3rLwoNDHgKCSKmx4BYFWbO1B34=;
        b=tEqyZA/Lz3su9Sq9DQpRED9eL4swNf64vvlApaUmdLHcwZmb7oS6gTQc/z7Om4Zzzj
         /CaQFcEok4W7LT0p5B6t6a+dP6fBYUO0RoV3dcglIOv92WYFydUSdAyUH+89T88+yP6u
         wkQj4xQD9DGW0hslHMz+gISqIJ83iVyU+RrFgbFpR+dNZOwz2OpjDxR1Fl+t5RWt+lJy
         Dspg0pT88fz1FAgROp4qeiPT8xRrkBOQkRyQg+ATYRjt8Udy0H8DpUdGzW1RCbGrM/Mn
         GcdkONXcJ9cbAXypFOGDTxj4216hxAxLXXwi+2o6/WPJ4/FZmqn9YH+PeVQJ7C7HI00C
         f1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYxj1fvKsYweHYYDCA0+qpKVGpdWP8XjjDBtUqsA4uky3Yeluy+q5QDp3K06ICIUou/RO8xMol@vger.kernel.org
X-Gm-Message-State: AOJu0YwwNEwQ+uXg5RkNeba8I7n/p0fWTGhS+ahnwwlR+FWWkS40ejle
	ebYwJKsEb/Oj5roftlHAPthQiASO7rs752uuaQT+2MUbJXOUxYaOSP9+MZ1y/yoNzg+Hcn/abgD
	OklvCTcrUZN2HAALXprPZXN+b2XGP9yGTm6PVwIeV
X-Gm-Gg: ASbGncs5jtpH3KN5P/Z5sF1/u6sl80iKw0bqywVIDpWHqaIiQ6RRVFZTRD/Jdz2T41b
	ZTdMjsE+k3+9HNjp5kkT7Gpoiv9DZbL4LPdfvbD642pc3pDuFe7PTrFaPtRFuYffmMChvrPB5f3
	ciSEAoe3AGYlepCpgX70+98Rt4M4b4wVVXcZ/rdeKu/VVLK7E60IalM9WTOFs+YR6mL85ivH80H
	q6mTQ==
X-Google-Smtp-Source: AGHT+IGNqove+d9nqBnprWFval+F465BdR48MaFKPBz3i7+j2sNb0kdf1AFXSoxhiABjI4x2NGpy1yAogO5YUQ5F9ng=
X-Received: by 2002:ac8:5a0e:0:b0:4ae:6b72:2ae9 with SMTP id
 d75a77b69052e-4ae6b724070mr1666271cf.43.1753197874316; Tue, 22 Jul 2025
 08:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
In-Reply-To: <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 08:24:23 -0700
X-Gm-Features: Ac12FXwavIrX7g0teLwhtLsjBkoK2NrttJzG5Br2HWJz_qCsAQMuVk1ahKeyT1Q
Message-ID: <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
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

On Tue, Jul 22, 2025 at 8:14=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jul 21, 2025 at 08:35:32PM +0000, Kuniyuki Iwashima wrote:
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
> >
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
> >
>
> Sorry but the above is not reasonable. On a multi-tenant system no
> workload should be able to opt out of memcg accounting if isolation is
> needed. If a workload can opt out then there is no guarantee.

Deployment issue ?

In a multi-tenant system you can not suddenly force all workloads to
be TCP memcg charged. This has caused many OMG.

Also, the current situation of maintaining two limits (memcg one, plus
global tcp_memory_allocated) is very inefficient.

If we trust memcg, then why have an expensive safety belt ?

With this series, we can finally use one or the other limit. This
should have been done from day-0 really.

>
> In addition please avoid adding a per-memcg knob. Why not have system
> level setting for the decoupling. I would say start with a build time
> config setting or boot parameter then if really needed we can discuss if
> system level setting is needed which can be toggled at runtime though
> there might be challenges there.

Built time or boot parameter ? I fail to see how it can be more convenient.

