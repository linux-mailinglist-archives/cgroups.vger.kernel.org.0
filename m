Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0AD48BB86
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 00:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiAKXif (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 18:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243729AbiAKXic (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 18:38:32 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA6C061748
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 15:38:32 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m6so1483691ybc.9
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 15:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=95SGhqOm0RccSxJd03GJ+P09jT1muY8YMjYut8pvtqA=;
        b=oh8SsVjgy0iZTdFo6YzyNVUqT1q/qdQHbxYWVkHGO7CG64yrC1aFcOfJBL7xrSAlY+
         RVtvIjA/p2bWEp6apmi/M0sDnT83FLIUvq78MpV8sZy9vtQVY5tqeJrpJDEedtQvx9OZ
         MPw4nuikifUlivgQBD+7FjtvuZo7nc2CwEX8orNj2/Slu0GJ9e+69x01Jxsz2wlPaobq
         U/dF8X2zhedHCjjLSMl/qZhQ3HFa55fhGCf8qofKVe0BQLTWNijS9GIv/O/GHgBhOrHJ
         SgzyS93ujsrXUWxfD97cq7se0IRa35hwt980hfCuYJyr39pl1Jc8wlvTcVIIk5iE4kLR
         eGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=95SGhqOm0RccSxJd03GJ+P09jT1muY8YMjYut8pvtqA=;
        b=SovZ5uk6drKyZ4H7WjD7ezxpBlK137GNTbZO2IUiXMdEjFWwbpa2qaGUBNsurHhXPY
         vEDI0n50Oe8iRcOJabgi4Uuk9Hcmb9QDwfSj/L9DCHIE52cxkyjMlJi2fVjN6d28OREd
         l3you1/oLng9HWyzZFhTxc1FHsKXKiU0iX7i4W284KVz0O2xo1KQp9AiSqzX9FCUacOv
         U54HN9lyz7aOkK2aO6r3kFoJa52+YBEZYx7yBfc5bX7EFS74k2aVdI0u5f3yZgI1F5ab
         j4VHj9pQRDQaRQw7+c52mQAjprGjGtqA6eUw05xxXFAzfHxlcb7lQ4Sr3TLQn+VBaCgr
         wEiw==
X-Gm-Message-State: AOAM532XQhyuFdgRqvko0G702k3J7ZTDPwZdPQetAXLga9XeIP/wYJ58
        SIOhamgqhJf7cunrcfBfV27sgXh9IWw5I9iW0HLW7w==
X-Google-Smtp-Source: ABdhPJymtneO7XZ322JsP6ScH1vz+nxafPzDb/8P3vFGru+YCwIQAx2X7BIG31eVsRLKMY8+ovsKJfxSCiVJ37kJwjg=
X-Received: by 2002:a25:fc27:: with SMTP id v39mr10217685ybd.9.1641944311344;
 Tue, 11 Jan 2022 15:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20220107234138.1765668-1-joshdon@google.com> <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd189wHB2LJcK1Pv@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 11 Jan 2022 15:38:20 -0800
Message-ID: <CABk29NuGs_9uxgbv678W=BGGinZNiUHO5T57FHGbOG+HP-FT2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] cgroup: add cpu.stat_percpu
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 4:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 07, 2022 at 03:41:37PM -0800, Josh Don wrote:
>
> > +     seq_puts(seq, "usage_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.sum_exec_runtime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
> > +
> > +     seq_puts(seq, "user_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.utime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
> > +
> > +     seq_puts(seq, "system_usec");
> > +     for_each_possible_cpu(cpu) {
> > +             cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
> > +             val = cached_bstat->cputime.stime;
> > +             do_div(val, NSEC_PER_USEC);
> > +             seq_printf(seq, " %llu", val);
> > +     }
> > +     seq_puts(seq, "\n");
>
> This is an anti-pattern; given enough CPUs (easy) this will trivially
> overflow the 1 page seq buffer.
>
> People are already struggling to fix existing ABI, lets not make the
> problem worse.

Is the concern there just the extra overhead from making multiple
trips into this handler and re-allocating the buffer until it is large
enough to take all the output? In that case, we could pre-allocate
with a size of the right order of magnitude, similar to /proc/stat.

Lack of per-cpu stats is a gap between cgroup v1 and v2, for which v2
can easily support this interface given that it already tracks the
stats percpu internally. I opted to dump them all in a single file
here, to match the consolidation that occurred from cpuacct->cpu.stat.
