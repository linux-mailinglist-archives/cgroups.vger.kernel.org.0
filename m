Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B269E378
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjBUPcx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjBUPcv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:32:51 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F2180
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 07:32:49 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q189so2392894pga.9
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 07:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676993568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehh0eemONObY4KTgZxfTyrJ90BFUoWQW75KmGdpJJUU=;
        b=Y2YGEjYzRv62HOvaoOMPOPH3yegCdyyoIldwK+TxmcJiHo3mLPKK2G0bDGyrWCH3FD
         SkEmK4DcPWsY7pslsIrb4z4w+hREUjckAQRiRcvpOB0hb+WoonFfg1JVMhiSrcBS7U5z
         xCDl0RSJXQsR6+8xr1imkZB2ZWKxTmHCxGMpzatiEdosMpvV61wkcEkN0YZtOQP5k5bI
         3ypUuVzovLYI3ak4HSjxDy1HOYGoWTwG7+7WRCZqZsKSkmyqlM477TEvYdh2JdLMFF1g
         plc3+kBgE7JgPFKcq75owdW2ME8rLkLd/KGBhrSzZcoxKjBZGrjq/da7V1fTU+NEfiV2
         LrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676993568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehh0eemONObY4KTgZxfTyrJ90BFUoWQW75KmGdpJJUU=;
        b=SyphluxOXvKM2nWSCXcznQqXA9qe8qFbzJLgJJ0M+Hjn5B9wQWSEsTwNrrl6WxZmlG
         wCCloMr20fQUcVW2vwDDBbp8vVbWgXx+h/tm5kWcVyjZRyUQuJAaA513LiRIpHkWZ/Ko
         7kTjh29/wt2nOSyQbUucDwUz5BLEOQ1P9laCrz3Lh91bZPp81yByIiTD7YqMeYhHpkRO
         C9KlPmFjzQ3S0mhjofbtB2BSmbZ4gxyoK9g0Hgfe8zOiAAFwkHjD3I9UsJJLvhf94xC+
         GrbXqk0hspCoiRrk+xu7MK6CqBovgu/6ZKFmxCUGfSHyLHW63X/Rnda97n1/LkOK0qQa
         4Gjw==
X-Gm-Message-State: AO0yUKWYL79L8xcDukEJYfHkjbZLjEGLVgfwAfAHhyhuOdaHkenhzPja
        oW5cEebG28VfYHQoykFjgAvjNx8xWWPvEMP0+JFWIg==
X-Google-Smtp-Source: AK7set+Jt29aIywCZG6ebML4pz3GWxRVcvD2HxW1SIbREXfvTywk3Jefh6bOyScGVIVpVBmtcGIVPy+qvWw94OJK+cs=
X-Received: by 2002:a62:d441:0:b0:5ac:44d6:c260 with SMTP id
 u1-20020a62d441000000b005ac44d6c260mr715036pfl.31.1676993568476; Tue, 21 Feb
 2023 07:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-7-vincent.guittot@linaro.org> <Y/TcwkmiVXJmQ9nw@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/TcwkmiVXJmQ9nw@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 16:32:37 +0100
Message-ID: <CAKfTPtBsFn3SW+DLYFNLiaroqFox5sXwBy8zVWZ24F9SKg7FJg@mail.gmail.com>
Subject: Re: [PATCH v10 6/9] sched/fair: Add sched group latency support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 21 Feb 2023 at 16:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 03:12:31PM +0100, Vincent Guittot wrote:
>
> > +static s64 cpu_latency_nice_read_s64(struct cgroup_subsys_state *css,
> > +                                 struct cftype *cft)
> > +{
> > +     int prio, delta, last_delta = INT_MAX;
> > +     s64 weight;
> > +
> > +     weight = css_tg(css)->latency_offset * NICE_LATENCY_WEIGHT_MAX;
> > +     weight = div_s64(weight, get_sleep_latency(false));
> > +
> > +     /* Find the closest nice value to the current weight */
>
> This comment isn't entirely accurate, since we only have the nice_write
> interface below, this will be an exact match. The thing with weight is
> that we first had the raw weight value interface and then the nice
> interface had to map random values back to a 'nice' value.

Yes, there was a long discussion about the interface and without any
simple raw value to share, we decided to only use latency_nice until
we found a generic metric
>
> Arguably we can simply store the raw nice value in write and print it
> out again here.

Probably, I just wanted to prevent the latency.nice being the main
value saved in cgroup . But I suppose it could be ok to save it
directly

>
> > +     for (prio = 0; prio < ARRAY_SIZE(sched_latency_to_weight); prio++) {
> > +             delta = abs(sched_latency_to_weight[prio] - weight);
> > +             if (delta >= last_delta)
> > +                     break;
> > +             last_delta = delta;
> > +     }
> > +
> > +     return LATENCY_TO_NICE(prio-1);
> > +}
> > +
> > +static int cpu_latency_nice_write_s64(struct cgroup_subsys_state *css,
> > +                                  struct cftype *cft, s64 nice)
> > +{
> > +     s64 latency_offset;
> > +     long weight;
> > +     int idx;
> > +
> > +     if (nice < MIN_LATENCY_NICE || nice > MAX_LATENCY_NICE)
> > +             return -ERANGE;
> > +
> > +     idx = NICE_TO_LATENCY(nice);
> > +     idx = array_index_nospec(idx, LATENCY_NICE_WIDTH);
> > +     weight = sched_latency_to_weight[idx];
> > +
> > +     latency_offset = weight * get_sleep_latency(false);
> > +     latency_offset = div_s64(latency_offset, NICE_LATENCY_WEIGHT_MAX);
> > +
> > +     return sched_group_set_latency(css_tg(css), latency_offset);
> > +}
