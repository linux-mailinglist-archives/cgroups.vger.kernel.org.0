Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48CF6A4326
	for <lists+cgroups@lfdr.de>; Mon, 27 Feb 2023 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjB0Noi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Feb 2023 08:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjB0Noh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Feb 2023 08:44:37 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEA41CAD8
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 05:44:35 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a7so3517915pfx.10
        for <cgroups@vger.kernel.org>; Mon, 27 Feb 2023 05:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z110NAjU0K09Me/E1RV39MMihHyn6kMCAJzzQuDRvLM=;
        b=Bt25ZvB0N308yiyf/YLK6YTdoFkc2Qa+32onq9WBjhU/OTcfuk9JA3esrW4xhcahv+
         7C8KuGS41htHANVW9KbDLzdQ7VxEyp3H2nDqK/0W7L4QdxuVfnOlUUnnGg1H5AyhtrIL
         0bQufJpjUNdNJ85Y6SUmYAGRzWyphsj0y3VxG8sugulYIxbJpKsfcqYB4dTJAjoQ8y5u
         m2HxHiO/mCzujS2P4vOwiStsfHE/T0oCBSpn/UJbPe2SSXoaXMb8SxIFFUUQNQ34E3Dz
         8B24mQVHov6TeFvUwvAUAOPyjvje0N4cLw6nsmfh0L3ZXwJSAoXqIaGf0FwznVrWHUFv
         f8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z110NAjU0K09Me/E1RV39MMihHyn6kMCAJzzQuDRvLM=;
        b=LlWpSn0VE9XMhaqEYIT5w6LyC1obgpzMyVMrHoFtRT+pp8Hmf1kiwOBSf3VzLcPyR1
         ElNGPcSlny2TA856rwWq2fcttFjvTScqrfeZzwr/0oqQ560Su+Jb4IQyQZ1a3Uhkx5hj
         J5HVnhhsoRjoC91NO+s7DFMBsO0mAhrRMQvTGduaYcZy526zoo7/4Qt3AKTsuhiwRIUo
         XatNc11qVdUW7l8R0M1vS1PWkI41S9wJo/THk1mEPe8Z0Xgib1SuxEw5Ok2F3aPgc9Q/
         qqTV26skbnIAx8rEI7qbwfFD5Jiujvthm5ZQ/EgP7KHXZnFAPoRY7IPD3D+5fuCG2zGK
         Eh+Q==
X-Gm-Message-State: AO0yUKW7rWDA7fUYmNzolQ84HU+9i9NaNGTNYDh3K+QBXolY+RePX/zm
        hfKY4oTt1Ff59KWlovF2Ml66GWvJ3pWcFZA/jCYy2A==
X-Google-Smtp-Source: AK7set87NqLRpSozE6kg2p4o0pb3XUQaQz7B9sYHA7YkNrwzCDZ04rxsE1XWwJm5J825W1si6bN1i5xRQxMQsUL0Yvo=
X-Received: by 2002:a05:6a00:1629:b0:5e9:57b1:5bda with SMTP id
 e9-20020a056a00162900b005e957b15bdamr2461691pfc.3.1677505474786; Mon, 27 Feb
 2023 05:44:34 -0800 (PST)
MIME-Version: 1.0
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-7-vincent.guittot@linaro.org> <20230224192919.d4fcde3dwh7betvm@blackpad>
In-Reply-To: <20230224192919.d4fcde3dwh7betvm@blackpad>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Feb 2023 14:44:22 +0100
Message-ID: <CAKfTPtBorwnjU2=nprBo7aAEjoz+7x5nRYUdajZc53cuVgHSBw@mail.gmail.com>
Subject: Re: [PATCH v12 6/8] sched/fair: Add sched group latency support
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 24 Feb 2023 at 20:29, Michal Koutn=C3=BD <mkoutny@suse.com> wrote:
>
> Hello Vincent.
>
> On Fri, Feb 24, 2023 at 10:34:52AM +0100, Vincent Guittot <vincent.guitto=
t@linaro.org> wrote:
> > +  cpu.latency.nice
> > +     A read-write single value file which exists on non-root
> > +     cgroups.  The default is "0".
> > +
> > +     The nice value is in the range [-20, 19].
> > +
> > +     This interface file allows reading and setting latency using the
> > +     same values used by sched_setattr(2). The latency_nice of a group=
 is
> > +     used to limit the impact of the latency_nice of a task outside th=
e
> > +     group.
>
> IIUC, the latency priority is taken into account when deciding between
> entitites at the same level (as in pick_next_entity() or
> check_preempt_wake()/find_matchig_se()).
>
> So this group attribute is relevant in context of siblings (i.e. like
> cpu.weight ~ bandwidth priority)?

Yes

>
> I'm thus confused when it's referred to as a limit (in vertical sense).
> You somewhat imply that in [1]:

There were discussions about adding more features that could make use
of the latency nice. This comment mainly wants to describe how this
would behave in case that we need to compre entities/tasks not at the
same level.

Regarding the current use of latency nice to set a latency offset, the
problem doesn't appear because latency offset applies between entities
at the same level as you mentioned above

>
> > Regarding the behavior, the rule remains the same that a sched_entity
> > attached to a cgroup will not get more (latency in this case) than
> > what has been set for the group entity.
>
> But I don't see where such a constraint would be implemented in the
> code. (My cursory understanding above tends to horizontal comparisons.)
>
> Could you please hint me which is right?

Does  my explanation above make sense to you ?

>
> Thanks,
> Michal
>
> [1] https://lore.kernel.org/r/CAKfTPtDu=3Dc-psGnHkoWSPRWoh1Z0VBBfsN++g+kr=
v4B1SJmFjg@mail.gmail.com/
>
