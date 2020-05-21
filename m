Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9948A1DCE51
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgEUNlw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgEUNlv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 09:41:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F94C061A0F
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 06:41:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j21so8902377ejy.1
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xV51Tcrf9NcqZbm5wUPmCudngXiKCmzHzaVIGwxSLX0=;
        b=mVLBa0YkwB4qr/nGUx3mTqt/IBNkDYMevgIGIDvGXl6mMe9hC/iNBgUGd5KNQhW1C2
         9VRaEeFAhHWBGnn62P2YYa9mMqk5yFn72KsrQrJt2qlo1uogjLnYcd8FWbScxgkMXJYD
         LjLNQZqXCO3CrKOtpR884DuapuK4oJipI1hO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xV51Tcrf9NcqZbm5wUPmCudngXiKCmzHzaVIGwxSLX0=;
        b=TDInsZjuIsKgQiNt4QdyplwzJFFmtydEqh/1tlpiCpOd7PxdJ0SDfyFPsTv33EKumH
         W5TtZx5wZn9Jki9kTYVWayoSYeJMr0/Y23eSy6+SLuRmMFYkSsTXdPV9JhaZzG3dFp1m
         PRezRgBF7rSOwXxi3jZ6YHKS/BOhu2FMZOjV5vi4opfMggxUWJNbzLtE33Y5vgRE2TDR
         mnYCT1rRe+VcWESqs6eR61m3O43t1hu88utNnVpYVBlsAUiqnp8JQoNqoEfseSIqWso7
         /PbjF5tmAZkSWpN7wyTkj5tbzWtAZGZFOsvQrr5YZLbsnWYAzCoHO6xS2bf8fSGXuQOG
         kHYw==
X-Gm-Message-State: AOAM532MLUhRtppJ0AnjB9P37cRmOGCzQKOQXZVUbcSUeTGc9n8qJaYK
        Jo7Swty4Bc3KDv8WKSZg/9dCqm6Rk0yazjHN
X-Google-Smtp-Source: ABdhPJyPmqgON7ZwGWSaHZxJk6nAVtW7JFpeftFSfh6aqvslRE6WSSH/itVmXPZpIv9jK/4agLflLg==
X-Received: by 2002:a17:906:edd3:: with SMTP id sb19mr3469182ejb.39.1590068508871;
        Thu, 21 May 2020 06:41:48 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id f24sm4741685edq.21.2020.05.21.06.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:41:48 -0700 (PDT)
Date:   Thu, 21 May 2020 14:41:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521133324.GF990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
 <20200521132120.GR6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521132120.GR6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>On Thu 21-05-20 13:57:59, Chris Down wrote:
>> Michal Hocko writes:
>> > > A cgroup is a unit and breaking it down into "reclaim fairness" for
>> > > individual tasks like this seems suspect to me. For example, if one task in
>> > > a cgroup is leaking unreclaimable memory like crazy, everyone in that cgroup
>> > > is going to be penalised by allocator throttling as a result, even if they
>> > > aren't "responsible" for that reclaim.
>> >
>> > You are right, but that doesn't mean that it is desirable that some
>> > tasks would be throttled unexpectedly too long because of the other's activity.
>>
>> Are you really talking about throttling, or reclaim? If throttling, tasks
>> are already throttled proportionally to how much this allocation is
>> contributing to the overage in calculate_high_delay.
>
>Reclaim is a part of the throttling mechanism. It is a productive side
>of it actually.

I guess let's avoid using the term "throttling", since in this context it 
sounds like we're talking about allocator throttling :-)

>> If you're talking about reclaim, trying to reason about whether the overage
>> is the result of some other task in this cgroup or the task that's
>> allocating right now is something that we already know doesn't work well
>> (eg. global OOM).
>
>I am not sure I follow you here.

Let me rephrase: your statement is that it's not desirable "that some task 
would be throttled unexpectedly too long because of [the activity of another 
task also within that cgroup]" (let me know if that's not what you meant). But 
trying to avoid that requires knowing which activity abstractly instigates this 
entire mess in the first place, which we have nowhere near enough context to 
determine.
