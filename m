Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5FC48BCCC
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 02:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiALB7f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 20:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbiALB7e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 20:59:34 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A5C061748
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 17:59:34 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id z22so1742757ybi.11
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 17:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVxEczww7H9SKUQS4bM3hqv/i/BHfSqFjaglAC6lVKQ=;
        b=Ts2boQ0OQ6dUg+Q1bgi1eRic89TubkUE0VQ2NPiyhgnU3O0OzuHrNsR/aYTnxham6j
         QkFUVZHsgmjs/3IJLRiePUPt2SyMyFnLJAjc+jITIcvu+aD44BkdZK20a5pA5ojpVZjz
         aOvkgkwHgYrqe31l/rstBihzrSuX6cCEeJOTCrj9q4I/BeqQFvPfpTlLSoJoJmqH6J3V
         yuAgSyr6Z0SbVWOFs00A9/fwH4X5uc6aBbvOAdytDX6Tn7l/PeZz0eXeYkvh9LgU2UoE
         lWPQDZt03th6mEf0Qj5U2yfEOk7ebdD/9B8nEoucVNGOBtU98dqeVrDKcGwN/HY+e6yu
         CB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVxEczww7H9SKUQS4bM3hqv/i/BHfSqFjaglAC6lVKQ=;
        b=WzuRxmtqkTSp5xIIGBR3YGC+L7XPFr1Kthpl7uOYtJHkMLAyHMvVQtOr8FZU8VUuFy
         6oskS9Ojvn2l8t3NiIWuW/eHylFsgByJ5ndF3T+LwLKK2zUtOBg05DggsZuKTGk7Drbr
         CfxN8785EF/5zguNjxXOy4Z5x3AW+z4qupgQvAf7tsLOAUXPNI+SPnxgGDBdtGpc7Go0
         ty4HEFAsIlhsOrjM921uNXo3+7Pmm2wYTFioxD33JDHkwydiyHuojw/O9NGkUqpq+hXj
         R5W3etQo31vqhLalvfunO8+YahntttNVPV7UxFSAFPIt+8Ken7U2M4/UqL6g2W9D+X+F
         3QJw==
X-Gm-Message-State: AOAM533EOAT9Bdp3MN8nShlCLVEmEWfXvsX6NkgB6mPxE1VzRZkMCSNw
        iRenNO4vRK7MrBzk+FITzjMJxR9IDiWBSoFx0PQkGQ==
X-Google-Smtp-Source: ABdhPJwN4hwcuKzBzJtr7wGTU0xnt0KS8/Uq8aK0aVyxSAu3ccYgg66CQmlwyhXOT6fWIigjAUWgjHVnsEGldOBZvgI=
X-Received: by 2002:a25:2383:: with SMTP id j125mr9713381ybj.430.1641952773384;
 Tue, 11 Jan 2022 17:59:33 -0800 (PST)
MIME-Version: 1.0
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com> <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 11 Jan 2022 17:59:22 -0800
Message-ID: <CABk29NtonxXS53J-+3w_GTLTVurf8HS4v35T9evoGyERB0uDqA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
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

On Tue, Jan 11, 2022 at 1:56 AM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>
> Accounting for "forced idle" time per cpu, which is the time a cpu is
> forced to idle by its SMT sibling.
>
> As it's not accurate to measure the capacity loss only by cookie'd forced
> idle time, and it's hard to trace the forced idle time caused by all the
> uncookie'd tasks, we account the forced idle time from the perspective of
> the cpu.
>
> Forced idle time per cpu is displayed via /proc/schedstat, we can get the
> forced idle time of cpu x from the 10th column of the row for cpu x. The
> unit is ns. It also requires that schedstats is enabled.
>
> Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
> ---

Two quick followup questions:

1) From your v1, I still wasn't quite sure if the per-cpu time was
useful or not for you versus a single overall sum (ie. I think other
metrics could be more useful for analyzing steal_cookie if that's what
you're specifically interested in). Do you definitely want the per-cpu
totals?

2) If your cgroup accounting patch is merged, do you still want this
patch? You can grab the global values from the root cgroup (assuming
you have cgroups enabled). The only potential gap is if you need
per-cpu totals, though I'm working to add percpu stats to cgroup-v2:
https://lkml.kernel.org/r/%3C20220107234138.1765668-1-joshdon@google.com%3E
