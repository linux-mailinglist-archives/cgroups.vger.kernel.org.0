Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60819674DC
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfGLSBi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jul 2019 14:01:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35591 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbfGLSBi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jul 2019 14:01:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so5134611plp.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jul 2019 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b6hwgXA922LSiU77QdmFAK6M0uj4ZKo/a8bhNCXvaZI=;
        b=gRgLmceCvYbTpcuxiDu6B/wRGW1Sid2xetbUgH5NjoJvHuQbGTLboGv+fsjK3hC49X
         QG5c4Kmv5UEsJ5iOSkPs6oEdqMdj1lD8qw4KZpG4ZixNZipR316XpAJuIuzjbblIlT89
         mmMWoyLeawiIelt0BspNgZVnxqP3P4ctHnbk/eNKv/FLPjXGK4docqWF4rsePqdKeg3z
         rIxfuf/sxPP646RbS/qtyKxYAYA0eB+OkbVjDxvXPZE+/wtbZC+z0cOAgaILAjSS5Wji
         psWSnMi9FGsl7PQxS+Qp6sOtd0IuZbnSf7vaq5jiCF3fH/OVPetpOqBSbam8HYTExlpV
         Irbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=b6hwgXA922LSiU77QdmFAK6M0uj4ZKo/a8bhNCXvaZI=;
        b=m5AisvTRf1lzKzofmnz+h4PZdE/uoJ3KoKDESRjeKCn35Id65dXw7HzT04b8HB63S8
         3O9SXPKMqUby3MEEECOFGOSjg9G+SSfi37PZJW8ItGFQr5u57K2voJEQ5cUYjNpJTxnt
         jQwQVUFRaPLm8Ezl+Syn9CwesTtdIySxHyHROZKe/QtDHAc0H45EwucUozbYODlWqVvp
         VvBR0Ms2z4OT7Poc/0GrXpc5LpufZC5kNT8LM34MW7cRQOmCAnbNvC/6vy/B0Pfl67uw
         3l8p0dCtKAHSiCOZK6/BVhZnPppbZ+Tv4ywG8AKPjM1hxxEpjfHxJLg0nGDPXyFVL4eb
         clFA==
X-Gm-Message-State: APjAAAVRBx1U2ftQ7F4IdmWCke2gK0FLtXF1cNOTCtEjYzePpoG9jcwq
        siTDEjod6N0563eoTT2QQM3VMA==
X-Google-Smtp-Source: APXvYqwowaQhDJ+ynRQ8i6JkQUSv4PZETsbhuVaHAkZ3NWQw8s3foPy1DmT+joDB8E8cPRg+iBm7xw==
X-Received: by 2002:a17:902:6a2:: with SMTP id 31mr12391837plh.296.1562954496844;
        Fri, 12 Jul 2019 11:01:36 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id d14sm13175357pfo.154.2019.07.12.11.01.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 11:01:35 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
        <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
        <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
        <20190711095102.GX3402@hirez.programming.kicks-ass.net>
        <xm26v9w8jwgl.fsf@bsegall-linux.svl.corp.google.com>
        <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
