Return-Path: <cgroups+bounces-10819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A5BE18F0
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 07:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 48F0A4ECE49
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 05:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C523C503;
	Thu, 16 Oct 2025 05:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+AVgcfK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C512BAF9
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 05:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593632; cv=none; b=Y/3Ix3l3WXjbTp4tgw5ctYTX60xCTZpUvE6m/ecV+aNvWv5JqinfryQxrEhCnaWZkq/y/dM3DK9+lShD0FaVT4apO8EP2Uq39No56oQxKhqpqyaD4i73P9M7X6T2s4HyoFhFYajKynuAc2Or/j+oxPd8EuPr/bSGPbV6JGYy0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593632; c=relaxed/simple;
	bh=g71KTR4TKAoXFFydAPJnfgt3hIZ/mMbBfnbeCy5SzDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9SxI9MpvAE5K9f4rJmBfEtb6E0Wk0d9oLyS+O1c8V69dWD6yQ9svReIVBlWCSzdfma8Va8L7ULILAQt/h3gCPvWyy2emC/BYXOzKKpzRqD3M8P5zGMhnSgg71y4DV6uwZ86z4dpv8NC8yiC1a9jrx/SAVLKtjaUJBSOfwA2brY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+AVgcfK; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso578002a12.0
        for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 22:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760593629; x=1761198429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA6mhhqCrmj7IiS/atA26gzsL8vdKi8INK9aHEVZuHc=;
        b=G+AVgcfKSGxI7K7KGNHxv4qMB6oUQ9s7t7ABYzTf2P+R9Nr2jEAnEQ3q4sE78LesW2
         SIF9pVd1VUnJC30hY3DgCIxipjeonFrN9IDrKAqDuyBuPj41ud4196AYwRQ1KcaGeTw5
         0GXbiRwx4TUVj91k/s5TuVyRqTQMyvqEvai1d0y76IqyYEnB3Hsq/vs3hP6wqttQIu6t
         cq953B9Q+ua6HL4LX0rdI9z7Pe3Nj8JAY3gx5la8mVo5iRU0HguPZV0SC4bZ3HVCeisO
         sXnkSMKe5d7Xk/uwys29/lB3600HvMYQB/V+okOxFnqDrzrqyDl0bIfZoz7LzKBChA3L
         U+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593629; x=1761198429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA6mhhqCrmj7IiS/atA26gzsL8vdKi8INK9aHEVZuHc=;
        b=pvF6F9P6Zwr4DkyH5hECaFXPD56kIbe5Wa1jwAV8H06dJEdwXr+G/6ayfYl76uYH7o
         Jj1eMadFzUz4v/CZjPl6R7w8Y780VWe/i/8ZQWZfQ1bsjddF+ppfz9RlZsAcrFDeuk5d
         m+5hBN1QpyHmUBU7MMm+hRMPcHjb+no9wh6SWPKtrFkIfTG4jC0dzyZtXqWtS82ejX3A
         zcU1U5s3Z480BgzislBpgisDZp0wY9xcrg9bUG5ArnwYJAqoPmUfRNkMXSHYWgDQ0FDW
         5ZVBKwu6oVwwLdmg9eoQghgX95LBznChlvvLVctuISvCmZjA9QGahp2MXlBKjJF3JFwA
         mR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOMZGvFYFpP2W6XZsgVEDOmchhndfJJkMfuq/3rTT3XuZwSdzkXEtVxtv+1SahD0xlSQFzXmDn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+r7eFEXldjMZ+/Qv4pamAhxPX+ScHTK51R1alCf556iUzSdEZ
	/WIadS60DIPZaJJ07jPgV3Tt9ggX4orVwT2TiJM6SjqfUHC6NqOyplN2baRY+lOa1WRC8s00cdf
	3pTwETTsE4QV3OipS88Ru9Gn8kZ/7qKMZmY/5EBuv
X-Gm-Gg: ASbGncvdcjkQe69vch/iUc3EQcFSy+/ol6MkmWH+iG8uIzqbHLwWIzYXBce0hqkrQD9
	gYlbqx14Kb1Lx4DYWbkS9/9Nfg6O2c7DXPXd2d0SKrJbuxFzDf/+oYVjduuwCNhaFdvT3oWvvgk
	L9NufB/AvlbAllGS6h3On3IGzEngLBTSltYNWtsWMS2pV6qMrfBTlVnK1bSF3F+YCJMxCz9MxBD
	jWv2jYnHU3gobUcyE7GaqBaU15Z1HXA5vMbbMicKxcNeD/DsjVNuSrDbNIL18ugtVReZKHIgJ5o
	qGs85TbKHzRnkAbsAXUjqjVxp1b79oPhEnY=
X-Google-Smtp-Source: AGHT+IFzw+sm9kmi/FXeFTMQBBNhRcBK3NKNkQBYJXmvg92GJWyWk0z/4dzc7vdtFnEF/yXk7jod/id/D4o55kM/p14=
X-Received: by 2002:a05:6402:354b:b0:63c:1171:b8d2 with SMTP id
 4fb4d7f45d1cf-63c1171c22fmr260689a12.32.1760593628477; Wed, 15 Oct 2025
 22:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016013116.3093530-1-shakeel.butt@linux.dev> <87o6q77hfn.fsf@linux.dev>
In-Reply-To: <87o6q77hfn.fsf@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 22:46:54 -0700
X-Gm-Features: AS18NWA5RQWYnfsEWfydqaWHIyqqFuKRjGF0eqaH-MLEpN4EhdsHRHE5mpgYePI
Message-ID: <CAAVpQUBXzBKfbH_iqn78k6d7ys9DNrXTVbnYSD4ecuKwgCwk8A@mail.gmail.com>
Subject: Re: [PATCH] memcg: net: track network throttling due to memcg memory pressure
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Matyas Hurtik <matyas.hurtik@cdn77.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Wei Wang <weibunny@meta.com>, netdev@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:40=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Shakeel Butt <shakeel.butt@linux.dev> writes:
>
> > The kernel can throttle network sockets if the memory cgroup associated
> > with the corresponding socket is under memory pressure. The throttling
> > actions include clamping the transmit window, failing to expand receive
> > or send buffers, aggressively prune out-of-order receive queue, FIN
> > deferred to a retransmitted packet and more. Let's add memcg metric to
> > indicate track such throttling actions.
> >
> > At the moment memcg memory pressure is defined through vmpressure and i=
n
> > future it may be defined using PSI or we may add more flexible way for
> > the users to define memory pressure, maybe through ebpf. However the
> > potential throttling actions will remain the same, so this newly
> > introduced metric will continue to track throttling actions irrespectiv=
e
> > of how memcg memory pressure is defined.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 4 ++++
> >  include/linux/memcontrol.h              | 1 +
> >  include/net/sock.h                      | 6 +++++-
> >  kernel/cgroup/cgroup.c                  | 1 +
> >  mm/memcontrol.c                         | 3 +++
> >  5 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 0e6c67ac585a..057ee95e43ef 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1515,6 +1515,10 @@ The following nested keys are defined.
> >            oom_group_kill
> >                  The number of times a group OOM has occurred.
> >
> > +          socks_throttled
> > +                The number of times network sockets associated with
> > +                this cgroup are throttled.
>
> I'd prefer sockets_throttled or sock_throttled. And same for the
> constant name.
>
> Otherwise,
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

+1 for sock_ like "sock" in memory.stat and its MEMCG_SOCK.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

