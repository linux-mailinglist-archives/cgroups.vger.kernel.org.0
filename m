Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CA9358ED9
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 22:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhDHU6s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 16:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHU6q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 16:58:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA4C061760
        for <cgroups@vger.kernel.org>; Thu,  8 Apr 2021 13:58:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d13so6255041lfg.7
        for <cgroups@vger.kernel.org>; Thu, 08 Apr 2021 13:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkxHhJqNProKhVzizVTFQYR4zVgXz8q4oP2NJJdcs/E=;
        b=XMaJZNgyutfANSdggd1yIuEbwRbGBdcUhhpTV4tyd52LO06noE0SU+OllRrBcwnLJS
         m4WRnbwddW+o5lMg+Obk+rHkHQui5eb8ooVFnFJxnx/kMYOXUwobOQ9C9PnIxtyGgXQe
         hbmxWxwHXWceC0OEUglJz1TOOvw97vEz3lU9SAKjLH1fQ3vo7LrdnM4tFqG7zBnmnp5h
         GxxuwrQXOrkX7EwCQJeD4bXRy/Rn0rbKTXOlesjAhbPNA+k/7JL851XuMKu0bT/CJucK
         1fUMWz9xCv5eJ1Mj+D9Cr3GBkWDIp9bgClgJ2x3A7NKe3UOxvPbChFcuLDcxOQTAaD5T
         EXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkxHhJqNProKhVzizVTFQYR4zVgXz8q4oP2NJJdcs/E=;
        b=hRrGoz+LNMv7jiZ6qIfzV7MPpUBn41AizYRf/XjfXpeZTuVUkS5yLP9jsKTk8eRKf8
         7xRu5J35nubEvoDJPvC0aUjuxCaBRp3Il6yIkSjCU34HD04OjhuFXeKUyNM6QoKlU+6C
         rtEefLrkXvws4QDrEK/6UL0lyXEhLDw/E8EODTbS6x+3chn8HGW/zvbzWcWmErQiTvud
         bvqIz3GSMfEMWaedhFYuTEQgcnmj9f5wOT+TCZnEbO7XrSe+aBzKpDTiVWzBmLCH0J2J
         cq+Bi4XoK4WSA+N4peowY1EwwkrLZgZkHADVzsRnDEDfsu8P/HqMzgnJW1rqyQZH4Ilb
         dpBw==
X-Gm-Message-State: AOAM530z9giKS0HJtvqLPxrCc5clQEisQYpegsDlqqEk6dvs7L0cSRGR
        JKCT7Ad3tJ0eScU0M8LEabJt4P6oRJxxgtHLxiYRGg==
X-Google-Smtp-Source: ABdhPJz5g3ldslC9N0y+VjGINZbsEDiAfTkh3IGxvjMGlc2ui6IdMI+urbfvjVB/rqWU0LnAxGOiYoPTcaA2BzJG5Fo=
X-Received: by 2002:a05:6512:2356:: with SMTP id p22mr7970038lfu.347.1617915511909;
 Thu, 08 Apr 2021 13:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617355387.git.yuleixzhang@tencent.com> <YGn3iHBp5UweFv2/@mtj.duckdns.org>
 <CACZOiM0xA+6kAeM2sk3SfVV9Vu+5dOzC7APoNmB0Zw3jQKbg+w@mail.gmail.com>
In-Reply-To: <CACZOiM0xA+6kAeM2sk3SfVV9Vu+5dOzC7APoNmB0Zw3jQKbg+w@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 8 Apr 2021 13:58:20 -0700
Message-ID: <CALvZod6JagEjzkn+2hVg+npFp=+X5mv4GLWAH-QbvJFP=udtgA@mail.gmail.com>
Subject: Re: [RFC 0/1] Introduce new attribute "priority" to control group
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>, linussli@tencent.com,
        herberthbli@tencent.com, lennychen@tencent.com,
        allanyuliu@tencent.com, Yulei Zhang <yuleixzhang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 8, 2021 at 9:51 AM yulei zhang <yulei.kernel@gmail.com> wrote:
>
> On Mon, Apr 5, 2021 at 1:29 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Sun, Apr 04, 2021 at 10:51:53PM +0800, yulei.kernel@gmail.com wrote:
> > > From: Yulei Zhang <yuleixzhang@tencent.com>
> > >
> > > This patch is the init patch of a series which we want to present the idea
> > > of prioritized tasks management. As the cloud computing introduces intricate
> > > configurations to provide customized infrasturctures and friendly user
> > > experiences, in order to maximum utilization of sources and improve the
> > > efficiency of arrangement, we add the new attribute "priority" to control
> > > group, which could be used as graded factor by subssystems to manipulate
> > > the behaviors of processes.
> > >
> > > Base on the order of priority, we could apply different resource configuration
> > > strategies, sometimes it will be more accuracy instead of fine tuning in each
> > > subsystem. And of course to set fundamental rules, for example, high priority
> > > cgroups could seize the resource from cgroups with lower priority all the time.
> > >
> > > The default value of "priority" is set to 0 which means the highest
> > > priority, and the totally levels of priority is defined by
> > > CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
> > > priority change notification for their own purposes.
> > >
> > > We would like to send out the corresponding features in the coming weeks,
> > > which are relaying on the priority settings. For example, the prioritized
> > > oom, memory reclaiming and cpu schedule strategy.
> >
> > We've been trying really hard to give each interface semantics which is
> > logical and describable independent of the implementation details. This runs
> > precisely against that.
> >
> > Thanks.
> >
> > --
> > tejun
>
> Thanks for the feedback. I am afraid that I didn't express myself clearly
> about the idea of the priority attribute. We don't want to overwrite
> the semantics
> for each interface in cgroup, just hope to introduce another factor that could
> help us apply the management strategy. For example, In our production
> environment
> K8s has its own priority class to implement the Qos, and it will be
> very helpful
> if control group could provide corresponding priority to assist the
> implementation.

IMHO the 'priority' is a high level concept mainly to define policies
and should not be part of user API. The meaning of priority changes
with each use-case and it can be more than one dimension. For example
I can have two jobs running on a machine. One is a batch and the
second is a latency sensitive job, let's say web server. For oom-kill
use-case, I might prefer to kill the web server as there will be
multiple instances running and the load balancer will redirect the
load. However for memory reclaim, I would prefer to reclaim from batch
as the cost of refaults in the web server is visible to end customers.

Basically we should have mechanisms in the kernel which can be used to
define and enforce high level priorities. I can set memory.low of the
web server to prefer reclaim from batch job. For oom-kill, Android's
lmkd and fb's oomd are the examples of user space oom-killer where
policies are in user space.
