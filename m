Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1ABB36C500
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 13:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhD0LZR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 07:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0LZR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 07:25:17 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D05DC061756
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 04:24:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id y12so43830567qtx.11
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 04:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+zgbtU1vOwhB3SBIed2el/86CyL2G7RXLQCFx+dXdg=;
        b=HlpVAXsGwPwleAUn5ptrQGwKr3io8B11Ggf5oOOFF/81PXRpzhU1BycPn7o/Jt6S2g
         nv/RFiCmYAREjuFLohn5tc3Ph5xIJF73FSXqTuYWAZ0H8ahvcbSLqjCJyJf+1zAaKyp1
         313H9G30Y4gMvZnhEis/kECBcqIGerF7dKuyyPVLXUe9gOizLeCoO7uaonnh2SayjBtQ
         ysQoQYoXuyE6PCWMeBMwEJzM/nIokfX0pKBmZMBH6RaoRHr2b2NQRV95mKW4iAtt5Ja1
         9ge5M8wjBHy8+wdmhfhtpbixsu/ynWL/M5lmCQnDRIDrQHtRAG4l8/D13PrnsZgGuJ+6
         YTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+zgbtU1vOwhB3SBIed2el/86CyL2G7RXLQCFx+dXdg=;
        b=Jyf7WHhLGjYGAkPyccoz7nhMlunxND5F4UNqEGOH8IvaSi6OGK2TEYJ080gpBfFocQ
         tbH0SBUU3DnQ5+y07YeIPOgNtgB1zIZzkQ68cd7L6PNp5YNM1v06ne4Eq9Qx/eB/SmLZ
         6kZDn8bT0j3UKLiXZDPQ2EbbZd4tNBJMWR90jsMndK8KMZdLZ8P/4uJn+zljawPBnbkh
         /4xWo+ZRAI8ABoOGgstVbVJ1319GIc65SspbSSu6GZIDW+getZg0mXMQGqyCAreutpEW
         YMMtwATjQ1OB6LTp1ZBZg1KRvq5Nfi+lv4wTAb3v0q0KXGYYsIHFXroORqXyFjKmAZFy
         DIyw==
X-Gm-Message-State: AOAM530G3TMTgFj08tLPxzB5vAC7k87/NgAxoK4WrN2aXmlja9lijxpM
        8cUidN7ZBkDvayvYWCQmro6AlOF4Sz5XDkdsUsiWWQ==
X-Google-Smtp-Source: ABdhPJwBp8bSnKxWI3RkUgNFimAZlKr4aCyPU3Y9n7PtYxqMyq9/sn8mJqQMBylFSS2K6fb1X5lcyNFW+EZdZQMY1JI=
X-Received: by 2002:ac8:6f7b:: with SMTP id u27mr20961714qtv.209.1619522673525;
 Tue, 27 Apr 2021 04:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080902.11854-1-odin@uged.al> <CAKfTPtBHm+CjBTA614P9F2Vx3Bj7vv9Pt0CGFsiwqcrTFmKzjg@mail.gmail.com>
 <CAFpoUr1FgZhuBmor2vCFqC9z7wao+XSybPxJZKFfK-wvZOagCA@mail.gmail.com> <CAKfTPtCdJC2-jxJn82Z4GSsHu0e49pKL4DT0GWk5vKXnyn1Gog@mail.gmail.com>
In-Reply-To: <CAKfTPtCdJC2-jxJn82Z4GSsHu0e49pKL4DT0GWk5vKXnyn1Gog@mail.gmail.com>
From:   Odin Ugedal <odin@ugedal.com>
Date:   Tue, 27 Apr 2021 13:24:00 +0200
Message-ID: <CAFpoUr2PmOzOfE4+zBP5HGzEypj-7BhStjUoCVChPt-yT_s2EA@mail.gmail.com>
Subject: Re: [PATCH 0/1] sched/fair: Fix unfairness caused by missing load decay
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

> I wanted to say one v5.12-rcX version to make sure this is still a
> valid problem on latest version

Ahh, I see. No problem. :) Thank you so much for taking the time to
look at this!

> I confirm that I can see a ratio of 4ms vs 204ms running time with the
> patch below.

(I assume you talk about the bash code for reproducing, not the actual
sched patch.)

> But when I look more deeply in my trace (I have
> instrumented the code), it seems that the 2 stress-ng don't belong to
> the same cgroup but remained in cg-1 and cg-2 which explains such
> running time difference.

(mail reply number two to your previous mail might also help surface it)

Not sure if I have stated it correctly, or if we are talking about the
same thing. It _is_ the intention that the two procs should not be in the
same cgroup. In the same way as people create "containers", each proc runs
in a separate cgroup in the example. The issue is not the balancing
between the procs
themselves, but rather cgroups/sched_entities inside the cgroup hierarchy.
(due to the fact that the vruntime of those sched_entities end up
being calculated with more load than they are supposed to).

If you have any thought about the phrasing of the patch itself to make it
easier to understand, feel free to suggest.

Given the last cgroup v1 script, I get this:

- cat /proc/<stress-pid-1>/cgroup | grep cpu
11:cpu,cpuacct:/slice/cg-1/sub
3:cpuset:/slice

- cat /proc/<stress-pid-2>/cgroup | grep cpu
11:cpu,cpuacct:/slice/cg-2/sub
3:cpuset:/slice


The cgroup hierarchy will then roughly be like this (using cgroup v2 terms,
becuase I find them easier to reason about):

slice/
  cg-1/
    cpu.shares: 100
    sub/
      cpu.weight: 1
      cpuset.cpus: 1
      cgroup.procs - stress process 1 here
  cg-2/
    cpu.weight: 100
    sub/
      cpu.weight: 10000
      cpuset.cpus: 1
      cgroup.procs - stress process 2 here

This should result in 50/50 due to the fact that cg-1 and cg-2 both have a
weight of 100, and "live" inside the /slice cgroup. The inner weight should not
matter, since there is only one cgroup at that level.

> So your script doesn't reproduce the bug you
> want to highlight. That being said, I can also see a diff between the
> contrib of the cpu0 in the tg_load. I'm going to look further

There can definitely be some other issues involved, and I am pretty sure
you have way more knowledge about the scheduler than me... :) However,
I am pretty sure that it is in fact showing the issue I am talking about,
and applying the patch does indeed make it impossible to reproduce it
on my systems.

Odin
