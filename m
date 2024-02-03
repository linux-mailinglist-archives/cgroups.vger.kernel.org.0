Return-Path: <cgroups+bounces-1335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9158E8483C0
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 05:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F1D28187F
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 04:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDF679FE;
	Sat,  3 Feb 2024 04:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwXwk+cT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420DF9F6
	for <cgroups@vger.kernel.org>; Sat,  3 Feb 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706934887; cv=none; b=uFPDKIQlaCSB4nehTujbxHQnhcYatErCaA4FxEgr+Y+PcztJn4kA5usr2wmvp2UZ7COMQZn5F6NUBRcMYXz7khEgZwcpGNEDptBeNIoW4dxBCO+eAQjnp8TcnfGDMWuHXSK1+2OIxJcNRGzo/iRi0XI0hiKKeDLMCoZYhyj6GY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706934887; c=relaxed/simple;
	bh=B6IZS2BTnQcZfDh3L2ip4LzFdJI5EEsmT+nOePGT0/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8+AvkXYjrrJP/WCvmPIDyENorzl/XIFMzV54HVqlWZyyu+q6R2+36V4GA1/dvUGHS87j5rrVxfJAQYQiLmhEcjJNaAfWxv2t1CLDByqB/0ROaVxCruf7pFTAJ5HVDrwZGTf8Bn2/+qFlzlaMplKrty8Dfm+dTTaIyhSfrhC0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwXwk+cT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5ce88b51cso113035ad.0
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 20:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706934886; x=1707539686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEyrgFwwKoShgj6vdkFSEjnvjtQ1aT81MmdRSOV1nTY=;
        b=CwXwk+cTGQDkC+1TxBeWXs8v+wi6fu2O39c+mVs5XvSPu+0OXvy3Wqiu2TXpeMeZ+/
         bMgll+XGzOVqGnXRQD88NI0RDp7Sq0eH4l/22Ifp6bg3noXBQPh58OpcLmamKrnmgohM
         PYeLLNT4K0EXtn75CMjG7vNuM0Rz8p7rd7llNclwJpgJuHTcWOOcDaPcukoAX3ZT3fPA
         SP+mfydLnK8seDHA4S/mtU0RseG5rOtJbNGd4I1Nwg5Mp6bNNGPQlmsNiuZRm2Trs+kl
         KrdatiezX00xu/X1AQLHHfe2adc8xRYJHSW8WFX5cClKXxKToEVwMZt53KeTY8TdZy3P
         nDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706934886; x=1707539686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEyrgFwwKoShgj6vdkFSEjnvjtQ1aT81MmdRSOV1nTY=;
        b=RltpvFK8Gfbk7lAFIX4Bd+ZWqNjiZve7qywiCk4gHe+1qCs3HLyM3P/GDeaaBe1KN7
         zt8aGXGYHXItPuEgk77aE4HwyiQ5rJxV5wDHt90g1Lx0LDBufbAaV8WV6ywlfuDFX65k
         roTtO7D9qeQBVXlHoqpyypx1aTiaUN3208QjeFPdkAEDC5++wZoTr53yQyJqa1FRWwis
         xKtPl89D43/ftK9iMiW7u8LEWRhUhZ4mo430eM1KY/N0vYy1XgDy7qJfhy7cZhBsJm0L
         CenxvBfjUG8Wm21eoiG+rLFampVuNzI+qr8UEAgFSA4ipqAHXjxECuylLRhNUKElGMGg
         4XDw==
X-Gm-Message-State: AOJu0YyYNvUGcyO79AbpbEIHiNtDKKIzYRfVtIuyMwyE3XyOyFLLUE4M
	KsIpHUo34B11uMrVc6kkg6jeWeeRHQBg3k4+SJebGl9pKPJqaKpxLuPhQzqG+XfcsPPzILogGO0
	agkOU4PDy9GBfXFZceUu8gqYd/t5AXb2WzZEN18pvA38D6p9dMr34
