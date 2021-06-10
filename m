Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20E3A24BE
	for <lists+cgroups@lfdr.de>; Thu, 10 Jun 2021 08:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJGvt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Jun 2021 02:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJGvt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Jun 2021 02:51:49 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66600C061574
        for <cgroups@vger.kernel.org>; Wed,  9 Jun 2021 23:49:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id f30so1458110lfj.1
        for <cgroups@vger.kernel.org>; Wed, 09 Jun 2021 23:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=67pgjCx8vmxJvqmbawagxHeBDG9F0WOXi380k50exuo=;
        b=po0rea81p6koLdoj90+BpTqr297m34vqZiDHl35MFKN5HmBo/cINMskvg8Rj1AiXCD
         P/mX6NsU8ilK5hyP7AW2r0V1bwvN2iVAetVFInJHL3ulhputAR1fbbnR8g/j+kgSLQRN
         iXciNRcfQNWXmevrvU/V5C2Ds7I+9bLqYeVGkHSoUKiLnS7CZ/zFob00D4OF3VknComV
         +qQqQK4kXsp5qjvVU5KnImu/nnQ+tNK8McFDo2o+UIVNatGM0GWVemlGxwcDZQAGmctV
         Yi8SxUDNO9ks7NLikMTm/51IqsXk6A361yvzd5VwX3BuQ5o0Bb4YtgNKJRMi3H4g+gpU
         x25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=67pgjCx8vmxJvqmbawagxHeBDG9F0WOXi380k50exuo=;
        b=JbidD4F+J3GeQokEON/3VQo5ElaoTSTf15cav4ailvxIScHIoSl5amc+nJW8LBRbJB
         3j5ubxV8W2ox1AO9K2bkHlVyon4JX9ZDr1Usw6iLC5j1ZR+boKags/fgX/Ionwv7vcIK
         E88bnUpxJGQjPMdRpf93BKcAegNIt8zcV1bYiNB5zEfRHrJN97/2SKmcStt3t/CHixin
         gQQ0uPymRwZON+LZN4qDkhLELb9IXQtuKs9utsv+GIIixM6t3M9Ohvo3dhZDzsjlVqAL
         /5DjEvhTFI66Sgw/YUejU41MdsJ1Clx+bqkqYawTvRcAT6sPmXZVt8i8y+Mio19Tsp9X
         nXNw==
X-Gm-Message-State: AOAM532P7jGji6CRAoZPhyxMgwB2rDD+6dmEcEtpbrn4lzkO3e/4DcXU
        BZ0DG9zhPQLtvbomLlYsyG0QTaCl647vdKcYGl4i5Q==
X-Google-Smtp-Source: ABdhPJz6FaRyzkyT5JROY4fDMVlcASzRb2xRU5K+8ShUxTZ08+8Qwr8pCgPa1FkXe3u+pAUYQeCllBc3ABd61aq8ik8=
X-Received: by 2002:a05:6512:3b84:: with SMTP id g4mr969823lfv.277.1623307791024;
 Wed, 09 Jun 2021 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210604102314.697749-1-odin@uged.al> <YL+dTtsCtZjMeZWn@blackbook>
In-Reply-To: <YL+dTtsCtZjMeZWn@blackbook>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Jun 2021 08:49:39 +0200
Message-ID: <CAKfTPtBEZZo9fHDxe7viLyZmCe=4NTLLtBFyWM_UuJ1nmqxGvA@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 8 Jun 2021 at 18:39, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello.
>
> On Fri, Jun 04, 2021 at 12:23:14PM +0200, Odin Ugedal <odin@uged.al> wrot=
e:
>
> > @@ -4719,8 +4738,8 @@ static int tg_unthrottle_up(struct task_group *tg=
, void *data)
> >               cfs_rq->throttled_clock_task_time +=3D rq_clock_task(rq) =
-
> >                                            cfs_rq->throttled_clock_task=
;
> >
> > -             /* Add cfs_rq with already running entity in the list */
> > -             if (cfs_rq->nr_running >=3D 1)
> > +             /* Add cfs_rq with load or one or more already running en=
tities to the list */
> > +             if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
> >                       list_add_leaf_cfs_rq(cfs_rq);
> >       }
>
> Can there be a decayed cfs_rq with positive nr_running?
> I.e. can the condition be simplified to just the decayed check?

Yes, nothing prevent a task with a null load to be enqueued on a
throttle cfs as an example

>
> (I'm looking at account_entity_enqueue() but I don't know if an entity's
> weight can be zero in some singular cases.)
>
> Thanks,
> Michal
