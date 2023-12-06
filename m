Return-Path: <cgroups+bounces-855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4140806A8D
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 10:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E051C20850
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 09:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6C41A588;
	Wed,  6 Dec 2023 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+/x+gJe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358A7692;
	Wed,  6 Dec 2023 01:00:46 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67adaacd943so11245806d6.0;
        Wed, 06 Dec 2023 01:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701853245; x=1702458045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0DKAYeWHrIOHg+OJus+i9Ob39IuHW/MVdjVCMWpwqY=;
        b=V+/x+gJevNYOdHv3Lz5sC4zY9sdP5JXN8Z/p8vIgkUQ51rRse1RJ+qOz1NHIPg7rW2
         WMGVZL0uCLxjWGK+C4q2GFzn4LNqWutDMIOElYg6TmTBLuFMLxORUmy4PujAR4aCF22V
         YFJyMS6U5i/9WFWNGH6Fu4YzKHjk768UX2dzsp+CdwOKW7/qHVBu8T60JWLfdn6v8gEb
         OlLtTpMNbq51IGeJ3KESschoGBpNdwNJnep1adTz6oQQ/MVTkaiVx4Nr6/ziOqtQXzRM
         jlEeTBxh4GJZueKt54V9SOVQ+urCmxyeczWSB+GnvIaQ9pJ5CdotkS5FBwYOB3H1ssmV
         V14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853245; x=1702458045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0DKAYeWHrIOHg+OJus+i9Ob39IuHW/MVdjVCMWpwqY=;
        b=TEmQvWvCqxzFmvsGmFapartYKbaUMQH8x5YahP/YyqT8rTXPmIbuJMLWCgih9QlsWW
         vJHqGQCCLAONXU05Gw6ugQNML3jH6Uk77kOSy0zqhYDHFg3CCbIPeib/axeAjRNW9s6w
         kSw/Ir+UCHI9DQlJSWW4N6JuZJ9YIEWgI9vM3s7zZGTR8w5ch1vcsDx1dF5i0ssWFi5A
         huMkYgb3xxeenfMFBp+qmQ24RphOcl2ZzSc0BSwl7wpC27QmjCijnif8qProrr33zRbl
         qiV3QrI661htVbvX4wgYdaLfr1DUsVThoMQQkrAk7PSJRZdAz0Aynn/p7F+oRzbQKQoH
         jQ8w==
X-Gm-Message-State: AOJu0YwQchCBMFmKqmxNcXTEOc1vWfdxy/T7q0kWYdw8uBuGbzLX0i4E
	00B82xGmLvJpF28pBg1SzWTvCQTaFy0uYeEyHFI=
X-Google-Smtp-Source: AGHT+IFvAqF9AW6SExsbhpu/ZZ3fLsIv7ocpZIS4TTUS1V8wVtqpcNjk6nQpxh3D2sbtEH0V0gqczcm7aApY0v8mpxs=
X-Received: by 2002:a05:6214:584e:b0:67a:a721:82ec with SMTP id
 ml14-20020a056214584e00b0067aa72182ecmr525991qvb.70.1701853245441; Wed, 06
 Dec 2023 01:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205143725.4224-1-laoar.shao@gmail.com> <20231205143725.4224-4-laoar.shao@gmail.com>
 <0aba58ed-e3bd-4698-9e7d-e68b03573361@linux.dev>
In-Reply-To: <0aba58ed-e3bd-4698-9e7d-e68b03573361@linux.dev>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 6 Dec 2023 17:00:09 +0800
Message-ID: <CALOAHbD00WQTo166rFRG+KwNDh=fv0AiRGhYPPKkOHfoGzo-DQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: Add selftests for cgroup1
 local storage
To: Yonghong Song <yonghong.song@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org, 
	bpf@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 12:24=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 12/5/23 9:37 AM, Yafang Shao wrote:
