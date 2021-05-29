Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F96394B55
	for <lists+cgroups@lfdr.de>; Sat, 29 May 2021 11:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhE2Jfw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 May 2021 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhE2Jfu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 May 2021 05:35:50 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A22C061574
        for <cgroups@vger.kernel.org>; Sat, 29 May 2021 02:34:13 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id j184so6577060qkd.6
        for <cgroups@vger.kernel.org>; Sat, 29 May 2021 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t2zk5Z9qlmuHt7s59WmntMYgLXKVD6H7rp//7T7Ci/8=;
        b=hDCCEJVAZKetxCHmjId0bnmlfkx3k16wWn12wNDc5P5idPT0ngrHc3rLGObhkyriBA
         mvWG+3CPFlSemwRz6/fXgFfplhLrrwCh98FXV9wmSTImqhMKUrgx0gMSuP/84D0d+8F1
         7mFB4u54hKeRmrfeBxbOlnCpASZOQXTn6idAD5hD5+lB3QNbcG/BxCWObvGJvZ8GRaob
         qMPvxz97lervJeKwHD2gCa4qLV9+4lkpECE3tnM832PMwWx4zZURXY5u3hfI4DhsDqyR
         3h4CZOWLvtZjihPvbgqkqq5T+aN0xCp4TYoid+7HEBLzgoQ/+zTp9LvGewApdQg5gMFH
         H9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t2zk5Z9qlmuHt7s59WmntMYgLXKVD6H7rp//7T7Ci/8=;
        b=LjmvvuXvGck2M1u16qINL3Fh+WuRwin95u0gFuIj5b+d8j6Xd3yuTrx3k1jvBvUd/y
         D/+ib3VRVXPzq4TRxgm7T49NLfWpx3W6xgbK020X0QVXvuqX8LZmdO1xgc66ool3tKSW
         qhab4xwZA1Zljn+rj6s9+IaurNWNyTqosEmtBZnRGxMTXimfgAGOiFA7NSBOUN6wS578
         gFdOcT/jWtDeqvHENnQwyA+HPcGc5QvG7fl4ch/F7wL/ISGpiQsndwgLrplkFSwqIeSw
         wjIAImYjH5Bay3v5xRYCMWLZh1oD1v6g5Owx8tSQ/rEOmJEZXRLlkvDDbDrgeK2EfZZ0
         e3CA==
X-Gm-Message-State: AOAM532XrEcgAPziZOH4wH/BADEi479iuPKwm4vMSy5ZNWvqEyZPs3Fm
        W1KrJmlsfffjtxaiT4w66Gg73j2x8lIKAhxBs3rElg==
X-Google-Smtp-Source: ABdhPJwXoRj5VTC3ispBzurA46Rc887udt72YjBDhzkFyli/geAoFElPNHYPCgUZMfBGhigry3TT9gk/AkYI1XbfgsE=
X-Received: by 2002:ae9:e706:: with SMTP id m6mr7950209qka.74.1622280852071;
 Sat, 29 May 2021 02:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
 <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com> <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Sat, 29 May 2021 11:33:32 +0200
Message-ID: <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
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

> normally tg_load_avg_contrib should be null when cfs_rq_is_decayed()

Yeah, I think that is an ok assumption of how it _should_ work (given
the other patches in flight are merged).

> The reason of this list is to ensure that the load of all cfs_rq are
> periodically updated  as it is then used to share the runtime between
> groups so we should keep to use the rule whenever possible.

Yeah, right.

> we probably need to keep (cfs_rq->nr_running >= 1) as we can have case
> where tg_load_avg_contrib is null but a task is enqueued

Yeah, there is probably a chance of enqueuing a task without any load,
and then a parent gets throttled.
So (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running) is probably the
way to go if we want to avoid
a new field. Will resend a patch with that instead.

In case the new field is the main issue with the original solution, we
could also change the on_list int to have three modes like; NO, YES,
THROTTLED/PAUSED, but that would require a bigger rewrite of the other
logic, so probably outside the scope of this patch.

Thanks
Odin
