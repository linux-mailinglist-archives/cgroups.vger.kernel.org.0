Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B46588BDA
	for <lists+cgroups@lfdr.de>; Wed,  3 Aug 2022 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiHCMRe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Aug 2022 08:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbiHCMRd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Aug 2022 08:17:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF68A24F08
        for <cgroups@vger.kernel.org>; Wed,  3 Aug 2022 05:17:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso1812305pjq.4
        for <cgroups@vger.kernel.org>; Wed, 03 Aug 2022 05:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=x4/SZID/1XNhMOqSKnwdkmMau4H8OofmRy/FbmoxvEg=;
        b=Qxzz3XQYiaXJalf/es7ikBYZATLndo+CihdM+270E6X3mVgzGHjCbX2gbmb16gI/Ov
         rSvkxx6lRoeo0n2OX5ZnfuAy8nbvYly0hxZzmx4jRrMK3YAojWRnz9b/UBXXdof2JCyx
         MvxcEmgyVsGeFiHOJm57LKUERvfEZrlKvzFZlFtQC7MQx7qVLmttFCceB2hpMNmhF0H3
         WG3yWnPUiGHHvyWe6AFqcmygCvj6+OGKU14bNnYcfbJUgjyynfru3pUhW0UfZCn33pBG
         xE434cPgQOYCKWyhFTYcYMhdWG+uYLoohGsHSPlyIgsQAgra2xR93ptHB+/TGhmMCmBo
         sxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4/SZID/1XNhMOqSKnwdkmMau4H8OofmRy/FbmoxvEg=;
        b=pp6X+ybWCRYo2DHMdWyrEZnzAkbfqE7lyEsl3Q/vzrISWHBtzlG+tMvm2OsqGVZECf
         qOj3X2x6reWMOeY0dg23UUo5OQHLAEYV4hU2BDxq8tmPotmcT1ycafZo9lMnGuQhGrEB
         K6CUiVRg6jRsHQ51269mtuiuW0KIzGGMFj3Wqz2WGx3c8tkkUoGW2anofNW07ovQ0+BB
         Lnm6mpMvRLWHkLpm0tRCEdPB1Scdq5+mzOk40J0Ibcd1CFhEIVPVvoFlCtn2vECyfGSL
         UFaz7hewJs6vi6ji0a2PfmXBFApMWCNb2uv6nz0II5vXIuKWp1Jz7YH4WbI1/y12eTx8
         2FRg==
X-Gm-Message-State: ACgBeo3j9I/mGYO/Dc+90XeKQcJ+Xpbw4/F0IUyjrgkGrvQz3RyhnWQQ
        cTxfFNXfaZlh13O2lYtKDj4w/Q==
X-Google-Smtp-Source: AA6agR6K3MfdANHxcunD2XRTV9uJBMf+zOY1iDRSOo00/SlZyGwxYzO+c0r66ftoR1wGizK1pICcPQ==
X-Received: by 2002:a17:902:cccf:b0:168:c4c3:e8ca with SMTP id z15-20020a170902cccf00b00168c4c3e8camr26226711ple.40.1659529051172;
        Wed, 03 Aug 2022 05:17:31 -0700 (PDT)
Received: from [10.70.253.98] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00528c066678csm12815094pfb.72.2022.08.03.05.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 05:17:30 -0700 (PDT)
Message-ID: <5a3410d6-428d-9ad1-3e5a-01ca805ceeeb@bytedance.com>
Date:   Wed, 3 Aug 2022 20:17:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [PATCH 8/9] sched/psi: add kernel cmdline parameter
 psi_inner_cgroup
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        corbet@lwn.net, akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-9-zhouchengming@bytedance.com>
 <Yt7KQc0nnOypB2b2@cmpxchg.org> <YuAqWprKd6NsWs7C@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YuAqWprKd6NsWs7C@slm.duckdns.org>
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

On 2022/7/27 01:54, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 25, 2022 at 12:52:17PM -0400, Johannes Weiner wrote:
>> On Thu, Jul 21, 2022 at 12:04:38PM +0800, Chengming Zhou wrote:
>>> PSI accounts stalls for each cgroup separately and aggregates it
>>> at each level of the hierarchy. This may case non-negligible overhead
>>> for some workloads when under deep level of the hierarchy.
>>>
>>> commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
>>> make PSI to skip per-cgroup stall accounting, only account system-wide
>>> to avoid this each level overhead.
>>>
>>> For our use case, we also want leaf cgroup PSI accounted for userspace
>>> adjustment on that cgroup, apart from only system-wide management.
>>
>> I hear the overhead argument. But skipping accounting in intermediate
>> levels is a bit odd and unprecedented in the cgroup interface. Once we
>> do this, it's conceivable people would like to do the same thing for
>> other stats and accounting, like for instance memory.stat.
>>
>> Tejun, what are your thoughts on this?
> 
> Given that PSI requires on-the-spot recursive accumulation unlike other
> stats, it can add quite a bit of overhead, so I'm sympathetic to the
> argument because PSI can't be made cheaper by kernel being better (or at
> least we don't know how to yet).
> 
> That said, "leaf-only" feels really hacky to me. My memory is hazy but
> there's nothing preventing any cgroup from being skipped over when updating
> PSI states, right? The state count propagation is recursive but it's each
> task's state being propagated upwards not the child cgroup's, so we can skip
> over any cgroup arbitrarily. ie. we can at least turn off PSI reporting on
> any given cgroup without worrying about affecting others. Am I correct?

Yes, I think it's correct.

> 
> Assuming the above isn't wrong, if we can figure out how we can re-enable
> it, which is more difficult as the counters need to be resynchronized with
> the current state, that'd be ideal. Then, we can just allow each cgroup to
> enable / disable PSI reporting dynamically as they see fit.

This method is more fine-grained but more difficult like you said above.
I think it may meet most needs to disable PSI stats in intermediate cgroups?

Thanks!

> 
> Thanks.
> 