> > Expanding the test coverage from cgroup2 to include cgroup1. The result
> > as follows,
> >
> > Already existing test cases for cgroup2:
> >    #48/1    cgrp_local_storage/tp_btf:OK
> >    #48/2    cgrp_local_storage/attach_cgroup:OK
> >    #48/3    cgrp_local_storage/recursion:OK
> >    #48/4    cgrp_local_storage/negative:OK
> >    #48/5    cgrp_local_storage/cgroup_iter_sleepable:OK
> >    #48/6    cgrp_local_storage/yes_rcu_lock:OK
> >    #48/7    cgrp_local_storage/no_rcu_lock:OK
> >
> > Expanded test cases for cgroup1:
> >    #48/8    cgrp_local_storage/cgrp1_tp_btf:OK
> >    #48/9    cgrp_local_storage/cgrp1_recursion:OK
> >    #48/10   cgrp_local_storage/cgrp1_negative:OK
> >    #48/11   cgrp_local_storage/cgrp1_iter_sleepable:OK
> >    #48/12   cgrp_local_storage/cgrp1_yes_rcu_lock:OK
> >    #48/13   cgrp_local_storage/cgrp1_no_rcu_lock:OK
> >
> > Summary:
> >    #48      cgrp_local_storage:OK
> >    Summary: 1/13 PASSED, 0 SKIPPED, 0 FAILED
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> LGTM with a few nits below.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> > ---
> >   .../bpf/prog_tests/cgrp_local_storage.c       | 92 ++++++++++++++++++=
-
> >   .../selftests/bpf/progs/cgrp_ls_recursion.c   | 84 +++++++++++++----
> >   .../selftests/bpf/progs/cgrp_ls_sleepable.c   | 67 ++++++++++++--
> >   .../selftests/bpf/progs/cgrp_ls_tp_btf.c      | 82 ++++++++++++-----
> >   4 files changed, 278 insertions(+), 47 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.=
c b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> > index 63e776f4176e..9524cde4cbf6 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c
> > @@ -19,6 +19,9 @@ struct socket_cookie {
> >       __u64 cookie_value;
> >   };
> >
> > +bool is_cgroup1;
> > +int target_hid;
> > +
> >   static void test_tp_btf(int cgroup_fd)
> >   {
> >       struct cgrp_ls_tp_btf *skel;
> > @@ -29,6 +32,9 @@ static void test_tp_btf(int cgroup_fd)
> >       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> >               return;
> >
> > +     skel->bss->is_cgroup1 =3D is_cgroup1;
> > +     skel->bss->target_hid =3D target_hid;
>
> Let reverse the order like below to be consistent with other code pattern=
s:

will change it.

> +       skel->bss->target_hid =3D target_hid;
> +       skel->bss->is_cgroup1 =3D is_cgroup1;
>
> > +
> >       /* populate a value in map_b */
> >       err =3D bpf_map_update_elem(bpf_map__fd(skel->maps.map_b), &cgrou=
p_fd, &val1, BPF_ANY);
> >       if (!ASSERT_OK(err, "map_update_elem"))
> > @@ -130,6 +136,9 @@ static void test_recursion(int cgroup_fd)
> >       if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
> >               return;
> >
> > +     skel->bss->target_hid =3D target_hid;
> > +     skel->bss->is_cgroup1 =3D is_cgroup1;
> > +
> >       err =3D cgrp_ls_recursion__attach(skel);
> >       if (!ASSERT_OK(err, "skel_attach"))
> >               goto out;
> > [...]
> > diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c b/to=
ols/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> > index 4c7844e1dbfa..985ff419249c 100644
> > --- a/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> > +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_sleepable.c
> > @@ -17,7 +17,11 @@ struct {
> >
> >   __u32 target_pid;
> >   __u64 cgroup_id;
> > +int target_hid;
> > +bool is_cgroup1;
> >
> > +struct cgroup *bpf_task_get_cgroup1(struct task_struct *task, int hier=
archy_id) __ksym;
> > +void bpf_cgroup_release(struct cgroup *cgrp) __ksym;
> >   void bpf_rcu_read_lock(void) __ksym;
> >   void bpf_rcu_read_unlock(void) __ksym;
> >
> > @@ -37,23 +41,56 @@ int cgroup_iter(struct bpf_iter__cgroup *ctx)
> >       return 0;
> >   }
> >
> > +static void __no_rcu_lock(struct cgroup *cgrp)
> > +{
> > +     long *ptr;
> > +
> > +     /* Note that trace rcu is held in sleepable prog, so we can use
> > +      * bpf_cgrp_storage_get() in sleepable prog.
> > +      */
> > +     ptr =3D bpf_cgrp_storage_get(&map_a, cgrp, 0,
> > +                                BPF_LOCAL_STORAGE_GET_F_CREATE);
> > +     if (ptr)
> > +             cgroup_id =3D cgrp->kn->id;
> > +}
> > +
> >   SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> > -int no_rcu_lock(void *ctx)
> > +int cgrp1_no_rcu_lock(void *ctx)
> >   {
> >       struct task_struct *task;
> >       struct cgroup *cgrp;
> > -     long *ptr;
> > +
> > +     if (!is_cgroup1)
> > +             return 0;
>
> Do we need this check? Looks like the user space controls whether it will
> be loaded or not depending on whether it is cgrp1.

will remove this check.

>
> > +
> > +     task =3D bpf_get_current_task_btf();
> > +     if (task->pid !=3D target_pid)
> > +             return 0;
> > +
> > +     /* bpf_task_get_cgroup1 can work in sleepable prog */
> > +     cgrp =3D bpf_task_get_cgroup1(task, target_hid);
> > +     if (!cgrp)
> > +             return 0;
> > +
> > +     __no_rcu_lock(cgrp);
> > +     bpf_cgroup_release(cgrp);
> > +     return 0;
> > +}
> > +
> > +SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
> > +int no_rcu_lock(void *ctx)
> > +{
> > +     struct task_struct *task;
> > +
> > +     if (is_cgroup1)
> > +             return 0;
>
> Same here, check is not needed.

will remove it.

Thanks for your review.

--=20
Regards
Yafang

