Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061DC77D715
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 02:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbjHPA3r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 20:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbjHPA3n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 20:29:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A43B2112
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 17:29:41 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bcc0adab4so776181366b.2
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692145780; x=1692750580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf96gEUuffZ5bugLPGNyrmA+1QjENgh5PWJjdIlY5k8=;
        b=Roa+zIv+mNU/NtciKeNsOa6uM75uCp+S0VtC8PYEb+ILU6Z2WoUMzfAiQer5N5DYfa
         0d7dDd1UyioRCzkGgdkIHUDv3RjUiWIzB1V3ou7d64b0bTzbcOhCrHsbRQsd9dl8h7IY
         axTFam5oPj7T1b09AEAmcI4/Coq6t0G4v0qmyH0BkN9oLhrpmds+rLaJNjcyQ3XMhDvl
         dZvzpFARC/WYs+JeQyofxaP46UVf9VdGfXHNdgdichb3HG0Z03ZvIQSnwBeAoHG7dqo5
         yY+Gksx+Dpsq/QyXNfQnwd51qr2HPA1Eohy7B5ID7ZOKuk4GuXOEbH19knKLmtxt3lIZ
         WrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145780; x=1692750580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf96gEUuffZ5bugLPGNyrmA+1QjENgh5PWJjdIlY5k8=;
        b=UcZsNlexxDxOY3fxrOjEqlQiXZ9xP2aR5LpSj+uhOBPMlYz1Q8m+JA73D5qlbnwJ3L
         nolpViIHInC90Mgp2lgCeFc/J32szcQTBPj97uWfxgjvQFSJgO712nnY25g3p+cYQ/SY
         9S6Qa9EKL/kQSr4QkxXZMrbEcnNPSlfE3lvYNaAQfiVeV21FntLyDXlLRDnh/+7qm1AX
         ZJONghLzuLklknwWjV4MIYRkkIQA/av+HHUCt2ikUdPGhgbCBw0Klgjfg2ts3fgFTWo+
         G5fL7qCUzPw49VaydbG/J+AjNKiFbvYFGTRkSWRDP01Clpzev4EoKPCXGRUrgoRuGpQ2
         Qq+A==
X-Gm-Message-State: AOJu0YzwPyAzAzUot9k4/g7gYrr5EUi37vj4WYL4//8nWYx0tJHFgi9T
        0gCJRQeKX9TAo233Zno9uOaY3z/wAj0e1vEovmgIZA==
X-Google-Smtp-Source: AGHT+IET4IObBwFCzpP3WD/a21iSZnldxBuBe2UDZwpFgxUiZEsIeMr8bLYT7X1W29/8Vf7CE5ZXknc+XvfschltiJk=
X-Received: by 2002:a17:907:7893:b0:99c:b65b:54ed with SMTP id
 ku19-20020a170907789300b0099cb65b54edmr167636ejc.60.1692145779622; Tue, 15
 Aug 2023 17:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
In-Reply-To: <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 15 Aug 2023 17:29:03 -0700
Message-ID: <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
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

On Tue, Aug 15, 2023 at 5:23=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> +Ivan
>
> On Mon, Aug 14, 2023 at 5:51=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Aug 14, 2023 at 5:48=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> > >
> > > Hello,
> > >
> > > On Mon, Aug 14, 2023 at 05:39:15PM -0700, Yosry Ahmed wrote:
> > > > I believe dropping unified flushing, if possible of course, may fix
> > > > both problems.
> > >
> > > Yeah, flushing the whole tree for every stat read will push up the bi=
g O
> > > complexity of the operation. It shouldn't be too bad because only wha=
t's
> > > updated since the last read will need flushing but if you have a real=
ly big
> > > machine with a lot of constantly active cgroups, you're still gonna f=
eel it.
> > > So, yeah, drop that and switch the global lock to mutex and we should=
 all be
> > > good?
> >
> > I hope so, but I am not sure.
> >
> > The unified flushing was added initially to mitigate a thundering herd
> > problem from concurrent in-kernel flushers (e.g. concurrent reclaims),
> > but back then flushing was atomic so we had to keep the spinlock held
> > for a long time. I think it should be better now, but I am hoping
> > Shakeel will chime in since he added the unified flushing originally.
> >
> > We also need to agree on what to do about stats_flushing_threshold and
> > flush_next_time since they're both global now (since all flushing is
> > global).
> >
>
> I thought we already reached the decision on how to proceed here. Let
> me summarize what I think we should do:
>
> 1. Completely remove the sync flush from stat files read from userspace.
> 2. Provide a separate way/interface to explicitly flush stats for
> users who want more accurate stats and can pay the cost. This is
> similar to the stat_refresh interface.
> 3. Keep the 2 sec periodic stats flusher.

I think this solution is suboptimal to be honest, I think we can do better.

With recent improvements to spinlocks/mutexes, and flushers becoming
sleepable, I think a better solution would be to remove unified
flushing and let everyone only flush the subtree they care about. Sync
flushing becomes much better (unless you're flushing root ofc), and
concurrent flushing wouldn't cause too many problems (ideally no
thundering herd, and rstat lock can be dropped at cpu boundaries in
cgroup_rstat_flush_locked()).

If we do this, stat reads can be much faster as Ivan demonstrated with
his patch that only flushes the cgroup being read, and we do not
sacrifice accuracy as we never skip flushing. We also do not need a
separate interface for explicit refresh.

In all cases, we need to keep the 2 sec periodic flusher. What we need
to figure out if we remove unified flushing is:

1. Handling stats_flush_threshold.
2. Handling flush_next_time.

Both of these are global now, and will need to be adapted to
non-unified non-global flushing.
