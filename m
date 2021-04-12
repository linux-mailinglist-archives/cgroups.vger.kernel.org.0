Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246DF35D268
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 23:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhDLVNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbhDLVNW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 17:13:22 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA8C061574
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 14:13:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id i9so15816786qka.2
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VhpeC0PCBKcKFiAl7ppRsOOB3Otxo0lk7Zd3T6AZwNM=;
        b=WnYKb70Cx5OQVPFK9OAHJNNPUzeGnDdH/lqQWvldpQLwRF0TeKp7OOcCsqrGn3A2fP
         X7JSCUXEAxdUwX1KHddEf8mdYypYI1Ci6RWcdUntTl6Cw/6sJk8aelTufvyKnaQ7dxCt
         gz+qtss9qhGqnhFc9LIGH1/YjGDU+0FCDIYLc0s88lmJDCRdb8dZ1X8X5jwIkS6s8951
         l9UhZ7hwM04XdHi9oH656UT6gi68AWG1vT4xj9tHMWzi5H1bOEKS7ovUc1ein199JqN8
         fnvCnDLiH4d9OLrWJQQeiWKHVhOW49C0ceMO6WOg1eX7qpsG1s7YVA6ziYsqCv1ijwfB
         gg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VhpeC0PCBKcKFiAl7ppRsOOB3Otxo0lk7Zd3T6AZwNM=;
        b=W5L5y9GkIzjjFttdsc4tO7qq4mWYTnh2s+e+bi76zDLLIOXQer3Jmyvz2ddtO6EzH/
         hGALq2EqKMuqlsuRBOAmi3dqZ9oG3H+YeeIcxvdY0mQDd8eB62tWFkKBeiYrMiZIUzKD
         2kJNlYZmiElRkqhHabAjDr3UQGHRYHKvj1TnxLLfwGZTVtjJDdUBdx5LxJqfAjBJEuux
         VKhslLvyZWpHXF1Vx3u1eI1iTDc/iGDQqmUIvtrw40p+QZxL68OHhkZ6/HNCCzenuVcO
         /Bsn05i+bSGdHzkN+IB26BpSJWgHxvxUXBXqrJxlrIzTnluLxhnkbU1ha3AYkpXhQNAU
         jVaQ==
X-Gm-Message-State: AOAM532R6P1olaS8tsb3CX4s71Toq89rO6bUDJn6lBHN5oK/4wm8gKpR
        /ldeoEWfaMUQnnDdqdC56y4=
X-Google-Smtp-Source: ABdhPJyXuq3MZhkc19WxuNIgTLmh15JIiHWsOLxNHBR8Vh6XavGP/PQFhz30Kb45VFmHIzcIb80VtQ==
X-Received: by 2002:a37:9b93:: with SMTP id d141mr10050765qke.50.1618261983311;
        Mon, 12 Apr 2021 14:13:03 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id b83sm3101382qkc.97.2021.04.12.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:13:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Apr 2021 17:13:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     yulei.kernel@gmail.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, christian@brauner.io,
        cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        linussli@tencent.com, herberthbli@tencent.com,
        Yulei Zhang <yuleixzhang@tencent.com>
Subject: Re: [RFC v2 0/2] introduce new attribute "priority" to control group
Message-ID: <YHS33Rsj5xZ+nE3u@slm.duckdns.org>
References: <cover.1618219939.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618219939.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 12:40:09AM +0800, yulei.kernel@gmail.com wrote:
> From: Yulei Zhang <yuleixzhang@tencent.com>
> 
> Last time we introduce the idea of adding prioritized tasks management
> to control group. Sometimes we may assign the same amount of resources
> to multiple cgroups due to the environment restriction, but we still 
> hope there are preference order to handle the tasks in those cgroups,
> the 'prio' attribute may help to do the ranking jobs. 
> 
> The default value of "priority" is set to 0 which means the highest
> priority, and the totally levels of priority is defined by
> CGROUP_PRIORITY_MAX. Each subsystem could register callback to receive the
> priority change notification for their own purposes. 
> 
> In this v2 patch we apply a simple rule to the oom hanlder base on the
> order of priority to demonstrate the intention about adding this attribute.
> When enable the prioritized oom, it will perfer to pick up the victim from the
> memory cgroup with lower priority, and try the best to keep the tasks
> alive in high ranked memcg.

I don't think the discussion in the previous thread led anywhere. Please
consider this series nacked for now.

Thanks.

-- 
tejun
