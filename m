Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852363A0296
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 21:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhFHTG6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 15:06:58 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:38412 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbhFHTE7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 15:04:59 -0400
Received: by mail-yb1-f181.google.com with SMTP id m9so25264885ybo.5
        for <cgroups@vger.kernel.org>; Tue, 08 Jun 2021 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Q62ke2XWkCOB5xI489ufG7OUF/C+vGscmBTXHr5cls=;
        b=JefvDSOvRlIAhXCAScJI3MkrvZhUIqoSdi6+Zz2+X+DhJhDkZGIb/RKdsWCOR4WEtZ
         tF7RtQv54pePx1GdKw4blv5HZiO6Z+lQKXXIlkM4+J2ovC5QPJv2Sb7qhE6oFEBKV4gH
         eOFrb4Hd9QdANKsb8iQUrZgkWOo9+QjRdiK1KDejN9LfyG3XLhosv9XRuSbvmKi9AsrS
         CAlZXeQeb7D73fVptUQ1IgolesraCPWKtmlUw38fv7/MZZERWznE9GnfY1NBzpLWunA9
         X9aOnqH7ZcssaOPiLi1NyvLnqcwaa5HORPlh/7FDqQWHu9NO7/J8QgryUQ4CoHgt4rTP
         c/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Q62ke2XWkCOB5xI489ufG7OUF/C+vGscmBTXHr5cls=;
        b=ihVe5IUq3umtomWQ9pIe6+p6KMA7c9AWpeECMNY3i4Ads8ZOdu5eTm4gT4AA8toPaM
         0EfeFjwlbQgRH4wgrTxExt2deSDjlk8X3M9NvYtfbdEaun4/GF3rne++ntaeSGOn1c3h
         nbeUqN1CQQIThUKDuSiKJm36Bjxjj8YnbYXY09lOozxuK3pZKiu0qm+T3Wx4NZ0/atNR
         U6fnlJ99KLsSHQC+zV1Vz0NeGFTff4JbvJWoRomSYS/7q6gXGyLR8lbDr1Z6wLNBFXli
         J4H9ArsL8jJ7v4taUTU3sBr5us/e2gBNR6WNr+lUgH/M2eIp5U9fJd/5ZI69Et3vajOq
         e7rg==
X-Gm-Message-State: AOAM531yO69zURk1yWLHxTVFL+CqsRi9lFt5pycgkO4AZZ4cW9p96EFF
        o2EpE3JGMZ8UWUC6kb2rtJSQfNU50m2lVGRcziuC3Q==
X-Google-Smtp-Source: ABdhPJy+fNm4QOr298WGvA4Zlz2bTkxgJLA52gN0Z8CpWJHcMpPf1UbFpG1hxpnar6yV3Ga3LQ+Vlh1duPmEzUpeJQE=
X-Received: by 2002:a25:1ec2:: with SMTP id e185mr33330825ybe.23.1623178925539;
 Tue, 08 Jun 2021 12:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210524195339.1233449-1-surenb@google.com> <YL++cWuetMvfx9Tf@slm.duckdns.org>
In-Reply-To: <YL++cWuetMvfx9Tf@slm.duckdns.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 8 Jun 2021 12:01:54 -0700
Message-ID: <CAJuCfpFKBpz10eMaPjcycoLrJ=m68U9=hoEZAG=02Pa+zuBVZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, macro@orcam.me.uk,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 8, 2021 at 12:01 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, May 24, 2021 at 12:53:39PM -0700, Suren Baghdasaryan wrote:
> > PSI accounts stalls for each cgroup separately and aggregates it at each
> > level of the hierarchy. This causes additional overhead with psi_avgs_work
> > being called for each cgroup in the hierarchy. psi_avgs_work has been
> > highly optimized, however on systems with large number of cgroups the
> > overhead becomes noticeable.
> > Systems which use PSI only at the system level could avoid this overhead
> > if PSI can be configured to skip per-cgroup stall accounting.
> > Add "cgroup_disable=pressure" kernel command-line option to allow
> > requesting system-wide only pressure stall accounting. When set, it
> > keeps system-wide accounting under /proc/pressure/ but skips accounting
> > for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Applied to cgroup/for-5.14.
>
> Thanks.

Thanks folks!

>
> --
> tejun
