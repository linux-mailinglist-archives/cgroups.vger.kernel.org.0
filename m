Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3E77C4112
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 22:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJJUXL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUXL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 16:23:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA60B8
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 13:23:09 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d9a389db3c7so216975276.1
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 13:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696969388; x=1697574188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYgkUNINwcenUseeTVeq/bExT5fIfYMT1S3rwt4UQkU=;
        b=YDqvtdEqtNhqLrYyIOsLw8nHGBX0j64EfifGv8jaYTh1zIdBwWxPA9w+C8SKnpjVyO
         4ErS312DeLe5RQQOzDLMC4ksnMc3QwcK74bhJQp+7sKuJfaH8Q2CPvwYDd/OliAvIBHP
         0Zl2mFFSk2Vk+DQBRXa8FbbNsieCuI0ArGLyQ8qAFYAwXROhYOzRHXKleXvxw3BmqMAn
         zmgcTvF+ci+d2ZmtoJLvYSFM3jeZ1fPhm/y1ZpDa0arNpYgTZpi7BogFi/JRMa1bWO0z
         goUPX3iCHR7CxgrmRHOludGOuKVEYYJn5rpCIc6LTRkW3ecVPodoGhDw8WIcGer/uYhS
         kYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969388; x=1697574188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYgkUNINwcenUseeTVeq/bExT5fIfYMT1S3rwt4UQkU=;
        b=Ud8Lh2Cls9exkCEkeWr7YK47lvG1ukfA0yzNiqklIS2meABf2moaw3AecZ/NMW2/Ne
         cyJJE/I04da5bcuj5m7hrsPRuRDmTQ+6qfCNuk3tiww1aDaDLSiyCmSIwWWwMjwISBuY
         InPKPr7hEX9QzAtWXDIF2fsJ3iOtgq/xKWKfSb5aEWIjVD0YmHuXQtkMjE1Z3Dc14x0L
         hBwKSYg2ZxIgeLq+2dymQFmgx8igp322C+tGStnvn0UxELxeN/V++8lrqvHXyFAq9yGp
         53HqUBmFqCzuu1Qw9vo9/rXLFv2sIOQy+jUwagdRGR0nATwForCRs/gTNQyZfnfI1n+t
         DWoA==
X-Gm-Message-State: AOJu0YwvsNxaUmdIx69eYX4WXAVxOd4GaIm7/Eq1Pv41P+YHo8V91lst
        6fpEEY+s3WWXPTvZtjzpN5fU726sTgFKuGCDta2s/Q==
X-Google-Smtp-Source: AGHT+IH3XzOe35P+mGX9r5IaxByNc6AZhNSEOBcITvJ1kazwBDUAXXYUx9b5cxJV3CAwhxlXVl68lf2TLW6LOK/ZUDI=
X-Received: by 2002:a25:6645:0:b0:d9a:61b4:cd31 with SMTP id
 z5-20020a256645000000b00d9a61b4cd31mr1864734ybm.20.1696969388120; Tue, 10 Oct
 2023 13:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX3SOXpcK85a7cx3iXrwUj=i1yXqEz9i9zNkx8mB=ZXQ8A@mail.gmail.com>
 <CABdmKX0Grgp4F5GUjf76=ZhK+UxJwKaL2v-pM=phpdyrot+dNg@mail.gmail.com>
 <sgbmcjroeoi7ltt7432ajxj3nl6de4owm7gcg7d2dr2hsuncfi@r6tln7crkzyf>
 <CABdmKX3NQKB3h_CuYUYJahabj9fq+TSN=NAGdTaZqyd7r_A+yA@mail.gmail.com>
 <s2xtlyyyxu4rbv7gjyl7jbi5tt7lrz7qyr3axfeahsij443ahx@me6wx5gvyqni>
 <CABdmKX0Aiu7Run9YCYXVAX4o3-eP6nKcnzyWh_yuhVKVXTPQkA@mail.gmail.com> <ZSWay-22Gh9opIC_@slm.duckdns.org>
In-Reply-To: <ZSWay-22Gh9opIC_@slm.duckdns.org>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 10 Oct 2023 13:22:56 -0700
Message-ID: <CABdmKX1MYpBerSe2oCTx7vBSQQt8PaYpNpp6Pn0ZE-yymowVjw@mail.gmail.com>
Subject: Re: [Bug Report] EBUSY for cgroup rmdir after cgroup.procs empty
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023 at 11:41=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Oct 10, 2023 at 10:14:26AM -0700, T.J. Mercier wrote:
> > > BTW is there any fundamental reason the apps cannot use the
> > > notifications via cgroup.events as recommended by Tejun?
> > >
> > This would require that we read both cgroup.procs and cgroup.events,
> > since we'd still want to know which processes to signal. I assumed
> > this would increase lock contention but there's no synchronization on
> > cgroup_is_populated so it looks like not. I had already identified
> > this as a workaround, but I'd prefer to depend on just one file to do
> > everything.
>
> I don't think we can guarantee that. There's a reason why we have
> [!]populated events. Maybe we can find this particular situation better b=
ut
> there isn't going to be a guarantee that a cgroup is removable if its
> cgroup.procs file is seen empty.
>
I understand that there are cases where the cgroup can become
populated after a read of cgroup.procs shows nothing and before a
removal is attempted. But that doesn't seem to be what's happening
here.

> Note that cgroup.events file is pollable. You can just poll the file and
> then respond to them. I don't understand the part of having to read
> cgroup.procs, which btw is an a lot more expensive operation. You said
> "which processes to signal". If this is to kill all processes in the cgro=
up,
> you can use cgroup.kill which sends signal atomically to all member tasks=
.
>
That's coming, but we still need to support kills without cgroup.kill
for kernels before it was introduced. There are some non-SIGKILL use
cases that code supports, so that's what I meant when I said, "which
processes to signal". I guess we could separate these two paths so
that one uses cgroup.kill and blocks until populated =3D 0, and the
other just reads cgroup.procs to generate the signals and then
returns. But it would be nice to have cgroup.procs just show the pids
until after cgroup_exit when the condition for removal is satisfied.

> It feels like the use case is just trying to do things in an unsupported =
way
> when there's no actual benefit to doing so. Is there something preventing
> you guys from doing how it's supposed to be used?
>
Isn't this avoiding the problem? The docs say, "A cgroup which doesn't
have any children or live processes can be destroyed by removing the
directory." If it has live processes they should show up in
cgroup.procs. FWIW that's also the language used to describe how the
populated notification works, so the two shouldn't report different
things. (Assuming they could actually be read simultaneously.)
