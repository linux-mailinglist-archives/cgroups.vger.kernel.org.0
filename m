Return-Path: <cgroups+bounces-10518-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6413BB4836
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 18:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B163A3488
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B842522A7;
	Thu,  2 Oct 2025 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+H1396U"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238F21ABD0
	for <cgroups@vger.kernel.org>; Thu,  2 Oct 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422158; cv=none; b=jf/QWdB3R7oN49YKbz3WgnK+6APyRkWMtG7vxVCJbG2k4Tta68VTXsmJTPoUknfSDIi3aFXe1CbgkK/RaeeoxX9U8Bj68EkN2DiF52T/FsbUVKRFf4Rrw6AAQ3lUkxFs848VS7yzkLfgvv9PqW/UTdiqzl6U1iuo1Ny3a1wXZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422158; c=relaxed/simple;
	bh=QGIybxUWIo/fpWjPlVkioQPIUWX0XI99dAus9iHNj90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xk6Mvh6bbPT52GOocHuZ8qOyljRO5bBliyhl4dAle6zdXJBI1USRH9jws6YZTgfKvBBux3Rn5nuvGykNOP14ElfHczDz7pVqKfdDlfuGMMqHsRzPbvCjfeaD7fkGDmpI/ipK6/x/pR426viC/qJmAagZqFRPDBJwvwJyFNvZ6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+H1396U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b556284db11so1158687a12.0
        for <cgroups@vger.kernel.org>; Thu, 02 Oct 2025 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759422156; x=1760026956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcmW+Ew4uz5zHRnSkRPvLKByvtHyprDgk3Fv0lQQWSQ=;
        b=d+H1396UkkREEzPBkkDiZh8Ott60iXBXrgWFIBMTiE+XW01LwMOMQPIJhplnhXOrHH
         MxugVCTLCAX0inuxnNe4QzmmQ/59r6Y5HB3EBGXXPcbg5CyT7K+pTLlPr5WUwQHkIZBR
         aqunVp/FdPpGqr7JL+Wm0I5KowI5Rv1DacZdEvHH1clVmzRYrGySmABQ1rm1GDS3kVXt
         yDyZ6V5unJGQDujJELvrzmNPrmnVzqab66zsFfsh3MrJrnhJJaKtolmPG5IChGg043Dc
         H7eVm+xh53ibF6Svzkoz+jM1lc6LoTeEmRQH2b925MzicdQqllLsUxbXf1Cb28Zj8I4u
         rRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422156; x=1760026956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcmW+Ew4uz5zHRnSkRPvLKByvtHyprDgk3Fv0lQQWSQ=;
        b=nkfSc7zq4rfgQUWJ6efrX6DM0yMQ/Vk0Lx/vXsBQC5YSgxODe5zbFx47gx/VrXxCqg
         whj8Qspf0oFulRP4tWi3ccHiSBQviFfErMsro72+wBVAW7639N54dyGuWoRgywCBitXp
         lmPOMTLGi4YIvb73pUVAZUI/jn7jb+SZW6J5gQTVwScoXzU9Gs380oifIitHMifRLaiu
         lX99fhAZUWbdY3JA+6wy+F274bqNeDdSpapQ2K6rlprQzJmIXUzwrDFEgFP56P6muxd6
         Dc2kat/0s/w85L66N7YzrCZtPvyccPLSF3EDU55XRvinkgDyhQ4jX49K+5HDZnf6JdTf
         xh3w==
X-Forwarded-Encrypted: i=1; AJvYcCVY/5JCHLi3Mq8izP7ZB7PILESjQGAhnMvJzWJcxupLrDp4daLV5VD8mWnl5vorFdsu8JP2UOgd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv3Yg+WTiUxudfWrFTPqwfdW7lMieG154odpQ662TFZ5taOIcs
	3lMmMOT5BAdMfN/iSZu1QXSbCFfSIfR7rmD711Kzc33oBaCi9i+PJIrs9Cb/pTML9+CqnbiHWUf
	Mx3UAusYmfKQLYUpTKr2W9OpOawVfLht7/d60Y9/f
X-Gm-Gg: ASbGncvDqJacnCM7fjlPwpZ1K93NF3y9PaP4rTETZe2b+gtPjtprr5kZTbvMN+kCZ7c
	iiZVDFTD69rA2KyXVr3pJbsxm1WwLtlIKv5BU3RIM//X4/JA4nWXX4WzsDwrTprt9BJJqLMZEDZ
	81jHsesCbNvGX30Ghcx0G5BGB9TM/7WIFKGki0/ZA1tX5mU97wxW1+lDOCNTI1ScG1+ChhDtult
	SAmVXfwoWi9k8HL7dfW6j8qoLZgASe4TgwDqFLChk3xLztqM92RirJbA8hx4hblkdgClH4=
X-Google-Smtp-Source: AGHT+IFNTFrPHAbMV6/5Qvwr8vn9kT2v4YCrJnA1lgWdmelrsTV01jk/KvXHXcMsIf5vGWtTWuLVhQ+tJtc1zoQqtkk=
X-Received: by 2002:a17:902:e552:b0:24b:24dc:91a7 with SMTP id
 d9443c01a7336-28e7f2ff464mr99197155ad.45.1759422156184; Thu, 02 Oct 2025
 09:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002052215.1433055-1-kuniyu@google.com> <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
In-Reply-To: <5k5g5hlc4pz4cafreojc5qtmp364ev3zxkmahwk4yx7c25fm67@gdxsaj5mwy2j>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 2 Oct 2025 09:22:25 -0700
X-Gm-Features: AS18NWAIrcPS3jKugFFIcPfVpeqpTYVrB7j_tzhODluDiOsPr4J2TubIgApxZCc
Message-ID: <CAAVpQUCQaGbV1fUnHWCTqrFmXntpKfg7Gduf+Ezi2e-QMFUTRQ@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq
 when CONFIG_PREEMPT_RT=y.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <ynaffit@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, 
	syzbot+27a2519eb4dad86d0156@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:28=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello.
>
> Thanks for looking into this Kuniyuki.
>
> On Thu, Oct 02, 2025 at 05:22:07AM +0000, Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > The writer side is under spin_lock_irq(), but the section is still
> > preemptible with CONFIG_PREEMPT_RT=3Dy.
>
> I see similar construction in other places, e.g.
>         mems_allowed_seq in set_mems_allowed

IIUC, local_irq_save() or local_irq_disable() is used
for the writer of mems_allowed_seq, so there should
be not preemptible.



>         period_seqcount in ioc_start_period
>         pidmap_lock_seq in alloc_pid/pidfs_add_pid

These two seem to have the same problem.

> (where their outer lock becomes preemptible on PREEMPT_RT.)
>
> > Let's wrap the section with preempt_{disable,enable}_nested().
>
> Is it better to wrap them all (for CONFIG_PREEMPT_RT=3Dy) or should they
> become seqlock_t on CONFIG_PREEMPT_RT=3Dy?

I think wrapping them would be better as the wrapper is just
an lockdep assertion when PREEMPT_RT=3Dn

Thanks!

