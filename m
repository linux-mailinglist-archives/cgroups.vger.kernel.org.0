Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCE3930D7
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbhE0O0i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbhE0O0h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 10:26:37 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AE9C061760
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 07:25:04 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id g8so320726qtp.4
        for <cgroups@vger.kernel.org>; Thu, 27 May 2021 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5ioh6/kmyR43pZvyyWx3jgh3NQ4aOfCzd/5djtqWu8=;
        b=uk1Clutn08ap0T0eYiCfBLwIre/sRgapht3WRTSb/OUz86VJK5yz1vBTHMxu/U6zTM
         YqtL/akei9DOsGUBMzxBwyWrksY5LQriwy+lYebt/K15XJVyvstz+BQ4izwCBbA6v85u
         o4N5jnOcO+4jk7cB4+k84aVnCN6+qkks38BBc6HPuA4f+UriPgZNqQ6oGHQjjiZ//4MT
         ypgXJjp0y+y2zzRQ1awvIiR+TVc3zxChipuUFY5u4wShlpQGC3K14lDxFs6rxWxxPufK
         h3L2wVOWANe9dPni62OaXYZV95+oNGkyNDclB4aLoBToQnycLzpEg9WfiXSx3Tlz4MtX
         jHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5ioh6/kmyR43pZvyyWx3jgh3NQ4aOfCzd/5djtqWu8=;
        b=LNhXdvOqUYlgotFA/0C1LOyUWxULChYEjQ9JPhZkeiPOwzpMJL36qBPcK7P2c5luiY
         X9rsfncraZN8SVFGKhfvKuSQTtoejABGc1NNJD9/I5TOwEP70RwrS9Jb+2FtLaLmemmZ
         AZwsyMdac/csGcrsYhbqUh8hNh/FdOYD+PSeirMaqDqpMHOvPxgFLU0E8Q1yBPAnUpAI
         OY+cILaBRtOFvbMLFJTwaodMdqxIjKokkMsgjxsFWxBFlrNeqMRpyq4OPmi7sjOJcadT
         M/FpZbCnsNouXy/4SVbfQVo7mcbDSGS0zmOnoLBCvcMosn2brFDdDcS0D6XtPh83z2gN
         /G5w==
X-Gm-Message-State: AOAM533jTag6+Qtc5OQ5Xy7cI6q9M1nADv4ze1cCDMIRExqGrJddQAzy
        78ujVIcBEAheshfxpDzrVAuviq6R6dWL6gyUoNoing==
X-Google-Smtp-Source: ABdhPJwhdt5wcjjTW0iOJsm+wu8Rclsir1cSLjlKUZxzBn3wYrKchPfxZu0GBf9UQHH89vz8RX0cSJxrC/rC3ukFH2o=
X-Received: by 2002:ac8:699a:: with SMTP id o26mr3318904qtq.209.1622125503830;
 Thu, 27 May 2021 07:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210527122916.27683-1-vincent.guittot@linaro.org> <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
In-Reply-To: <CAKfTPtAK2fkzhzKA8iFT8cEcCG6Q=8WfLskPYADvTrQ=nF7kDA@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 27 May 2021 16:24:24 +0200
Message-ID: <CAFpoUr0FrSV5VO40q7pbnqiiqCYbgS_YUp1Kktfn6YgOgh8whw@mail.gmail.com>
Subject: Re: [PATCH 0/2] schd/fair: fix stalled cfs_rq->tg_load_avg_contrib
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
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

Hi,

Yes, this does the trick!

I have tested this locally and it works as expected, as discussed in
the previous thread (more info there). Together with the patch "[PATCH
2/3] sched/fair: Correctly insert cfs_rq's to list on unthrottle", I
am unable to reproduce the issue locally; so this is good to go.

Feel free to add this to both patches when the warnings on the first
patch are fixed;

Reviewed-by: Odin Ugedal <odin@uged.al>

Thanks
Odin
