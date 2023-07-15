Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E8775458D
	for <lists+cgroups@lfdr.de>; Sat, 15 Jul 2023 02:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGOABF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jul 2023 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGOABE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jul 2023 20:01:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046263A95
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:01:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3144098df56so2677922f8f.2
        for <cgroups@vger.kernel.org>; Fri, 14 Jul 2023 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689379261; x=1691971261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qCsYq5AfQu15dBgFcUhM5i+Y9hdaw4Di+rchoqRa1A=;
        b=w1so6/uRCSkF2JfOE4Lp7UEUm7H2/SnJOrUe5GP0/6Hoc5lu/q59ef2oEAIUdNGlPu
         1oBomtwOZE28hBXuVf9l6r3h/U7PyWOeBibY6Emk7xzVuyXK6RJfTioxx73MA4Ej67Ft
         gK1kNyPKvTTQneIkrmuHgWBjmDfq96bq6Y21Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689379261; x=1691971261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qCsYq5AfQu15dBgFcUhM5i+Y9hdaw4Di+rchoqRa1A=;
        b=BDC9q7vBn3aOi/NQJIZzkAlf6Ktcy/DmSkjDL/Iaj2XP5hHlevwUu/0TcUsAZSWmxH
         +732HQyjAzsROzWgzkHQ9urE0R7c9kn/R5F1Dxgj14/eoIsCyPHSo22i30OexS143Jbr
         XaV/9Vn11f1NkGQjdMQZXNyhBHSU86qx5tJgvpevrGNEGOnAqPF0IbzD+OUIAxWMUtog
         yPv7vjJXiD+TPCnpY+o2OI2XTgjxHToKZkh8ndnyRtnagVTHpIVRp8/rk83AWRW7xS45
         1568sUqNzqQLoquJxrl1AHcVH7KeyYNBWquY7/cPQuBwDfVhrwJsPqYVE/FT1J8mOfjO
         4qiw==
X-Gm-Message-State: ABy/qLa3rDADwtXHBBFTj7ptB/uHxX+1jzfhFXVFDkjmN9tReLvT+bdC
        J6zSJdflHvsyBZu4zM4jQBdUuvePcdxgL9wwcLRNsz4E6ZG+quzXWXc=
X-Google-Smtp-Source: APBJJlEvCf0BSl7GtqyQou6Cs0GD8ZpzFZvUUaUmW+z6ihNa4/16dJUC5WbYXRU1+zLyptJm0Uqq3GnsW0ohBqtQtKI=
X-Received: by 2002:a5d:66c5:0:b0:316:e073:e547 with SMTP id
 k5-20020a5d66c5000000b00316e073e547mr5135314wrw.28.1689379261115; Fri, 14 Jul
 2023 17:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <fea3587a-ca6a-6930-bd3d-c4f7f330be67@redhat.com>
In-Reply-To: <fea3587a-ca6a-6930-bd3d-c4f7f330be67@redhat.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Fri, 14 Jul 2023 17:00:50 -0700
Message-ID: <CABWYdi2mBWsaEJXDEKeYaSCuikNbjBBU1yo+Yai+vM=rf2=LVQ@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Waiman Long <longman@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 14, 2023 at 10:23=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
> On 7/13/23 19:25, Ivan Babrou wrote:
> > On Mon, Jul 10, 2023 at 5:44=E2=80=AFPM Waiman Long <longman@redhat.com=
> wrote:
> >> On 7/10/23 19:21, Ivan Babrou wrote:
> >>> On Wed, Jul 5, 2023 at 11:20=E2=80=AFPM Shakeel Butt <shakeelb@google=
.com> wrote:
> >>>> On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou wrote:
> >>>>> Hello,
> >>>>>
> >>>>> We're seeing CPU load issues with cgroup stats retrieval. I made a
> >>>>> public gist with all the details, including the repro code (which
> >>>>> unfortunately requires heavily loaded hardware) and some flamegraph=
s:
> >>>>>
> >>>>> * https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13
> >>>>>
> >>>>> I'll repeat the gist of that gist here. Our repro has the following
> >>>>> output after a warm-up run:
> >>>>>
> >>>>> completed:  5.17s [manual / mem-stat + cpu-stat]
> >>>>> completed:  5.59s [manual / cpu-stat + mem-stat]
> >>>>> completed:  0.52s [manual / mem-stat]
> >>>>> completed:  0.04s [manual / cpu-stat]
> >>>>>
> >>>>> The first two lines do effectively the following:
> >>>>>
> >>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.s=
tat
> >>>>> /sys/fs/cgroup/system.slice/cpu.stat > /dev/null
> >>>>>
> >>>>> The latter two are the same thing, but via two loops:
> >>>>>
> >>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat=
 >
