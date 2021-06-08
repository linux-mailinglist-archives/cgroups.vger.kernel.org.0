Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F839FC77
	for <lists+cgroups@lfdr.de>; Tue,  8 Jun 2021 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhFHQ1N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Jun 2021 12:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbhFHQ1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Jun 2021 12:27:12 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729DC061574
        for <cgroups@vger.kernel.org>; Tue,  8 Jun 2021 09:25:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p184so31009208yba.11
        for <cgroups@vger.kernel.org>; Tue, 08 Jun 2021 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9BYezu8gyZabw4yWCqgrj5D/dzmRPqg3cqOBnuX70I=;
        b=JFQV+NEkpW/iFhrOOSAEJdSvL4Y5t7uoDY1dd51Y2Duhk5IpfAeqhuOyRWPFleGd3j
         IYdDjObTU/mSwgFZLLbQl5DFxzATFnERzNKUj5O4DVbW7GoQzRu3HVFLrA6eE932UFqa
         TUBINtgBShb/FCjRoTrYIdj2+wQRXbb2T1VZ52hbLSQRcCbHE42KncKpaSAw32jsGP5E
         aOHoGGn9J8Esk/WJ6zRNYgghsabPfwjmjUR7H7m9bfTjOaWn1kBnCbrIJrYVMBeHab7V
         9z39z1pHc3ZsyC7nRCPnIz4iOwdfrAki0j7U0Jb8FcXcaGkp0//wtiz90eUBg7r+88WM
         BlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9BYezu8gyZabw4yWCqgrj5D/dzmRPqg3cqOBnuX70I=;
        b=GoUOd6PAdmqASwMx+XW2+foKXngUnfDoRqljm9CI1iHLRI+W/vhzZWMg5ClwPfQnmQ
         AxdnoSBgn/rkiv5nxesX4RQ5PvaL2ilpRZ32FmAOgD5vKPaZDVqKnxwAlSwjJpmvYiZP
         3fwMN1OOp/tyQfek/FwJf+sTkXWvQIYIKzP2HRtImyKO9rucqVYP70rT+yiJXi3oDQOz
         HwO9b+UTAbb4DYPcuorWJFfWm9ifbvjrI/YCREu+u7Yr0jByCakmy62Oe5KxgjlOkzB6
         pZtMShTboTemPakqZuW3OYSPhIYjPJxNIJ6rgwVgmspyYOLhzOoyTZv7DryI+8w4CCHH
         r+Tg==
X-Gm-Message-State: AOAM5300trRAJ71Wkwn75GGbmANhpI+Yx7IP1hSztfcHqukNa02VA7F+
        yPblKs/d16x7Wscmyv1BXzquG02o3g0fZ8GKnn5cJw==
X-Google-Smtp-Source: ABdhPJy/90mDe1H2hifctB9B/7ALX5JPz820xu2hHqF2Ww069zzxmnIKlkaoYn4bNVvu6YINVAbfCT1TVBOcLPHP9dE=
X-Received: by 2002:a25:ade3:: with SMTP id d35mr34223802ybe.190.1623169519031;
 Tue, 08 Jun 2021 09:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210524195339.1233449-1-surenb@google.com> <YKz07nx3E8UEo1xa@cmpxchg.org>
In-Reply-To: <YKz07nx3E8UEo1xa@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 8 Jun 2021 09:25:08 -0700
Message-ID: <CAJuCfpE2U3LAZP_42b7XV7rfQTdJWbTVw43TDcxGM95oW03upQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] cgroup: make per-cgroup pressure stall tracking configurable
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 25, 2021 at 6:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
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
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Gentle ping for cgroup folks to please take a look at the cgroup interface part.
