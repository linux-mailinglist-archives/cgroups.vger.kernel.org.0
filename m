Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FC336D30D
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhD1HZf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 03:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236648AbhD1HZe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Apr 2021 03:25:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE86C061574
        for <cgroups@vger.kernel.org>; Wed, 28 Apr 2021 00:24:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so8632843pjv.1
        for <cgroups@vger.kernel.org>; Wed, 28 Apr 2021 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ocOiwhnINfr+vKnvSHIfg9Nbg66LG1Qzz5IHcV/tGpI=;
        b=eVN+NK23/ESRrBYM2lxx0JJdpsKDZ22tgKcqU4ZQ5DFwQMOPQ935OCwLL4eRBcpt6b
         HxY//w+DZIIaMWpUPH0oGLw+/OhMrGPu2xNL9RubfJ+do06n4Pr9hmubQyF6wksegxHI
         SzBNqNn/9rVxc0B+YiHhTFWCvQRyGNvaPm3/R6+1Lx6QOsEQzQyUP9Ix1O5XFrv8+59a
         DV+QdW1aWQ/po8Y377Yl3+PbWy8EY3IQEC6z7wh5BB55uwIDQW/lbzaZGc3kjFBRLTJE
         SZoq9XsQy7+XmDFdzb/xmHW04Iu8A410Ai1Fq4A4ST8qN2msmz6C+2phGOV76KgvnIaR
         nBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ocOiwhnINfr+vKnvSHIfg9Nbg66LG1Qzz5IHcV/tGpI=;
        b=C+ngAJcmbq+6nLcDF324O6N1JzJ+VPIyl9rpGS1GefEIrgA0HStcJL5H7P63WmPA3E
         IixpPV1ipDawUBFcXRPuNtzaHimmJ5J0E5hZEKKeNYFlst9I8rHqbJeEyUd9BV1BO6jf
         TlfRvRjm+dwQ0w0xXg17AgrJDysSAb7P8EkjeLHneU/I0t+gwvzvK0R8jYOi9NJRaePp
         +9i03VsWgj4XQTBFMYTrVK4pgV09RBlw+XEBT0VSOQZONQd0js9XvBh+hFQPCVI6IgzR
         3VvEIwzWlR96pgwVC7Z6elLzY5RVUKtcC3wYePTpd7TelZCptwOskmJATr4XPTaPZmAE
         EHkA==
X-Gm-Message-State: AOAM531OloeaadxCQ0X/Ra+KwPqKjIGPqK2jdzhqg+riaz7RRHNjSBq3
        CRwmoQ8vY2uxhtrhrYQV+w5cjoHzf622/A==
X-Google-Smtp-Source: ABdhPJxcIEGDPedhqMOT2+LOr0kK7lINj+wlYhZkeKnm1k35EsmrDc1yUxcpXF/9LFTdEwFCz5quoQ==
X-Received: by 2002:a17:902:e892:b029:ec:d257:b8a2 with SMTP id w18-20020a170902e892b02900ecd257b8a2mr29159002plg.15.1619594688274;
        Wed, 28 Apr 2021 00:24:48 -0700 (PDT)
Received: from [10.94.59.238] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id f10sm4152090pju.27.2021.04.28.00.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 00:24:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] cgroup/cpuset: introduce cpuset.mems.migration
To:     Tejun Heo <tj@kernel.org>
Cc:     akpm@linux-foundation.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210426065946.40491-1-wuyun.abel@bytedance.com>
 <20210426065946.40491-3-wuyun.abel@bytedance.com>
 <YIgjE6CgU4nDsJiR@slm.duckdns.org>
From:   Abel Wu <wuyun.abel@bytedance.com>
Message-ID: <67632345-9c30-9e87-f9b2-ba4e18b5ae91@bytedance.com>
Date:   Wed, 28 Apr 2021 15:24:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIgjE6CgU4nDsJiR@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Tejun, thanks for your review,

On 4/27/21 10:43 PM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 26, 2021 at 02:59:45PM +0800, Abel Wu wrote:
>> When a NUMA node is assigned to numa-service, the workload
>> on that node needs to be moved away fast and complete. The
>> main aspects we cared about on the eviction are as follows:
>>
>> a) it should complete soon enough so that numa-services
>>     won’t wait too long to hurt user experience
>> b) the workloads to be evicted could have massive usage on
>>     memory, and migrating such amount of memory may lead to
>>     a sudden severe performance drop lasting tens of seconds
>>     that some certain workloads may not afford
>> c) the impact of the eviction should be limited within the
>>     source and destination nodes
>> d) cgroup interface is preferred
>>
>> So we come to a thought that:
>>
>> 1) fire up numa-services without waiting for memory migration
>> 2) memory migration can be done asynchronously by using spare
>>     memory bandwidth
>>
>> AutoNUMA seems to be a solution, but its scope is global which
>> violates c&d. And cpuset.memory_migrate performs in a synchronous
> 
> I don't think d) in itself is a valid requirement. How does it violate c)?
Yes, d) is more like a preference, since we operate in cgroup level.
Process/thread level interfaces are also acceptable.
AutoNUMA violates c) in its global effect that not only the source
and destination nodes, the processes running on other nodes would
also suffer from unwanted overhead due to numa faults.
And besides the global effect, one-shot mode migration is expected
in this scenario, like cpuset.memory_migrate, rather than autonuma's
periodic behavior.
> 
>> fashion which breaks a&b. So a mixture of them, the new cgroup2
>> interface cpuset.mems.migration, is introduced.
>>
>> The new cpuset.mems.migration supports three modes:
>>
>>   - "none" mode, meaning migration disabled
>>   - "sync" mode, which is exactly the same as the cgroup v1
>>     interface cpuset.memory_migrate
>>   - "lazy" mode, when walking through all the pages, unlike
>>     cpuset.memory_migrate, it only sets pages to protnone,
>>     and numa faults triggered by later touch will handle the
>>     movement.
> 
> cpuset is already involved in NUMA allocation but it always felt like
> something bolted on - it's weird to have cpu to NUMA node settings at global
> level and then to have possibly conflicting direct NUMA configuration via
> cpuset. My preference would be putting as much configuration as possible on
> the mm / autonuma side and let cpuset's node confinements further restrict
> their operations rather than cpuset having its own set of policy
> configurations.
Such conflicting configuration exists in our system in order to
reduce TCO, and yet we haven't found a proper way to get rid of
it. Say a numa-service occupies the whole memory of a node but
still leave some cpus free. The free cpus may be assigned to some
services, the ones that are not memory latency sensitive and are
forbidden to use local memory. Thoughts?

Thanks,
	Abel
> 
> Johannes, what are your thoughts?
> 
> Thanks.
> 
