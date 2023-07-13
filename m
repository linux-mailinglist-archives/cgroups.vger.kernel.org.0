Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECF4752DED
	for <lists+cgroups@lfdr.de>; Fri, 14 Jul 2023 01:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjGMXZ2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jul 2023 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMXZ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jul 2023 19:25:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE5B1BD4
        for <cgroups@vger.kernel.org>; Thu, 13 Jul 2023 16:25:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbfcc6daa9so12068955e9.3
        for <cgroups@vger.kernel.org>; Thu, 13 Jul 2023 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689290724; x=1691882724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ldt/m7vMp8HF0ifqHxjiRFq7e6BEhHM91NOp3YGXdYE=;
        b=rT7wOYM73TGH7nce+q9Q0mqkHE46+XclhlnVMn5LD2+Fj1FK9IXWuLoYHFLF/W2bTu
         JrX5TUBkI0hyq1MyT/SMKCb6CsovdHxHmPzif6xsD8rA5Jshy0lZ8PJ0RnZ/Sk/NPVxQ
         5Vu0Xh9msZ1zXdd3l4aLJj1IeSencA6b/m8lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689290724; x=1691882724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ldt/m7vMp8HF0ifqHxjiRFq7e6BEhHM91NOp3YGXdYE=;
        b=hGYr78yb0MBH1qkdLWnQvksIwftZ1NAaOZplEhOGVZ+LIWtTdiAvAq9/ZCeotdeK6+
         +MpfTuSUXyAIm2DZ7O0GsZlCIjJuBz6ETdDNb0kTiNqWW/a4FiSMPftj/sd++jXeXinS
         E/AcRfeNGSmkJhAgyiuNTE9g8VPUGmsb81Bv4jCG1JlgeZBMqaedkwpVRFmmz/M6gYJC
         sUX0kdGI8wyRXB/Xxkvhfg7VxtnEYZBk7ah9vOvLm/wIn1yFJ2VSPlZiQRqQrucreQkq
         8WihzMCoyuX2K0M6zvvU0E+akbJIuETK22StbLEb4mVV+DU+bV9lmgyCZOKfvcqp6t73
         ID9w==
X-Gm-Message-State: ABy/qLY25ac+SgrNMICku4WiEtHwRdBlaz6XyQWIheYtQCh2JdsBce5p
        DKshnM1rUIJ6eOXVNG1mOiHEbfSdAgHwG+Em+Rzi4U3e4ttS6nhUJRSyfg==
X-Google-Smtp-Source: APBJJlGe3Qbx9y7uUIFH51v4cW0mTJdTxI78fcBw7ath04XBIi0I7nTDJNYHJnY8kezZinvoPmvK0lHOhyKapndW66c=
X-Received: by 2002:adf:e952:0:b0:30e:5bd0:21a2 with SMTP id
 m18-20020adfe952000000b0030e5bd021a2mr2638278wrn.52.1689290724372; Thu, 13
 Jul 2023 16:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com>
In-Reply-To: <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jul 2023 16:25:13 -0700
Message-ID: <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 10, 2023 at 5:44=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 7/10/23 19:21, Ivan Babrou wrote:
> > On Wed, Jul 5, 2023 at 11:20=E2=80=AFPM Shakeel Butt <shakeelb@google.c=
om> wrote:
> >> On Fri, Jun 30, 2023 at 04:22:28PM -0700, Ivan Babrou wrote:
> >>> Hello,
> >>>
> >>> We're seeing CPU load issues with cgroup stats retrieval. I made a
> >>> public gist with all the details, including the repro code (which
> >>> unfortunately requires heavily loaded hardware) and some flamegraphs:
> >>>
> >>> * https://gist.github.com/bobrik/5ba58fb75a48620a1965026ad30a0a13
> >>>
> >>> I'll repeat the gist of that gist here. Our repro has the following
> >>> output after a warm-up run:
> >>>
> >>> completed:  5.17s [manual / mem-stat + cpu-stat]
> >>> completed:  5.59s [manual / cpu-stat + mem-stat]
> >>> completed:  0.52s [manual / mem-stat]
> >>> completed:  0.04s [manual / cpu-stat]
> >>>
> >>> The first two lines do effectively the following:
> >>>
> >>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.sta=
t
> >>> /sys/fs/cgroup/system.slice/cpu.stat > /dev/null
> >>>
> >>> The latter two are the same thing, but via two loops:
> >>>
> >>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/cpu.stat >
> >>> /dev/null; done
> >>> for _ in $(seq 1 1000); do cat /sys/fs/cgroup/system.slice/memory.sta=
t
> >>>> /dev/null; done
> >>> As you might've noticed from the output, splitting the loop into two
> >>> makes the code run 10x faster. This isn't great, because most
> >>> monitoring software likes to get all stats for one service before
> >>> reading the stats for the next one, which maps to the slow and
> >>> expensive way of doing this.
> >>>
> >>> We're running Linux v6.1 (the output is from v6.1.25) with no patches
> >>> that touch the cgroup or mm subsystems, so you can assume vanilla
> >>> kernel.
> >>>
> >>>  From the flamegraph it just looks like rstat flushing takes longer. =
I
> >>> used the following flags on an AMD EPYC 7642 system (our usual pick
> >>> cpu-clock was blaming spinlock irqrestore, which was questionable):
> >>>
> >>> perf -e cycles -g --call-graph fp -F 999 -- /tmp/repro
> >>>
> >>> Naturally, there are two questions that arise:
> >>>
> >>> * Is this expected (I guess not, but good to be sure)?
> >>> * What can we do to make this better?
> >>>
> >>> I am happy to try out patches or to do some tracing to help understan=
d
> >>> this better.
> >> Hi Ivan,
> >>
> >> Thanks a lot, as always, for reporting this. This is not expected and
> >> should be fixed. Is the issue easy to repro or some specific workload =
or
> >> high load/traffic is required? Can you repro this with the latest linu=
s
> >> tree? Also do you see any difference of root's cgroup.stat where this
> >> issue happens vs good state?
> > I'm afraid there's no easy way to reproduce. We see it from time to
> > time in different locations. The one that I was looking at for the
> > initial email does not reproduce it anymore:
>
> My understanding of mem-stat and cpu-stat is that they are independent
> of each other. In theory, reading one shouldn't affect the performance
> of reading the others. Since you are doing mem-stat and cpu-stat reading
> repetitively in a loop, it is likely that all the data are in the cache
> most of the time resulting in very fast processing time. If it happens
> that the specific memory location of mem-stat and cpu-stat data are such
> that reading one will cause the other data to be flushed out of the
> cache and have to be re-read from memory again, you could see
> significant performance regression.
>
> It is one of the possible causes, but I may be wrong.

Do you think it's somewhat similar to how iterating a matrix in rows
is faster than in columns due to sequential vs random memory reads?

* https://stackoverflow.com/q/9936132
* https://en.wikipedia.org/wiki/Row-_and_column-major_order
* https://en.wikipedia.org/wiki/Loop_interchange

I've had a similar suspicion and it would be good to confirm whether
it's that or something else. I can probably collect perf counters for
different runs, but I'm not sure which ones I'll need.

In a similar vein, if we could come up with a tracepoint that would
tell us the amount of work done (or any other relevant metric that
would help) during rstat flushing, I can certainly collect that
information as well for every reading combination.
