Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52517BBECB
	for <lists+cgroups@lfdr.de>; Fri,  6 Oct 2023 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjJFShe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Oct 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjJFShd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Oct 2023 14:37:33 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B3BBE
        for <cgroups@vger.kernel.org>; Fri,  6 Oct 2023 11:37:32 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a24b03e22eso29933217b3.0
        for <cgroups@vger.kernel.org>; Fri, 06 Oct 2023 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696617452; x=1697222252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo8j5LctJjOXSOwYPtAww0DYBAOog101Ybo6uL6Dc3M=;
        b=gf+S7DqEqeNyrZ2ClCfmF6M48HHOUiJSkRtLeRYpVSI3L4O+RaZKsFMOHV/yDjFv7z
         2nc796dmQ4LG+Y15IDKCami/HKe9ubrCHP2hi2Ra9BtrvB7lK3dSbU1RayCgJa8ROtRs
         ty007Ps3mOkzXTJVbBMID8TuYUh/ECwSO6Fz4MQvDyGW/JGoY/E54m9IqUqe/bZ2G4ev
         D8LXJgRCtfLS68LUNtRotLrts/X4e21nr99bO9Cg1UNivvOG1x57bc6sIOyWzJHDGnXq
         OqMV7ZaFd8Kok2oMyE0qQmSp/Uq7xE1R1khWGu//ok337nOXVItaq6RY6QJkCqFJF+BG
         FlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696617452; x=1697222252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo8j5LctJjOXSOwYPtAww0DYBAOog101Ybo6uL6Dc3M=;
        b=K8HPqXYJNXYEd/8bqO1cXnu5H8+9ol2dvtnhiEBzvLrCvfLnNbzNcztJTJ49PcIXHS
         KLVZwd1+5/AEuy/FKGLzuZzMH0hvuBVQKF9JAV8k3o/QjhCKBKknkQ6sn218jJB3d/TS
         53qpfZduk6Wg4OSvoCa+lHLucxoNbJSQu6b3/TBXwkmbdwOHa0fnBL2LdkZshQsI5BV+
         +8BcRdz0I8bGyNMJgPN11lgnFdrvjoJK1VYRjVrglo8vhrJDAxX93q50Fi1KoM60pe7F
         LS3+Je25Ava5Dyb5JbyQ0mWueQMbFnCi3QNPjq0cobS7dYZk0QlHkKsYcnXgP9fn59uT
         YhGA==
X-Gm-Message-State: AOJu0YxptzQiTv3gorKYVBZplcLyTDDV0dEXBt4avnly6htJ02tO9NRJ
        wua7kYJPnBDgnouwS9MrHkd6MR5AHuOIujTETl2w4g==
X-Google-Smtp-Source: AGHT+IG/j49d480i2hrz2vHadaqN2itDTmAzUEVueGHTrOrPgfMjS3jh67+jKlqf1IGijjdxHU7CNTp3QG6FmwLQpt0=
X-Received: by 2002:a25:2109:0:b0:d90:a7a4:7093 with SMTP id
 h9-20020a252109000000b00d90a7a47093mr8307317ybh.55.1696617451513; Fri, 06 Oct
 2023 11:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com> <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
In-Reply-To: <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Fri, 6 Oct 2023 11:37:19 -0700
Message-ID: <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 6, 2023 at 9:58=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.com=
> wrote:
>
> Hello T.J.
>
> A curious case.
>
> I was staring at the code and any ways occurring to me would imply
> css_set_lock doesn't work.
>
> OTOH, I can bring the reproducer to rmdir()=3D-EBUSY on my machine
> (6.4.12-1-default) [1].
>
> I notice that there are 2*nr_cpus parallel readers of cgroup.procs.
> And a single thread's testimony is enough to consider cgroup empty.
> Could it be that despite the 200ms delay, some of the threads see the
> cgroup empty _yet_?
> (I didn't do own tracing but by reducing the delay, I could reduce the
> time before EBUSY was hit, otherwise it took several minutes (on top of
> desktop background).)
>
Hm yes, it's possible a thread runs before the child migrates and sets
noProcs =3D true too early. I added a loop to wait for B to be populated
before running the threads, and now I can't reproduce it. :\

> On Tue, Oct 03, 2023 at 11:01:46AM -0700, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> ...
> > > The trace events look like this when the problem occurs. I'm guessing
> > > the rmdir is attempted in that window between signal_deliver and
> > > cgroup_notify_populated =3D 0.
>
> But rmdir() happens after empty cgroup.procs was spotted, right?
> (That's why it is curious.)
>
Right, we read cgroup.procs to find which processes to kill. Kill them
all, wait until cgroup.procs is empty, and then attempt to rmdir.

I will try changing the cgroup_rmdir trace event to always fire
instead of only when the rmdir succeeds. That way I can get a more
complete timeline.

> > > However on Android we retry the rmdir for 2 seconds after cgroup.proc=
s
> > > is empty and we're still occasionally hitting the failure. On my
> > > primary phone with 3 days of uptime I see a handful of cases, but the
> > > problem is orders of magnitude worse on Samsung's device.
>
> Would there also be short-lived members of cgroups and reading
> cgroup.procs under load?
>
I think the only short-lived members should be due to launch failures
/ crashes. Reading cgroup.procs does frequently happen under load. One
scenario that comes to mind is under memory pressure where LMKD hunts
for apps to kill (after which their cgroups are removed), while
reclaim and compaction are also occurring.

I suppose it's also possible there is PID reuse by the same app,
causing the cgroup to become repopulated at the same time as a kill,
but that seems extremely unlikely. Plus, at the point where these
kills are occurring we shouldn't normally be simultaneously launching
new processes for the app. Similarly if a process forks right before
it is killed, maybe it doesn't show up in cgroup.procs until after
we've observed it to be empty?

I will investigate some more on a phone where I'm seeing this since my
reproducer isn't doing the trick.

Thanks for taking a look Michal.

>
> Thanks,
> Michal
>
> [1] FTR, a hunk to run it without sudo on a modern desktop:
> -static const std::filesystem::path CG_A_PATH =3D "/sys/fs/cgroup/A";
> -static const std::filesystem::path CG_B_PATH =3D "/sys/fs/cgroup/B";
> +static const std::filesystem::path CG_A_PATH =3D "/sys/fs/cgroup/user.sl=
ice/user-1000.slice/user@1000.service/app.slice/a";
> +static const std::filesystem::path CG_B_PATH =3D "/sys/fs/cgroup/user.sl=
ice/user-1000.slice/user@1000.service/app.slice/b";
>
