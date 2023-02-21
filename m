Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D31469E384
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjBUPec (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbjBUPeb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:34:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C8BDD0
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 07:34:30 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id fb30so2642116pfb.13
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 07:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1676993670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DAuesQqHdhNJRfFTi8gVtpxjiFGXYrbd9LOZ6E9mPEs=;
        b=arf2uoaa0am6PjIgZtw0W/YccaHL/ZaWYh3gkwr6R1Zp6ZeHrEbM/0RUw46nwZlhFT
         OMAHia2AyFhXGUQQqxOIx2w8VMDjwhiwgduHWQVr9c2eLH9YLHTNPtxJAU+UsuQ0xS53
         rOqIbcHKVReze/LVMBFLTASG5oiyw2oUbTQP2c1+y6SjDHjwSNspQ/rlPYy7WpDr486Z
         KKNCsl+Jfj4Q0aSedrzOe+8geFNoQoT/hq/FTp61YUIs/ybJYbkzqO6z2HE35ozz6vcM
         s8l+2tQmnwuIKgfX8mFGQT5CGmGJFvCC0DpqGV9b7WN4np5B1aQe8dGCIB56VxAXwapQ
         P3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676993670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAuesQqHdhNJRfFTi8gVtpxjiFGXYrbd9LOZ6E9mPEs=;
        b=OzqP66qqFeMLRVv4knp1MzTczwqA5NHh4lxM/l7sOklzTytfmuPAIgHk+Ggy/uEnUq
         lNF1Bb9W8sJ3c8Mqi9V4rYh9T9pdFBKrPuYI7NoZKgG0o5tDVLnE/aKGfJu6eJrYmBIN
         /XMzSOBGGa3Ga0bBx/0qZKwEpGKUQjFyg3h531gWJOpuQuDywjc/mlTVG6E3hk3NLNCZ
         A0UadGB+JHlcHKMbLRjl/l6BbJ6EprZAG2MAdZSx2vcMwvsPsOmUm2QjBemJOPaYZXG2
         QMPIypETqBAig+7qXKJUNwRn7pog/GuleFQZS+U2fgTf8H1GERNT7qtKBlDOtXnZ2C1p
         rhWA==
X-Gm-Message-State: AO0yUKWEpjxtsQSikbZJaxgvjgd5F+uqlacDtY/rjgG5YODY0RFjkE87
        NrLT7e2mzQFxGxf8HTnAn4/4d8zQcVz3RgikdtbaBQ==
X-Google-Smtp-Source: AK7set9BABzKg5BIizE+fiRAUv9+ReZulJMCCV1+J7EebfBPk0WjC7mVd6maphfiBrI0hoF36iA4Yis0ICc6W1WMXEU=
X-Received: by 2002:a62:d441:0:b0:5ac:44d6:c260 with SMTP id
 u1-20020a62d441000000b005ac44d6c260mr715822pfl.31.1676993670357; Tue, 21 Feb
 2023 07:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org> <Y/TBdB23akBbUjqd@hirez.programming.kicks-ass.net>
 <CAKfTPtAk2A8zPgOfpbN0s4LZv+d7ABB9=5tAEMCbVrf263XtjA@mail.gmail.com> <Y/Tecdpxls3N6pO+@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/Tecdpxls3N6pO+@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 16:34:19 +0100
Message-ID: <CAKfTPtDQy9E=Ux=RWUZKM42XHGnVG_RNp4nnE-nEsRi5JLhpyQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority at wakeup
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

On Tue, 21 Feb 2023 at 16:08, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Feb 21, 2023 at 03:21:54PM +0100, Vincent Guittot wrote:
> > On Tue, 21 Feb 2023 at 14:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > Should we perhaps also do this for latency_nice == 0?, in any case I
> > > think this can be moved to its own patch to avoid doing too much in the
> > > one patch. It seems fairly self contained.
> >
> > This function is then removed by patch 9 as the additional rb tree
> > fixes all cases
>
> Also, since you remove it again later, perhaps not introduce it at all?

Yes, I have done the split to easily revert patch 8  if needed but
keep good behavior. I can probably remove this and patch 9 completly
