Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CF63930A0
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhE0OU7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 10:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236395AbhE0OU4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 10:20:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FDC061763
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 07:19:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f30so396760lfj.1
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LatqtaP/aGx6woxQl/xZuLro5ci8AMLtHb6rQktXh24=;
        b=M7YJUkv0b9ZqkYCDwgcBFIcG5MN4CKndmPnWQdY2RJQHhZFVfdRUJHVRnhKAumFP7L
         xB0gbKrxCsAVajM8z2yvoA1bc7kvVBybZX48Htc446q/1kNtqtm5hoaVse9MYQh660Wv
         E56HXbe9YBGsOWvDV03VnedvUY8Mat1bdqAGkqtC0LuSynuSgH8hjijzLj+Xy6bhjsK/
         5u/9h3epeiMaAH7QNiIm4MIhBuom/9p5Fw+VhVhcAg3mg0GxMNmAPhNCio3HOiAC+6U5
         oM94F79Pvp3i6mfXvE8WGMbW0XSv7cApEYZHQ4BeedsDydhMkYNurUGs9FfJ6NnDhxvv
         QHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LatqtaP/aGx6woxQl/xZuLro5ci8AMLtHb6rQktXh24=;
        b=SyFdR0Hk7taTLXaV/Tqm35OxL+Ay4OKGe4/VbYg7UmzIdLKZXTSFnpigJGIp72XwU2
         DMkr9aYg+5Nyoc1nldsaHqjDf5tYF8yYpIqQgTAEyUKxMytU6oH6vpoK9LUsGdv7SjVX
         f3zCiEve71B3tx1vz0bHXG4ia6Ju06zgTSVgO7dIPiSLd0eyp3d/DyBzP8c0GUYUlpKR
         XSx9mLxHC7nhvZzUHv9VS4zjIAkxggdNYiN0AODmqFpHsxaqF+QvrtMZaUaxiWiPPZ4l
         yyCuLD5BzwFDG6gygWEQDfN/5p+ZL6S1P6GfhnBQ+0ruZqd/YWqwpmXcEVuqV3bG1xrF
         pmHg==
X-Gm-Message-State: AOAM530h78qlJKubn+HcsVStu7KDKhiEvLLVa8+Lir5Y9d5qxsX1c/sG
        7ySBoYjQpILEkiYF7axcqyX+243IhrYLKrmHXvsuCkpk9qI=
X-Google-Smtp-Source: ABdhPJwsOlsV0ZytuPo8dcabW8+vOtf/l++7R/XvOwxqJ9HGcHO+jMzLXJOXXcOg7S38dSjqEO5I6lMj20DMgZ1RfXc=
X-Received: by 2002:a19:e017:: with SMTP id x23mr2549190lfg.254.1622125159781;
 Thu, 27 May 2021 07:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
In-Reply-To: <20210527122916.27683-1-vincent.guittot@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 16:19:08 +0200
Message-ID: <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
Subject: Re: [PATCH 0/2] schd/fair: fix stalled cfs_rq->tg_load_avg_contrib
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Odin Ugedal <odin@uged.al>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Odin,

On Thu, 27 May 2021 at 14:29, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Odin reported some fairness problem between cgroup because of stalled
> value in cfs_rq->tg_load_avg_contrib:
>
> https://lkml.org/lkml/2021/5/18/566
>
>
> 2 problems generated this situation:
> -1st: After propagating load in the hierarchy, load_sum can be null
>  whereas load_avg isn't so the cfs_rq is removed whereas it still
>  contribute to th tg's load
> -2nd: cfs_rq->tg_load_avg_contrib was not always updated after
>  significant changes like becoming null because cfs_rq had already
>  been updated when propagating a child load.
>

This series fixes the problem triggered by your 1st script on my test
machine. But could you confirm that this patchset also fixes the
problem on yours

Regards,
Vincent

>
> Vincent Guittot (2):
>   sched/fair: keep load_avg and load_sum synced
>   sched/fair: make sure to update tg contrib for blocked load
>
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>
