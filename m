Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8B3036C
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfE3Uo7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 16:44:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40740 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Uo7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 16:44:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so4692848pfn.7
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q6AUBPvqyat2bLNM++F9NloXkkCwBt3/tItx63cMlpE=;
        b=C2e/JzbpUueBW6GWiWsrwQbKeGbHeV+0umj6fYHo//SnFeP6ktUlkhrM4ciCTH1r01
         GiqRMuwhQC4PFGeU4JtJ0cJmEDB1GcL+fEV+5ReV0/OX84vu6QQipYF9IhWRIseSCwye
         Yd6Ny28KV9jXxKId1cKev/qx2qjNT0bNlIcUcOqT0gSzZOqgBx5CcDyj9XKs/HG3tl2u
         A+9dmAt0jbXOjWnMgRSXENvJAGGJ+s8n42XCpdvtVEegDqVRT4irnQKFTlL8YP4C6XFA
         m7/G009ugSO8iFwOfoNeeFB2/YjQO5yA7UBg1McHFypCDaz91MGXSxTYKuZtMWd09wdF
         2lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=q6AUBPvqyat2bLNM++F9NloXkkCwBt3/tItx63cMlpE=;
        b=R9hg2bvyRaNMW7LFVCZlzDI5kxaRXSIB4u2v0bE/fua8RJEjbllR9hQhoozwUX6KpV
         dHhAH5ijZAAFfom9L39PRbn8qT6Hj3OGLMgK/l98/k0q5TKcZK85fKGtJlGp392tfp5m
         qcESaSxktLIFB3bwnwqzJ8hiQoOphmLHcqML29bgesOCj7AdbtjmBrbjnqcCWcLY16Ep
         LwwVZ614AhbWhODTcTj/BxTQGGOrAAGpYX4Vlgc1uCWy5yPfUcyoEq78LEudE4Kwe/Uo
         pORTN5p+EZjvDDmBxJhumD+44UrRzV/hE+OCUTUYYQh43tb9emW5AguZYQej9t58JtQP
         mT0w==
X-Gm-Message-State: APjAAAVAXQ+1KvNpXWlUW0kzn0fdaXk0KZKAJmVnuB40HX47N/WzFYlG
        6pQrfZ/E/OAiHG32tN9bwpTl2Q==
X-Google-Smtp-Source: APXvYqwupWORAT9iyn5M2LRuwVXU+wPnlXfdJiuevQ15iB/9Mq30VTKY+wUMHcd1Nm1Mx7YzW8V9nQ==
X-Received: by 2002:a17:90a:2a09:: with SMTP id i9mr5287388pjd.103.1559249097503;
        Thu, 30 May 2019 13:44:57 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id k22sm4021024pfk.54.2019.05.30.13.44.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 13:44:56 -0700 (PDT)
From:   bsegall@google.com
To:     Dave Chiluk <chiluk+linux@indeed.com>
Cc:     Phil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        pjt@google.com
Subject: Re: [PATCH v3 1/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
        <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
        <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com>
        <xm264l5dynrg.fsf@bsegall-linux.svl.corp.google.com>
        <CAC=E7cU9GetuKVQE1HxXsSuOKgyxezXUmSH2ZDHOrLio_YZi1g@mail.gmail.com>
Date:   Thu, 30 May 2019 13:44:55 -0700
In-Reply-To: <CAC=E7cU9GetuKVQE1HxXsSuOKgyxezXUmSH2ZDHOrLio_YZi1g@mail.gmail.com>
        (Dave Chiluk's message of "Thu, 30 May 2019 12:53:37 -0500")
Message-ID: <xm26zhn3y8mw.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Dave Chiluk <chiluk+linux@indeed.com> writes:

> On Wed, May 29, 2019 at 02:05:55PM -0700, bsegall@google.com wrote:
>> Dave Chiluk <chiluk+linux@indeed.com> writes:
>>
>> Yeah, having run the test, stranding only 1 ms per cpu rather than 5
>> doesn't help if you only have 10 ms of quota and even 10 threads/cpus.
>> The slack timer isn't important in this test, though I think it probably
>> should be changed.
> My min_cfs_rq_runtime was already set to 1ms.

Yeah, I meant min_cfs_rq_runtime vs the 5ms if the slack stuff was
broken.

>
> Additionally raising the amount of quota from 10ms to 50ms or even
> 100ms, still results in throttling without full quota usage.
>
>> Decreasing min_cfs_rq_runtime helps, but would mean that we have to pull
>> quota more often / always. The worst case here I think is where you
>> run/sleep for ~1ns, so you wind up taking the lock twice every
>> min_cfs_rq_runtime: once for assign and once to return all but min,
>> which you then use up doing short run/sleep. I suppose that determines
>> how much we care about this overhead at all.
> I'm not so concerned about how inefficiently the user-space application
> runs, as that's up to the invidual developer.

Increasing scheduler overhead is something we generally try to prevent
is what I was worried about.

> The fibtest testcase, is
> purely my approximation of what a java application with lots of worker
> threads might do, as I didn't have a great deterministic java
> reproducer, and I feared posting java to LKML.  I'm more concerned with
> the fact that the user requested 10ms/period or 100ms/period and they
> hit throttling while simultaneously not seeing that amount of cpu usage.
> i.e. on an 8 core machine if I
> $ ./runfibtest 1
> Iterations Completed(M): 1886
> Throttled for: 51
> CPU Usage (msecs) = 507
> $ ./runfibtest 8
> Iterations Completed(M): 1274
> Throttled for: 52
> CPU Usage (msecs) = 380
>
> You see that in the 8 core case where we have 7 do nothing threads on
> cpu's 1-7, we see only 380 ms of usage, and 52 periods of throttling
> when we should have received ~500ms of cpu usage.
>
> Looking more closely at the __return_cfs_rq_runtime logic I noticed
>         if (cfs_b->quota != RUNTIME_INF &&
>             cfs_rq->runtime_expires == cfs_b->runtime_expires) {
>
> Which is awfully similar to the logic that was fixed by 512ac999.  Is it
> possible that we are just not ever returning runtime back to the cfs_b
> because of the runtime_expires comparison here?

The relevant issue that patch fixes is that the old conditional was
backwards. Also lowering min_cfs_rq_runtime to 0 fixes your testcase, so
it's working.

>
>> Removing expiration means that in the worst case period and quota can be
>> effectively twice what the user specified, but only on very particular
>> workloads.
> I'm only removing expiration of slices that have already been assigned
> to individual cfs_rq.  My understanding is that there is at most one
> cfs_rq per cpu, and each of those can have at most one slice of
> available runtime.  So the worst case burst is slice_ms * cpus.  Please
> help me understand how you get to twice user specified quota and period
> as it's not obvious to me *(I've only been looking at this for a few
> months).

The reason that this effect is so significant is because slice_ms * cpus
is roughly 100% of the quota. So yes, it's roughly the same thing.
Unfortunately if there are more spare cpus on the system just doubling
quota and period (keeping the same ratio) would not fix your issue,
while removing expiration does while also potentially having that effect.

>
>> I think we should at least think about instead lowering
>> min_cfs_rq_runtime to some smaller value
> Do you mean lower than 1ms?

Yes
