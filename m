Return-Path: <cgroups+bounces-11424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33334C1E931
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B104038EA
	for <lists+cgroups@lfdr.de>; Thu, 30 Oct 2025 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63D2FBDEE;
	Thu, 30 Oct 2025 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlHPwUQ0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6252F5A02
	for <cgroups@vger.kernel.org>; Thu, 30 Oct 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806048; cv=none; b=aiji79JqiDkbmqxx7WKTVEz7b4yjd1xHN5ljAFvgho9Htv4SirqWIWjL5HdsBrX6WtMu9d4npabvkOozFaL9XQ6djVxIbPvXQfjXM4bQh/922cq/RBaRtGuxmf1FHyC8dMokwN7tGtERtEYIQJp7UN6ZAE1Vgx16WvSUXb4hpFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806048; c=relaxed/simple;
	bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9c2V71lTfP8G6sGsHLdwbYMyfMAS0BAg7t29Duex38FNpD5yUswBDMzlMUBFxCfa3Jnz+3dB7DqVqXGaRZM/d7FbNhBGzva1i2ifaTJSlf0lGEFiXH1l57tuWqWl6uAYfY24vi8szPpIkiLODBZmQUGNhI6c9SeR/9CvUswhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlHPwUQ0; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7847ee5f59dso10891897b3.2
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761806046; x=1762410846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=UlHPwUQ0YSemv40ZGHCY7NIcxtx7Vdgvi54HCNlWgnToL98ONPEPEua6KiSleMKvZs
         CGnpyBNJFvkkMHenB1MYC3FLSNu4BVaOiNYS2FzlzUO6WDaLIyTlISp7339s0hodnitz
         6NtQdZzitvGieoICQidNlR+dlXRT3hTHxEwl8J4iQvV9gna2odKV7Ht6yhIorppqiufi
         N7AIYwAf2kZZsQyZroDk/uMqWMB6gcMFTIgVbfEM5/zUdFgdrvSVSvqRfEpQxK1BeqZP
         HTT+txarUxveXuMlN1i28dJ/0tXeO2ADi8ncOckcaXvpdiHuJvRV3RVl8rNTawxwYOH5
         3tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761806046; x=1762410846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zflyYk3NYy4RcPJITCP+PJ6c8wHVT/sLZfTTgaXKfCk=;
        b=X3YSR0jedNDyv4clikZVzRiOGn0H8dc68X2Li6bDdQukjfpVEdY2vff1rBHD/B7fzp
         coekFK8B7Oq9Zoh6Qj0x4NjnDwo4xPTAdorism1RK1jZyOwnJiby8LBMAqTR/Sj3Xd18
         rOSffHHW1FOB5u5OyE6WT8eTnOP6+rXE5v9I5wnB1x1aWRCW7XKKiA+wCbY7SlSfvbgO
         j1gv23u5NSKiQOfYNJT4CdwT6+nDLu94Rd0YsSgYzOtKeeHmY6zoScjnZ9oM2rbixpgX
         pJ6SJd0BvQmcetmXhBVLMN8IsYaT0ZcjfnHriGaLokwuv05Fv3Un1N6vrPMe4SRElFLQ
         7Pog==
X-Forwarded-Encrypted: i=1; AJvYcCUjquWEo3PVC4zPErG8VF4tN7bij8YOrqCQJ664tGPGKQRuv9uJJgJjjHKRrzJYqBO0LpkN3IzG@vger.kernel.org
X-Gm-Message-State: AOJu0YziqDzjOXISShuiuUe/vRtXe4y6fhMmC2zIaETGIprSv0pBn9Qg
	XmuhDvj4+yZDmQpXB/sxaAhRTvLQMCcIVMPxnKM/fXFOzOHlA8a/yzC/GIQxD5YHBRdD//RADzE
	dXgs4zSp2hkP8gAKXrateE7MyLymUQz4=
