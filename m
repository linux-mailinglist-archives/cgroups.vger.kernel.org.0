Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A796B35DF7
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfFENep (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:34:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35992 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFENep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:34:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so5134881qkl.3;
        Wed, 05 Jun 2019 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=grBBM9ViaanFgHPLnFrQHKU04qolbq9KsWYNsIIwRqA=;
        b=u107NaP8nG876tIG6Q2fL9N9piNv7X1C8ktfs1g7H/hDLqed+pH6cxVRLLRNznbtm7
         Mcs4Os2HbvpEVPU71DOG2dkTQkQFj1DTVQD1xbFBWjw7WF0h97y/V1UlSvaIuFEftNWK
         dbxnDMpwhY3GY20Mb6DEdwg3rrwqciAvdHqjQnpRY/BolbgE4M1jaiF1ZPvawQvLAFJc
         mcV6vpbo4mCioqlrX32FS6meK6OqhxdlRBo/hp2jYyy/9ZG4eFC4e6hRV5mikW8QsOPd
         e+yXKMeMNN+lIamY359iclpNA/oUtZ93ElA4TD7urYgkhnKxGU0Z8kzqejtn6DHL6ifZ
         Vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=grBBM9ViaanFgHPLnFrQHKU04qolbq9KsWYNsIIwRqA=;
        b=khGQHwe9CYIf0BQhjf5E9rh4DUxyspB4gGqGoeMAC9xVfOOK40FQz33aHP2wM+XIEI
         jxYfLy4F97OoDou7UN1d7WbYiGU+atVE4VM/PyuHzjmE435A4eHdOQSRm84JInqn0qUg
         WOqh1wGGvpdJ36PUITGmpl9E8IvCkUlRgARdlDHg8VSQclB2/QamHFP/YADmkHcHalRY
         8GOJKo8P+4TI4bClX+G0zZyoZDkfBWRXByOreJS0PqtCO+e/GTzqEfvWJcTRaeNSfuW9
         7IgE+KYhLd3cy8VGEe39UGSfzAOhqBmGggVXf9RtL3FfAaevpTMcC9E4/M6+z5A5EVo9
         K+6g==
X-Gm-Message-State: APjAAAUHeVZqrLqioCL8ap9lQ2xclXDsuvbxnHJ9Hu1Ukl0SUz8CzPws
        T8qvRHAQneWaS1CnLdFHOGs=
X-Google-Smtp-Source: APXvYqwl1p5ZrcCZPQK3a1Eh2kpFD9I7pupsFV3QFAqHHQm23X4++11e1P8XI1bGH2GOwoL1JUr5vA==
X-Received: by 2002:a37:4804:: with SMTP id v4mr34301359qka.330.1559741684282;
        Wed, 05 Jun 2019 06:34:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id d16sm13121896qtd.73.2019.06.05.06.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:34:43 -0700 (PDT)
Date:   Wed, 5 Jun 2019 06:34:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, lizefan@huawei.com, cgroups@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190605133442.GJ374014@devbig004.ftw2.facebook.com>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605114935.7683-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Jun 05, 2019 at 01:49:35PM +0200, Juri Lelli wrote:
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
> ---
> Hi,
> 
> Although I'm pretty assertive in the changelog, I actually wonder what
> am I missing here and why (if) current behavior is needed and makes
> sense.
> 
> Any input?

Yeah, RT tasks being transprent to the cpu controller when
!RT_GROUP_SCHED makes sense to me, especially given that the rules
around it are already inconsistent.  Please feel free to add

  Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
