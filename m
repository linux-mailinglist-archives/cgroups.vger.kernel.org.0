Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08D355547
	for <lists+cgroups@lfdr.de>; Tue,  6 Apr 2021 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbhDFNgS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Apr 2021 09:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbhDFNgN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Apr 2021 09:36:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449CCC06174A;
        Tue,  6 Apr 2021 06:36:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c3so14893173qkc.5;
        Tue, 06 Apr 2021 06:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXOWvNOAIfgi9gqBy5DvwnTrsEdHbB64uWkA3abilWU=;
        b=QLQkqzAeiYAjql/CBYeCXbnB9686oKnalJzTqApxbMhRQqeBZWrm69SrvTPBvXPGUz
         HnNDlwIuv8W4dZFeKPUTn/pS2aKrnF1F1vSjWvV3u4ttyPszRWoHhUmDbFxyKOEgAeoe
         FX1/ANr4FBT/9uIdb9Ge3vgwEu78kw4ErBowRW9guepBIvhhW+HZoI/yTUB5W4psNpJE
         QxRTWAyFVIHksYuoc/hP8xDpVTjs4qVrdgwQ6XCU/rx1JX6avFSVsN+HcMnLA5CMXzf/
         686ZRKvFNnk3jwGtO6UHZnqLYjYJmAJgQIZDYh0fNGuhbuWggvzXgfQnjOvZO1RtJFAT
         vUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=YXOWvNOAIfgi9gqBy5DvwnTrsEdHbB64uWkA3abilWU=;
        b=kIlu24vdI5T6jtTlGN4SnwxIQxHvM3Ktb0g/SQIulC6ZOEym/dm+H4JZm/lLGWLxrN
         GBAWOcCjaST7/H5LggXgiuE88AhZ5qlyiKyfwvsWsxo2zaGcRrC1t247xWVMjIhUAlqq
         NWtPnjfTK0DXuczfXk2SOjqwier9ohajp60Lm4HjWMLCnLeCXYr243u7uVY9G/nwH1kX
         ImWEY0aIpzPPKC9Vj9OPZveYtumf76AyggBPulgZHVlVQf4lfdiZ2+Bk/ZjLFsRxRl0V
         K27DfxygiHQmJL8FUaRSPOa7WekV/qV9DYbVp4T0XnNIUoXAtUeZi4DNyYITutOmQNVu
         QF4Q==
X-Gm-Message-State: AOAM5325M+eXBXKcON13NWozbso8ssC+9FdcYcMbdc1+7Ys3zHs2s0cN
        GAG95R21QEHqJRBQA/Awswc=
X-Google-Smtp-Source: ABdhPJyVvJRz4C6K9ZueGi45M8Z13CkImOTS11C4UEBzOoWu5fWTGD4fgjkcA57tVGGAszZxtvRZig==
X-Received: by 2002:a05:620a:c0d:: with SMTP id l13mr29020975qki.234.1617716163308;
        Tue, 06 Apr 2021 06:36:03 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id e2sm14550488qto.50.2021.04.06.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:36:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Apr 2021 09:36:00 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>
Subject: Re: [PATCH] cgroup: Relax restrictions on kernel threads moving out
 of root cpu cgroup
Message-ID: <YGxjwKbec68sCcqo@slm.duckdns.org>
References: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617714261-18111-1-git-send-email-pkondeti@codeaurora.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Apr 06, 2021 at 06:34:21PM +0530, Pavankumar Kondeti wrote:
> In Android GKI, CONFIG_FAIR_GROUP_SCHED is enabled [1] to help prioritize
> important work. Given that CPU shares of root cgroup can't be changed,
> leaving the tasks inside root cgroup will give them higher share
> compared to the other tasks inside important cgroups. This is mitigated
> by moving all tasks inside root cgroup to a different cgroup after
> Android is booted. However, there are many kernel tasks stuck in the
> root cgroup after the boot.
> 
> We see all kworker threads are in the root cpu cgroup. This is because,
> tasks with PF_NO_SETAFFINITY flag set are forbidden from cgroup migration.
> This restriction is in place to avoid kworkers getting moved to a cpuset
> which conflicts with kworker affinity. Relax this restriction by explicitly
> checking if the task is moving out of a cpuset cgroup. This allows kworkers
> to be moved out root cpu cgroup when cpu and cpuset cgroup controllers
> are mounted on different hierarchies.
> 
> We also see kthreadd_task and any kernel thread created after the Android boot
> also stuck in the root cgroup. The current code prevents kthreadd_task moving
> out root cgroup to avoid the possibility of creating new RT kernel threads
> inside a cgroup with no RT runtime allocated. Apply this restriction when tasks
> are moving out of cpu cgroup under CONFIG_RT_GROUP_SCHED. This allows all
> kernel threads to be moved out of root cpu cgroup if the kernel does not
> enable RT group scheduling.

The fundamental reason why those kthreads are in the root cgroup is because
they're doing work on behalf of the entire system and their resource usages
can't be attributed to any specific cgroup. What we want to do is accounting
actual usages to the originating cgroups so that cpu cycles spent by kswapd
is charged to the originating cgroups, however well we can define them, and
then throttle the origin if the consumption is going over budget for that
cgroup's allocation. This is how we already handle shared IOs.

The problem with the proposed patch is that it breaks the logical
organization of resource hierarchy in a way which hinders proper future
solutions.

If all you want is deprioritizing certain kworkers, please use workqueue
attrs instead.

Thanks.

-- 
tejun