X-Google-Smtp-Source: AGHT+IGDiblbM8v5IY8+18PVR34EF9Hdinoguwe39nhCn0T8cbHUFMRAZhZMvp3/mjXn6wiUTo/tZ74uZGteNAYzk/4=
X-Received: by 2002:a17:902:e801:b0:1d9:4c70:9731 with SMTP id
 u1-20020a170902e80100b001d94c709731mr73869plg.29.1706934885315; Fri, 02 Feb
 2024 20:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203003414.1067730-1-yosryahmed@google.com>
 <CALvZod6pKLhLm6v7da1sm_axvSR07f_buOc9czRfLb5mpzOanw@mail.gmail.com> <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaLs8JTdLEm1UcpO9amYHwDie=TW12f+7q1y_ipxC15cQ@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 2 Feb 2024 20:34:33 -0800
Message-ID: <CALvZod62OZVQ7sYKY5V4685eo3RC8esXNyK87JG9VLX3bjeKpw@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable] mm: memcg: fix struct
 memcg_vmstats_percpu size and alignment
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 8:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Feb 2, 2024 at 8:13=E2=80=AFPM Shakeel Butt <shakeelb@google.com>=
 wrote:
> >
> > On Fri, Feb 2, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > Commit da10d7e140196 ("mm: memcg: optimize parent iteration in
> > > memcg_rstat_updated()") added two additional pointers to the end of
> > > struct memcg_vmstats_percpu with CACHELINE_PADDING to put them in a
> > > separate cacheline. This caused the struct size to increase from 1200=
 to
> > > 1280 on my config (80 extra bytes instead of 16).
> > >
> > > Upon revisiting, the relevant struct members do not need to be on a
> > > separate cacheline, they just need to fit in a single one. This is a
> > > percpu struct, so there shouldn't be any contention on that cacheline
> > > anyway. Move the members to the beginning of the struct and cachealig=
n
> > > the first member. Add a comment about the members that need to fit
> > > together in a cacheline.
> > >
> > > The struct size is now 1216 on my config with this change.
> > >
> > > Fixes: da10d7e140196 ("mm: memcg: optimize parent iteration in memcg_=
rstat_updated()")
> > > Reported-by: Greg Thelen <gthelen@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  mm/memcontrol.c | 19 +++++++++----------
> > >  1 file changed, 9 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index d9ca0fdbe4ab0..09f09f37e397e 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -621,6 +621,15 @@ static inline int memcg_events_index(enum vm_eve=
nt_item idx)
> > >  }
> > >
> > >  struct memcg_vmstats_percpu {
> > > +       /* Stats updates since the last flush */
> > > +       unsigned int                    stats_updates ____cacheline_a=
ligned;
> >
> > Why do you need ____cacheline_aligned here? From what I understand for
> > the previous patch you want stats_updates, parent and vmstats on the
> > same cacheline, right?
>
> Yes. I am trying to ensure that stats_updates sits at the beginning of
> a cacheline to ensure they all fit in one cacheline. Is this
> implicitly guaranteed somehow?
>
> >
> > I would say just remove the CACHELINE_PADDING() from the previous
> > patch and we are good.
>
> IIUC, without CACHELINE_PADDING(), they may end up on different cache
> lines, depending on the size of the arrays before them in the struct
> (which depends on several configs). Am I misunderstanding?
>

Yeah keeping them at the start will be better. Move
____cacheline_aligned to the end of the struct definition like:

struct memcg_vmstats_percpu {
...
} ____cacheline_aligned;


> >
> > In the followup I plan to add usage of __cacheline_group_begin() and
> > __cacheline_group_end() usage in memcg code. If you want, take a stab
> > at it.
>
> For now, I am just looking for something simple to fix the struct size
> proliferation for v6.8, but this would be interesting to see. I wonder
> how __cacheline_group_end() works since the end is decided already by
> __cacheline_group_begin() and the cacheline size.

