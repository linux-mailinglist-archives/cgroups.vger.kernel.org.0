Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C23CBE3C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 23:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhGPVPR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 17:15:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234129AbhGPVPQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 17:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626469941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtZkPkL5ifGn/qh+FLZXpXfgaKHtHcJkyP1xEcuftv4=;
        b=WszPjFD71SjhDDskK8JsnI+gGp5Hiung2ko2vbyqc1FIpT+r34vD/VVRnr4eDbDxoKWLk6
        XHzuTEX/vkAomrobyo5wsyPrxNJhr1Ur2cnUnIpIhK0pzJK+ZzgSfS4Kdt6sxRZDSBxDs5
        catWfdZTPMb4lNp6rI2fnbiKUxYX/ic=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-PPMxz-8rMf6GZ2i62T-mfQ-1; Fri, 16 Jul 2021 17:12:19 -0400
X-MC-Unique: PPMxz-8rMf6GZ2i62T-mfQ-1
Received: by mail-qv1-f70.google.com with SMTP id d10-20020a0ce44a0000b02902c99dfad03fso7607936qvm.8
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 14:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rtZkPkL5ifGn/qh+FLZXpXfgaKHtHcJkyP1xEcuftv4=;
        b=bfjjHSjfzPwPylmiBjA+6p2nXpnAURFcwyrzerNxa635UQHIk7bQDQAjqw71D8Ndwa
         4Wfqa+BXVExIaNR1V6UxsiaWnJ2c0g3XnSrZoSFMzDG5Fyt+BRkWHmTLbqVpfKgTFrMV
         tLiKMXuwel/xBb4kd7UD7MmL0i4J/OddK1R4c3mv2E3CwEp+V3UiN5jQckdBxAEKPuNq
         o5ChreIX/KZ25KmI6GJ4RbUji5OZxTIMYpztEQoA1qc+cjje5yqtcr4XSoZxIqlQK7Si
         7cdReeuFcVqB+M7z2Ff0qMZw/sRAl3O6MJqlbKjvya1TFedQneVkhiacDd7EG3Ld0t2t
         9zsQ==
X-Gm-Message-State: AOAM530OlMgzp5VMyXK8C9AeNJsAWojxwj5uR/dK1jXAmFSyUpyv1xtd
        QdwgbQ+vAKr2ej6JCX3ltalNBmSAwy3Ykfj2xsTil7d6rlbfSJTGPxfhcOiUqutvHklDXArvEUA
        tl9b+t0f+QgcZVYtiuw==
X-Received: by 2002:ae9:e511:: with SMTP id w17mr11949832qkf.306.1626469939102;
        Fri, 16 Jul 2021 14:12:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9mVFlRQajFH1fN2NUgEKxwR2UFx9GsK1tedNLIEIZuzRTR9mkQNQGf6W+FM+nKWayRyhUCA==
X-Received: by 2002:ae9:e511:: with SMTP id w17mr11949813qkf.306.1626469938928;
        Fri, 16 Jul 2021 14:12:18 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id r187sm4315358qkb.129.2021.07.16.14.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 14:12:18 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 2/6] cgroup/cpuset: Clarify the use of invalid
 partition root
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
        Juri Lelli <juri.lelli@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
 <20210621184924.27493-3-longman@redhat.com>
 <YNcHOe3o//pIiByh@mtj.duckdns.org>
 <6ea1ac38-73e1-3f78-a5d2-a4c23bcd8dd1@redhat.com>
 <YONGk3iw/zrNzwLK@mtj.duckdns.org>
 <c6ae2d9b-ad6e-9bbd-b25c-f52b0ff6fb9b@redhat.com>
 <1bb119a1-d94a-6707-beac-e3ae5c03fae5@redhat.com>
 <8c44b659-3fe4-b14f-fac1-cbd5b23010c3@redhat.com>
 <YPHwG61qGDa3h6Wg@mtj.duckdns.org>
Message-ID: <e8c538a8-bf5c-b04c-1b21-ac22cd158dd1@redhat.com>
Date:   Fri, 16 Jul 2021 17:12:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPHwG61qGDa3h6Wg@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/16/21 4:46 PM, Tejun Heo wrote:
> Hello, Waiman.
>
> On Fri, Jul 16, 2021 at 04:08:15PM -0400, Waiman Long wrote:
>>>> I agree with you on principle. However, the reason why there are
>>>> more restrictions on enabling partition is because I want to avoid
>>>> forcing the users to always read back cpuset.partition.type to see
>>>> if the operation succeeds instead of just getting an error from the
>>>> operation. The former approach is more error prone. If you don't
>>>> want changes in existing behavior, I can relax the checking and
>>>> allow them to become an invalid partition if an illegal operation
>>>> happens.
>>>>
>>>> Also there is now another cpuset patch to extend cpu isolation to
>>>> cgroup v1 [1]. I think it is better suit to the cgroup v2 partition
>>>> scheme, but cgroup v1 is still quite heavily out there.
>>>>
>>>> Please let me know what you want me to do and I will send out a v3
>>>> version.
>>> Note that the current cpuset partition implementation have implemented
>>> some restrictions on when a partition can be enabled. However, I missed
>>> some corner cases in the original implementation that allow certain
>>> cpuset operations to make a partition invalid. I tried to plug those
>>> holes in this patchset. However, if maintaining backward compatibility
>>> is more important, I can leave those holes and update the documentation
>>> to make sure that people check cpuset.partition.type to confirm if their
>>> operation succeeds.
>> I just realize that partition root set the CPU_EXCLUSIVE bit. So changes to
>> cpuset.cpus that break exclusivity rule is not allowed anyway. This patchset
>> is just adding additional checks so that cpuset.cpus changes that break the
>> partition root rules will not be allowed. I can remove those additional
>> checks for this patchset and allow cpuset.cpus changes that break the
>> partition root rules to make it invalid instead. However, I still want
>> invalid changes to cpuset.partition.type to be disallowed.
> So, I get the instinct to disallow these operations and it'd make sense if
> the conditions aren't reachable otherwise. However, I'm afraid what users
> eventually get is false sense of security rather than any actual guarantee.
>
> Inconsistencies like this cause actual usability hazards - e.g. imagine a
> system config script whic sets up exclusive cpuset and let's say that the
> use case is fine with degraded operation when the target cores are offline
> (e.g. energy save mode w/ only low power cores online). Let's say this
> script runs in late stages during boot and has been reliable. However, at
> some point, there are changes in boot sequence and now there's low but
> non-trivial chance that the system would already be in low power state when
> the script runs. Now the script will fail sporadically and the whole thing
> would be pretty awkward to debug.
>
> I'd much prefer to have an explicit interface to confirm the eventual state
> and a way to monitor state transitions (without polling). An invalid state
> is an inherent part of cpuset configuration. I'd much rather have that
> really explicit in the interface even if that means a bit of extra work at
> configuration time.

Are you suggesting that we add a cpuset.cpus.events file that allows 
processes to be notified if an event (e.g. hotplug) that changes a 
partition root to invalid partition happens or when explicit change to a 
partition root fails? Will that be enough to satisfy your requirement?

Cheers,
Longman