X-Gm-Gg: ASbGncsvmopuUbqoAe3ujBD/tAtH09PrVYIwr8ArVQR3dSmt4I39QQ6UcaV/rwfEuGS
	y6oQh/x75Ec948DhJXUIHJh4Z74carv5qpg81Gii2H8plCfH+nFSPberjqi9YbfjgdP/Z4HhaRk
	3GqPe9tO17NI0ptN+Z9zlePnhaM/UMKeviLZEptO2tcMN7B4NH2z/A+Wr3xBYJMwQPMyWNMa/E3
	VNbvY2xe4Gk8RvCuCa5TDoTMaZE8dyKh89dw0IaMbP8amFU6VxhlGNGjHfE9EM3dIGQqMZX
X-Google-Smtp-Source: AGHT+IHAkzPCtNQ20ppd+4ZhB3lJD10RCDw7ZQWKRcjkJ/MU+ifVpTXFAcgPBxAL5BiXPDLqVFNv4y1b/arwSry/zk8=
X-Received: by 2002:a05:690c:b95:b0:781:159:33ae with SMTP id
 00721157ae682-78628e82453mr55969657b3.4.1761806045641; Wed, 29 Oct 2025
 23:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-3-roman.gushchin@linux.dev> <aQJZgd8-xXpK-Af8@slm.duckdns.org>
 <87ldkte9pr.fsf@linux.dev> <aQJ61wC0mvzc7qIU@slm.duckdns.org>
 <CAHzjS_vhk6RM6pkfKNrDNeEC=eObofL=f9FZ51tyqrFFz9tn1w@mail.gmail.com>
 <871pmle5ng.fsf@linux.dev> <CAADnVQJ+4a97bp26BOpD5A9LOzfJ+XxyNt4bdG8n7jaO6+nV3Q@mail.gmail.com>
 <aQKa5L345s-vBJR1@slm.duckdns.org> <CAADnVQJp9FkPDA7oo-+yZ0SKFbE6w7FzARosLgzLmH74Vv+dow@mail.gmail.com>
 <aQKrZ2bQan8PnAQA@slm.duckdns.org> <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
In-Reply-To: <CAADnVQJPcqq+w0qDjMV+fx-gYfp6kjuc7m8VD-7saCZ7-bvaBw@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 Oct 2025 14:33:29 +0800
X-Gm-Features: AWmQ_bmDSiMH7BHRJ2t-PSFn5y1B5iA1PUPKgXH8mX3AM57qm-0dXLGAddjgEhY
Message-ID: <CALOAHbBW0jM=WZG7BM3Lh=xHBV7M585j85xMzpWAtWdrkRa+nQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Song Liu <song@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrii Nakryiko <andrii@kernel.org>, JP Kobryn <inwardvessel@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:16=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 29, 2025 at 5:03=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> >
> > Oh, if there are other mechanisms to enforce boundaries, it's not a pro=
blem,
> > but I can almost guarantee as the framework grows, there will be needs =
for
> > kfuncs to identify and verify the callers and handlers communicating wi=
th
> > each other along the hierarchy requiring recursive calls.
>
> tbh I think it's a combination of sched_ext_ops and bpf infra problem.
> All of the scx ops are missing "this" pointer which would have
> been there if it was a C++ class.
> And "this" should be pointing to an instance of class.
> If sched-ext progs are attached to different cgroups, then
> every attachment would have been a different instance and
> different "this".
> Then all kfuncs would effectively be declared as helper
> methods within a class. In this case within "struct sched_ext_ops"
> as functions that ops callback can call but they will
> also have implicit "this" that points back to a particular instance.
>
> Special aux__prog and prog_assoc are not exactly pretty
> workarounds for lack of "this".
>

I also share the concern that supporting the attachment of a single
struct-ops to multiple cgroups appears over-engineered for the current
needs. Given that we do not anticipate a large number of cgroup
attachments in real-world use, implementing such a generalized
mechanism now seems premature. We can always introduce this
functionality later in a backward-compatible manner if concrete use
cases emerge.

That said, if we still decide to move forward with this approach, I
would suggest merging this patch as a standalone change. Doing so
would allow my BPF-THP series to build upon the same mechanism.

--=20
Regards
Yafang

