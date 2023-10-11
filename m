Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279BB7C6148
	for <lists+cgroups@lfdr.de>; Thu, 12 Oct 2023 01:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjJKX6E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Oct 2023 19:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJKX6E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Oct 2023 19:58:04 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099A94
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 16:58:02 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7a80a96dbso13655137b3.0
        for <cgroups@vger.kernel.org>; Wed, 11 Oct 2023 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697068682; x=1697673482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04nvNIqvjfdJGa9HNQL1RXDxXpr464tpbF5PLlKxJI0=;
        b=tlKdVWq66cCajjKw8PyzkvuH/CQMyusE/t8F0xciShPEC26nalPcNwFhu8QDyHA1/0
         RYm5uY4yVPp4jhJ1gvpk9f92Y+iTQueAC+xivGS1AbGX2+l+ChjsUUG1jS/g04eYEOmM
         DLePBmJL4MnF6cTsaXFgNBXYJJfKa0T4v64Njozy4+lWp3X641UxpvYo9lcXwfCvAanG
         yPt8nwtwOZZ95Mlxjb16Z/qYv9/ocKtdqQVWArLSGR8kiOeKGxdsaqmdT8LvgpQgEjvr
         wrUuqyRvAJ53FUZDZFtCHju23QPpd0O7eBMknFbtbH1lm5IwGkbGL8Wpc99W//jhb0WQ
         nY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697068682; x=1697673482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04nvNIqvjfdJGa9HNQL1RXDxXpr464tpbF5PLlKxJI0=;
        b=inC3B/4F7km6PrxRkqZCn7olVtj/2vK5ePSYCTARya3MFKDCcAKBp5outuIRVFfTx5
         +Q+ETN3RtbV/h2abUMyQ0uriEtbVaQ0EA5C/mPc2+i+EgWGhymQBveBqMcbzYNzrA9Ga
         FsbduAmA8s72EQkYP8mo41C7cCR2SxaOXRFX1QtblDfOX8PTQ6i9+ltSinn78fgtnaEb
         yYciPMjlfyOwtqTi8OmLzsE8UYR57O/34NYyTjvcnNK2wZ0TyMVDeAJt9NHOCJoA0mYB
         zDavPBHgMp+0z0kWlAqfMP5h4uJe76mbGvGe9zcLWAlyGNVveWvIkyI2QeLlmQDH2bG2
         oPIA==
X-Gm-Message-State: AOJu0YwugxbD9RhTBpSLqkTo0+Yyr9x0GCfM7WEqcZ6tWkM6QaZk42az
        s9ZANFT9MapqNy8PduP1Fb48oWcyur/iO6pC1fIn2g==
X-Google-Smtp-Source: AGHT+IHFHnasFKjtzM6hx3ViXaYko/yzkLmeKvl7aiPUrc1DdFg8X/Ukst0T/n0jMttIBy/FSjX9ys88BcnqhQ6BiAc=
X-Received: by 2002:a25:d481:0:b0:d9a:bba3:5e39 with SMTP id
 m123-20020a25d481000000b00d9abba35e39mr498998ybf.30.1697068681638; Wed, 11
 Oct 2023 16:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni> <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
In-Reply-To: <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 11 Oct 2023 16:57:49 -0700
Message-ID: <CABdmKX1O4gFpALG03+Fna0fHgMgKjZyUamNcgSh-Dr+64zfyRg@mail.gmail.com>
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

On Tue, Oct 10, 2023 at 10:14=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> On Tue, Oct 10, 2023 at 9:31=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > On Fri, Oct 06, 2023 at 11:37:19AM -0700, "T.J. Mercier" <tjmercier@goo=
gle.com> wrote:
> > > I suppose it's also possible there is PID reuse by the same app,
> > > causing the cgroup to become repopulated at the same time as a kill,
> > > but that seems extremely unlikely. Plus, at the point where these
> > > kills are occurring we shouldn't normally be simultaneously launching
> > > new processes for the app. Similarly if a process forks right before
> > > it is killed, maybe it doesn't show up in cgroup.procs until after
> > > we've observed it to be empty?
> >
> > Something like this:
> >
> >                                                         kill (before)
> > cgroup_fork
> > cgroup_can_fork .. begin(threadgroup_rwsem)
> > tasklist_lock
> > fatal_signal_pending -> cgroup_cancel_fork              kill (mid)
> > tasklist_unlock
> >                                                         seq_start,
> >                                                         seq_next...
> >
> > cgroup_post_fork  .. end(threadgroup_rwsem)
> >                                                         kill (after)
> >
> > Only the third option `kill (after)` means the child would end up on th=
e
> > css_set list. But that would mean the reader squeezed before
> > cgroup_post_fork() would still see the parent.
> > (I.e. I don't see the kill/fork race could skew the listed procs.)
> >
> So here is a trace from a phone where the kills happen (~100ms) after
> the forks. All but one of the children die before we read cgroup.procs
> for the first time, and cgroup.procs is not empty. 5ms later we read
> again and cgroup.procs is empty, but the last child still hasn't
> exited. So it makes sense that the cset from that last child is still
> on the list.
> https://pastebin.com/raw/tnHhnZBE
>
Collected a bit more info. It's before exit_mm that the process
disappears from cgroup.procs, but the delay to populated=3D0 seems to be
exacerbated by CPU contention during this time. What's weird is that I
can see the task blocking the rmdir on cgrp->cset_links->cset->tasks
inside of cgroup_destroy_locked when the rmdir is attempted, so I
don't understand why it doesn't show up when iterating tasks for
cgroup.procs.

I'm going to be out until next Wednesday when I'll look some more.
