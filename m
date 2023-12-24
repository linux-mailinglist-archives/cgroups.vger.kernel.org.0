Return-Path: <cgroups+bounces-1011-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7081D7BB
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 04:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ECB1F21B82
	for <lists+cgroups@lfdr.de>; Sun, 24 Dec 2023 03:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB2815;
	Sun, 24 Dec 2023 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/QX6rbX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0820EBD;
	Sun, 24 Dec 2023 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-679dd3055faso19138106d6.0;
        Sat, 23 Dec 2023 19:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703387735; x=1703992535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlVucJe/FAoYS7TVMfgun2EfW+aN4M8qYOO3fXQAQLQ=;
        b=g/QX6rbXDRzOHRa7/2jGeArYQz2ATsg9NpJ8HuzzNVBZ26/euSPpI1vw1JjkDZYHHy
         Vi/tSrA3wq1pvhs5ibqhJpdi28eDK/wkzG0zP2KeVk54clfFBbAIAm9j8Hzb1EJ3z+Ut
         nt4e+Dv9t5eNRWcN0h4vSPXqbSifNhDCyEdz++I6VMqXN6ZeNHw32rArCFCMZZqgwl1w
         7AuQERM21WXU5rLW3UWSQZnluygzz9qVjA1LX6yLUgulmMiDlM/EiLUKwJmrwon99U4B
         BhYBIgGfToqarFKEUQRV+r3o9D4+rdkmOGMPCgTtKi5TQyRfCQxmqjSUX4L1TIV4vRsb
         PhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703387735; x=1703992535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlVucJe/FAoYS7TVMfgun2EfW+aN4M8qYOO3fXQAQLQ=;
        b=DxGx9tGAh3rhDUR8+0e7YI9Lc6lkJ669ttwQccBpTyuZSk87uDCEUndMpteJct+yHK
         x+Bl1Q5P6XMfsE0/uVaEQEqV74v7lZOeSIzOaPcuQuhfM8hiDrBVDR8KFcr15vGQmsGE
         g0Tfm2XcHekuUNJ5O+CzjgK87KAQBQDLVB0WKUozScbZJ6O+AQxyN4X8hZY3XM3DMFZn
         RLUb6SRGiPIhkmYcWxv87P2nlZHvfkeaUUCDPcKqYL5xD+Kxbjkt+XrtJhjZDHoLDE6T
         p5uCMgepz1NY5mKs5y/s82qydYaVdQQrYA/CTMeOwnNu+4QH0LnAQc47nJZKFk2Pwalg
         ChGQ==
X-Gm-Message-State: AOJu0YyduNmFjQ59AhUyNVqsVHnX1lfFvqKNBuZ50u8/G8wEe2jeOkIv
	Psh3anjrXDK8p0SSC3J8M2j9kdP8XMVHX6r6nYI=
X-Google-Smtp-Source: AGHT+IG0lq9Y5bU1VjJG96Qx5xkdSIIhbngzmUEZXFCzn6PYs4KNhDr26d1tNnz/eZYh19gPMhzj6mK1R8PVVtdr/1w=
X-Received: by 2002:a05:6214:1c8a:b0:67f:4890:bbaa with SMTP id
 ib10-20020a0562141c8a00b0067f4890bbaamr4236207qvb.121.1703387735622; Sat, 23
 Dec 2023 19:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222113102.4148-1-laoar.shao@gmail.com> <20231222113102.4148-2-laoar.shao@gmail.com>
 <ZYXLy0AofQyasLkC@mac.lan>
In-Reply-To: <ZYXLy0AofQyasLkC@mac.lan>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 24 Dec 2023 11:14:59 +0800
Message-ID: <CALOAHbAVXhoqw5eekxdnoEOaj8V79gDWpjKoKyABRt+S8zzLCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to psi_system
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:47=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Dec 22, 2023 at 11:30:59AM +0000, Yafang Shao wrote:
> > By initializing the root cgroup's psi field to psi_system, we can
> > consistently obtain the psi information for all cgroups from the struct
> > cgroup.
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  include/linux/psi.h    | 2 +-
> >  kernel/cgroup/cgroup.c | 5 ++++-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/psi.h b/include/linux/psi.h
> > index e074587..8f2db51 100644
> > --- a/include/linux/psi.h
> > +++ b/include/linux/psi.h
> > @@ -34,7 +34,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct =
file *file,
> >  #ifdef CONFIG_CGROUPS
> >  static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
> >  {
> > -     return cgroup_ino(cgrp) =3D=3D 1 ? &psi_system : cgrp->psi;
> > +     return cgrp->psi;
> >  }
>
> How have you tested this change? Looking at the code there are other

After implementing the modification, I solely focused on validating
the functionality of root_cgrp->psi to ensure its compatibility with
the recent changes, akin to the self-tests performed in the previous
version [0]. However, it's noteworthy that building the kernel
necessitates clang-14+, hence, I refrained from incorporating this
into the current version.

Regarding the alterations made to /proc/pressure/, I haven't yet
conducted thorough verification to confirm if the adjustments are
comprehensive enough. I will analyze the potential impact on
/proc/pressure/* in the next phase.

[0]. https://lore.kernel.org/bpf/20230801142912.55078-4-laoar.shao@gmail.co=
m/

> references to psi_system, e.g. to show it under /proc/pressure/* and to
> exempt it from CPU FULL accounting. I don't see how the above change woul=
d
> be sufficient.

Thanks for your suggestion.

--=20
Regards
Yafang