Date:   Fri, 12 Jul 2019 11:01:34 -0700
In-Reply-To: <CAC=E7cV4sO50NpYOZ06n_BkZTcBqf1KQp83prc+oave3ircBrw@mail.gmail.com>
        (Dave Chiluk's message of "Thu, 11 Jul 2019 18:48:24 -0500")
Message-ID: <xm26r26vjfnl.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> So I spent some more time testing this new patch as is *(interrupts disabled).  I know I probably should have fixed the patch, but it's hard to get time on big test hardware sometimes, and I was already well along my way with testing.
>
> In regards to the quota usage overage I was seeing earlier: I have a
> theory as to what might be happening here, and I'm pretty sure it's
> related to the IRQs being disabled during the rq->lock walk. I think
> that the main fast thread was able to use an excess amount of quota
> because the timer interrupt meant to stop it wasn't being handled
> timely due to the interrupts being disabled. On my 8 core machine this
> resulted in a what looked like simply improved usage of the quota, but
> when I ran the test on an 80 core machine I saw a massive overage of
> cpu usage when running fibtest. Specifically when running fibtest for
> 5 seconds with 50ms quota/100ms period expecting ~2500ms of quota
> usage; I got 3731 ms of cpu usage which was an unexpected overage of
> 1231ms. Is that a reasonable theory?

Tht doesn't seem likely - taking 1ms would be way longer than I'd expect
to begin with, and runtime_remaining can go negative for that sort of
reason anyways assuming the irq time is even counted towards the task.
Also I don't that the enable-irqs version will help for the scheduler
tick at least without rt patchsets.

That is still also too much for what I was thinking of though. I'll have
to look into this more.

>
> I'll try to get some time again tomorrow to test with IRQs disabled before the walk.  Ben if you have a chance to fix and resend the patch that'd help.
>
> I'm really starting to think that simply removing the quota expiration
> may be the best solution here.  Mathmatically it works out, it makes
> the code simpler, it doesn't have any of the lock walk issues, it
> doesn't add extra latency or overhead due to the slack timer,

It works out _for the job that is supposed to be throttled_. If the job
then gets a burst of actually-expensive work on many threads it can then
use NCPUs extra ms, adding latency to any other job on the system. Given
that it's still only 1ms on each runqueue, maybe this isn't the end of
the world, but the fail case does exist.

(We have to do exactly the same locking stuff on distribute, both more
rarely on the period timer, and on the currently existing slack timer)

> and that behavior is exactly what the kernel was doing for 5 years with few complaints about overage afaik.
>
> Either way, I'm very glad that we are getting to the end of this one, and all solutions appear to solve the core of the problem.  I thank you all the work you guys have put into this.
>
> On Thu, Jul 11, 2019 at 12:46 PM <bsegall@google.com> wrote:
>
>  Peter Zijlstra <peterz@infradead.org> writes:
>
>  > FWIW, good to see progress, still waiting for you guys to agree :-)
>  >
>  > On Mon, Jul 01, 2019 at 01:15:44PM -0700, bsegall@google.com wrote:
>  >
>  >> - Taking up-to-every rq->lock is bad and expensive and 5ms may be too
>  >>   short a delay for this. I haven't tried microbenchmarks on the cost of
>  >>   this vs min_cfs_rq_runtime = 0 vs baseline.
>  >
>  > Yes, that's tricky, SGI/HPE have definite ideas about that.
>  >
>  >> @@ -4781,12 +4790,41 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  >>   */
>  >>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  >>  {
>  >> -    u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
>  >> +    u64 runtime = 0;
>  >>      unsigned long flags;
>  >>      u64 expires;
>  >> +    struct cfs_rq *cfs_rq, *temp;
>  >> +    LIST_HEAD(temp_head);
>  >> +
>  >> +    local_irq_save(flags);
>  >> +
>  >> +    raw_spin_lock(&cfs_b->lock);
>  >> +    cfs_b->slack_started = false;
>  >> +    list_splice_init(&cfs_b->slack_cfs_rq, &temp_head);
>  >> +    raw_spin_unlock(&cfs_b->lock);
>  >> +
>  >> +
>  >> +    /* Gather all left over runtime from all rqs */
>  >> +    list_for_each_entry_safe(cfs_rq, temp, &temp_head, slack_list) {
>  >> +            struct rq *rq = rq_of(cfs_rq);
>  >> +            struct rq_flags rf;
>  >> +
>  >> +            rq_lock(rq, &rf);
>  >> +
>  >> +            raw_spin_lock(&cfs_b->lock);
>  >> +            list_del_init(&cfs_rq->slack_list);
>  >> +            if (!cfs_rq->nr_running && cfs_rq->runtime_remaining > 0 &&
>  >> +                cfs_rq->runtime_expires == cfs_b->runtime_expires) {
>  >> +                    cfs_b->runtime += cfs_rq->runtime_remaining;
>  >> +                    cfs_rq->runtime_remaining = 0;
>  >> +            }
>  >> +            raw_spin_unlock(&cfs_b->lock);
>  >> +
>  >> +            rq_unlock(rq, &rf);
>  >> +    }
>  >
>  > But worse still, you take possibly every rq->lock without ever
>  > re-enabling IRQs.
>  >
>
>  Yeah, I'm not sure why I did that, it isn't correctness.
