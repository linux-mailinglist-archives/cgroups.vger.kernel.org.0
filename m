Return-Path: <cgroups+bounces-9355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4BB32980
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 17:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E630688025
	for <lists+cgroups@lfdr.de>; Sat, 23 Aug 2025 15:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A9023183C;
	Sat, 23 Aug 2025 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y3d3EgDf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0E1D9A5F
	for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755962254; cv=none; b=DI4gAK5+vSHop/XKGdNGfU8rgTlsr+aGnQEUQRpIAZE+ewMYth2AfAN8wAzVW5Zo1WF2mBiv6qIJoTd0ZMNllSgmlo2I5yGrn9JHmOUXVsqAb/Ywhj68vLhG31DPO9YrCsPjQuSsgmvbuEnzRYRqojXckthw0af+i6lCt8KsM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755962254; c=relaxed/simple;
	bh=8gddN4QAHS9UO9USCj5SBZtn10yohbkXCSnNNqxIG34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb0wsIW5XAYgsLa8bd8nCxyO4Unl1TeI6KZgEVhwBsfvOUwTQIatM58L+yL7Emc33Syx8BLd963twzoBhDPv+btXzx0VQCp6ZBfcQk6uDQT1wPm5LdIPQ0lCMfLUcatjTOB31TnHshiAFgtC5NOlOQrqmqCpzYIgMVG7ahYyfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y3d3EgDf; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e931c71a1baso4395877276.0
        for <cgroups@vger.kernel.org>; Sat, 23 Aug 2025 08:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755962251; x=1756567051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuRxDgISxpxh2GnvxFHQaLERLGxx6pa9QJkvdj6dXFA=;
        b=Y3d3EgDfMMFAfeWUu85nopbtkfZJN0qeDkv2wdqm7qYqNqae0k5J1knswr/W/Ucc7c
         P6/IExNjaRzWRgJyG/YUfM1UGaWHTdM7Jbua0/YhBGbyR/JVH3Iv3qSfHKSCMh3Ee6tT
         li9xjGDYEnk68HRMUKWs9cMJAgAzMnMLTgSYMeIn19Gtnwr7GfTFQQKJpAF+2IbO6AKX
         Wv2nHk5ykiuLy0bzFcsAm0I/x9Q/x8lKFc9aS/nOasEA6jKDkfT5H+0xhS2tMnPw0nPw
         CJ3j31iXh3eQkRkoTp6+8p0LsVNt15IgaFszcqDxXmHP5HF36YvM+zvA/JsgfwKJneWR
         84+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755962251; x=1756567051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuRxDgISxpxh2GnvxFHQaLERLGxx6pa9QJkvdj6dXFA=;
        b=FKUOW2iFBp0PYSkfMmISn7xWgewj0r6rlu1058e5ulU4xzlNJssiHs77bwHG9x4VJn
         hhYW24/TPHwwauyMtZ06uaLycvVTe7MdZ1+Xp3hm3IdtNgljwog1SzagHSlR1gdjWjSY
         uoPwiOC259fmzYBwrsjX/1wSKiLg27sEOHE9+4blKPIeh524wzFoyG1FfXHfKCnc0VtV
         wprY2NUZsTZMFKZKMWA2DuMN5zFW8lhtPB6Ikd8wIUx36TLhlr6H1T+VFqGRky37J3sZ
         602a/ntGv7rMcPgPszPM1O69eE5Xbdb+JyIOxTDR//EFRCScromVCNAsv8U03NwH/hyT
         qCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1QDn9Hn9wf4T4PG/DdOXkFN6BuOuFmoj4f2telzsGU/5xONlXBj71JHjaDu9NLpYLLnNmtqtN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+Zi+B3GhttEL4EOwLNmYRUI7LHtJ1RrUjWS7PZ4yq6l5PA5F
	ExZNFPE56F6tepHR0+wJ9y/F2QPguxlc2tQuRUyFFuf74Owoqq6O+uW34fhBeDfpyKMMFSnveTI
	dS2E4EbRi6MPpSpWqdUrg8NTMW4FB33EyxX9KK5L/bQ==
X-Gm-Gg: ASbGncvAV4Mv+1X4E9pUSMG6MuEYyCYtI6Os8YgVJvciBJtnRYNNCU6QFlFa4CPG1bR
	nxLJB2wwJTtlNyRQ7kunuM2sIkVHwe7lbGBCljfeYi9VJBDygz5E4idRaH79y5y5ndkIIpJpSzC
	zg7yQGVL2G0b1eTFra5xq7wAJcu9qTmY3xRzQsBjAsKW12V6PJ/SN+Vq8TfLJ2vcPbJoPVbbFi4
	mG6Ejefg9sc
X-Google-Smtp-Source: AGHT+IGfmqDZeqPR9mSevC/rcJ40kyyYwYfMlgm7zFyEEtXeFJRkcrNU7yLh0iiiwELRzs/EafzpuCacOFikh66vbYo=
X-Received: by 2002:a05:690c:6102:b0:71f:f866:bba4 with SMTP id
 00721157ae682-71ff866f374mr19817227b3.17.1755962250487; Sat, 23 Aug 2025
 08:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHSKhtd_oM8yXBwgm1-6FGhDEaDGCWunohMnb4AtV8Y-__z-zg@mail.gmail.com>
 <a3f9e0fd-28fd-41ea-9c78-e3c971e7445c@gmail.com>
