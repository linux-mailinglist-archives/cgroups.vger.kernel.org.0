Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8271E67BA
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2020 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405160AbgE1Qsv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 May 2020 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405123AbgE1Qsu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 May 2020 12:48:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F199C08C5C6
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 09:48:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so4087840wmd.0
        for <cgroups@vger.kernel.org>; Thu, 28 May 2020 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UwZ28g34UZ/LmYps/esI5h2JZjKeclqR/inpTX02z2o=;
        b=PPb3j7a/BdD86VI8igVSltNvHQ9B8pjLLH1ePEwa/baG3Wzmss76Lv0gRQbqiB0y7I
         qB3fSv9TLfHEKw23N/5h80TiBDGczfNsmJpY+OMnOWzCIfO1yGUMNJi8SGt8vStQ6HYl
         zOW8eKaK+Jq3r13HH3nV3qAD0HpX1p6KWe31I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwZ28g34UZ/LmYps/esI5h2JZjKeclqR/inpTX02z2o=;
        b=TleqH7zqilkeYzzlhK3ynuWfE0Zjo69m3NlYK1tOmMc8qR9L2exinN0sMf2p8+J0Yo
         ushbQSN6Gqrz8U/oDvWXqkA88to5fckadYOjhAfx6Wnz1lGN0ni0/MAKKuGVNvNpovvh
         wlEaOZ6BYZXt0l3wxUvn4dbEbVjlzix+lna+bdELCEHjO5xHP5pqpYLXNfwSn0QAVNp5
         guzQlPGjiysD59Cnohm6kFS2JQKzPGU0pR4B0kaTuXCDQ+mLRJdQWCevlT1PwThtb6rM
         rrdE6Bho2M3AEqwVzY/mot5Cakrb727RU1BXOKZM20OTWmAbtgYMS2EbSWltQHZWn1eb
         0hqQ==
X-Gm-Message-State: AOAM531gJyi4SOdBMFzqgMavNcTSgzX8dYhr2+obFXS0qKRnORq/fL7Q
        vzYzWRfVRmU2j+gkmhFlBQJwOA==
X-Google-Smtp-Source: ABdhPJx2lEUjIyLYkOhiyOkgO1n10vkCe0XPXbDohjqU2El6rgKvXLDbPYgyqKrqd2CxBujY0bcjUQ==
X-Received: by 2002:a1c:810a:: with SMTP id c10mr4180798wmd.107.1590684529184;
        Thu, 28 May 2020 09:48:49 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d125])
        by smtp.gmail.com with ESMTPSA id u13sm6429380wrp.53.2020.05.28.09.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 09:48:48 -0700 (PDT)
Date:   Thu, 28 May 2020 17:48:48 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200528164848.GB839178@chrisdown.name>
References: <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
 <20200521163833.GA813446@cmpxchg.org>
 <20200521173701.GX6462@dhcp22.suse.cz>
 <20200521184505.GA815980@cmpxchg.org>
 <20200528163101.GJ27484@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200528163101.GJ27484@dhcp22.suse.cz>
User-Agent: Mutt/1.14.2 (2020-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>> We send a simple bug fix: bring this instance of reclaim in line with
>> how everybody else is using the reclaim API, to meet the semantics as
>> they are intendend and documented.
>
>Here is where we are not on the same page though. Once you have identified
>that the main problem is that the reclaim fails too early to meet the
>target then the fix would be to enforce that target. I have asked why
>this hasn't been done and haven't got any real answer for that. Instead
>what you call "a simple bug fix" has larger consequences which are not
>really explained in the changelog and they are also not really trivial
>to see. If the changelog explicitly stated that the proportional memory
>reclaim is not sufficient because XYZ and the implementation has been
>changed to instead meet the high limit target then this would be a
>completely different story and I believe we could have saved some
>discussion.

I agree that the changelog can be made more clear. Any objection if I send v2 
with changelog changes to that effect, then? :-)

>> And somehow this is controversial, and we're just changing around user
>> promises as we see fit for our particular usecase?
>>
>> I don't even understand how the supposed alternate semantics you read
>> between the lines in the documentation would make for a useful
>> feature: It may fail to contain a group of offending tasks to the
>> configured limit, but it will be fair to those tasks while doing so?
>>
>> > But if your really want to push this through then let's do it
>> > properly at least. memcg->memcg_nr_pages_over_high has only very
>> > vague meaning if the reclaim target is the high limit.
>>
>> task->memcg_nr_pages_over_high is not vague, it's a best-effort
>> mechanism to distribute fairness. It's the current task's share of the
>> cgroup's overage, and it allows us in the majority of situations to
>> distribute reclaim work and sleeps in proportion to how much the task
>> is actually at fault.
>
>Agreed. But this stops being the case as soon as the reclaim target has
>been reached and new reclaim attempts are enforced because the memcg is
>still above the high limit. Because then you have a completely different
>reclaim target - get down to the limit. This would be especially visible
>with a large memcg_nr_pages_over_high which could even lead to an over
>reclaim.

We actually over reclaim even before this patch -- this patch doesn't bring 
much new in that regard.

Tracing try_to_free_pages for a cgroup at the memory.high threshold shows that 
before this change, we sometimes even reclaim on the order of twice the number 
of pages requested. For example, I see cases where we requested 1000 pages to 
be reclaimed, but end up reclaiming 2000 in a single reclaim attempt.
