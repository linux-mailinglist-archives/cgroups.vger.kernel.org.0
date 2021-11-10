Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DCB44C669
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 18:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhKJRvg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 12:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhKJRvb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 12:51:31 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2325C06121E
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 09:48:23 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id a129so8390370yba.10
        for <cgroups@vger.kernel.org>; Wed, 10 Nov 2021 09:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNHVVa6gv7z3dFlgEcituEPBx6aIWi4uliGKTG3gzjI=;
        b=qLmXdLt4YOVMgrzsS5BXEUYiJevmzqMjguHecWqoDcWTEsy74/p4NvsXb/LRZFkqGJ
         KhCWxNDSNHskY6KB2iMjRPfe5Y3fqFyPGxIytmN+X0UAayfYz6lOPXpDfqtRvdGdHmzi
         FtF0aZ5WCHIP3ioTdmDGtdqhYagHRZjSY8+p0rMVnVsMSfymyS/fXWqdGZnsf42PNfgE
         mNQw8LAQCVeiTEquV2CIvo9/bLSPNT0zxilW25HhKQu21qKwI/DTvxEWCzOQidlHTyY3
         RL5T2R6A2hNmaBfGnO3ZDvB7UGeuWCeqOy7HkG1FKg7y+9C69m7/xZJGTyPrdXquocIS
         NFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNHVVa6gv7z3dFlgEcituEPBx6aIWi4uliGKTG3gzjI=;
        b=pZ90snl3n1C4oGLyaFPuWDowNQZ52gP8WpthlgmKFU95mtByFYuZP0DigXUMXGHupC
         mfAPh9tSQjzlIOV89izJXD8Ls9JxNpvHKntn/tACiA+OknQNbmekVh2sL+sNSwCf+5+g
         0Imgf9AE7hbuqbvzrcozN3W52s7nNKHM9cnNj5o+Yo3/BgO1sDTdVW5tegJwZeU0IdtI
         Zfz50yJ2MzzhIRHFf75Tz8Z+6YbqnDk0iPO+u6xV9uYB3x3QWP8wciT5MzYlmrad9RcQ
         zVHr/2OkzSbKwy9jeY4YR1A7HEE44T+wiZaqpON+R3k7p/CnRafoalssaIfGObIRJlf9
         Tl7g==
X-Gm-Message-State: AOAM531vabYiUciWmlM7F15RNF+72FZtE8L9qz2gUpn33YzaO/RFuSBZ
        t2FU8HEeXUyWB3wsu0uHlJbtDpiH0B1ZJxozp5nBYA==
X-Google-Smtp-Source: ABdhPJzrykT3dyEuXyJOwpTgNgF1rS/2Zem47Hc09Yaees7H87Arp4lp7y5GOAaNmY0j3HE0mpPOPMhKiENFNoOsu3w=
X-Received: by 2002:a25:2f58:: with SMTP id v85mr1047967ybv.487.1636566502780;
 Wed, 10 Nov 2021 09:48:22 -0800 (PST)
MIME-Version: 1.0
References: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
 <20211110161402.GB174703@worktop.programming.kicks-ass.net> <1fd2d97b-7c83-3a82-ada3-46ec5025c3b1@kernel.org>
In-Reply-To: <1fd2d97b-7c83-3a82-ada3-46ec5025c3b1@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 10 Nov 2021 09:48:10 -0800
Message-ID: <CAJuCfpFP2VP_t_tP27w=k4HDhm=jv=G2C56mM_kbs6wqux+DhA@mail.gmail.com>
Subject: Re: [RFC] psi: Add additional PSI counters for each type of memory pressure
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>, hannes@cmpxchg.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        mingo@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, mhocko@kernel.org,
        vdavydov.dev@gmail.com, tj@kernel.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 10, 2021 at 8:46 AM Georgi Djakov <djakov@kernel.org> wrote:
>
>
> On 10.11.21 18:14, Peter Zijlstra wrote:
> > On Wed, Nov 10, 2021 at 07:36:37AM -0800, Georgi Djakov wrote:
> >> @@ -21,7 +19,18 @@ enum psi_task_count {
> >>       * don't have to special case any state tracking for it.
> >>       */
> >>      NR_ONCPU,
> >> -    NR_PSI_TASK_COUNTS = 4,
> >> +    NR_BLK_CGROUP_THROTTLE,
> >> +    NR_BIO,
> >> +    NR_COMPACTION,
> >> +    NR_THRASHING,
> >> +    NR_CGROUP_RECLAIM_HIGH,
> >> +    NR_CGROUP_RECLAIM_HIGH_SLEEP,
> >> +    NR_CGROUP_TRY_CHARGE,
> >> +    NR_DIRECT_COMPACTION,
> >> +    NR_DIRECT_RECLAIM,
> >> +    NR_READ_SWAPPAGE,
> >> +    NR_KSWAPD,
> >> +    NR_PSI_TASK_COUNTS = 16,
> >>   };
> >>
> >
> >> @@ -51,9 +80,20 @@ enum psi_states {
> >>      PSI_MEM_FULL,
> >>      PSI_CPU_SOME,
> >>      PSI_CPU_FULL,
> >> +    PSI_BLK_CGROUP_THROTTLE,
> >> +    PSI_BIO,
> >> +    PSI_COMPACTION,
> >> +    PSI_THRASHING,
> >> +    PSI_CGROUP_RECLAIM_HIGH,
> >> +    PSI_CGROUP_RECLAIM_HIGH_SLEEP,
> >> +    PSI_CGROUP_TRY_CHARGE,
> >> +    PSI_DIRECT_COMPACTION,
> >> +    PSI_DIRECT_RECLAIM,
> >> +    PSI_READ_SWAPPAGE,
> >> +    PSI_KSWAPD,
> >>      /* Only per-CPU, to weigh the CPU in the global average: */
> >>      PSI_NONIDLE,
> >> -    NR_PSI_STATES = 7,
> >> +    NR_PSI_STATES = 18,
> >>   };
> >
> > Have you considered what this does to psi_group_cpu's size and layout
> > and the impact thereof on performance?
>
> Thanks, i will definitely add some numbers in case there are no other
> major arguments against this RFC patch.

Please CC me too in the future postings.
Thanks,
Suren.

>
> BR,
> Georgi
>
