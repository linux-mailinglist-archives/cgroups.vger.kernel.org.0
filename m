Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F26AF733
	for <lists+cgroups@lfdr.de>; Tue,  7 Mar 2023 22:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjCGVHN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Mar 2023 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCGVHL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Mar 2023 16:07:11 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579AA92D8
        for <cgroups@vger.kernel.org>; Tue,  7 Mar 2023 13:07:09 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id cp12so8945618pfb.5
        for <cgroups@vger.kernel.org>; Tue, 07 Mar 2023 13:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678223229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht5LN05corsofYoRRZ6LtuPGm1HccZj2Qv4agF8zMXE=;
        b=j56rWVMq8AcAbG91+IFHoGnDYEKdEhPpWXttHuOCR9ZdEgqreHqaCEhELwykgJTclB
         rgqtjUgRgeI58Y7JhFG2bz3LQdOGRetfU31lRgyq+dl8CucVnMQp/oOSQsC48IB9K6+g
         hFehKk3LYl6xHfwqzf6XGkDsnIsz037HXGHbRuvtt3Z8IhyD121NivSzU/m9hA2H6rxh
         Lf0aJetdsL8le7mzSvfLD4j0dul5xrEvBKyw6tsGDAkeKa8Ci8OV3CZwni72Y+CJF3o+
         3dE9D7q4P2O+b5YsJbbC4vJwi+9NXDGYIBnpJnF2VnD+fENEF7Guz3Oh4otbyF+ZnIlA
         W8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678223229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ht5LN05corsofYoRRZ6LtuPGm1HccZj2Qv4agF8zMXE=;
        b=joJIdlrjuIdOdiKCwE3km34F2zeHhWzkWDeMwDokDRDZ6mhHRwESk1nzPSCEdc296z
         JT8Tcu0QKFOzCRGcJtR7v15/wQv3vj4DbcXIxSTpUQBKSzeJZCA2cqe63ydQZ1G1AZIO
         xk29Q3a8t+AhwAyqgymBLi0sZQwzEPZ8ugILLRkxIaY2SxhTiwU/yHNMqK1tnyhgsfCH
         ygAiNSuQJDAWoVfQ5oYkj6fnbiTUO8CA7lGxAP3+iLBoyeLFhteeNpGUp1nsEZ4JTLHe
         ffI3J18bFPypKwGHQEob7G5IfLi8mzMbdMk6BDKp8XOARP5GSpMo8fMXh7pzH3LGfd61
         TOaQ==
X-Gm-Message-State: AO0yUKXafuSi/Z0sljUlP24xjsq2sJgPLuayLbDuMAum/RFZHsmEVvXs
        i9TjcwXE725flKwe5GIAeUGdrK6IQeh7R7UnchhHYQ==
X-Google-Smtp-Source: AK7set8u+1Eh0MMGGELIeBwi9KpF81YnEVJ6HrRYnUhsWF0KJOIm5xTeDLbPuOPKQW+PIVapl6rkrS0+i226bORB290=
X-Received: by 2002:a62:f80d:0:b0:5e6:f9a1:e224 with SMTP id
 d13-20020a62f80d000000b005e6f9a1e224mr6517647pfh.6.1678223228845; Tue, 07 Mar
 2023 13:07:08 -0800 (PST)
MIME-Version: 1.0
References: <20230206221428.2125324-1-qyousef@layalina.io> <CA+khW7i_Sc0M4FXzojmQ5PSfkPwk6AdcbN9j0gDXZ9FsOMQAwA@mail.gmail.com>
 <f3a99500-e51c-032f-a0c6-01763f0a5be6@redhat.com>
In-Reply-To: <f3a99500-e51c-032f-a0c6-01763f0a5be6@redhat.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Mar 2023 13:06:57 -0800
Message-ID: <CA+khW7iWAn6bbXdkJX1Lt4dWUsN6o4KqVQ8OFTs0B+VTtVjBkw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 7, 2023 at 12:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/7/23 14:56, Hao Luo wrote:
> > On Mon, Feb 6, 2023 at 2:15=E2=80=AFPM Qais Yousef <qyousef@layalina.io=
> wrote:
> >> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting=
 information")
> >> enabled rebuilding root domain on cpuset and hotplug operations to
> >> correct deadline accounting.
> >>
> >> Rebuilding root domain is a slow operation and we see 10+ of ms delays
> >> on suspend-resume because of that (worst case captures 20ms which
> >> happens often).
> >>
> >> Since nothing is expected to change on suspend-resume operation; skip
> >> rebuilding the root domains to regain the some of the time lost.
> >>
> >> Achieve this by refactoring the code to pass whether dl accoutning nee=
ds
> >> an update to rebuild_sched_domains(). And while at it, rename
> >> rebuild_root_domains() to update_dl_rd_accounting() which I believe is
> >> a more representative name since we are not really rebuilding the root
> >> domains, but rather updating dl accounting at the root domain.
> >>
> >> Some users of rebuild_sched_domains() will skip dl accounting update
> >> now:
> >>
> >>          * Update sched domains when relaxing the domain level in cpus=
et
> >>            which only impacts searching level in load balance
> >>          * update sched domains when cpufreq governor changes and we n=
eed
> >>            to create the perf domains
> >>
> >> Users in arch/x86 and arch/s390 are left with the old behavior.
> >>
> >> Debugged-by: Rick Yiu <rickyiu@google.com>
> >> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> >> ---
> > Hi Qais,
> >
> > Thank you for reporting this. We observed the same issue in our
> > production environment. Rebuild_root_domains() is also called under
> > cpuset_write_resmask, which handles writing to cpuset.cpus. Under
> > production workloads, on a 4.15 kernel, we observed the median latency
> > of writing cpuset.cpus at 3ms, p99 at 7ms. Now the median becomes
> > 60ms, p99 at >100ms. Writing cpuset.cpus is a fairly frequent and
> > critical path in production, but blindly traversing every task in the
> > system is not scalable. And its cost is really unnecessary for users
> > who don't use deadline tasks at all.
>
> The rebuild_root_domains() function shouldn't be called when updating
> cpuset.cpus unless it is a partition root. Is it?
>

I think it's because we were using the legacy hierarchy. I'm not
familiar with cpuset partition though.

Hao
