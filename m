Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE13944C4
	for <lists+cgroups@lfdr.de>; Fri, 28 May 2021 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhE1PIq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 May 2021 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbhE1PIo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 May 2021 11:08:44 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A44C061574
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 08:07:08 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id ee9so2021479qvb.8
        for <cgroups@vger.kernel.org>; Fri, 28 May 2021 08:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDD8L3cpZ2uFFlamRa44nzf+hjozNU1Vk7p0K9J8i9o=;
        b=KoaQZLCadrqQc1MDei7B5DjdK62FAI6dbnLjokWjqw0ebQKCen8jKX4GfN00n378Tp
         XaW8JKB9/lX9jENFAGzAmVEw3tn7p3uX4pLNSsyw6hBL86Zs328QRsWKb7oBoY0z21/b
         I/kKqYabSEmiCvBTAw70SMd7+1hSn1oEdpo1cjnHKrkeFTe4wq8UNniWQHp6y/GA06kh
         7R6SbOIG2fbVNz/rcKg3LvvzwAh8FvVqbmQwSpDfJSli9LLyQwvBfztM6HCbd/FjDj0U
         PpBO1YAodzZDoH2gA2j/dDZZLZlh3PsiRZZWvmkj9vFVJ2W+C6K17nH4ljIKOuzCUrwd
         MgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDD8L3cpZ2uFFlamRa44nzf+hjozNU1Vk7p0K9J8i9o=;
        b=feZi2L68kLlyjqthVpQyxfYg1yWrZXyxIrrQUsY5ZnnKs1c4O1rkdIWx2hdXm6So10
         YAReFCkfX0yQ7JXCctpHRcTjaJTJAi7xmMZs+uEktt/ujGZaRIOZT8WZrcgiTQYMKHxg
         +TjSYhTV0BdJYFJWo47v1E8B2a3Wym9yhoA3W+1UNZ0duOqvC2dldZQq+MLqX3rvwSPU
         JXRM0HMw2uAbv7BR9oxtrQZTn3o1qBNWt7VPhCr73iRMRIctR7Ol/e2Jv2AYjui6F/q5
         6RXKnccynRQqVBwLACF2XOJxjUML8/n1J/8GYrc0TTYw5r2b6ZWHQHgp7zw3BuRkiSkr
         0/hw==
X-Gm-Message-State: AOAM530ONPwGAmvTn35bIlRtMSEaDGncpKZsebyZoDpj4CgRyRQl3mlI
        dLCPrDhrs2gvqrq/dkCSjpwVD+2XVaFtcz5l56ENfg==
X-Google-Smtp-Source: ABdhPJzKQOEA79+lYBw/t/+iEDTK/o45Vp89w+udE1coSKfpm9wXglMQ5z+OdPUytAb8SsrgvEy4ND8S55vU8qC4Dgc=
X-Received: by 2002:ad4:420b:: with SMTP id k11mr4482269qvp.18.1622214427850;
 Fri, 28 May 2021 08:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-3-odin@uged.al>
 <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
In-Reply-To: <CAKfTPtCiV5LMoXBQVdSsvNq-vurFVVd4aVWW-C=8Tza8uJTCjg@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Fri, 28 May 2021 17:06:28 +0200
Message-ID: <CAFpoUr0x=tgayPWYPORR+-h8gNhiE1t12Ko2o15Y8JwOCLp=yw@mail.gmail.com>
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

> What would be the other condition in addition to the current one
> :cfs_rq->nr_running >= 1 ?

The condition is that if it has load, we should add it (I don't have
100% control on util_avg and runnable_avg tho.). Using
"!cfs_rq_is_decayed()" is another way, but imo. that is a bit
overkill.

> We need to add a cfs_rq in the list if it still contributes to the
> tg->load_avg and the split of the share. Can't we add a condition for
> this instead of adding a new field ?

Yes, using cfs_rq->tg_load_avg_contrib as below would also work the
same way. I still think being explicit that we insert it if we have
removed it is cleaner in a way, as it makes it consistent with the
other use of list_add_leaf_cfs_rq() and list_del_leaf_cfs_rq(), but
that is about preference I guess. I do however think that using
tg_load_avg_contrib will work just fine, as it should always be
positive in case the cfs_rq has some load. I can resent v2 of this
patch using this instead;

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad7556f99b4a..969ae7f930f5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4720,7 +4720,7 @@ static int tg_unthrottle_up(struct task_group
*tg, void *data)
                                             cfs_rq->throttled_clock_task;

                /* Add cfs_rq with already running entity in the list */
-               if (cfs_rq->nr_running >= 1)
+               if (cfs_rq->tg_load_avg_contrib)
                        list_add_leaf_cfs_rq(cfs_rq);
        }
