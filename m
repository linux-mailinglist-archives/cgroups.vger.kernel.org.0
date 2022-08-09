Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6582158E086
	for <lists+cgroups@lfdr.de>; Tue,  9 Aug 2022 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345398AbiHITz1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Aug 2022 15:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbiHITzZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Aug 2022 15:55:25 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08605F7D;
        Tue,  9 Aug 2022 12:55:24 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f30so11358094pfq.4;
        Tue, 09 Aug 2022 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=9MuUym0qseMztmmB08QIe6J0PxQHYo7/9v1WA9Ef9Bg=;
        b=oC3ymHBJylR7XqQ1/YsoJWKU1vaS4NJ9iVSdgfEdCt9FgymssN/Wxfz4zV0wTqb8ox
         mHrHVPgBvk1V5bINjpZmmSZ2YVsLiVWbMc0QHAlLbxmlYteVr0eseqlyDpS3+otxKogh
         8n/4AHVa6kc0D7E4Nj6mrsGdmf7c/OQjhIbyhwrB9YafOwrvn6lCkvFCwEL8hV8uLSwx
         CYCfs9tOBHKWRpPEnz9suBU2fGtc5Jv3JLCCnD4ANllmc1h1yVvAZQMGRSRKbV9MiSKL
         SBzlVoS1vtOQUaMUVkuMOTZw/vBbRy4Qj8otjY2kg7ehzaT9sqR+sB2yizTxBQEx4EV1
         /GyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=9MuUym0qseMztmmB08QIe6J0PxQHYo7/9v1WA9Ef9Bg=;
        b=BD7RJQzQKU161Hk6Oj4WKXuvoKCjyXXO0VRw1VhI+I1juzWuxbq0Qx7LuVrpbE9QgW
         w8Rw+8wUIO0n6SbAC+0zjWiWi18ISfa0UG9utRecYIE3NfHhZR2V2R5Scu26ENbmkR1c
         LV15Xk1L41dNNCg1whFtUIRkVogMdDF5+dk5/vMOe59T2mGKvdrUZhcHdStVC29KNyoA
         SIwlrWY3A9QtkZY7tXMJ2Vp9V2Pj+Wcn6kiNclT5Q6F05s2CQ8aqFD4qjejeZgdVM6z1
         9rik1rpnrHB/S63EscrWXF84NLCE/A8Nsmo/I5x68tI3DCFuWTmLzYfsKSsyvXnNWDDZ
         apyg==
X-Gm-Message-State: ACgBeo3RfpQEud5If5U4UEiRX4uH3qtyuMZ+/PQb8jiBWyAGcoV7+6ag
        gyOS8ju9GQnNzFTYLpBYoBk=
X-Google-Smtp-Source: AA6agR5T2qyURPAUNz3Ik2+ANuXj1MEgX0/CWpXSSiJzOivF1/nX/FJPYo2OmCzEmS1ezPOFCZwC9g==
X-Received: by 2002:a65:5504:0:b0:41d:271:4929 with SMTP id f4-20020a655504000000b0041d02714929mr17565614pgr.606.1660074923724;
        Tue, 09 Aug 2022 12:55:23 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:237b])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0016c4147e48asm11156900plk.219.2022.08.09.12.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 12:55:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 Aug 2022 09:55:21 -1000
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] cgroup/cpuset: Keep user set cpus affinity
Message-ID: <YvK7qVkmzbA12Eut@slm.duckdns.org>
References: <20220801154124.2011987-1-longman@redhat.com>
 <20220801154124.2011987-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801154124.2011987-3-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing Linus)

Hello,

On Mon, Aug 01, 2022 at 11:41:24AM -0400, Waiman Long wrote:
> It was found that any change to the current cpuset hierarchy may reset
> the cpumask of the tasks in the affected cpusets to the default cpuset
> value even if those tasks have cpus affinity explicitly set by the users
> before. That is especially easy to trigger under a cgroup v2 environment
> where writing "+cpuset" to the root cgroup's cgroup.subtree_control
> file will reset the cpus affinity of all the processes in the system.
> 
> That is problematic in a nohz_full environment where the tasks running
> in the nohz_full CPUs usually have their cpus affinity explicitly set
> and will behave incorrectly if cpus affinity changes.
> 
> Fix this problem by looking at user_cpus_ptr which will be set if
> cpus affinity have been explicitly set before and use it to restrcit
> the given cpumask unless there is no overlap. In that case, it will
> fallback to the given one.
> 
> With that change in place, it was verified that tasks that have its
> cpus affinity explicitly set will not be affected by changes made to
> the v2 cgroup.subtree_control files.

The fact that the kernel clobbers user-specified cpus_allowed as cpu
availability changes always bothered me and it has been causing this sort of
problems w/ cpu hotplug and cpuset. We've been patching this up partially
here and there but I think it would be better if we just make the rules
really simple - ie. allow users to configure whatever cpus_allowed as long
as that's within cpu_possible_mask and override only the effective
cpus_allowed if the mask leaves no runnable CPUs, so that we can restore the
original configured behavior if and when some of the cpus become available
again.

One obvious problem with changing the behavior is that it may affect /
confuse users expecting the current behavior however inconsistent it may be,
but given that we have partially changed how cpus_allowed interacts with
hotplug in the past and the current behavior can be inconsistent and
surprising, I don't think this is a bridge we can't cross. What do others
think?

Thanks.

-- 
tejun
