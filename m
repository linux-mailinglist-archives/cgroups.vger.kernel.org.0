Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600567C025C
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 19:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjJJROl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 13:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjJJROk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 13:14:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEB93
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 10:14:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d865854ef96so6303055276.2
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696958078; x=1697562878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SERZmlYmwyiDyXq/1ko2OXTRLCO8KiO4yKDjTh6e2tA=;
        b=GgViXBXnCqCzY7FRJGHji9ENpwIc6m+SLpFK+cy0AJCBJCzRSc+q9snycN8nKF/O/s
         fSz4oF/QT/FlTv9XXSfSf6DQOW2pxakjlQWVHx8yNWSfEEdRhwKWOALhaGGXJOP5+axQ
         dwFmTONPFfF3fzUbLttYJay1xq1Sz4mewzjAcHIO3eYiLF6+Tj9W5OMqIEqcMX6r5HhE
         MxVYhDN61ZchBjT1xFIHJ9ucHOPFr5J+aCve4zTFmI9HjhFsiUzNfUOMLCqK3wy2PyNk
         JmFKXiVuLHCH0HWG5DmeZTRNIhArBOExzVwowZc8C0f32uz/GOOjyhqEO9cr54DRomSr
         kXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696958078; x=1697562878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SERZmlYmwyiDyXq/1ko2OXTRLCO8KiO4yKDjTh6e2tA=;
        b=v2yPejBH2eGFprmSw38fVout3BxzqJJqqC77cKlKkR0ShZQHGoD/ICdIn7YsbUuJh1
         WhLz88FL4qRTgKGb5ItzGV/H588A0zdEcci8mEGmPsCvA5KkURdOpGFnCiE/ojnHv5+Y
         hPuN+zTVF1CyUojpKVgWQ7uzt3/k12zGpUj3JTBUMIPzmvgqsyMHgKTp9xyRyauKfm/t
         7hbnROCd4Ny4XRlFumWPRdrYVgqGG2DAitCG30ESErzF1Gzh0LZqRj/dJcRbAw21LhCd
         rCmOFKjPpg9gvANNeyaJnkUlekQJF53dUwAaPPWMVEcuxWqHntxY4aDdQLWZo+LkV9Kn
         vhYQ==
X-Gm-Message-State: AOJu0Yy9sbKn0cQp0Hvx8RAa9IxkocT+4c7TBJY8sezXP1hh9PQSkacR
        Lpjey/FBmK/n0pDg0zEErVJG1BDr9I+lFJLlCfC/Ow==
X-Google-Smtp-Source: AGHT+IGyvp8zxa0r3ySBY1/0yrfvUji7poSIS2YnCG0hQvkYC0pGyJWmWeGFLJqbVEoEfOxyq0r6kajQIqfQvlouYhk=
X-Received: by 2002:a25:1f0a:0:b0:d9a:4ae7:ba2c with SMTP id
 f10-20020a251f0a000000b00d9a4ae7ba2cmr3218705ybf.22.1696958078340; Tue, 10
 Oct 2023 10:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com> <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
In-Reply-To: <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 10 Oct 2023 10:14:26 -0700
Message-ID: <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 9:31=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Fri, Oct 06, 2023 at 11:37:19AM -0700, "T.J. Mercier" <tjmercier@googl=
e.com> wrote:
> > I suppose it's also possible there is PID reuse by the same app,
> > causing the cgroup to become repopulated at the same time as a kill,
> > but that seems extremely unlikely. Plus, at the point where these
> > kills are occurring we shouldn't normally be simultaneously launching
> > new processes for the app. Similarly if a process forks right before
> > it is killed, maybe it doesn't show up in cgroup.procs until after
> > we've observed it to be empty?
>
> Something like this:
>
>                                                         kill (before)
> cgroup_fork
> cgroup_can_fork .. begin(threadgroup_rwsem)
> tasklist_lock
> fatal_signal_pending -> cgroup_cancel_fork              kill (mid)
> tasklist_unlock
>                                                         seq_start,
>                                                         seq_next...
>
> cgroup_post_fork  .. end(threadgroup_rwsem)
>                                                         kill (after)
>
> Only the third option `kill (after)` means the child would end up on the
> css_set list. But that would mean the reader squeezed before
> cgroup_post_fork() would still see the parent.
> (I.e. I don't see the kill/fork race could skew the listed procs.)
>
So here is a trace from a phone where the kills happen (~100ms) after
the forks. All but one of the children die before we read cgroup.procs
for the first time, and cgroup.procs is not empty. 5ms later we read
again and cgroup.procs is empty, but the last child still hasn't
exited. So it makes sense that the cset from that last child is still
on the list.
https://pastebin.com/raw/tnHhnZBE

> (But it reminds me another pathological case of "group leader
>  separation" where:
> - there is a multithreaded process,
> - threadgroup leader exits,
> - threadgroup is migrated from A to B (write to cgroup.procs)
>   - but leader stays in A (because it has PF_EXITING),
> - A will still show it in cgroup.procs,
> - B will not include it in cgroup.procs despite it hosts some threads of
>   the threadgroup (effectively populated).
> It's been some time, I didn't check if it's still possible nowadays.)
>
I don't think this is what 's happening because these processes only
get migrated once in their lifetimes (from the zygote cgroup to their
per-application cgroup), and the user/app code doesn't run until after
the migration completes which is the first time a thread could be
created.

> BTW is there any fundamental reason the apps cannot use the
> notifications via cgroup.events as recommended by Tejun?
>
This would require that we read both cgroup.procs and cgroup.events,
since we'd still want to know which processes to signal. I assumed
this would increase lock contention but there's no synchronization on
cgroup_is_populated so it looks like not. I had already identified
this as a workaround, but I'd prefer to depend on just one file to do
everything.
