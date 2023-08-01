Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77176BB3E
	for <lists+cgroups@lfdr.de>; Tue,  1 Aug 2023 19:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjHARaU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Aug 2023 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHARaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Aug 2023 13:30:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49464E52
        for <cgroups@vger.kernel.org>; Tue,  1 Aug 2023 10:30:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bccc9ec02so914035866b.2
        for <cgroups@vger.kernel.org>; Tue, 01 Aug 2023 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690911016; x=1691515816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWyPkbdgs7yx55emQXRqaXaZzIyQirdAz8BzArZ40eU=;
        b=3YMahqT1T68lBAKLGC6klWlHs6/yoQcVKMihs8hlR5o+bqg0M8L54pskZkt06Cdy/6
         peUqd8125n6i4m5Ix0JkAVgL2Rl/GZMCGJ92U3RaWPEgl6QroNJ9Zb/UT25pvXvk6yVH
         EDEKpsRJSX91B50bjz3WQnRgEkZbHP+/LXhrCz90OWxSXXWtIxecGf2Xz+bAqo3EbQGF
         V/g+rrJv4LGWlojIM4vxR6lEiEupKHUdVqqiawBYFt51n1NovxS0llWPtb+8KKREyNCk
         wummIomryE/q6enBx1sCWQ6NZhLB3umXzBvp3no92lVinNnDKuii9Z9EcHMa+vIptRrb
         XU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690911016; x=1691515816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWyPkbdgs7yx55emQXRqaXaZzIyQirdAz8BzArZ40eU=;
        b=jeCjXBn8jIcM1Y2QQmYn5jBeoLOFsB6vumHcsRnv2+sdHpUuGjZAxUvHdWrHVIlwcg
         0M4ZAF0F/Wh/9SH+wOvSwtVV0yPwWzwuLgLDpyu1D2Y/6zilF1baDMDgCYzK28diYpWm
         nu0ieJQo771zfLH3MHm8mhRMvUVctGl/5HK2z44P/iP101Ei+GVO3hkQ0HZNwZNsW/cR
         k5PJW3lwFowlaFchW1G6QnJpnOgwvcEJAdRwNMlw8mz0gBU0vQYqXUOrUjX8w/D36qOh
         eIXf9W6lkQws1sJCP40Xv2jKzkirJW7PyMq2qAjpdQJ8nC+wggk9aknzLHBznYe/69nO
         6eaA==
X-Gm-Message-State: ABy/qLbLcb7zfvHMW5tD3qBNdDYjRniy2HapQLCbWAjEbPdAx1gigfLG
        yiU04yeNqfg3w9rIQ/8UPLq8Kgo3pX8QG7OSE2Ao4g==
X-Google-Smtp-Source: APBJJlGJPVqDqQPC7nXfVN/Cb0vCjHGDfw0oAOT5O0W+9Lp/LUzmV3bVYAJWlWHC7S8wuT2dHXGRWIqsfQc4Kfhtbhg=
X-Received: by 2002:a17:907:7751:b0:99c:281:9987 with SMTP id
 kx17-20020a170907775100b0099c02819987mr3341587ejc.36.1690911015665; Tue, 01
 Aug 2023 10:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com> <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
In-Reply-To: <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 1 Aug 2023 10:29:39 -0700
Message-ID: <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 1, 2023 at 9:39=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Aug 1, 2023 at 7:30=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
> >
> > On Wed 26-07-23 15:32:23, Yosry Ahmed wrote:
> > > Currently, memcg uses rstat to maintain aggregated hierarchical stats=
.
> > > Counters are maintained for hierarchical stats at each memcg. Rstat
> > > tracks which cgroups have updates on which cpus to keep those counter=
s
> > > fresh on the read-side.
> > >
> > > Non-hierarchical stats are currently not covered by rstat. Their
> > > per-cpu counters are summed up on every read, which is expensive.
> > > The original implementation did the same. At some point before rstat,
> > > non-hierarchical aggregated counters were introduced by
> > > commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
> > > memory.stat reporting"). However, those counters were updated on the
> > > performance critical write-side, which caused regressions, so they we=
re
> > > later removed by commit 815744d75152 ("mm: memcontrol: don't batch
> > > updates of local VM stats and events"). See [1] for more detailed
> > > history.
> > >
> > > Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
> > > half) enjoyed cheap reads of non-hierarchical stats, specifically on
> > > cgroup v1. When moving to more recent kernels, a performance regressi=
on
> > > for reading non-hierarchical stats is observed.
> > >
> > > Now that we have rstat, we know exactly which percpu counters have
> > > updates for each stat. We can maintain non-hierarchical counters agai=
n,
> > > making reads much more efficient, without affecting the performance
> > > critical write-side. Hence, add non-hierarchical (i.e local) counters
> > > for the stats, and extend rstat flushing to keep those up-to-date.
> > >
> > > A caveat is that we now need a stats flush before reading
> > > local/non-hierarchical stats through {memcg/lruvec}_page_state_local(=
)
> > > or memcg_events_local(), where we previously only needed a flush to
> > > read hierarchical stats. Most contexts reading non-hierarchical stats
> > > are already doing a flush, add a flush to the only missing context in
> > > count_shadow_nodes().
> > >
> > > With this patch, reading memory.stat from 1000 memcgs is 3x faster on=
 a
> > > machine with 256 cpus on cgroup v1:
> > >  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
> > >  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
> > >  real  0m0.125s
> > >  user  0m0.005s
> > >  sys   0m0.120s
> > >
> > > After:
> > >  real  0m0.032s
> > >  user  0m0.005s
> > >  sys   0m0.027s
> >
> > Have you measured any potential regression for cgroup v2 which collects
> > all this data without ever using it (AFAICS)?
>
> I did not. I did not expect noticeable regressions given that all the
> extra work is done during flushing, which should mostly be done by the
> asynchronous worker, but can also happen in the stats reading context.
> Let me run the same script on cgroup v2 just in case and report back.

A few runs on mm-unstable with this patch:

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.020s
user 0m0.005s
sys 0m0.015s

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.017s
user 0m0.005s
sys 0m0.012s

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.016s
user 0m0.004s
sys 0m0.012s

A few runs on mm-unstable with the patch reverted:

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.020s
user 0m0.005s
sys 0m0.015s

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.016s
user 0m0.004s
sys 0m0.012s

# time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null
real 0m0.017s
user 0m0.005s
sys 0m0.012s

It looks like there are no regressions on cgroup v2 when reading the
stats. Please let me know if you want me to send a new version with
the cgroup v2 results as well in the commit log -- or I can just send
a new commit log. Whatever is easier for Andrew.

>
> > --
> > Michal Hocko
> > SUSE Labs
