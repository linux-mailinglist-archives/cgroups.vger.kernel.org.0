Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0723B6E261
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2019 10:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfGSISg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Jul 2019 04:18:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40637 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfGSISe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Jul 2019 04:18:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so30068674qtn.7
        for <cgroups@vger.kernel.org>; Fri, 19 Jul 2019 01:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sTL+cs2lCU2NM5qKSibXk5W13Ib4qYAgGUjbL1vgnqk=;
        b=Yg1mDAfruMUTpvNBo1tPrrgpS5N1fQLX1VNVghRoPKaXnuYpQb4adXjx46QRb6iU0v
         PCV24gVxSpQmiotESxQtsaoChK/aPnmnbFjWZLM0MjURBrAeo5quMqr0u6gPGgncGhSk
         vg5mTND/ahVeg6XodWg/flQBn5leFBWlXuQYvX9w88YL0zqeNeDVP/YeyAsyfUtD1W6w
         RMN1uSSEIJGHIPDl3GM+gBNccd4galwUFTutBz8d1PCxo3aRO7cLYKPwZiLVS9EF9ZBM
         cnLSgk7QiKLJxRxsFFdOVFXlwM2w7WS8MtDmaUWa4EB4CtAMKxbuhwb4Xb8f8XoVxrtS
         wIdg==
X-Gm-Message-State: APjAAAXslV7T6OC8NOGbTkyq5U0JTarD/YlCunOKuQ6HZEk35vFO+oO/
        9J8wjtypdCND3DJkbPIekT7y+R+5gMU=
X-Google-Smtp-Source: APXvYqyOVP03NX9J+wWs9KFySkhmqrZ2DbvfcP3TV14OEgsQszifz1DBOqmtzYEIUWDpFuxkJs37EQ==
X-Received: by 2002:a0c:afd5:: with SMTP id t21mr36606870qvc.105.1563524313146;
        Fri, 19 Jul 2019 01:18:33 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host53-206-dynamic.53-79-r.retail.telecomitalia.it. [79.53.206.53])
        by smtp.gmail.com with ESMTPSA id u16sm15479646qte.32.2019.07.19.01.18.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 01:18:32 -0700 (PDT)
Subject: Re: [PATCH v2] sched/core: Fix cpu controller for !RT_GROUP_SCHED
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, tj@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
References: <20190719063455.27328-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f9372197-0282-1ed8-fa0b-a2b4a723a439@redhat.com>
Date:   Fri, 19 Jul 2019 10:18:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719063455.27328-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 19/07/2019 08:34, Juri Lelli wrote:
> On !CONFIG_RT_GROUP_SCHED configurations it is currently not possible to
> move RT tasks between cgroups to which cpu controller has been attached;
> but it is oddly possible to first move tasks around and then make them
> RT (setschedule to FIFO/RR).
> 
> E.g.:
> 
>   # mkdir /sys/fs/cgroup/cpu,cpuacct/group1
>   # chrt -fp 10 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   bash: echo: write error: Invalid argument
>   # chrt -op 0 $$
>   # echo $$ > /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   # chrt -fp 10 $$
>   # cat /sys/fs/cgroup/cpu,cpuacct/group1/tasks
>   2345
>   2598
>   # chrt -p 2345
>   pid 2345's current scheduling policy: SCHED_FIFO
>   pid 2345's current scheduling priority: 10
> 
> Also, as Michal noted, it is currently not possible to enable cpu
> controller on unified hierarchy with !CONFIG_RT_GROUP_SCHED (if there
> are any kernel RT threads in root cgroup, they can't be migrated to the
> newly created cpu controller's root in cgroup_update_dfl_csses()).
> 
> Existing code comes with a comment saying the "we don't support RT-tasks
> being in separate groups". Such comment is however stale and belongs to
> pre-RT_GROUP_SCHED times. Also, it doesn't make much sense for
> !RT_GROUP_ SCHED configurations, since checks related to RT bandwidth
> are not performed at all in these cases.
> 
> Make moving RT tasks between cpu controller groups viable by removing
> special case check for RT (and DEADLINE) tasks.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
