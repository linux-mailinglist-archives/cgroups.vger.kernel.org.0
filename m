Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF44A5AE579
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiIFKh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 06:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiIFKhz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 06:37:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD551419
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 03:37:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so7030130pjl.0
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 03:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=Xz8bdPgR7exYL3R9SL9LcFFqWqgFZVil8ZYBWFtqEUU=;
        b=cA7Hl5ls5U/OscRp4DobHKMQjNA6D5C4jKC+7Av/PRDOkYb+XEGwmPKNz+0wLOS61X
         fhy0qVVTI5ldKJ0RhCmSDZqq/RQePtu4iAEe6umgDYn0MBNIb9KyPYXriWh+6o/CF8Ev
         0SP2kzY3jn3Ut7Uwr3OOVvEv5KLxDMgFehbIVflowPFwUBRRMOLtK6Poj76c5WL10QlO
         UZZU0VV5LbhyEHUDIUhN0ptJM5SMq1MRRmLd4NfX9PAtqxwkwlH2NCOb6SDzLvD0tb4k
         HBIsZ8wCBCeGVl7izNloEowlXHHdNdvPd5dTbNnKUop2/NhG/cwTOuW0nFYVuh7pSAbQ
         i+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=Xz8bdPgR7exYL3R9SL9LcFFqWqgFZVil8ZYBWFtqEUU=;
        b=mJkWpBV9oK1JfYpVQNF5GHrv/6d2MWYkI7WxrWY7BwWCmV28m4vzdGw7CyiBUaAN/Z
         eXYBVRYHH5fB071yh0T1P3gK/SZCsKsRuOkM/n8xsQLf/PqVKdWjf0L/3NkVVymRZIw0
         p6nx0kA9bKXq/c4xNB43Z+7KuYOhDFx69W4S/9nf/hASbK7pnPltMXiiyozducH63gjq
         /pQGz29YOgSIokph6MNbAsIsueBQoULd22221reRfpFexEAHjc8pqmSb8U9QgYWKG0EQ
         ouMN5rAWuzB2BQlHjdM9NZDEATIm3ftvdVI0/AAHvjP4nqggAGQDCYgTkO+m8wqGHHBI
         dyag==
X-Gm-Message-State: ACgBeo0GLHkRxlxjTxRweYreNQu9aU+W5fX4bYAwWSfr581Bv6ttLpSe
        W9jdYq+eXhN4H4wshckwYKEy0w==
X-Google-Smtp-Source: AA6agR58jEPcuQgEpaDM12qAcr3UOiSCl01qGenKN5dkhfPeBha2n6tYh8xoaVvbyMRX8m7ZKFA5dQ==
X-Received: by 2002:a17:903:228c:b0:16e:df74:34e5 with SMTP id b12-20020a170903228c00b0016edf7434e5mr53043766plh.49.1662460673860;
        Tue, 06 Sep 2022 03:37:53 -0700 (PDT)
Received: from [10.4.233.171] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902ecd000b00176db67ce98sm442737plh.3.2022.09.06.03.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 03:37:53 -0700 (PDT)
Message-ID: <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
Date:   Tue, 6 Sep 2022 18:37:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> On Mon 05-09-22 18:30:55, Zhongkun He wrote:
>> Hi Michal, thanks for your reply.
>>
>> The current 'mempolicy' is hierarchically independent. The default value of
>> the child is to inherit from the parent. The modification of the child
>> policy will not be restricted by the parent.
> 
> This breaks cgroup fundamental property of hierarchical enforcement of
> each property. And as such it is a no go.
> 
>> Of course, there are other options, such as the child's policy mode must be
>> the same as the parent's. node can be the subset of parent's, but the
>> interleave type will be complicated, that's why hierarchy independence is
>> used. It would be better if you have other suggestions?
> 
> Honestly, I am not really sure cgroup cpusets is a great fit for this
> usecase. It would be probably better to elaborate some more what are the
> existing shortcomings and what you would like to achieve. Just stating
> the syscall is a hard to use interface is not quite clear on its own.
> 
> Btw. have you noticed this question?
> 
>>> What is the hierarchical behavior of the policy? Say parent has a
>>> stronger requirement (say bind) than a child (prefer)?
>>>> How to use the mempolicy interface:
>>>> 	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
>>>> 	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
>>>>           echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
>>>
>>> Am I just confused or did you really mean to combine all these
>>> together?
>

Hi Michal, thanks for your reply.

 >>Say parent has a stronger requirement (say bind) than a child(prefer)?

Yes, combine all these together. The parent's task will use 'bind', 
child's use 'prefer'.This is the current implementation, and we can 
discuss and modify it together if there are other suggestions.

1:Existing shortcomings

In our use case, the application and the control plane are two separate 
systems. When the application is created, it doesn't know how to use 
memory, and it doesn't care. The control plane will decide the memory 
usage policy based on different reasons (the attributes of the 
application itself, the priority, the remaining resources of the 
system). Currently, numactl is used to set it at program startup, and 
the child process will inherit the mempolicy. But we can't dynamically 
adjust the memory policy, except restart, the memory policy will not change.

2:Our goals

For the above reasons, we want to create a mempolicy at the cgroup 
level. Usually processes under a cgroup have the same priority and 
attributes, and we can dynamically adjust the memory allocation strategy 
according to the remaining resources of the system. For example, a 
low-priority cgroup uses the 'bind:2-3' policy, and a high-priority 
cgroup uses bind:0-1. When resources are insufficient, it will be 
changed to bind:3, bind:0-2 by control plane, etc.Further more, more 
mempolicy can be extended, such as allocating memory according to node 
weight, etc.

Thanks.



	



