Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2086A584724
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 22:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiG1Uon (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Jul 2022 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiG1Uon (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Jul 2022 16:44:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603F6D2CD;
        Thu, 28 Jul 2022 13:44:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a7-20020a17090a008700b001f325db8b90so1855166pja.0;
        Thu, 28 Jul 2022 13:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=zEBR1Ky5G7KTNBelOELZjj3LDNqMPsUpTpOuJi2OqTg=;
        b=Vm+WbZZse7CT3sDU0lYolZ3mhefbqlwbQBYN/UAU0F8JiRqHSZBzfnSWzucq+4hhLu
         j6+ozXndQXd9WCCaXO9a9sMcuHjAzyJARs8DgbvUB+rQCPAzUHX1MbNIvEkpCHpe3kHt
         jjhHOhd+pYA+XbD5JbQMjo8hBGEKm5UexIvk+V6w+d31/y/N8kFiOrLATmyGCpAKR9l+
         /kONg+NMwMVyPs1zhKcCtCaTKxyytjwAGNTkJLazYcpBTcf9vuVFqUfH5CqlpQYeRVEv
         6b3oOuWAg8y8eJK0iT5VmtqkI4k5V4l+j7tD/Bpn9BaNjwmjEoe9DWTPcptFk6atOUGy
         tQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=zEBR1Ky5G7KTNBelOELZjj3LDNqMPsUpTpOuJi2OqTg=;
        b=hvJs46aqdyRxM5xywlZB0Z1UOxJ3vtiZ3SGR7SRQPH+T1bO24TugivD8U13N3Bt2nw
         zPLmBDZ9IhFPS82raMzBEc17TNE37OPfBLsraZs+uwWZVGXk0mAxfu+zo+MjcnoR55zk
         V7Lr6NtXeBS+2dgoOby2q2908FypC65SIU8x2CkBygebKFCrHqZxJoV0osGLNeWud1W2
         ACeraJBJIK3jSg0xCfZ8sdgAMV2gnxfGQ5ULK5fzVWiYFyQKyBKIwQDlcLdp1yI5YLTn
         jREZkNHi3i6QJQb9QYG8y8bEAiWeBeynYDETogGVGtKJzjJFePlfcC0I7XyAMPTghlU6
         hXTA==
X-Gm-Message-State: ACgBeo1o56zImgD0GzelgCeOBAV/40rO3x4p5vzX3aXvo7303YC8P5tN
        sFxJwKvYoh0b1jhibOczv6b6CuI95b0=
X-Google-Smtp-Source: AA6agR4NJeonS2cJ+HFzH46XzQhbj1kWHezl9LtVmnH3LAN8Irv0cfx9aEAoLWt/4l0BVJaaN5vHHQ==
X-Received: by 2002:a17:90b:3a84:b0:1f2:8d9d:46f3 with SMTP id om4-20020a17090b3a8400b001f28d9d46f3mr1172274pjb.174.1659041081677;
        Thu, 28 Jul 2022 13:44:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:23b6])
        by smtp.gmail.com with ESMTPSA id d70-20020a621d49000000b0052ab9f1fe45sm1180234pfd.120.2022.07.28.13.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 13:44:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jul 2022 10:44:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus
 affinity was explicitly set
Message-ID: <YuL1NijxSEv2xadk@slm.duckdns.org>
References: <20220728005815.1715522-1-longman@redhat.com>
 <YuLF+xXaCzwWi2BR@slm.duckdns.org>
 <1ae1cc6c-dca9-4958-6b22-24a5777c5e8d@redhat.com>
 <YuLdX7BYGvo57LNU@slm.duckdns.org>
 <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <606ed69e-8ad0-45d5-9de7-48739df7f48d@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jul 28, 2022 at 03:21:26PM -0400, Waiman Long wrote:
> On 7/28/22 15:02, Tejun Heo wrote:
> > On Thu, Jul 28, 2022 at 02:57:28PM -0400, Waiman Long wrote:
> > > There can be a counter argument that if a user found out that there is not
> > > enough cpus in a cpuset to meet its performance target, one can always
> > > increase the number of cpus in the cpuset. Generalizing this behavior to all
> > > the tasks irrespective if they have explicitly set cpus affinity before will
> > > disallow this use case.
> > This is nasty.
> 
> That is a nasty example, I know. There may be users depending on the
> existing behavior even if they don't know it. So I am a bit hesitant to
> change the default behavior like that. On the other hand, tasks that have
> explicitly set its cpu affinity certainly don't want to have unexpected
> change to that.

Yeah, I hear you. I'm on the same page.

> > The real solution here is separating out what user requested
> > and the mask that cpuset (or cpu hotplug) needs to apply on top. ie.
> > remember what the user requested in a separate cpumask and compute the
> > intersection into p->cpus_maks whenever something changes and apply
> > fallbacks on that final mask. Multiple parties updating the same variable is
> > never gonna lead to anything consistent and we're patching up for whatever
> > the immediate use case seems to need at the moment. That said, I'm not
> > necessarily against patching it up but if you're interested in delving into
> > it deeper, that'd be great.
> 
> I believe the current code is already restricting what cpu affinity that a
> user can request by limiting to those allowed by the current cpuset. Hotplug
> is another issue that may need to be addressed. I will update my patch to
> make it handle hotplug in a more graceful way.

So, the patch you proposed is making the code remember one special aspect of
user requested configuration - whether it configured it or not, and trying
to preserve that particular state as cpuset state changes. It addresses the
immediate problem but it is a very partial approach. Let's say a task wanna
be affined to one logical thread of each core and set its mask to 0x5555.
Now, let's say cpuset got enabled and enforced 0xff and affined the task to
0xff. After a while, the cgroup got more cpus allocated and its cpuset now
has 0xfff. Ideally, what should happen is the task now having the effective
mask of 0x555. In practice, tho, it either would get 0xf55 or 0x55 depending
on which way we decide to misbehave.

Thanks.

-- 
tejun
