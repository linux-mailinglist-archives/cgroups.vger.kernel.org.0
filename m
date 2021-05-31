Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A69395A3A
	for <lists+cgroups@lfdr.de>; Mon, 31 May 2021 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhEaMP7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 May 2021 08:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhEaMP4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 May 2021 08:15:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4CC061760
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 05:14:15 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v5so14695506ljg.12
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 05:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/KWdRrmmQUUdShTYgF7N8YHkQMQeJcSbu2C2nHtMqGU=;
        b=rPbHFz8KHO8hT6NGvD8FDUegbYXzFW7CwBdAcvbOsVMGsFbruuLsU0t+/dIxYqnDg3
         AwU6BmbMSgVEjo10g4ffph+/MI0BxsmOoDQA0pnk5h+h9/NLd+KzdZnWBOdH3Q63JzN3
         qOjA/8KXwvqW03o+DutluDDTXhdFJrXEIY/KaLqieleaWDzq2lvmXjiriY6ta+yWbfkC
         IcfLKu4CUceHw5eiDkF4TEmXrpvgR1VPTkvVyVBOqbrPWuDOzUe32ws9zx+pBma5/mCn
         ygaMt6kRU1AOssL0eA1GxFLLmKh5mEzkxnpj6ZnaWMvBQm+NAWaBMH3lm3urLi+PRuvu
         6pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/KWdRrmmQUUdShTYgF7N8YHkQMQeJcSbu2C2nHtMqGU=;
        b=k6Bt5M6Q8BQfM3V6UiIv7ZQyvphMeu9QANb06RCuB+CKx+NyHT/XW+UzvsBflqYUaT
         twOQqSTVbLLHrwlf5BQWpxymm01Ynx3CvFcc2h2piMBajIKdmaUf0EdVrUgPKhu/nRXC
         mgX3fTvyaaqSQ9+PVyIhhFy2B6JSD0VaWhJr1qZTUA5tBCxvetotxp+KJlVQL7keU4ce
         i971wuK62ihmjIDoMg0HQxkB548uAH5eBjQcbk6djJW7k0A0fiIX5CKxekEcELB7Uec2
         zSCin0FA4SnJnQDvEQSFpOJbh/WRyfc29vmZlk75LrBLzkDPsPxJZLmP1Eb8swSSjJMN
         OVOg==
X-Gm-Message-State: AOAM532UVFHmjq5Mb9lL2SH7a1fkW3v0ar5KnaOqxGmwgMVrsp/KH76G
        8oGyDG4299Pd059Vliq5JYxzCnGbbEYdIU+qBPUjFw==
X-Google-Smtp-Source: ABdhPJyvLD06YGTA0HPbe+GRQR+7zENZnT2n3jtljEwYxE5gwf+uqYntGcOHUJDRFtbAzyvOdfv0nKianVTzIm4WDdc=
X-Received: by 2002:a2e:a7c8:: with SMTP id x8mr16237409ljp.209.1622463253572;
 Mon, 31 May 2021 05:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
 <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com>
 <CAKfTPtA6AyL2f-KqHXecZrYKmZ9r9mT=Ks6BeNLjV9dfbSZJxQ@mail.gmail.com> <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
In-Reply-To: <CAFpoUr04ziEzvNBJx0xKSuuEnapGzyABwaM-FU3TUaCZkQ4WPw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 31 May 2021 14:14:02 +0200
Message-ID: <CAKfTPtAwErfdVwdHFULGwbZj5D1axiB-A_AeY49R=aD9p6cezw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
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

On Sat, 29 May 2021 at 11:34, Odin Ugedal <odin@uged.al> wrote:
>
> Hi,
>
> > normally tg_load_avg_contrib should be null when cfs_rq_is_decayed()
>
> Yeah, I think that is an ok assumption of how it _should_ work (given
> the other patches in flight are merged).
>
> > The reason of this list is to ensure that the load of all cfs_rq are
> > periodically updated  as it is then used to share the runtime between
> > groups so we should keep to use the rule whenever possible.
>
> Yeah, right.
>
> > we probably need to keep (cfs_rq->nr_running >= 1) as we can have case
> > where tg_load_avg_contrib is null but a task is enqueued
>
> Yeah, there is probably a chance of enqueuing a task without any load,
> and then a parent gets throttled.
> So (cfs_rq->tg_load_avg_contrib || cfs_rq->nr_running) is probably the
> way to go if we want to avoid
> a new field. Will resend a patch with that instead.

Thanks

>
> In case the new field is the main issue with the original solution, we
> could also change the on_list int to have three modes like; NO, YES,
> THROTTLED/PAUSED, but that would require a bigger rewrite of the other
> logic, so probably outside the scope of this patch.
>
> Thanks
> Odin
