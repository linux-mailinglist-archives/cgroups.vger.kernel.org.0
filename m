Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D651DCCC2
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgEUMX3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgEUMX3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 08:23:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE6C061A0E
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 05:23:29 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s19so6498368edt.12
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uwOifwCrhhMbK5Uq7O2JD6i7Fke3H2izTnc0aJuCXEg=;
        b=XPG2fmle0UHD0TI3rprNxDcmfUfFqTRmNpREToIIZtED2Tw1ccSUVY3s4nRvf2eeHI
         6fyQbuYFMmtWFb/NIweeYDAxLIZQggq40/t2t6OcwndTJ9KfQbOi2cjxxCdmgouj8g5f
         PWs23lR8s68dqTVlmt13rZ3Mv+n9u0mXUNON0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uwOifwCrhhMbK5Uq7O2JD6i7Fke3H2izTnc0aJuCXEg=;
        b=uTmYtoBkga43FH4pomfqxLa9kTczmRwsmTXxGINfijYU0mlmssL4qKbYyssIALPr9y
         yGIwy/A8dLyfAmLHWl4FKLC1AgxXkh8cGFg2VdiBreMb+Kdhw8DcICD0SAtS8nZ6U4nA
         wabd+2D9Mp16a2qDfuBgLsDGsblATLMl03KkIZupF9qgIxKdhfPNuTyS+o0IHS+3TKsT
         IDo/y1MLGfldd+5U1+d1j86RJ3YPaM9DHq41LAzAXRkOGYJIhNnkY7V5SqG0Qwq52K3O
         K/mYRL5IxH3P/FWCFx6OFEajJ6hLppxEZzhAN4IOTMMpfqQoE4x3oWJaoEBpsbFMEnvk
         avSQ==
X-Gm-Message-State: AOAM530rPY5PDRxriVAfP7WNJXz8WuH6jE6pIn0zTXfyIrgZBXX1x0wW
        6EMLcS5gfOZx2A9/6yQ2kl6L1w==
X-Google-Smtp-Source: ABdhPJwIyMIKWxVlICS84mttq3Nqy68ltl2ewLaM0bfQqS1tl6vJX6JfY8W4NWhUa5vl9fh86hqbhQ==
X-Received: by 2002:a50:bf04:: with SMTP id f4mr7265805edk.91.1590063807770;
        Thu, 21 May 2020 05:23:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id h16sm4695618ejy.47.2020.05.21.05.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:23:27 -0700 (PDT)
Date:   Thu, 21 May 2020 13:23:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521122327.GB990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521120455.GM6462@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(I'll leave the dirty throttling discussion to Johannes, because I'm not so 
familiar with that code or its history.)

Michal Hocko writes:
>> > The main problem I see with that approach is that the loop could easily
>> > lead to reclaim unfairness when a heavy producer which doesn't leave the
>> > kernel (e.g. a large read/write call) can keep a different task doing
>> > all the reclaim work. The loop is effectivelly unbound when there is a
>> > reclaim progress and so the return to the userspace is by no means
>> > proportional to the requested memory/charge.
>>
>> It's not unbound when there is reclaim progress, it stops when we are within
>> the memory.high throttling grace period. Right after reclaim, we check if
>> penalty_jiffies is less than 10ms, and abort and further reclaim or
>> allocator throttling:
>
>Just imagine that you have parallel producers increasing the high limit
>excess while somebody reclaims those. Sure in practice the loop will be
>bounded but the reclaimer might perform much more work on behalf of
>other tasks.

A cgroup is a unit and breaking it down into "reclaim fairness" for individual 
tasks like this seems suspect to me. For example, if one task in a cgroup is 
leaking unreclaimable memory like crazy, everyone in that cgroup is going to be 
penalised by allocator throttling as a result, even if they aren't 
"responsible" for that reclaim.

So the options here are as follows when a cgroup is over memory.high and a 
single reclaim isn't enough:

1. Decline further reclaim. Instead, throttle for up to 2 seconds.
2. Keep on reclaiming. Only throttle if we can't get back under memory.high.

The outcome of your suggestion to decline further reclaim is case #1, which is 
significantly more practically "unfair" to that task. Throttling is extremely 
disruptive to tasks and should be a last resort when we've exhausted all other 
practical options. It shouldn't be something you get just because you didn't 
try to reclaim hard enough.
