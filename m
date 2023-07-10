Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965BF74E22F
	for <lists+cgroups@lfdr.de>; Tue, 11 Jul 2023 01:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGJXWV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 19:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGJXWU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 19:22:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E29E4D
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 16:22:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3158a5e64b6so3365516f8f.0
        for <cgroups@vger.kernel.org>; Mon, 10 Jul 2023 16:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689031322; x=1691623322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQcaxlquPgLsEtf9zjMdvG6opf0s0bsmOxkcrF9GkyU=;
        b=LiKHuEY8+B0eE9iet2Xj4FKSCqKi9D4frQwFtNXsst0xV4BzybsxdnwYPBK6KXCGkz
         2ACTx02GPmCH4E5+NW576cPNdAIEkyeDmTmTiXibeodrdQFcZAdo50kWCBaramTS4KIO
         srCm8oB7dsyVg4AgU/wBvSV+TRePAExXqzxNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689031322; x=1691623322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQcaxlquPgLsEtf9zjMdvG6opf0s0bsmOxkcrF9GkyU=;
        b=mEWWO2vJDimfaU9Jic0Vyeq4Illb6H73tXtRtT04GHk2CNYLgQuZQtoSeaG1AerK2i
         OcFXFdQznMT4jSXxQpqXAnXuc5kqcdyyWryI/BIYEHROMr69g5Ab7hTkK02NTb1O1dFR
         QRXC1CDpa4lm0AKVOA+BnVY8j5OiEjRUW1YdOTy9KL3SaduOsgXEC0O4N7CmaoqW9uD9
         srb2eymOMiEPlaVSz676suPTBGL/OI3JDKPHia89pl+jVl+X6yqbpNMEBtKFL2fQ9Ym2
         Gi3VuAqsrIliOtiqFLjjLtA0mQxk8Z+H0M9umomgRzXgHG11LExD5DA5cMkRvX6AFAou
         vseQ==
X-Gm-Message-State: ABy/qLaRLlZRFHXl4UPXsB28bi9jRTPI+ptyA5ZfVVzVFtQu8egA+yoQ
        kRbJnXZ9GM+pgxPRSekKrN2Z2AOTPZx6LuGzrqz2jQ==
X-Google-Smtp-Source: APBJJlHgmT7D0rc2mTUV7WI1F/GqetfVFVi3NigwPeEnwVVGEJgjhlAeGv3GTccd93GHS0XLTZqChIxwGfK7DC08B3E=
X-Received: by 2002:a05:6000:118a:b0:30f:bb83:e6f4 with SMTP id
 g10-20020a056000118a00b0030fbb83e6f4mr12221189wrx.0.1689031321866; Mon, 10
 Jul 2023 16:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com>
In-Reply-To: <20230706062045.xwmwns7cm4fxd7iu@google.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 10 Jul 2023 16:21:51 -0700
Message-ID: <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 5, 2023 at 11:20=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou wrote:
> > Hello,
> >
> > We're seeing CPU load issues with cgroup stats retrieval. I made a
> > public gist with all the details, including the repro code (which
> > unfortunately requires heavily loaded hardware) and some flamegraphs:
> >
> > * https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13
> >
> > I'll repeat the gist of that gist here. Our repro has the following
> > output after a warm-up run:
> >
> > completed:  5.17s [manual / mem-stat + cpu-stat]
> > completed:  5.59s [manual / cpu-stat + mem-stat]
> > completed:  0.52s [manual / mem-stat]
> > completed:  0.04s [manual / cpu-stat]
> >
> > The first two lines do effectively the following:
> >
> > for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> > /sys/fs/cgroup/system.slice/cpu.stat > /dev/null
> >
> > The latter two are the same thing, but via two loops:
> >
> > for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
> > /dev/null; done
> > for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.stat
> > > /dev/null; done
> >
> > As you might've noticed from the output, splitting the loop into two
> > makes the code run 10x faster. This isn't great, because most
> > monitoring software likes to get all stats for one service before
> > reading the stats for the next one, which maps to the slow and
> > expensive way of doing this.
> >
> > We're running Linux v6.1 (the output is from v6.1.25) with no patches
> > that touch the cgroup or mm subsystems, so you can assume vanilla
> > kernel.
> >
> > From the flamegraph it just looks like rstat flushing takes longer. I
> > used the following flags on an AMD EPYC 7642 system (our usual pick
> > cpu-clock was blaming spinlock irqrestore, which was questionable):
> >
> > perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro
> >
> > Naturally, there are two questions that arise:
> >
> > * Is this expected (I guess not, but good to be sure)?
> > * What can we do to make this better?
> >
> > I am happy to try out patches or to do some tracing to help understand
> > this better.
>
> Hi Ivan,
>
> Thanks a lot, as always, for reporting this. This is not expected and
> should be fixed. Is the issue easy to repro or some specific workload or
> high load/traffic is required? Can you repro this with the latest linus
> tree? Also do you see any difference of root's cgroup.stat where this
> issue happens vs good state?

I'm afraid there's no easy way to reproduce. We see it from time to
time in different locations. The one that I was looking at for the
initial email does not reproduce it anymore:

completed:  0.75s [manual / cpu-stat + mem-stat]
completed:  0.72s [manual / mem-stat]
completed:  0.05s [manual / cpu-stat]

I took the top 20 servers by metrics scrape duration for cadvisor and
it it does happen on the slowest ones:

completed: 22.32s [manual / cpu-stat + mem-stat]
completed:  0.34s [manual / mem-stat]
completed:  1.68s [manual / cpu-stat]

Is cadvisor or a similar metrics agent used by Google? Any chance you
could see if your own fleet exhibits this behavior?

Given that this behavior requires full production setup with customer
traffic and long qualification times we have for kernels, I'm not sure
if I can try the linus tree here.

I uploaded the contents of /sys/fs/cgroup/memory.stat here:

* https://gist.github.com/bobrik/9255b5e8ed0a83afb73ebf06b79f07c4

The fast one is v6.1.37 and the slow one is v6.1.25. I'm not sure if
the kernel version makes a difference or if it's a matter of uptime /
traffic profile. The data is from two different locations. The fast
location has gone through an expansion, which meant a full reboot with
a kernel upgrade, so maybe that affected things:

* https://i.imgur.com/x8uyMaF.png

Let me try to reboot the slow location and see if there's any lasting
improvement.
