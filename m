Return-Path: <cgroups+bounces-464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C37EF624
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 17:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E199828111C
	for <lists+cgroups@lfdr.de>; Fri, 17 Nov 2023 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CBA3716E;
	Fri, 17 Nov 2023 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kG3MTh52"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76510D49
	for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 08:27:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c603e235d1so301312566b.3
        for <cgroups@vger.kernel.org>; Fri, 17 Nov 2023 08:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700238476; x=1700843276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYMqLtzHxtjl/0RXubUExMnoFoWXnrJhTRzwPVlfA/Y=;
        b=kG3MTh52jaToUxEeKJ61E5I5XP9g344+Q5mjoKNgOxauLNYMPHQW9/YqMto9lxv4q2
         TC9U0B5oA7Jl+6VIPHddCbk9iN0babk6PlQ5Ny2LVuJ60+pTiiYvRuUgMcwuKfU3W9Qt
         PDBslfiTqy0WIVOAbPpUpCT08vi5kLWiGr/CKrPbwVuFFGSxgZYlwckUPTljCf94CztF
         E39appyXUuGk7f7SJXiIWB3lRzWaGUbn1w/j4fCgSYvpwyH84le/Y4VhY4fPJgfYq9QJ
         LzJWy0XtSULlW1iTVtF3auqsMsoj5ysiwpHQ7JvbZMn8v1tPRIObqrgiBRTUTFq1Z3Co
         BIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700238476; x=1700843276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYMqLtzHxtjl/0RXubUExMnoFoWXnrJhTRzwPVlfA/Y=;
        b=hwOeY3TGiyzWPY5E1WvBQliW3lXnjZVf/zoye2/dhewXxuDjEMDRElDnJnGXCJwRNu
         Kjx5EJOuwQvOZi4eOrInSfZTzH7w3EmiC/QAtlGPc9bfWnc2Y5IEph8ZvSF1FpxVw1V1
         Gx/UqZlNxDTqjwmwaILw597VnRt+QtYJLefdOgwV5eHWDm7GcMWE0C8LP5BzQ9meNnZq
         4SposWNTw4BbxGPgL6la+4dCNRROCk9VLKSYSGG1dbLl3equKb9UPUbSTGrzdcyY6NU8
         D7oSM89aE8s0kP83+tjuUIRmvppN/4T3zV4fyn6scTunXdw3UP+H6KFd7/ScAJZVE8rh
         Nu6w==
X-Gm-Message-State: AOJu0YxyoGdOYY6X3fQ7g07tWSuouI0y97rOo+VKgmlK6TLfqbhJpLDR
	rJwXZwuLvdzDgMLmVvtNJcfTJxhs78E9eXRN8+U+cw==
X-Google-Smtp-Source: AGHT+IEML2McgqDhAm45vIc1lFPoPUKG88o0mJfcTJLxdrkvWDPgtUP33cqgTr1QEig22HevOk8eVl5Y/JCJy2Pl7rw=
X-Received: by 2002:a17:906:f0c9:b0:9f6:15ad:cbf5 with SMTP id
 dk9-20020a170906f0c900b009f615adcbf5mr3764249ejb.15.1700238475782; Fri, 17
 Nov 2023 08:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
 <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
 <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
 <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
 <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com> <CAKEwX=P343G80Bfbf1R+FfSxty763Bo3WCo_Pu0GOuZSJjnxRw@mail.gmail.com>
In-Reply-To: <CAKEwX=P343G80Bfbf1R+FfSxty763Bo3WCo_Pu0GOuZSJjnxRw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 17 Nov 2023 08:27:17 -0800
Message-ID: <CAJD7tkZGBSA0MVaybU8A5GeC1K5PWL73K3UwfNjrA=nebBbAYA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, mhocko@kernel.org, roman.gushchin@linux.dev, 
	Shakeel Butt <shakeelb@google.com>, muchun.song@linux.dev, linux-mm <linux-mm@kvack.org>, 
	kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 8:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Nov 16, 2023 at 4:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Nhat,
> >
> > I want want to share the high level feedback we discussed here in the
> > mailing list as well.
> >
> > It is my observation that each memcg LRU list can't compare the page
> > time order with other memcg.
> > It works great when the leaf level memcg hits the memory limit and you
> > want to reclaim from that memcg.
> > It works less well on the global memory pressure you need to reclaim
> > from all memcg. You kind of have to
> > scan each all child memcg to find out the best page to shrink from. It
> > is less effective to get to the most desirable page quickly.
> >
> > This can benefit from a design similar to MGLRU. This idea is
> > suggested by Yu Zhao, credit goes to him not me.
> > In other words, the current patch is similar to the memcg page list
> > pre MGLRU world. We can have a MRLRU
> > like per memcg zswap shrink list.
>
> I was gonna summarize the points myself :P But thanks for doing this.
> It's your idea so you're more qualified to explain this anyway ;)
>
> I absolutely agree that having a generation-aware cgroup-aware
> NUMA-aware LRU is the future way to go. Currently, IIUC, the reclaim logi=
c
> selects cgroups in a round-robin-ish manner. It's "fair" in this perspect=
ive,
> but I also think it's not ideal. As we have discussed, the current list_l=
ru
> infrastructure only take into account intra-cgroup relative recency, not
> inter-cgroup relative recency. The recently proposed time-based zswap
> reclaim mechanism will provide us with a source of information, but the
> overhead of using this might be too high - and it's very zswap-specific.
>
> Maybe after this, we should improve zswap reclaim (and perhaps all
> list_lru users) by adding generations to list_lru then take generations
> into account in the vmscan code. This patch series could be merged
> as-is, and once we make list_lru generation-aware, zswap shrinker
> will automagically be improved (along with all other list_lru/shrinker
> users).
>
> I don't know enough about the current design of MGLRU to comment
> too much further, but let me know if this makes sense, and if you have
> objections/other ideas.
>
> And if you have other documentations for MGLRU than its code, could
> you please let me know? I'm struggling to find more details about this.
>

This could be a good place to start:
https://www.youtube.com/watch?v=3D9HvJfN21H9Y

