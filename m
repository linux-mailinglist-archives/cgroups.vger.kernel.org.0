Return-Path: <cgroups+bounces-3317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A19159D0
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77BF1C22D89
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 22:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490B1A257C;
	Mon, 24 Jun 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ly6Jpr0b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB01A2561
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267723; cv=none; b=KTuouqI4u59eQKLE13e9bCFPzS1lziHqI37Ae8gHaCkzj/P41+pfGPB6cOl6Y7LYWX3TIVQwtet7Nbu8aIKnzeT9HOVY/E1jnNDjjJFP68RfpT3irt1VmTIwuOBXIB/JDINHvBkDvIvThepKdNVI3ngTSlkXUzTdgus4WjPERwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267723; c=relaxed/simple;
	bh=PcN2LJL6kWr6oWgE775RIznao+qaUEEZiOmFAo/x6hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5Vgi1YCzfbNqkDC1MV7HeZACWX+YqUynBB/Tfuujo8eaGYM1TGFBgA3JntnbgtjlEV354CrY0WLgzK/dQartRrSbE4fA5OZqBk9o0WsX3I0VcjhKu7QcF/QHktht35XiQ6g2EP8Ap6t/yF1HUlQH/v5P4D7urwUFT5roJ2aRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ly6Jpr0b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a724b4f1218so236092966b.2
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 15:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267720; x=1719872520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcN2LJL6kWr6oWgE775RIznao+qaUEEZiOmFAo/x6hk=;
        b=ly6Jpr0bu6ozqibhVR06YMAPRKsXj7QLTCvr/30EIIAlaRiZPcffLkrpDgtn6288zX
         dXKORxfZXdndsXqL9etdvJYJbwH7p9ydr7rPvHEWb7VN54QObLCzVOeTaHNqV77zgL9Q
         jT15xd3jVFoTDnBbN7AAdbOKk0eBOS6+LDjRdRvhAu41aaBdk9UWq7rx3ZxATSSMdT5A
         WRFvrZjVpzOJJ/PhwNEEdt0TtavDKkQH2klYDaOX/v/fSe68GXq8Lw5D/G0VS2DFqIYO
         7USpuAqhHJZFW5Z8Sgvn4pxc3/gGCYKUmAvkgWIkBZHp6lkmnSQxKpH5ADd4eHjXGLhq
         7cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267720; x=1719872520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcN2LJL6kWr6oWgE775RIznao+qaUEEZiOmFAo/x6hk=;
        b=eDBLf4z9jETQ2C37wZYVZW+bEN0vNcjmRUoN8iJgMNEiWrwLlUvTTqdnhl54jgzedf
         yiILhCBsO//mfjjSBc2uOVAIx5PKN8wpqe+ibpOaTgGQC/T9cFXLxfebMWypWUutNbP7
         K0CxVB8YjHPP3T7av4l/hCpf1yuSlvRXMJYetFDpMoOeH+V+NlTwV4BsCLaV33SE0E/I
         jnB1X+9BG/tnqc8Jd2bN2S8zvbeiT0Oc6mCXm2yS6bnXIEuRXPFuJyCto3TfajW3bk3g
         G1Q86ofspMfW8e8LNOBG1Q6uiLKfFCG5qI9PV/36xeuxUBc+qrSTjwoNJ5gVXLXjFJSf
         WazA==
X-Forwarded-Encrypted: i=1; AJvYcCWiI5wQxGbrBU3qH3A/rMnvGHYx9Fmb0Tx6anXoOxf3mlA8kO0BNrlHYo6OFytNbwH0wU8ngKhM3yXL+MmdZatjC+AcEpw73Q==
X-Gm-Message-State: AOJu0Yx09LdTI8WLnDkuC96c2IquupS3e6yT/05FdOWZUwuNo14TTB/K
	E2t0wUn2ac/hatN1BrQZ01jb/O3r6nqk/y/uljsvGzuzCYlD+i0XnV70rx87l0Pd+5jUj5R92JA
	YtRQZPp4T/N4VRpP/cRnumpU4WxCqq60rhsqJ
X-Google-Smtp-Source: AGHT+IFo+oka3TVDwdKDk6KZym0SSihHfv4LPK2ktJvuzlqktIKqFKnYrmXTq5Q0GH9QzykFfyUnlf10x/LmX2qpDRA=
X-Received: by 2002:a17:906:7c49:b0:a68:b557:76f5 with SMTP id
 a640c23a62f3a-a7242e12fd3mr364963966b.69.1719267719316; Mon, 24 Jun 2024
 15:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com> <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
In-Reply-To: <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 15:21:22 -0700
Message-ID: <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:17=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Mon, Jun 24, 2024 at 02:43:02PM GMT, Yosry Ahmed wrote:
> [...]
> > >
> > > > There is also
> > > > a heuristic in zswap that may writeback more (or less) pages that i=
t
> > > > should to the swap device if the stats are significantly stale.
> > > >
> > >
> > > Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
> > > zswap_shrinker_count()? There is already a target memcg flush in that
> > > function and I don't expect root memcg flush from there.
> >
> > I was thinking of the generic approach I suggested, where we can avoid
> > contending on the lock if the cgroup is a descendant of the cgroup
> > being flushed, regardless of whether or not it's the root memcg. I
> > think this would be more beneficial than just focusing on root
> > flushes.
>
> Yes I agree with this but what about skipping the flush in this case?
> Are you ok with that?

Sorry if I am confused, but IIUC this patch affects all root flushes,
even for userspace reads, right? In this case I think it's not okay to
skip the flush without waiting for the ongoing flush.