> >>>>> /dev/null; done
> >>>>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.s=
tat
> >>>>>> /dev/null; done
> >>>>> As you might've noticed from the output, splitting the loop into tw=
o
> >>>>> makes the code run 10x faster. This isn't great, because most
> >>>>> monitoring software likes to get all stats for one service before
> >>>>> reading the stats for the next one, which maps to the slow and
> >>>>> expensive way of doing this.
> >>>>>
> >>>>> We're running Linux v6.1 (the output is from v6.1.25) with no patch=
es
> >>>>> that touch the cgroup or mm subsystems, so you can assume vanilla
> >>>>> kernel.
> >>>>>
> >>>>>   From the flamegraph it just looks like rstat flushing takes longe=
r. I
> >>>>> used the following flags on an AMD EPYC 7642 system (our usual pick
> >>>>> cpu-clock was blaming spinlock irqrestore, which was questionable):
> >>>>>
> >>>>> perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro
> >>>>>
> >>>>> Naturally, there are two questions that arise:
> >>>>>
> >>>>> * Is this expected (I guess not, but good to be sure)?
> >>>>> * What can we do to make this better?
> >>>>>
> >>>>> I am happy to try out patches or to do some tracing to help underst=
and
> >>>>> this better.
> >>>> Hi Ivan,
> >>>>
> >>>> Thanks a lot, as always, for reporting this. This is not expected an=
d
> >>>> should be fixed. Is the issue easy to repro or some specific workloa=
d or
> >>>> high load/traffic is required? Can you repro this with the latest li=
nus
> >>>> tree? Also do you see any difference of root's cgroup.stat where thi=
s
> >>>> issue happens vs good state?
> >>> I'm afraid there's no easy way to reproduce. We see it from time to
> >>> time in different locations. The one that I was looking at for the
> >>> initial email does not reproduce it anymore:
> >> My understanding of mem-stat and cpu-stat is that they are independent
> >> of each other. In theory, reading one shouldn't affect the performance
> >> of reading the others. Since you are doing mem-stat and cpu-stat readi=
ng
> >> repetitively in a loop, it is likely that all the data are in the cach=
e
> >> most of the time resulting in very fast processing time. If it happens
> >> that the specific memory location of mem-stat and cpu-stat data are su=
ch
> >> that reading one will cause the other data to be flushed out of the
> >> cache and have to be re-read from memory again, you could see
> >> significant performance regression.
> >>
> >> It is one of the possible causes, but I may be wrong.
> > Do you think it's somewhat similar to how iterating a matrix in rows
> > is faster than in columns due to sequential vs random memory reads?
> >
> > * https://stackoverflow.com/q/9936132
> > * https://en.wikipedia.org/wiki/Row-_and_column-major_order
> > * https://en.wikipedia.org/wiki/Loop_interchange
>
> Yes, it is similar to what is being described in those articles.
>
>
> >
> > I've had a similar suspicion and it would be good to confirm whether
> > it's that or something else. I can probably collect perf counters for
> > different runs, but I'm not sure which ones I'll need.
> >
> > In a similar vein, if we could come up with a tracepoint that would
> > tell us the amount of work done (or any other relevant metric that
> > would help) during rstat flushing, I can certainly collect that
> > information as well for every reading combination.
>
> The perf-c2c tool may be able to help. The data to look for is how often
> the data is from caches vs direct memory load/store.

It looks like c2c only works for the whole system, not individual
treads. There's a lot of noise from the rest of the system.
