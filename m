Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BA3F7CA5
	for <lists+cgroups@lfdr.de>; Wed, 25 Aug 2021 21:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhHYTWy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 15:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237397AbhHYTWy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 15:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629919327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7z03hZuDBTQ0h38/Oi8p6IqjEpIuhunBdpC+bYuyK4g=;
        b=IAVFLM0a/FgICHYJlrZ559UWshNFTf9WDcxTRcKNHOr5L0KLWvePc2T/TESA/d7dv/lZTx
        hDUYnL4rGRywX/bi66mVSjt6cgneTXiqiieYfUiIubTuuJLJ9neW/M6TJJYxIXEMi60LQ3
        YWl0d+1+tdtRQg5xHsMXqMl8nuRNvGE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-xnTU3DDaMAaC2g5i-qe09w-1; Wed, 25 Aug 2021 15:22:06 -0400
X-MC-Unique: xnTU3DDaMAaC2g5i-qe09w-1
Received: by mail-qk1-f197.google.com with SMTP id v21-20020a05620a0a9500b003d5c1e2f277so293649qkg.13
        for <cgroups@vger.kernel.org>; Wed, 25 Aug 2021 12:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7z03hZuDBTQ0h38/Oi8p6IqjEpIuhunBdpC+bYuyK4g=;
        b=bIZdFVlXrlXJO5bxMaGHNKcGE9gbV6i93nGiAYy7n7y1Ifijp69ukEMRYNgb83w3pL
         AYdsZD6ZtilRqOdMwCKSQovYxVfMqW1dNhPbkB2vMHD+udyfPb2UdxVtcjIs87Mpxi24
         Hrgg67cGFGLCEPBUOxm5kjKoVm/I3gxCd9PELCv+6i9VzCIQm8zs5Wg0DWWfksmEqYKW
         qm7xA+6oA2W+IErmmBnIDlM11reAMM8o/AIaIRWFNUF/z3sYWiCcZ8ibDg33YIAeN+zr
         eG7xfSxdUOKoY0Lc0AyeuuviIaep7bVgogdVEj5WltAjfLNc1RX9vGMnNkgiN1GRTE97
         p8kw==
X-Gm-Message-State: AOAM533VQIQznHNtlFUTFiEm1JryN+gf6kkgpJOiilxHb0VdBKh+9JUn
        BRrxUb7qC7VBP7thWEruHpaw3iX2d4tBCpPRcFjXlroepumjHoOD4ylSqNN7e1QKRarZL5nTCEN
        crpPdevHDjqsc7utC9w==
X-Received: by 2002:a05:620a:ce6:: with SMTP id c6mr112441qkj.384.1629919321888;
        Wed, 25 Aug 2021 12:22:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+HJledI458RfarxWz1CFx7kJ5Fy8JunQsfebD6su3xj4Q/BGYlb0USIlJYWgzjRHqzajaAg==
X-Received: by 2002:a05:620a:ce6:: with SMTP id c6mr112402qkj.384.1629919321194;
        Wed, 25 Aug 2021 12:22:01 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id m187sm652139qkd.131.2021.08.25.12.21.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 12:22:00 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
To:     Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20210814205743.3039-1-longman@redhat.com>
 <20210814205743.3039-6-longman@redhat.com> <YRqbj5+ZdS+7k0Fn@slm.duckdns.org>
 <95b72d36-32a9-8356-05b7-2829e4cc29ad@redhat.com>
 <YSVCv0WjTzwPUWUN@slm.duckdns.org>
Message-ID: <af7ad628-62f4-848b-7eaa-1c9eb62355b6@redhat.com>
Date:   Wed, 25 Aug 2021 15:21:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSVCv0WjTzwPUWUN@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/24/21 3:04 PM, Tejun Heo wrote:
> Hello,
>
> On Tue, Aug 24, 2021 at 01:35:33AM -0400, Waiman Long wrote:
>> Sorry for the late reply as I was on vacation last week.
> No worries. Hope you enjoyed the vacation. :)
>
>>> All the above ultimately says is that "a new task cannot be moved to a
>>> partition root with no effective cpu", but I don't understand why this would
>>> be a separate rule. Shouldn't the partition just stop being a partition when
>>> it doesn't have any exclusive cpu? What's the benefit of having multiple its
>>> own failure mode?
>> A partition with 0 cpu can be considered as a special partition type for
>> spawning child partitions. This can be temporary as the cpus will be given
>> back when a child partition is destroyed.
> But it can also happen by cpus going offline while the partition is
> populated, right? Am I correct in thinking that a partition without cpu is
> valid if its subtree contains cpus and invalid otherwise? If that's the
> case, it looks like the rules can be made significantly simpler. The parent
> cgroups never have processes anyway, so a partition is valid if its subtree
> contains cpus, invalid otherwise.
Yes, that is true. Thanks for the simplification.
>
>>> So, I think this definitely is a step in the right direction but still seems
>>> to be neither here or there. Before, we pretended that we could police the
>>> input when we couldn't. Now, we're changing the interface so that it
>>> includes configuration failures as an integral part; however, we're still
>>> policing some particular inputs while letting other inputs pass through and
>>> trigger failures and why one is handled one way while the other differently
>>> seems rather arbitrary.
>>>
>> The cpu_exclusive and load_balance flags are attributes associated directly
>> with the partition type. They are not affected by cpu availability or
>> changing of cpu list. That is why they are kept even when the partition
>> become invalid. If we have to remove them, it will be equivalent to changing
>> partition back to member and we may not need an invalid partition type at
>> all. Also, we will not be able to revert back to partition again when the
>> cpus becomes available.
> Oh, yeah, I'm not saying to lose those states. What I'm trying to say is
> that the rules and failure modes seem a lot more complicated than they need
> to be. If the configuration becomes invalid for whatever reason, transition
> the partition into invalid state and report why. If the situation resolves
> for whatever reason, transition it back to valid state. Shouldn't that work?

I agree that the current description is probably more complicated than 
it should be. I will try to fix that.

Thanks,
Longman


