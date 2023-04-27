Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926CE6EFF73
	for <lists+cgroups@lfdr.de>; Thu, 27 Apr 2023 04:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242677AbjD0C6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 22:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjD0C6Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 22:58:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266931FCE;
        Wed, 26 Apr 2023 19:58:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-18f16bb1a9bso1662340fac.1;
        Wed, 26 Apr 2023 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682564294; x=1685156294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt12pza0kSqr2v/SyPGEEMbF6AGPcE5T8sVhWjoTuNo=;
        b=PXbRbj/hqLIMG7XcL+7o/0g5pwQ8mX2GCONQE8Hy8VMJndcsn9gZRBM9OvNcwcFNDg
         bIHFxJQ3oY21rCZ8ujcOTmXrVDEVPWwQQTHbm/E9TI+we0j0zv79E+DPqka570z+F8Gn
         7+M7ZvrlpdQH+vMOSbOKYM/gsp5VEsCcPlHMn+1a0rywWHcxljl2yUOVIbWHFdRIUcW+
         dMg2UP09vjd4UuknFAytWQO22a3R+OnjrY3WjcU+vkwoRf/qLXE10hv9TaAEt9yuAOXb
         xSkAdzV6qAQbqXYxYuu8iniGAhXWlw4XwYWWx5l8zyTsoK5dddzJTLPsA4X0Ayt632Tl
         Qsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682564294; x=1685156294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt12pza0kSqr2v/SyPGEEMbF6AGPcE5T8sVhWjoTuNo=;
        b=dLuZBldOUe8SGe63acQQxzfH/1OZAyPeLOZAsmz+rZeddq6uOBsHcj26afHHRytgUD
         GZMGYb5NpeAH2LKf374TFOp5PnhcnMqTY3rLvUW/DVZxyR3uKIGUX2TOB9ZT1Qee+RiL
         5rXUeEBowEtWPljQsLLyloJizbNThWqydTjIxsyTTuvSewgMiYKhhdKv+ROi7PnBozNl
         e+WlO6zAZA/qJdAmHt1mjmUIv3UJ93jzHg4z0zN0hgHUgBlj3Il+P/aLIr0EpNiK4Sdf
         IjGjHshq6M7XGdHo+LAWBEVqrsqMaKCrVDGc85eFjcT7ASxDd0SNCE06fpafYF3GJVzB
         GIOg==
X-Gm-Message-State: AC+VfDxELzJfUDoHHQXP2oDgEJL0m9nTkRwivNKKARMnKP/SCFPnqd5G
        Qy+lav3nF23wwpV5dPNXOKKmJxtQ6NocKorlgng=
X-Google-Smtp-Source: ACHHUZ4ndjHDeEx3LzsOZ9y2jCjKuTk3OrazJpvPy+BXVbdRZERtqrGyjkPlHuYilwC4gi0Rlm8dT7IIPmivIkNS+Ss=
X-Received: by 2002:a05:6820:627:b0:547:6a8d:67b2 with SMTP id
 e39-20020a056820062700b005476a8d67b2mr263521oow.0.1682564294378; Wed, 26 Apr
 2023 19:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com> <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain> <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
In-Reply-To: <d53a8af3-46e7-fe6e-5cdd-0421796f80d2@redhat.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 27 Apr 2023 10:58:03 +0800
Message-ID: <CAB8ipk-ns=d+jNkKi1sjkSQmQidziCj34COkHZt6ZkRiG47HHA@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
To:     Waiman Long <longman@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        =?UTF-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>,
        zhiguo.niu@uniissoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

HI Juri,

Would this patch be merged tobe stable-rc? In kernel5.15, we also find
that the rwsem would be blocked for a long  time, when we change the
task's cpuset cgroup.
And when we revert to the mutex, the delay would disappear.

BR
Thanks!

On Wed, Apr 26, 2023 at 10:50=E2=80=AFPM Waiman Long <longman@redhat.com> w=
rote:
>
> On 4/26/23 07:57, Juri Lelli wrote:
> > On 04/04/23 13:31, Waiman Long wrote:
> >> On 3/29/23 08:55, Juri Lelli wrote:
> >>> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> >>> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea=
,
> >>> as it has been reported to cause slowdowns in workloads that need to
> >>> change cpuset configuration frequently and it is also not implementin=
g
> >>> priority inheritance (which causes troubles with realtime workloads).
> >>>
> >>> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab i=
t
> >>> only for SCHED_DEADLINE tasks (other policies don't care about stable
> >>> cpusets anyway).
> >>>
> >>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> >> I am thinking that maybe we should switch the percpu rwsem to a regula=
r
> >> rwsem as there are cases where a read lock is sufficient. This will al=
so
> >> avoid the potential PREEMPT_RT problem with PI and reduce the time it =
needs
> >> to take a write lock.
> > I'm not a big fan of rwsems for reasons like
> > https://lore.kernel.org/lkml/20230321161140.HMcQEhHb@linutronix.de/, so
> > I'd vote for a standard mutex unless we have a strong argument and/or
> > numbers.
>
> That is fine for me too.
>
> Cheers,
> Longman
>
