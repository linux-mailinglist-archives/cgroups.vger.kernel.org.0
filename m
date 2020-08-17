Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0F1246FC7
	for <lists+cgroups@lfdr.de>; Mon, 17 Aug 2020 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgHQRxp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Aug 2020 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbgHQQLh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Aug 2020 12:11:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7555C061389
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:11:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id m7so15410265qki.12
        for <cgroups@vger.kernel.org>; Mon, 17 Aug 2020 09:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EPZNWjTuoNbn3/0iITSmRZt5ivNwv7BWW6z1AtL/Hmc=;
        b=Z23cJzvoZmVLpOK2aT+f4XT4iV2NnQq1w6sWZWEGLYa39+S+I66Qx1sJuEz0lgvGq1
         9MafbfOp+fkSCLAdwkxY3sqWfa/7Ya+r03VJzdWTWGLlMGY81AwTZ2a03DaIZWFHcudU
         YK2AWWX4x4DALRmK9f7+jCQ+8hCmXiM0ppCuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EPZNWjTuoNbn3/0iITSmRZt5ivNwv7BWW6z1AtL/Hmc=;
        b=XUeLtEqpxATcU2xCVD3rtAALfrw2C/erbHUF3AVOju42OgkFIEyl6aUjpA1DIqUB+u
         83d43Z90qplAYO6MFUK/sUnUY6++RASUdlJlcOHM9kYAO1T5c5SyzGDSa4CFurIxzs2J
         1ojUoBjgCQSVm/GfSORKAneNMr+UqQnOTVGjLUqg73mcn+/hHyUNKUdNg4MDIx57BjCH
         tHEqZediTZm72EcfFNtMZY+X5SxOp5NAIFhBxTKbvqv2gdB0PPMo+daR3qf6YhwSjsz8
         s15fRStoUY3pLz4lSIs11TNka/TF02NGI11Qls+CbvjTbbwW47fulrpGimkhN3yOh3MA
         cb3w==
X-Gm-Message-State: AOAM530rIsxUpXyAIpQk7gjp4jIiwVc0fIZByCOQsBis7NdKfpUCiayn
        l91vHbhdwgHS/yxNh5deUu6drwU64OF2mAIafxU=
X-Google-Smtp-Source: ABdhPJxCfcujs7UvLmGxbMeQ2XhvVrOMYp62V16ipQ+dV/Tk0r1zxthxYII+3rcf8N5c4NDp4jS9dg==
X-Received: by 2002:a37:9a46:: with SMTP id c67mr13909866qke.85.1597680694869;
        Mon, 17 Aug 2020 09:11:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:47cc])
        by smtp.gmail.com with ESMTPSA id z14sm19093304qtn.92.2020.08.17.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:11:34 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:11:32 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
Message-ID: <20200817161132.GA5171@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
 <20200817143044.GA1987@chrisdown.name>
 <934e4bc3-bab6-b19a-49f9-6a6ae8638570@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <934e4bc3-bab6-b19a-49f9-6a6ae8638570@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Waiman Long writes:
>On 8/17/20 10:30 AM, Chris Down wrote:
>>Astractly, I think this really overcomplicates the API a lot. If 
>>these are truly generally useful (and I think that remains to be 
>>demonstrated), they should be additions to the existing API, rather 
>>than a sidestep with prctl.
>This patchset is derived from customer requests. With existing API, I 
>suppose you mean the memory cgroup API. Right? The reason to use 
>prctl() is that there are users out there who want some kind of 
>per-process control instead of for a whole group of processes unless 
>the users try to create one cgroup per process which is not very 
>efficient.

If using one cgroup per process is inefficient, then that's what needs to be 
fixed. Making the API extremely complex to reason about for every user isn't a 
good compromise when we're talking about an already niche use case.

>>I also worry about some other more concrete things:
>>
>>1. Doesn't this allow unprivileged applications to potentially 
>>bypass    memory.high constraints set by a system administrator?
>The memory.high constraint is for triggering memory reclaim. The new 
>mitigation actions introduced by this patchset will only be applied if 
>memory reclaim alone fails to limit the physical memory consumption. 
>The current memory cgroup memory reclaim code will not be affected by 
>this patchset.

memory.high isn't only for triggering memory reclaim, it's also about active 
throttling when the application fails to come under. Fundamentally it's 
supposed to indicate the point at which we expect the application to either 
cooperate or get forcibly descheduled -- take a look at where we call 
schedule_timeout_killable.

I really struggle to think about how all of those things should interact in 
this patchset.

>>2. What's the purpose of PR_MEMACT_KILL, compared to memory.max?
>A user can use this to specify which processes are less important and 
>can be sacrificed first instead of the other more important ones in 
>case they are really in a OOM situation. IOW, users can specify the 
>order where OOM kills can happen.

You can already do that with something like oomd, which has way more 
flexibility than this. Why codify this in the kernel instead of in a userspace 
agent?
