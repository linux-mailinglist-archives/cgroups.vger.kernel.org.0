Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316513A01F4
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 21:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbhFHS6T (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhFHS4O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 14:56:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF71AC06114F
        for <cgroups@vger.kernel.org>; Tue,  8 Jun 2021 11:51:34 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c10so8638184qvo.9
        for <cgroups@vger.kernel.org>; Tue, 08 Jun 2021 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BHtJ01+O9MGfngUx/tkkUwGswFNUD5Vr6xavfI/bB+w=;
        b=v3P4A1Ia9fsZuLq0N6xEVC9DWIR7E5XQuvfED1xa+4ijHr+R0m5duY4PKJQvebPG15
         hRsCLgqHerQAPTwhfmwD7jTNb/ulH6gF+KGJ+w76AqRERi19GdhmSOj+dZ+2zYIxX57C
         uw4tKBJkwaiv6f2xuCQt+8NnVu5ChESNI3Z4Upi4KY8a6frhl+UguSbowW9snrC9grp6
         lqG8bEjshk27OswFtIzW06u2agWPAgiLdpeKcMkkXteZHMGasVnfRVvEUt5AH4H23uMd
         LFi9PFcCnOjOrPCZOr5VVTCXC7q9GaoKD79JiY+vGKpDQIqEBAZDqHWTraY1bruDCPsV
         Uycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BHtJ01+O9MGfngUx/tkkUwGswFNUD5Vr6xavfI/bB+w=;
        b=tIc5fROUoPA62tzSWhMZGFcL2QNwVnZbHo9ef3Vw+L56szwPFkTc+7HhIQ7kNUCmoI
         EH3C0qKWrMHxj8aLqArzM3+l7U+4jgLiKz8XNHZ9zlxgXtk8eORKp/yG5Q+B5wKEc0XM
         b3BrUoYUsMAwsxRpSXZeGPZ8KSlG07fTJlo2dXqeNTHBkhofWR7A53aoQSHWv0EbzBAi
         n0TkUaDvG63eWrm5s0KbTTTacTITg77Wfv1WQaJdT9Aj9kBWWiiL/SSQskZW2fZjBZui
         a/X9huL8fIweR3D4x9iW1J/QA+pLoKvtfMTmypEd8Qs7zn8gJfoJDD3VUA1STByEyEOS
         K7yQ==
X-Gm-Message-State: AOAM531YUuDZBo+frg/UW1PggwF4HK0CckrDaW8dKwQ+T8h/9PRjF7+2
        hjDxQm8MNPgjv4pcgxLv7GwZEA==
X-Google-Smtp-Source: ABdhPJxDcpfYFvT+QzXz+jWD0tUoHBqOV1mhqCUxmPjSaeqEDUlqv5gxjBz9Vy9KsoVyiITJCIQe1w==
X-Received: by 2002:ad4:5fc7:: with SMTP id jq7mr1615457qvb.41.1623178294157;
        Tue, 08 Jun 2021 11:51:34 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id g2sm6107432qtb.63.2021.06.08.11.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:51:33 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:51:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking
 configurable
Message-ID: <YL+8NG8xBJmA6lOq@cmpxchg.org>
References: <20210524195339.1233449-1-surenb@google.com>
 <YKz07nx3E8UEo1xa@cmpxchg.org>
 <CAJuCfpE2U3LAZP_42b7XV7rfQTdJWbTVw43TDcxGM95oW03upQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE2U3LAZP_42b7XV7rfQTdJWbTVw43TDcxGM95oW03upQ@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 08, 2021 at 09:25:08AM -0700, Suren Baghdasaryan wrote:
> On Tue, May 25, 2021 at 6:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, May 24, 2021 at 12:53:39PM -0700, Suren Baghdasaryan wrote:
> > > PSI accounts stalls for each cgroup separately and aggregates it at each
> > > level of the hierarchy. This causes additional overhead with psi_avgs_work
> > > being called for each cgroup in the hierarchy. psi_avgs_work has been
> > > highly optimized, however on systems with large number of cgroups the
> > > overhead becomes noticeable.
> > > Systems which use PSI only at the system level could avoid this overhead
> > > if PSI can be configured to skip per-cgroup stall accounting.
> > > Add "cgroup_disable=pressure" kernel command-line option to allow
> > > requesting system-wide only pressure stall accounting. When set, it
> > > keeps system-wide accounting under /proc/pressure/ but skips accounting
> > > for individual cgroups and does not expose PSI nodes in cgroup hierarchy.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Gentle ping for cgroup folks to please take a look at the cgroup interface part.

Tejun, this is more in cgroups territory than it is psi/scheduler, and
should go through the cgroup tree.

Both the psi and the cgroup side look good to me, and we have Peter's
ack from the scheduler too.

Do you have concerns about the cgroup side? If not, would you mind
picking this up for 5.14?

Thanks
