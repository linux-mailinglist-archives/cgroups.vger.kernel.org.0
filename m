Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186855895CB
	for <lists+cgroups@lfdr.de>; Thu,  4 Aug 2022 04:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiHDCCW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Aug 2022 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHDCCV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Aug 2022 22:02:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB853D0E
        for <cgroups@vger.kernel.org>; Wed,  3 Aug 2022 19:02:20 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l64so1050338pge.0
        for <cgroups@vger.kernel.org>; Wed, 03 Aug 2022 19:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=R8a2uTZpErjV8ZoEO/x1ZNaBxjx4vHWCt7mF0miAi5E=;
        b=zZ1UG92HUINfBQ0MPaLPPVMGISoqyJK/vD/6sOBUj8XoURNF1lfjGeUqvP9Fd0Q0n4
         S4tnowzf3rtmuMxZufeXmYMk6Idx/JgCkX3Plw150oX75qK9rOWR5ykDKz/sz3+WUMmV
         qoFAxG0rCEOoKhTUc12aJo6XYNciiUvXjIJdrE1WLpbsMhASFxIFg9i+mVCKLFfEdRf4
         79VgYyrQKQ1IuJT+owA5Geif2IltJJU2FgCCZb8FX9DuLUrLQiPPMA3fiLeIhVfrDhS6
         lgBpNEPmcHiEORwN/t+xhP9fHEMu5jG2DSGj5k1P7NT0ZHbum9gVw4Knz8LQVXLxleRM
         DJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=R8a2uTZpErjV8ZoEO/x1ZNaBxjx4vHWCt7mF0miAi5E=;
        b=bnPaETadn3xf1K6gkyyogGLqAIMP2tmOrNHA0aeCQLyjYEJ1FoRe6wz04dcQy54qI7
         f9Vx9k7wko65ematXfV0PhP4XtDqDVaoUgZN2A+58wcj5Hyh260Tej5OHdvrjAMxllsg
         c9aRG/WowPB0s/mG7h7n1G4VOvWcsvqw3nHy7BadyEziWUB4E2t7Ym8IcvhWiIzfz9k/
         SmMROFYcuRBxTXW13HZ1lMeZ3LGVWUWJmMSX/8WDWDo+c9Hk9cKCsjgp13ALGCLoMtVQ
         2LcTwyx4oUxcjd7VPInmfP9fhxLJnZlKWIkMsXHyt5AWZLwyuAF+VRj0Ot4SJ6AhsGE4
         WzXw==
X-Gm-Message-State: AJIora/OJlO4DeBuBRd/X/JYTCtOIPua78SiMVQo04bZfE6WavYqnD0f
        KdgRG7Eso5Q82E4yLvDPvQdDUQ==
X-Google-Smtp-Source: AGRyM1taVZO1N6EAUFFd6LVCOyUP7rwsRGObXVBy+H93Y4h3tUP8RyBFCKJp59eKeZktJHyBkWgolQ==
X-Received: by 2002:a05:6a00:2282:b0:52b:bab:16a4 with SMTP id f2-20020a056a00228200b0052b0bab16a4mr28685867pfe.17.1659578539603;
        Wed, 03 Aug 2022 19:02:19 -0700 (PDT)
Received: from [10.200.231.53] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id i10-20020a056a00004a00b0052ab602a7d0sm6513352pfk.100.2022.08.03.19.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:02:19 -0700 (PDT)
Message-ID: <94ddcd31-e168-06ed-c0f9-2ea25b802d60@bytedance.com>
Date:   Thu, 4 Aug 2022 10:02:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, surenb@google.com,
        mingo@redhat.com, peterz@infradead.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org> <YuAqWprKd6NsWs7C@slm.duckdns.org>
 <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
 <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org>
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Yuq3Q6Y9dRnjjcPt@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/8/4 01:58, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 03, 2022 at 08:17:22PM +0800, Chengming Zhou wrote:
>>> Assuming the above isn't wrong, if we can figure out how we can re-enable
>>> it, which is more difficult as the counters need to be resynchronized with
>>> the current state, that'd be ideal. Then, we can just allow each cgroup to
>>> enable / disable PSI reporting dynamically as they see fit.
>>
>> This method is more fine-grained but more difficult like you said above.
>> I think it may meet most needs to disable PSI stats in intermediate cgroups?
> 
> So, I'm not necessarily against implementing something easier but we at
> least wanna get the interface right, so that if we decide to do the full
> thing later we can easily expand on the existing interface. ie. let's please
> not be too hacky. I don't think it'd be that difficult to implement
> per-cgroup disable-only operation that we can later expand to allow
> re-enabling, right?

Agree, the interface is important, per-cgroup disable-only operation maybe easier
to implement. I will look into this more.

Thanks!

