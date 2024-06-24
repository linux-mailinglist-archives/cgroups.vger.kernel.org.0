Return-Path: <cgroups+bounces-3311-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0998191559A
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143B4B2461B
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11319F474;
	Mon, 24 Jun 2024 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ofi53Tf4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D319E83A
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250889; cv=none; b=GfsxcXTZKSjbF94KU520Q7gW4hZ3nhFs1hhuyuy7pN3UKwXKbEYytHPDrF3NdMGMYoIuKi85f60/CiKFnF99u/NEiBXO7jsA2aSyVbkJVmx4Dp5/DlFVrqt4sd+R/94EQe3PWIMvt3gIzLHDgsB98T02irHC3V+LPFIKCFnG3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250889; c=relaxed/simple;
	bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QngEDPMhqDw5ZNOAmmII9TVWJV2pPFkiGo2FbQzpx5rNyJb1YpsniSPB2Bc+CNfdrqjYUhk7vmvcAypifKqI2IAxX/2ImOovFx57goXU0pNRcmU75CwINAuQSULtuO4vReXVbVhtG9ctEqV165j3i2XJWy4Ly1EAnt+EET1qXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ofi53Tf4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6fe617966fso219372466b.1
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 10:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719250885; x=1719855685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
        b=Ofi53Tf4tQog+D8EO7dBIwI1LobLB8+JbK6ZS6iGpbFm+egs+eT0CX1f4glwrewQht
         7IoHMdiGbJxNTIIOvfSCQrSq2/ctWaICOP8U7TdbCkY65G3e83e+0NKaw2wlkJxH1RsG
         EYQyNweZPN95il8VJMgElC6lycs0xX12C5wzE3kOnA0QBE1PREOpTvqyYKxhnUOO04+o
         I+HEKOk7twKHScoEjpbf0UPUq+EuRB0mqRXhQEOcYlICzZQR2442dAxy/Z9htaDFhE58
         aKNtx8RXg/k6CJPVRGWar/5SfBlVfgPfadBMHFifDlt826z20ZTGRUwuRMbUHTYho5jW
         rL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250885; x=1719855685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xy0P0JjsXZxZJicveAS1RvVzevvMoz85YH/ChWlqVE=;
        b=qpGOz35lzjnCjF3M/R8QvUcb0QI3278c9r2BvLyKaT37HHUG2iTWLCaFfG1s9TSZey
         FnIWmY23AlzjZN1XGWMGLAyHGjO80i8rUD+6ERosR0oP/le5xgGN+GVZPjOE0Si0r2kI
         HVcpSBnH2iWQRlfADFg0o75eWv6RhnauRg/2EmODFH5nRa7ZG8iDDnJWhYTstMFGqYOc
         +Qgh0hAA2LF9JsmFdgFDoboYUxb3qG6jbpPdximy+AepjxpRkBg3nSA2q9XUpV3JV6gd
         8v1fsL44DCKs6OwTDBCXUvz1ekQE+ZO7JimV3vQMYS1FY01RDVKIfcaSqi0qFG2FevWQ
         CzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQgU7Efn2NMs6L+9A4gOsLAF+C4MWyL6CH15Iu9EzJLWvbOr9dMJbnyckd78DhLS5ZFMQQZ/fyO9PYfroqShqb/ncHdKIEOg==
X-Gm-Message-State: AOJu0Yyti93WedUvYdDSH0hhByPhK0+eNs71KO3z1fuHMia9Hr8BfMrS
	G5i71UAyZd0y2uASUEk9ptCvEzbkN2n2nE98VzyU8Mdmokq72yABMl3KD3IzxHxyaVXxLv7zzmg
	g8Egjq4iuhlM3l4VhZ6HQVg7brV9YVAhIX3Oy
X-Google-Smtp-Source: AGHT+IGN0kwEH305qXkCZ+rKKYQEXLaxOppsohbq8yTWO5V/Fuld5DFcgw2j47k12u8a0vEpENBk57Mi5GklK0CSoKI=
X-Received: by 2002:a17:907:c301:b0:a6f:5f5d:e924 with SMTP id
 a640c23a62f3a-a7245b4c9bcmr439831666b.6.1719250884154; Mon, 24 Jun 2024
 10:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com> <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
In-Reply-To: <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 10:40:48 -0700
Message-ID: <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:32=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 4:55=E2=80=AFAM Jesper Dangaard Brouer <hawk@ke=
rnel.org> wrote:
> >
> [...]
> > I am assuming this supersedes your other patch titled "[PATCH RFC]
> > cgroup/rstat: avoid thundering herd problem on root cgrp", so I will
> > only respond here.
> >
> > I have two comments:
> > - There is no reason why this should be limited to the root cgroup. We
> > can keep track of the cgroup being flushed, and use
> > cgroup_is_descendant() to find out if the cgroup we want to flush is a
> > descendant of it. We can use a pointer and cmpxchg primitives instead
> > of the atomic here IIUC.
> >
> > - More importantly, I am not a fan of skipping the flush if there is
> > an ongoing one. For all we know, the ongoing flush could have just
> > started and the stats have not been flushed yet. This is another
> > example of non deterministic behavior that could be difficult to
> > debug.
>
> Even with the flush, there will almost always per-cpu updates which will
> be missed. This can not be fixed unless we block the stats updaters as
> well (which is not going to happen). So, we are already ok with this
> level of non-determinism. Why skipping flushing would be worse? One may
> argue 'time window is smaller' but this still does not cap the amount of
> updates. So, unless there is concrete data that this skipping flushing
> is detrimental to the users of stats, I don't see an issue in the
> presense of periodic flusher.

As you mentioned, the updates that happen during the flush are
unavoidable anyway, and the window is small. On the other hand, we
should be able to maintain the current behavior that at least all the
stat updates that happened *before* the call to cgroup_rstat_flush()
are flushed after the call.

The main concern here is that the stats read *after* an event occurs
should reflect the system state at that time. For example, a proactive
reclaimer reading the stats after writing to memory.reclaim should
observe the system state after the reclaim operation happened.

Please see [1] for more details about why this is important, which was
the rationale for removing stats_flush_ongoing in the first place.

[1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.=
com/

>
> >
> > I tried a similar approach before where we sleep and wait for the
> > ongoing flush to complete instead, without contending on the lock,
> > using completions [1]. Although that patch has a lot of complexity,
>
> We can definitely add complexity but only if there are no simple good
> enough mitigations.

I agree that my patch was complicated. I am hoping we can have a
simpler version here that just waits for ongoing flushers if the
cgroup is a descendant of the cgroup already being flushed.

