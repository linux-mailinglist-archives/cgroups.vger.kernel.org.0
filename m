Return-Path: <cgroups+bounces-1068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 988A8823A25
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 02:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FF20B21D43
	for <lists+cgroups@lfdr.de>; Thu,  4 Jan 2024 01:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4A641;
	Thu,  4 Jan 2024 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tLgBSnCT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1FA5F
	for <cgroups@vger.kernel.org>; Thu,  4 Jan 2024 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so6613a12.0
        for <cgroups@vger.kernel.org>; Wed, 03 Jan 2024 17:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704331102; x=1704935902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eOihVzL+EVjsPhR8JjZLVk3UHy9SeIcu5m/iOFaAv0=;
        b=tLgBSnCTFWUrfSu+3Z61hCZ3Zesj0TDji1cH007BaCsdaQAgEnLOtGtr3WDEOtacjz
         oi4F6/ZuXSZ7/aBvcdY4l9P5MLBiS6k9lMy0yXH9r2ygQnczljbQUAOuIcn8nKmgZPvt
         hHI8hcxfdmoKR4JbW/3wgTYnZckjT4OQHbXqPJrM5Rxefnny8wx+8Z8YAE6pw6tqzUrI
         vON5y+VA1ozp9TNr2fAeyFzuElKQePxetOizGqFZ6rsYQjgxeIaKbNI8pySckNNX/y8v
         793LN79BJQnmTf96iNe9xMhvEsb3UUX4ZOCOrIKIhgrUoJqn/0+oWlnbGJNDtpEBoEsG
         zP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704331102; x=1704935902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eOihVzL+EVjsPhR8JjZLVk3UHy9SeIcu5m/iOFaAv0=;
        b=sRpgmlMxC35YYVH04bKXn3aaveg/MSyoASS3eVP2L6nbAfWt4kllYqYfs8AiWcuuNE
         z+PIL4NMtDSd/QJLBBqnpKeeq9iH+4pokw0H4taby8XIXzhSCwRhDYVWD2fsxtntgznc
         A2XEg6j34VJB1IEHz7yZehWtNTbFp5L65koWuA66sSLxhNHO8RSxYoeixfTdwTuW0mu4
         P508P2wsrpTkSoNAR4poAw8FSush89sr72HNemP+54D1PfSnnlS3HsZYAuxiL3CfG8WL
         9b9bMxYJ/ln6LRxc4WoXzFM24nkdG1wTocH6yHbxzPVqmqTXUdCx/zr4IRuJASCSSJSU
         VGmg==
X-Gm-Message-State: AOJu0YxbIYdxI0YAmsI5mJ/vaw/Yoo+IYQ1anxggCAzS1Qi9A4PJeGN4
	1orH2UNvQZp5CZd2wr5JgZy29wlxnL92VxOT1WFwmRjTVnlW
X-Google-Smtp-Source: AGHT+IHkDaYXx3vIf2LQ/rTC9gJtpfrx24b7Zag7MbADMq8MnjXCdGVLkz4I2hDjvet/5H2gw+LHsrFnWNOczjuZXIQ=
X-Received: by 2002:aa7:d412:0:b0:557:15d:b784 with SMTP id
 z18-20020aa7d412000000b00557015db784mr16278edq.2.1704331102029; Wed, 03 Jan
 2024 17:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com> <CAOUHufZ-hTwdiy7eYgJWo=CHyPbdxTX60hxjPmwa9Ox6FXMYQQ@mail.gmail.com>
 <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>
In-Reply-To: <ZZWlT5wmDaMceSlQ@dschatzberg-fedora-PC0Y6AEN>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 3 Jan 2024 18:17:44 -0700
Message-ID: <CAOUHufZNx7=Oufp5RrJ=GDHDN6RhcZtkBOHeKYbXFzPwVDejXA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Chris Li <chrisl@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 11:20=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> On Wed, Jan 03, 2024 at 10:19:40AM -0700, Yu Zhao wrote:
> [...]
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index d91963e2d47f..394e0dd46b2e 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -92,6 +92,11 @@ struct scan_control {
> > >         unsigned long   anon_cost;
> > >         unsigned long   file_cost;
> > >
> > > +#ifdef CONFIG_MEMCG
> > > +       /* Swappiness value for proactive reclaim. Always use sc_swap=
piness()! */
> > > +       int *proactive_swappiness;
> > > +#endif
> >
> > Why is proactive_swappiness still a pointer? The whole point of the
> > previous conversation is that sc->proactive can tell whether
> > sc->swappiness is valid or not, and that's less awkward than using a
> > pointer.
>
> It's the same reason as before - zero initialization ensures that the
> pointer is NULL which tells us if it's valid or not. Proactive reclaim
> might not set swappiness and you need to distinguish swappiness of 0
> and not-set. See this discussion with Michal:
>
> https://lore.kernel.org/linux-mm/ZZUizpTWOt3gNeqR@tiehlicka/
>
> > Also why the #ifdef here? I don't see the point for a small stack
> > variable. Otherwise wouldn't we want to do this for sc->proactive as
> > well?
>
> This was Michal's request and it feels similar to your rationale for
> naming it proactive_swappiness - it's just restricting the interface
> down to the only use-cases. I'd be fine with doing the same in
> sc->proactive as a subsequent patch.
>
> See https://lore.kernel.org/linux-mm/ZZUhBoTNgL3AUK3f@tiehlicka/

Also regarding #ifdef, quoting Documentation/process/4.Coding.rst:
"As a general rule, #ifdef use should be confined to header files
whenever possible."

