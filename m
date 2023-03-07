Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0839B6AF860
	for <lists+cgroups@lfdr.de>; Tue,  7 Mar 2023 23:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCGWRk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Mar 2023 17:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCGWRj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Mar 2023 17:17:39 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70BAA73C
        for <cgroups@vger.kernel.org>; Tue,  7 Mar 2023 14:17:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 16so8503590pge.11
        for <cgroups@vger.kernel.org>; Tue, 07 Mar 2023 14:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678227457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZPDIXIYKXniSn7Cewj9Ohui8u8k77FZgGbBf+MYE2I=;
        b=H564rYcr021ZaO8vXlD0OPJNwRxXvsmm/vqUrqRtpwiFQvN40keui/j6Bp3KmULdu0
         ivF+sTy4V6jvb6d37Mz5mve8tFjbJKLWl5yMUyEVgpSK1EcV63guC/PFNzt+wwIT798o
         WqdQoR3xShV1oG19aLBwWl/pXw4vKAwK9izs0QOL6MyM6i2SEA9H6wcRRCDyVzSNu6tI
         HBPukjF+XFb10s4toX3I8sppLqirPA5S7hSYGqsWOioAHyTdu1xTh7tiFAfi2YImRMms
         V74ZL12YdBf/AQet8JvGIrBeausWDblgLUn0+XRaTe5HAGxvBBcQqG8kXpTe00SfoBWk
         582g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZPDIXIYKXniSn7Cewj9Ohui8u8k77FZgGbBf+MYE2I=;
        b=VIzTK9zGl/Rew6d3E3xyyY133tpbmNQPnqWPpHi8rWPJxJl5bROZcJt85HZM5yBfB+
         5xIpr1n3rzPj0me3vE6yS3NgIXtj6S/4KtRURlqg4y9zmz96MT2GpfktYq2+WpbJxjPg
         uQw6t8tyBMXYidZPKv8NqEOfqO1Agegu5orHbbXur+oUrw6dyHm5HuIveTE9f+weS/+N
         WwryHFsuk3yK146VPKDd/52tJ3fmm24xAQ12J2+b4bw36RCaVXTL+Q1tXJgBeghtcaNr
         dzJilbG62ZcwJYE8ne7Aa2dvDWH7VtcJ1oMfVaWhfL2cnIKGF6uLQLsY99dGsGUPPGEJ
         2wow==
X-Gm-Message-State: AO0yUKUZnniMYQjCGsZkRY6K1H4Fuk5XXu2x0pAOI14tIkZHLFb+kOxC
        k4L5WL9VmGqQ/YxO4egKVCiOPcMd4m5k2eN2+5pi+w==
X-Google-Smtp-Source: AK7set8bTAGAzcozR0mHlx2H4rby0W+fDsvyU0VDW8yH6kyQ72u7VVUu/0hrchLg1UOauYaAFQgZM89VmNF8LcPa1WU=
X-Received: by 2002:a62:870e:0:b0:5a9:c954:563e with SMTP id
 i14-20020a62870e000000b005a9c954563emr6678943pfe.6.1678227456770; Tue, 07 Mar
 2023 14:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20230206221428.2125324-1-qyousef@layalina.io> <CA+khW7i_Sc0M4FXzojmQ5PSfkPwk6AdcbN9j0gDXZ9FsOMQAwA@mail.gmail.com>
 <f3a99500-e51c-032f-a0c6-01763f0a5be6@redhat.com> <CA+khW7iWAn6bbXdkJX1Lt4dWUsN6o4KqVQ8OFTs0B+VTtVjBkw@mail.gmail.com>
 <1f2cf8ea-a9d7-5245-0f69-eb8be9f64afc@redhat.com>
In-Reply-To: <1f2cf8ea-a9d7-5245-0f69-eb8be9f64afc@redhat.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Mar 2023 14:17:25 -0800
Message-ID: <CA+khW7jQg6x_j70eARVF0eemP0txU_K9Lc=5kfBmU_KxsfbK2w@mail.gmail.com>
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
To:     Waiman Long <longman@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 7, 2023 at 1:13=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> On 3/7/23 16:06, Hao Luo wrote:
> > On Tue, Mar 7, 2023 at 12:09=E2=80=AFPM Waiman Long <longman@redhat.com=
> wrote:
> >> On 3/7/23 14:56, Hao Luo wrote:
> >>> On Mon, Feb 6, 2023 at 2:15=E2=80=AFPM Qais Yousef <qyousef@layalina.=
io> wrote:
> >>>> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounti=
ng information")
> >>>> enabled rebuilding root domain on cpuset and hotplug operations to
> >>>> correct deadline accounting.
> >>>>
> >>>> Rebuilding root domain is a slow operation and we see 10+ of ms dela=
ys
> >>>> on suspend-resume because of that (worst case captures 20ms which
> >>>> happens often).
> >>>>
> >>>> Since nothing is expected to change on suspend-resume operation; ski=
p
> >>>> rebuilding the root domains to regain the some of the time lost.
> >>>>
> >>>> Achieve this by refactoring the code to pass whether dl accoutning n=
eeds
> >>>> an update to rebuild_sched_domains(). And while at it, rename
> >>>> rebuild_root_domains() to update_dl_rd_accounting() which I believe =
is
> >>>> a more representative name since we are not really rebuilding the ro=
ot
> >>>> domains, but rather updating dl accounting at the root domain.
> >>>>
> >>>> Some users of rebuild_sched_domains() will skip dl accounting update
> >>>> now:
> >>>>
> >>>>           * Update sched domains when relaxing the domain level in c=
puset
> >>>>             which only impacts searching level in load balance
> >>>>           * update sched domains when cpufreq governor changes and w=
e need
> >>>>             to create the perf domains
> >>>>
> >>>> Users in arch/x86 and arch/s390 are left with the old behavior.
> >>>>
> >>>> Debugged-by: Rick Yiu <rickyiu@google.com>
> >>>> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> >>>> ---
> >>> Hi Qais,
> >>>
> >>> Thank you for reporting this. We observed the same issue in our
> >>> production environment. Rebuild_root_domains() is also called under
> >>> cpuset_write_resmask, which handles writing to cpuset.cpus. Under
> >>> production workloads, on a 4.15 kernel, we observed the median latenc=
y
> >>> of writing cpuset.cpus at 3ms, p99 at 7ms. Now the median becomes
> >>> 60ms, p99 at >100ms. Writing cpuset.cpus is a fairly frequent and
> >>> critical path in production, but blindly traversing every task in the
> >>> system is not scalable. And its cost is really unnecessary for users
> >>> who don't use deadline tasks at all.
> >> The rebuild_root_domains() function shouldn't be called when updating
> >> cpuset.cpus unless it is a partition root. Is it?
> >>
> > I think it's because we were using the legacy hierarchy. I'm not
> > familiar with cpuset partition though.
>
> In legacy hierarchy, changing cpuset.cpus shouldn't lead to the calling
> of rebuild_root_domains() unless you play with cpuset.sched_load_balance
> file by changing it to 0 in the right cpusets. If you are touching
> cpuset.sched_load_balance, you shouldn't change cpuset.cpus that often.
>

Actually, I think it's the opposite. If I understand the code
correctly[1], it looks like rebuild_root_domains is called when
LOAD_BALANCE _is_ set and sched_load_balance is 1 by default. Is that
condition a bug?

I don't think we updated cpuset.sched_load_balance.

[1] https://github.com/torvalds/linux/blob/master/kernel/cgroup/cpuset.c#L1=
677
