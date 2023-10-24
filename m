Return-Path: <cgroups+bounces-72-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5267D5E91
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 01:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CD12819B9
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B1F4311B;
	Tue, 24 Oct 2023 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rxf82Sf6"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233A21116
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 23:10:47 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9F10C6
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:10:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9beb863816so4513460276.1
        for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 16:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698189045; x=1698793845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzKN5BUtlhDu8nh3vJ6vBYgPfOZEUE8HJkvy7AN8Q50=;
        b=Rxf82Sf6jkj6RExgeGvffGJl8vpWicCmYlDZaEQnYjcWiXSMytHzfc4ZOTzJqKTjhY
         P03jjmaWiXfYwU5QYUlQlUkg5TcdDDQ/57p5hs2TxvblvGo9GZ7W0RpJQAkX+Jlv7tOa
         bSwUXaB7TiCWjQwNPqqJUJf3EzXTGHHaXQXxM0TP7KWlSi5vH4LVry77KrhwMCMu/tCc
         oQ+jwqhYa0jXQoMUWTE+ypMsbxZVTK18ha4DXo1YA0rpUmwzSJQe2YCq4Ebzvh8PmcOB
         pglCOulThY+n3zIJ4SicRXe94PYTyUovqs/xWPgd27gCuMMF/gEx0SCNHvJB7NOOMS8O
         ASbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698189045; x=1698793845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzKN5BUtlhDu8nh3vJ6vBYgPfOZEUE8HJkvy7AN8Q50=;
        b=mzIABW1cPO+FA5oYb2QMHZgchvYw5h/AnwUsh2c55s8YvFG1mM4DQt87PR+FeuT7YO
         foM4Qri9v8piotNZBGf0fv0IoKcCXIPOTPkYUtp+84ms+xacn+p2MazH0b8mlawLPhhZ
         WXcUZAU0ZXXHd8/ivQvwMjVkufo0MV/dSBR5CapFE+Pbg+N2JWfmhnfY7vC9HsC7n6zg
         guXQEs67neFaJnW+dWl36wq9gLgoNGE5C5y3Sybhl3orRSmKpgM4P2bx4GWkimkGJurE
         cPioDQQBQseKLC0I2m7G7PujwOpsH/EOlJqRQiriY4/I0SvZ53ywvLjsdW6PVy8fsu0T
         s4yg==
X-Gm-Message-State: AOJu0Yx6Q0e7w+giBYeUGar0TW7RcxhIR0xE4iqSWhe7GAhLuKgZ+TKQ
	3l9kGBcjAXkAfY4opge9BQZ0eQZkEqmVUe9/7E8d6yJwiinqAk6LZ2kNcA==
X-Google-Smtp-Source: AGHT+IEcUVXhJzIRWFIq2gzBZAJHQw+CawWL8nBuU4PX7z/8yOQ9t+okWOiT10lE9M2/w79xwCUvN2bOGT+t/cd1SOQ=
X-Received: by 2002:a25:ae86:0:b0:da0:5136:3d95 with SMTP id
 b6-20020a25ae86000000b00da051363d95mr2511677ybj.40.1698189044797; Tue, 24 Oct
 2023 16:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com> <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
In-Reply-To: <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 24 Oct 2023 16:10:32 -0700
Message-ID: <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 4:57=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, Oct 10, 2023 at 10:14=E2=80=AFAM T.J. Mercier <tjmercier@google.c=
om> wrote:
> >
> > On Tue, Oct 10, 2023 at 9:31=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@sus=
e.com> wrote:
> > >
> > > On Fri, Oct 06, 2023 at 11:37:19AM -0700, "T.J. Mercier" <tjmercier@g=
oogle.com> wrote:
> > > > I suppose it's also possible there is PID reuse by the same app,
> > > > causing the cgroup to become repopulated at the same time as a kill=
,
> > > > but that seems extremely unlikely. Plus, at the point where these
> > > > kills are occurring we shouldn't normally be simultaneously launchi=
ng
> > > > new processes for the app. Similarly if a process forks right befor=
e
> > > > it is killed, maybe it doesn't show up in cgroup.procs until after
> > > > we've observed it to be empty?
> > >
> > > Something like this:
> > >
> > >                                                         kill (before)
> > > cgroup_fork
> > > cgroup_can_fork .. begin(threadgroup_rwsem)
> > > tasklist_lock
> > > fatal_signal_pending -> cgroup_cancel_fork              kill (mid)
> > > tasklist_unlock
> > >                                                         seq_start,
> > >                                                         seq_next...
> > >
> > > cgroup_post_fork  .. end(threadgroup_rwsem)
> > >                                                         kill (after)
> > >
> > > Only the third option `kill (after)` means the child would end up on =
the
> > > css_set list. But that would mean the reader squeezed before
> > > cgroup_post_fork() would still see the parent.
> > > (I.e. I don't see the kill/fork race could skew the listed procs.)
> > >
> > So here is a trace from a phone where the kills happen (~100ms) after
> > the forks. All but one of the children die before we read cgroup.procs
> > for the first time, and cgroup.procs is not empty. 5ms later we read
> > again and cgroup.procs is empty, but the last child still hasn't
> > exited. So it makes sense that the cset from that last child is still
> > on the list.
> > https://pastebin.com/raw/tnHhnZBE
> >
> Collected a bit more info. It's before exit_mm that the process
> disappears from cgroup.procs, but the delay to populated=3D0 seems to be
> exacerbated by CPU contention during this time. What's weird is that I
> can see the task blocking the rmdir on cgrp->cset_links->cset->tasks
> inside of cgroup_destroy_locked when the rmdir is attempted, so I
> don't understand why it doesn't show up when iterating tasks for
> cgroup.procs.
>
> I'm going to be out until next Wednesday when I'll look some more.

Back on this and pretty sure I discovered what's happening. For
processes with multiple threads where each thread has reached
atomic_dec_and_test(&tsk->signal->live) in do_exit (but not all have
reached cgroup_exit yet), subsequent reads of cgroup.procs will skip
over the process with not-yet-fully-exited thread group members
because the read of task->signal->live evaluates to 0 here in
css_task_iter_advance:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/cgroup/cgroup.c?h=3Dv6.5#n4869

But the cgroup is not removable yet because cgroup_exit hasn't been
called for all tasks.

Since all tasks have been signaled in this case and we're just waiting
for the exits to complete, I think it should be possible to turn the
cgroup into a zombie on rmdir with the current behavior of
cgroup.procs.

Or if we change cgroup.procs to continue showing the thread group
leader until all threads have finished exiting, we'd still probably
have to change our userspace to accommodate the longer kill times
exceeding our timeouts. So I'm going to change our userspace anyway as
suggested by Tejun. But I'd be interested to hear what folks think
about the potential kernel solutions as well.

Thanks,
T.J.

