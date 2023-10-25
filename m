Return-Path: <cgroups+bounces-88-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A2E7D7346
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 20:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2351BB21092
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8C2869A;
	Wed, 25 Oct 2023 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2PahOBpt"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70C31A6D
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 18:30:11 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975BB123
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 11:30:09 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5a7ad24b3aaso212887b3.2
        for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698258609; x=1698863409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AGjug/ZalpYwbhEtdGvaPRgrhAGa7Qdg/UkHWx2EjA=;
        b=2PahOBpt5r8XtdfOczonOo0iDQcHQAaBSdD8lsgOjiIOZhrwq6xsuy23g8/lKAkzDs
         3U2bUd6m/vfsUw6+aHQOwNC+Yj9juIZfCyCE7FFa6r/AX9uAjGbLEmfRULPNkXMKba2+
         BFRLR/Sm9Cf3nRu1dQNfysB6UMH5dM/wGZDm8wCOaXWFje5rjhmo1sywLp4ASynqaQvR
         nvoegQmlj6iorNu3R2vxbMa4B2NZbY5eWhp/ncfneR2hA8/CpaGA0pluarYRHlO0CQ3N
         Sa+JKUK2ddLejnMB8xuakisjsec8iJg0YsJTSzRJbEXY0sOYwBVDVZkm/mZbuH1iTsMe
         wxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698258609; x=1698863409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AGjug/ZalpYwbhEtdGvaPRgrhAGa7Qdg/UkHWx2EjA=;
        b=oKfOzD9u0i+Ga3LpEarcEVklF7/ch/KQvcCcLychFpZ1Xdp7PoADbv9z79Phv3xVz6
         gqWntyLMgpCpOkLudmN0ZyVRzltx0Hv2qc2vEIxzcPtX1FCCl9zL/IrhK0gmsIkpNmuP
         fX+eheWCiIZEijx+J7n9anF8sUF2LMvFG0ZsSvlQsPu6qClo9xIDYqEUHlRJ7+Fl+++l
         PAhzGar82imTiG4AHoVVcwiC3g5dbGLpsHpzUOnIbtq/lo9b0Vlz2ydufY7UqClw7SaY
         vDK2ADtIwtefJBByG4QDuDj1GBC/kje4GTxrYf3+aVU/haSctmg2EpsQ3vpHuo36BC7k
         ZCOw==
X-Gm-Message-State: AOJu0YxkMdcG+kQqGfrEtf4cXbAjhdhQ6s+EV11jzLJenvcPN4umjtNs
	3887qcw2W8yaxZ2FgMLJYHNg+Hfsas75BhDT9B1v2g==
X-Google-Smtp-Source: AGHT+IF1njPPY9rAPCmgfI2NOxL//O1EtFpROeDZSqmbwsOKTlCKA18GCZaedk8YEGovXb6mtcrU0GW/bGzYZ5+vnwY=
X-Received: by 2002:a05:690c:16:b0:5a8:d92b:fbf3 with SMTP id
 bc22-20020a05690c001600b005a8d92bfbf3mr17811712ywb.38.1698258608533; Wed, 25
 Oct 2023 11:30:08 -0700 (PDT)
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
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
 <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
 <CABdmKX2jJZiTwM0FgQctqBisp3h0ryX8=2dyAgbPOM8+NugM6Q@mail.gmail.com> <5quz2zmnv4ivte6phrduxrqqrcwanp45lnrxzesk4ykze52gx7@iwfkmy4shdok>
In-Reply-To: <5quz2zmnv4ivte6phrduxrqqrcwanp45lnrxzesk4ykze52gx7@iwfkmy4shdok>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 25 Oct 2023 11:29:56 -0700
Message-ID: <CABdmKX0h6oi7VE=rzSAvCFGPHhG6jWh+7k1_p6SwV5dYGcUPDQ@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 6:30=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hi.
>
> On Tue, Oct 24, 2023 at 04:10:32PM -0700, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > Back on this and pretty sure I discovered what's happening. For
> > processes with multiple threads where each thread has reached
> > atomic_dec_and_test(&tsk->signal->live) in do_exit (but not all have
> > reached cgroup_exit yet), subsequent reads of cgroup.procs will skip
> > over the process with not-yet-fully-exited thread group members
> > because the read of task->signal->live evaluates to 0 here in
> > css_task_iter_advance:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/kernel/cgroup/cgroup.c?h=3Dv6.5#n4869
>
> Well done! It sounds plausible, the task->signal->live is not synced
> via css_set_lock.
>
> >
> > But the cgroup is not removable yet because cgroup_exit hasn't been
> > called for all tasks.
> >
> > Since all tasks have been signaled in this case and we're just waiting
> > for the exits to complete, I think it should be possible to turn the
> > cgroup into a zombie on rmdir with the current behavior of
> > cgroup.procs.
>
> In this case it could be removed but it would make the check in
> cgroup_destroy_locked() way too complicated (if I understand your idea).
>
I was thinking to remove it from sysfs and prevent migrations / forks,
but keep the cgroup and csets around in a dead state until all tasks
complete their exits. Similar to how with memcg any pages charged to
the memcg keep it alive in the background even after a successful
rmdir. Except in this case we're guaranteed to make progress towards
releasing the cgroup (without any dependency on reclaim or charge
transfer) because all tasks have already begun the process of exiting.
We're just waiting on the scheduler to give enough time to the tasks.

The cgroup_is_populated check in cgroup_destroy_locked is what's
currently blocking the removal, and in the case where
nr_populated_csets is not 0 I think we'd need to iterate through all
csets and ensure that each task has been signaled for a SIGKILL. Or
just ensure there are only dying tasks and the thread group leader has
0 for task->signal->live since that's when cgroup.procs stops showing
the process?

> >
> > Or if we change cgroup.procs to continue showing the thread group
> > leader until all threads have finished exiting, we'd still probably
> > have to change our userspace to accommodate the longer kill times
> > exceeding our timeouts.
>
> Provided this is the cause, you could get this more (timewise) precise
> info from cgroup.threads already? (PR [1] has a reproducer and its fix
> describes exactly opposite listings (confusing) but I think that fix
> actually works because it checks cgroup.threads additionally.)
>
Yes, I just tried this out and if we check both cgroup.procs and
cgroup.threads then we wait long enough to be sure that we can rmdir
successfully. Unfortunately that duration exceeds our current timeouts
in the environment where I can reproduce this, so we eventually give
up waiting and don't actually attempt the rmdir. But I'll fix that
with the change to use the populated notification.

> > So I'm going to change our userspace anyway as suggested by Tejun. But
> > I'd be interested to hear what folks think about the potential kernel
> > solutions as well.
>
> Despite that, I'd stick with the notifications since they use rely on
> proper synchronization of cgroup-info.
>
> HTT,
> Michal
>
> [1] https://github.com/systemd/systemd/pull/23561

Interesting case, and in the same part of the code. If one of the exit
functions takes a long time in the leader I could see how this might
happen, but I think a lot of those (mm for example) should be shared
among the group members so not sure exactly what would be the cause.
Maybe it's just that all the threads get scheduled before the leader.

Thanks!
-T.J.

