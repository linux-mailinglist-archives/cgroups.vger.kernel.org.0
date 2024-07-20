Return-Path: <cgroups+bounces-3829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A2937EF9
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 06:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4401C2144A
	for <lists+cgroups@lfdr.de>; Sat, 20 Jul 2024 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DDC2D6;
	Sat, 20 Jul 2024 04:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7YxT9Kl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123A63D
	for <cgroups@vger.kernel.org>; Sat, 20 Jul 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721451192; cv=none; b=MsJixSB8xFkJzYZLlGwdSwIolRmosq/0HViGrvF9Sh6/w+weRiCnch4k+m8YddHRKD1PYE0eGQ085eJ/1+dQr/3Lt+fVTGip8Gy/ZmuLI+N5eU3abVzfsCDVkFbak41ZR8qDFJLx6F0oxb68k/T/JVHOZxmL5xwbOdoRARhn2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721451192; c=relaxed/simple;
	bh=H2k2l7JgCsBFkV5JACOdQKLwvUVvJd0wvKwI6imVZ3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBTL84nMNwM+Y7RS8GtdU03BenIYhiCbNlt4ad17sQtI8x6ObA/aMWasenUdqSZbp1l9/dt8H3jD9Ob+PuvisbrB259kxiYAPJ3untlWUl+Sz3fs1AbQJWdUrsmyRn5S9hQR569rj54Ad//tTIdC+eXmDwSHs4Msk9bfGbNVuf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7YxT9Kl; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf858so1093283a12.1
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721451188; x=1722055988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HvZkcpZdJwtVEMfsUyDpdFr/ZrEH8j2lB/wRls5Y1k=;
        b=u7YxT9Klbw+icASOWZv8ZNWQevshd3iA5p1P0l3sOZFgV411kZMvrju/cr+aedMPND
         3M3mO1VebZXfzItH3U/QD2NMms72Z9CUNfGhWuEx6MTqkR2MpGhNj7h5eHIeLCrw3seP
         AIFv1K1mhORJ4hgLiTGTI9/PGTfvRrlIG7RktKx9cjUF5hI3r2NaImdI+ezBxpYFVKcf
         wf4oOjIFiXpPtYC9302YVTylgjL1tIZEyHc+vJtVGA8vN1+nFGGNfc8Pv9oGWtl1Eog+
         JUfML3JCbxnwg3nbTw9ZSQkNRCX6psUgbqWlGqlAPFnYgcRODA9IOQT1lBzeHD8QtClU
         tR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721451188; x=1722055988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HvZkcpZdJwtVEMfsUyDpdFr/ZrEH8j2lB/wRls5Y1k=;
        b=rG8uukrvxP1geRsZPPRnNNDBVPlRnAV0tD2hprBvsLYwpTb7YIfkva0sn2MpL3QPdt
         DZzPh+kLElEERyNc8C9j2f4AimiYHyQQQGgmgOxDZ9jp2ypXA7kKcic6XJ0/fWKXogbA
         cTV1KXwB/Kq1YVIXtgNxy9+12Mgk/UMMzTv2yIrdGEviZcsJL19IhzSw3d/UfUh78vd+
         affgiMkCkRtqqKSOHAMUp36kldWi6Tb13ZTSU1h3VpiwM6+UvRsMbR2q17y8QZfzwqQD
         EaSSko7koQcQkvFQVBgJkjpJivTgUEC7qb9nB/0dl9WpSwXgi/NW8E4Y3rzwq4UYK90z
         I+pw==
X-Forwarded-Encrypted: i=1; AJvYcCWx7YISKcH6T9dO9YuO3iorkIIc7MV8B1evSdcfbESu3T7OqdfoCdcPbmEsTOUxeQpV2Ua8U/uBkVZwVpA90eqrKy4hDGgwJQ==
X-Gm-Message-State: AOJu0YxGZvP9NPK1ZMVfBFBVQaVujCJffbQ9SXZbAHPvjvNE4zN7ap6o
	0XAHPWC5w0nwYU/pwpLe8h5g27O7MW8SX+/l+PMQz95EZ149hKdYL6A0Hmzh9XQH+H0OpsmbC9H
	xjy4o9OQokIqijqO0hb3EHUEnISvuzBVXzR+w
X-Google-Smtp-Source: AGHT+IEBtcKhMX4a7FkKEgtIIzfnWRLuBADucgwX1FvHsdXKYU63mXZRF70j5SRBDAypHp4vYIKH2WsFbbU0fgz8G24=
X-Received: by 2002:a17:907:94c9:b0:a7a:3904:f45 with SMTP id
 a640c23a62f3a-a7a4bf39545mr26767166b.8.1721451187421; Fri, 19 Jul 2024
 21:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
In-Reply-To: <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Jul 2024 21:52:31 -0700
Message-ID: <CAJD7tkaypFa3Nk0jh_ZYJX8YB0i7h9VY2YFXMg7GKzSS+f8H5g@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > >
> > >
> > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > Hi Jesper,
> > > >
> > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrot=
e:
> > > > >
> > > > [...]
> > > > >
> > > > >
> > > > > Looking at the production numbers for the time the lock is held f=
or level 0:
> > > > >
> > > > > @locked_time_level[0]:
> > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          =
     |
> > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                              =
     |
> > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                               =
     |
> > > > >
> > > >
> > > > Is it possible to get the above histogram for other levels as well?
> > >
> > > Data from other levels available in [1]:
> > >  [1]
> > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kern=
el.org/
> > >
> > > IMHO the data shows we will get most out of skipping level-0 root-cgr=
oup
> > > flushes.
> > >
> >
> > Thanks a lot of the data. Are all or most of these locked_time_level[0]
> > from kswapds? This just motivates me to strongly push the ratelimited
> > flush patch of mine (which would be orthogonal to your patch series).
>
> Jesper and I were discussing a better ratelimiting approach, whether
> it's measuring the time since the last flush, or only skipping if we
> have a lot of flushes in a specific time frame (using __ratelimit()).
> I believe this would be better than the current memcg ratelimiting
> approach, and we can remove the latter.
>
> WDYT?

Forgot to link this:
https://lore.kernel.org/lkml/CAJD7tkZ5nxoa7aCpAix1bYOoYiLVfn+aNkq7jmRAZqsxr=
uHYLw@mail.gmail.com/

>
> >
> > Shakeel

