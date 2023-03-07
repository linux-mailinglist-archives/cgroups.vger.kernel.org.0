Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7554D6AF64A
	for <lists+cgroups@lfdr.de>; Tue,  7 Mar 2023 21:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjCGUA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Mar 2023 15:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjCGUAA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Mar 2023 15:00:00 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B1A3B55
        for <cgroups@vger.kernel.org>; Tue,  7 Mar 2023 11:57:02 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b20so8822828pfo.6
        for <cgroups@vger.kernel.org>; Tue, 07 Mar 2023 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678219021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6rHvMXIA4AIeoeeLB3IEmq2VgMRhSF8AcuEoI2eaFM=;
        b=SmNn57DznzxCb2rHg2w5G6Wwu/VPVRbuMuzsj3JJwTLtowa/di0sdFh1lEY9hWkppW
         LMr00m0niYjTp/NvBBkbJDOAlVIDAqss+BlUgBmBNzR2q1y65S4H6CYNtQsAbPkz3JEs
         4IyhoCYe3flWXhSppj+HxxmjRzkmPhS9KlWoBpuvpS8R+xqxWAFTHoGmluamtIyFgD5q
         hOz4F3ItjvnWDQKUPQJYQp3+ENL+/lNa721um/fr07NWJQXHgmW73D8fKogveNrll7P6
         FKYjXIuoyZEh7p9ba8nDIqqXWuyRAwK0JEejeJFx/4toCtxF0SeyxXSLwLaxNxb0TSgX
         Cg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678219021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6rHvMXIA4AIeoeeLB3IEmq2VgMRhSF8AcuEoI2eaFM=;
        b=P7ZzmGysMk0G5aRwbpSDp5z9f2E3ilE38V/GnWs9j4sNtX6Uut/ruhhpUmpyZXfzda
         5AWeFEsupCRm6I6rq1Ja/Bk7ETL+h+KQIkrtiE/1cCXne4fTyOPF90zY3ex7NYGYEDGH
         JYxWYPh1QUFV87vKtJcvMthvYyhPFoAeNsv+1sjBNxmh07tj8AtsUp2Whv+XkGNrk2gL
         oD8M1EnVc2wVn0xRiEF9H0iOAtKF1ilmAgp8EcgjXo91rx4AH894hHuRttkd9MlIc0Ck
         MtppWDdtAp1gvOcIWEHSXgEga7OYqdTWcK72aRS8VQdrgnGNeh1/1Zbnxg0U+SgrrVTL
         gYVg==
X-Gm-Message-State: AO0yUKWCWe+M/JByErb6Dv6Eus4xzimkEbW6MdSQMpL/HF0QxE+xYBj2
        S94IUde2YJoKsIncWZH3NboOKf64o6klV7mXwUWYqQ==
X-Google-Smtp-Source: AK7set9asmjLkxmVz+rrzfq5No/evYVmU8HTu/DQCTbPNSDJM0gnFub0whJn1YEHSWfr8/3Hp1h0mXIrbuC/QXV8LGE=
X-Received: by 2002:a62:f801:0:b0:5eb:e0e0:d650 with SMTP id
 d1-20020a62f801000000b005ebe0e0d650mr6505410pfh.6.1678219020640; Tue, 07 Mar
 2023 11:57:00 -0800 (PST)
MIME-Version: 1.0
References: <20230206221428.2125324-1-qyousef@layalina.io>
In-Reply-To: <20230206221428.2125324-1-qyousef@layalina.io>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Mar 2023 11:56:49 -0800
Message-ID: <CA+khW7i_Sc0M4FXzojmQ5PSfkPwk6AdcbN9j0gDXZ9FsOMQAwA@mail.gmail.com>
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>,
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

On Mon, Feb 6, 2023 at 2:15=E2=80=AFPM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting in=
formation")
> enabled rebuilding root domain on cpuset and hotplug operations to
> correct deadline accounting.
>
> Rebuilding root domain is a slow operation and we see 10+ of ms delays
> on suspend-resume because of that (worst case captures 20ms which
> happens often).
>
> Since nothing is expected to change on suspend-resume operation; skip
> rebuilding the root domains to regain the some of the time lost.
>
> Achieve this by refactoring the code to pass whether dl accoutning needs
> an update to rebuild_sched_domains(). And while at it, rename
> rebuild_root_domains() to update_dl_rd_accounting() which I believe is
> a more representative name since we are not really rebuilding the root
> domains, but rather updating dl accounting at the root domain.
>
> Some users of rebuild_sched_domains() will skip dl accounting update
> now:
>
>         * Update sched domains when relaxing the domain level in cpuset
>           which only impacts searching level in load balance
>         * update sched domains when cpufreq governor changes and we need
>           to create the perf domains
>
> Users in arch/x86 and arch/s390 are left with the old behavior.
>
> Debugged-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---

Hi Qais,

Thank you for reporting this. We observed the same issue in our
production environment. Rebuild_root_domains() is also called under
cpuset_write_resmask, which handles writing to cpuset.cpus. Under
production workloads, on a 4.15 kernel, we observed the median latency
of writing cpuset.cpus at 3ms, p99 at 7ms. Now the median becomes
60ms, p99 at >100ms. Writing cpuset.cpus is a fairly frequent and
critical path in production, but blindly traversing every task in the
system is not scalable. And its cost is really unnecessary for users
who don't use deadline tasks at all.

>
> The better solution that was discussed before is to not iterate through e=
very
> task in the system and let cpuset track when dl tasks are added to it and=
 do
> smarter iteration. ATM even if there are no dl tasks in the system we'll
> blindly go through every task in the hierarchy to update nothing.
>

Great idea. This works. I tried this solution. With that, 98% of
cpuset.cpu writes are now within 7ms. Though there are still long
tails, they are caused by another issue, irrelevant to
rebuild_root_domains().

Your suggestion of update_dl_rd_accounting() also makes sense to me.

Hao
