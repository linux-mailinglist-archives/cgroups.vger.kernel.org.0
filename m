Return-Path: <cgroups+bounces-1334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481F8483BC
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 05:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC56B276DA
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 04:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686ED10A01;
	Sat,  3 Feb 2024 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+Xx0GOw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF71F9FF
	for <cgroups@vger.kernel.org>; Sat,  3 Feb 2024 04:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934203; cv=none; b=hjULO6JAi89h0fFP8nrtl1Zv57IM+QGiUHwU1KmZiP0TKwWGi8F5pXQa7F3pmOGykmNV8+G4Wh/b1Gxwc0EgjoA/QSQeNrQfHhdzauf0V1SvGQRYs480BdwG1JOb3xk5jys14uuVeToaWCEhujlkGU1SHMXWI0KRHewj8S1rMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934203; c=relaxed/simple;
	bh=p8DcI038LCJsFfjS2X5a3TzYgQ4CoD5oN3YW/KgGnIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th1C2cVQqwTT05chi+glr21glxPwHSXJUxR6lrxvIvRLXeCI98bSLBGGqxHIyW08wz5zW7vhP6txU9iT+o3kSLjJH481HsNZGVLL+UTOa1OBzg6aKKDwcJG+N10sJJTWwKDiD9XgxWuN+qXPFWXTHUwVKaG054QzyNQwJ+AOB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+Xx0GOw; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51124d86022so4443518e87.0
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 20:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706934199; x=1707538999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DisFQpTn7TdXti+Sfq7OuBraM//Uzb0Fy3Abq9El6XY=;
        b=p+Xx0GOwwrGruHma2C/KjDFHKT+6BXpw1qrsX+w+b5oE3Q2i++kYTipuDA5ZV0MILC
         iYPJcCo93sW2X2N7wkw/jNo/goirEaY/OeVVjN3tLRkDCQvxM8D03lEcyT6589h8yrV6
         lBB7brbF2fiXfujAQaZzfd3fc4xfup5p/QNEEFf1FH5XUEib1saiRD0Mnj8P2rw/Obp0
         uWjjONzAchhsaOYI/pVqgxvdpbgec7hLRNHig9e376h9KptW0YatZgIlKCi07jHzhdky
         S6heF0xjHPBLx3vTKc9PvoL4uDgqSEYRTw02UfNZdzFiWsc+Ly7nil4A5V/ZsN6BBQYD
         QEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706934199; x=1707538999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DisFQpTn7TdXti+Sfq7OuBraM//Uzb0Fy3Abq9El6XY=;
        b=SSRvHLm3ykWYocs6CatlnyOn68pQ0u70SQb1TqJwEYncf8WOH/zFOgOG7aZvvo3a6+
         l61a8AyAXPk4RefkqWhYt0CVKi0Burr+3AzaphW60cqwrUOfICuXq9Oc9l2yHOcvVPIi
         5r2T4ixSpCwOUIfs6JXvK4CNVHdDKCDFJO1Si693mjuLBCv6MWtLyAnngMqSNoWi5a7e
         CirDImzwA65521LfBdsDMkzoritQqg5n4HFXuKg45jnnoKOOFYkkZ/9ik1PzSniXTrha
         89WxYF2klaGPkgKWfrZ3cSaWItQ1aRTwCxicKFiwIjj6N77ZegpDaAGbdJq4HwmXgd0g
         uJZQ==
X-Gm-Message-State: AOJu0YzeAAsNEXb19EIa1LxVGSzMEI3y32gpKqIMTNY4uEpv+oMbUWxD
	s/JPSBbGwjMlxYM8zoVBjcMY1ukULRsnqc0N5bywOnw962gCM4b1qV+cEDwE43jwSpdeuEXOovj
	XiLytxOzoQq+isVIp4wF3tdbw4gIaWv1w0Jtw
X-Google-Smtp-Source: AGHT+IFKvCQbNc+6dMkuI6Vjtw4TQbEk7zZdSVlZeVuzj7bG2ePVf9y2VMDFzBqSsBXRO+Xfzwu4RxFm8cRemMnTvVY=
X-Received: by 2002:a19:8c5a:0:b0:511:320d:872f with SMTP id
 i26-20020a198c5a000000b00511320d872fmr3316565lfj.37.1706934199201; Fri, 02
 Feb 2024 20:23:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203003414.1067730-1-yosryahmed@google.com> <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com>
In-Reply-To: <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 20:22:39 -0800
Message-ID: <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:13=E2=80=AFPM Shakeel Butt <shakeelb@google.com> w=
rote:
>
> On Fri, Feb 2, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
> > memcg_rstat_updated()") added two additional pointers to the end of
> > struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
> > separate cacheline. This caused the struct size to increase from 1200 t=
o
> > 1280 on my config (80 extra bytes instead of 16).
> >
> > Upon revisiting, the relevant struct members do not need to be on a
> > separate cacheline, they just need to fit in a single one. This is a
> > percpu struct, so there shouldn't be any contention on that cacheline
> > anyway. Move the members to the beginning of the struct and cachealign
> > the first member. Add a comment about the members that need to fit
> > together in a cacheline.
> >
> > The struct size is now 1216 on my config with this change.
> >
> > Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memcg_rs=
tat_updated()")
> > Reported-by: Greg Thelen <gthelen@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/memcontrol.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index d9ca0fdbe4ab0..09f09f37e397e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_event=
_item idx)
> >  }
> >
> >  struct memcg_vmstats_percpu {
> > +       /* Stats updates since the last flush */
> > +       unsigned int                    stats_updates ____cacheline_ali=
gned;
>
> Why do you need ____cacheline_aligned here? From what I understand for
> the previous patch you want stats_updates, parent and vmstats on the
> same cacheline, right?

Yes. I am trying to ensure that stats_updates sits at the beginning of
a cacheline to ensure they all fit in one cacheline. Is this
implicitly guaranteed somehow?

>
> I would say just remove the CACHELINE_PADDING() from the previous
> patch and we are good.

IIUC, without CACHELINE_PADDING(), they may end up on different cache
lines, depending on the size of the arrays before them in the struct
(which depends on several configs). Am I misunderstanding?

>
> In the followup I plan to add usage of __cacheline_group_begin() and
> __cacheline_group_end() usage in memcg code. If you want, take a stab
> at it.

For now, I am just looking for something simple to fix the struct size
proliferation for v6.8, but this would be interesting to see. I wonder
how __cacheline_group_end() works since the end is decided already by
__cacheline_group_begin() and the cacheline size.

