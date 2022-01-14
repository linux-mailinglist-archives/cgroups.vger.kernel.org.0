Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621C448F323
	for <lists+cgroups@lfdr.de>; Sat, 15 Jan 2022 00:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiANXk4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 18:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiANXkz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 18:40:55 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392CC06173F
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 15:40:55 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id m1so9405168ybo.5
        for <cgroups@vger.kernel.org>; Fri, 14 Jan 2022 15:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiwAHNhKS7wc00xP0NkWpMqOI7Wv0fb83E9HIPmzpeQ=;
        b=f5K79nKirjMw1uZAqB8jvKCYF2VSIM89RFH6n+QkXCfokaesvVBgMlOYEtAdSqZTRe
         lU4Y83UqCN+A3ynzeu7Cc4A9Lze0vLHbfv4p82QUhm8UmXcH325CogYt9rgsMlhnr/tV
         o/BT2s/rIgeLPW2C8NyBCiWzOGTujj3UUp4uH+JcE5JScDKqp4VIzxf9QwQRJWX1NqZv
         uQQzr+LiOIxKC3vnSuq3o93vk3tOnscteB93o+ySjio9QbMGwlI+RR5LEeUp/pMtTbcB
         ioyvpduZTWaApn0ya56DywySKvdjIltTLxfYxnBRWUb55S3b6RHYaE9yhxwshTIoSXdi
         4agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiwAHNhKS7wc00xP0NkWpMqOI7Wv0fb83E9HIPmzpeQ=;
        b=2qOvQWqgLZ8x4BNovAJon4XIuD0rKvpXdpTyhbzHJUk0UhBQC0DEjXRVj1f+YHbrSW
         sCOVlbZ4BfstXJ9oijOnhAVgfkex5T/3V/n2yLvUT27idgmUUaNUTyBryJMKcv4uwf2q
         dmWt8MvzXZYJB+N4N5iMZP5Qy7jEGT5cbFPjNZ0sWKXBVi4PATo6tgpG6uihO9UiT36l
         rGoGQPIQ6uBJDlPDWTauIqALGIMQj2oN3OXex791Nr9QCKjpGukwMIs2c9T/mlTK//mk
         MZiQEpA10+qaIBpoUq1Wcm5xSPLcl+2Aehr+HeqNJHsbkL7PfKF0Mise9flK0H6+nvqU
         VVDA==
X-Gm-Message-State: AOAM530BvKXJdENoDjjv01Q6M3IiBHJBObNJCzYzgSGcoaHuQXxcEdiq
        +wRJq41DVd7ToF9D6bqsPRIc8Z8Nvf1fnzB3zXAPCfaqfTE=
X-Google-Smtp-Source: ABdhPJxRxEOjbCcQ1JteGghcNtkn8GKyG02j/d34y05q3mKkV0Z3Fjqf7yoh+LH/X0dgwobc5IaeHrn3GMvGkEwrGVE=
X-Received: by 2002:a25:86cd:: with SMTP id y13mr15747687ybm.120.1642203654682;
 Fri, 14 Jan 2022 15:40:54 -0800 (PST)
MIME-Version: 1.0
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
 <CABk29NtonxXS53J-+3w_GTLTVurf8HS4v35T9evoGyERB0uDqA@mail.gmail.com> <86fbc313-e179-0cbd-8f5b-66e7b5964b14@linux.alibaba.com>
In-Reply-To: <86fbc313-e179-0cbd-8f5b-66e7b5964b14@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 14 Jan 2022 15:40:43 -0800
Message-ID: <CABk29Nu0iCs83VjuipEohL63mdUg_4L-=dKPS0yzE=SfYXtcxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
To:     cruzzhao <cruzzhao@linux.alibaba.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> > 1) From your v1, I still wasn't quite sure if the per-cpu time was
> > useful or not for you versus a single overall sum (ie. I think other
> > metrics could be more useful for analyzing steal_cookie if that's what
> > you're specifically interested in). Do you definitely want the per-cpu
> > totals?
> >
> IMO, the per-cpu forced idle time can help us get to know whether the
> forced idle time is uniform among the core, or among all the cpus. IMO,
> it's a kind of balance.

Sure, I'm not opposed to it.

> > 2) If your cgroup accounting patch is merged, do you still want this
> > patch? You can grab the global values from the root cgroup (assuming
> > you have cgroups enabled). The only potential gap is if you need
> > per-cpu totals, though I'm working to add percpu stats to cgroup-v2:
> > https://lkml.kernel.org/r/%3C20220107234138.1765668-1-joshdon@google.com%3E
>
> If cgroup accounting patch is merged, this patch is still needed.
>
> Consider the following scenario:
> Task p of cgroup A is running on cpu x, and it forces cpu y into idle
> for t ns. The forceidle time of cgroup A on cpu x increases t ns, and
> the forcedidle time of cpu y increases t ns.
>
> That is, the force idle time of cgroup is defined as the forced idle
> time it caused, and the force idle time of cpu is defined as the time
> the cpu is forced into idle, which have different meanings from each other.
>
> And for SMT > 2, we cannot caculate the forced idle time of cpu x from
> the cgroup interface.

Ack. Note that the patch I linked above for per-cpu stats for
cgroup-v2 has been nack'd, so it is unlikely we'll have kernel exports
for cgroup-v2 per-cpu stats (but perhaps some export via BPF). In v2,
we could at least export the cgroup sum force idle time in cpu.stat,
if you feel it would be useful and want to add the accounting to
rstat. If you really just want the per-cpu root stats then I'm fine
with skipping cgroup for now.