In-Reply-To: <a3f9e0fd-28fd-41ea-9c78-e3c971e7445c@gmail.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Sat, 23 Aug 2025 23:17:19 +0800
X-Gm-Features: Ac12FXwWa1i1Z_eWULAcABG_D4uLHUyCsSFkbKNqIneaeOcJBr_iJqr2a3VgmDw
Message-ID: <CAHSKhtewVTFTsfnLQwjJeaqg950Rn-_Jde5pQq8knoJaX=XsLQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, tj@kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 23, 2025 at 10:09=E2=80=AFPM Giorgi Tchankvetadze
<giorgitchankvetadze1997@gmail.com> wrote:
>
> Makes sense, yeah. What about using a shared, long-lived completion
> object (done_acc) inside cgwb_frn. All writeback jobs point to this same
> object via work->done =3D &frn->done_acc.

Well, IMO there's still no method to know which work has finished and
which hasn't. All we know is whether all the work has finished or not,
isn't it?
>
> On 8/23/2025 12:23 PM, Julian Sun wrote:
> > Hi,
> >
> > On Sat, Aug 23, 2025 at 4:08=E2=80=AFPM Giorgi Tchankvetadze
> > <giorgitchankvetadze1997@gmail.com> wrote:
> >> > Hi there. Can we fix this by allowing callers to set work->done =3D
> > NULL > when no completion is desired?
> > No, we can't do that. Because cgwb_frn needs to track the state of wb
> > work by work->done.cnt, if we set work->done =3D Null, then we can not
> > know whether the wb work finished or not. See
> > mem_cgroup_track_foreign_dirty_slowpath() and
> > mem_cgroup_flush_foreign() for details.
> >
> >> The already-existing "if (done)" check in finish_writeback_work() > al=
ready provides the necessary protection, so the change is purely >
> > mechanical. > > > > On 8/23/2025 10:18 AM, Julian Sun wrote: > > Hi, > =
>
> >  > > On Sat, Aug 23, 2025 at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> =
wrote: >
> >  >> > Hello, > > On Fri, Aug 22, 2025 at 04:22:09PM +0800, Julian Sun >
> >  > wrote: > > +struct wb_wait_queue_head { > > + wait_queue_head_t
> > waitq; > > > > + wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > >
> > wait_queue_head_t > > itself already allows overriding the wakeup
> > function. > Please look for > > init_wait_func() usages in the tree.
> > Hopefully, that should > contain > > the changes within memcg. > >
> > Well... Yes, I checked this function before, but it can't do the same >
> >  > thing as in the previous email. There are some differences=E2=80=94p=
lease > >
> > check the code in the last email. > > > > First, let's clarify: the key
> > point here is that if we want to remove > > wb_wait_for_completion() an=
d
> > avoid self-freeing, we must not access > > "done" in
> > finish_writeback_work(), otherwise it will cause a UAF. > > However,
> > init_wait_func() can't achieve this. Of course, I also admit > > that
> > the method in the previous email seems a bit odd. > > > > To summarize
> > again, the root causes of the problem here are: > > 1. When memcg is
> > released, it calls wb_wait_for_completion() to > > prevent UAF, which i=
s
> > completely unnecessary=E2=80=94cgwb_frn only needs to > > issue wb work=
 and no
> > need to wait writeback finished. > > 2. The current
> > finish_writeback_work() will definitely dereference > > "done", which
> > may lead to UAF. > > > > Essentially, cgwb_frn introduces a new scenari=
o
> > where no wake-up is > > needed. Therefore, we just need to make
> > finish_writeback_work() not > > dereference "done" and not wake up the
> > waiting thread. However, this > > cannot keep the modifications within
> > memcg... > > > > Please correct me if my understanding is incorrect. >
> >  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun
> > <sunjunchao@bytedance.com> > > > > > > Hi, > > > > On Sat, Aug 23, 2025
> > at 1:56=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote: > >> > Hello, > > O=
n Fri,
> > Aug 22, 2025 at 04:22:09PM +0800, Julian Sun > > wrote: > > +struct
> > wb_wait_queue_head { > > + wait_queue_head_t waitq; > > > > +
> > wb_wait_wakeup_func_t wb_wakeup_func; > > +}; > > wait_queue_head_t > >
> > itself already allows overriding the wakeup function. > Please look for
> >  > > init_wait_func() usages in the tree. Hopefully, that should >
> > contain > > the changes within memcg. > > Well... Yes, I checked this
> > function before, but it can't do the same > > thing as in the previous
> > email. There are some differences=E2=80=94please > > check the code in =
the last
> > email. > > > > First, let's clarify: the key point here is that if we
> > want to remove > > wb_wait_for_completion() and avoid self-freeing, we
> > must not access > > "done" in finish_writeback_work(), otherwise it wil=
l
> > cause a UAF. > > However, init_wait_func() can't achieve this. Of
> > course, I also admit > > that the method in the previous email seems a
> > bit odd. > > > > To summarize again, the root causes of the problem her=
e
> > are: > > 1. When memcg is released, it calls wb_wait_for_completion() t=
o
> >  > > prevent UAF, which is completely unnecessary=E2=80=94cgwb_frn only=
 needs to
> >  > > issue wb work and no need to wait writeback finished. > > 2. The
> > current finish_writeback_work() will definitely dereference > > "done",
> > which may lead to UAF. > > > > Essentially, cgwb_frn introduces a new
> > scenario where no wake-up is > > needed. Therefore, we just need to mak=
e
> > finish_writeback_work() not > > dereference "done" and not wake up the
> > waiting thread. However, this > > cannot keep the modifications within
> > memcg... > > > > Please correct me if my understanding is incorrect. >
> >  >> > Thanks. > > -- > tejun > > > > Thanks, > > -- > > Julian Sun
> > <sunjunchao@bytedance.com> > > > >
> > Thanks,
> > --
> > Julian Sun <sunjunchao@bytedance.com>
> >
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

