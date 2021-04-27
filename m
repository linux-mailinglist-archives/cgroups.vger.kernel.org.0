Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDD736C7E8
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 16:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhD0OoT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhD0OoR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 10:44:17 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E7C061574;
        Tue, 27 Apr 2021 07:43:34 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 66so20609342qkf.2;
        Tue, 27 Apr 2021 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LjEjIzfJA5KpJv/2vrQIbqJyINd5uBvKHBOwXFK4cmg=;
        b=UfjKZXQgIFJ/QoFLh4LdDInp1ZFrKTBWFrDnfd9PYx50iwg7P4068CGLxLxyqvB6HR
         E5zPZ+36iFhlDwhZWQ5hljKXDXdRrzQq9kHdktL3oQ77hML0nySMN3kUELGojr2B/ZyR
         Y2lLPGmylOXLTwPt79TlAhSGPBfCzeuGWj59Hfvs35GWmeyspiP1g04ozHoQVsh/oNqW
         RPmwxkbA2Hfyckn9PULtvNVHNcvotFHbUisOfJAKV4k5tdoUtKUMKS+8Ai8VZu1yzrQX
         DQAgxK1PgW37F/ZH9XO8H4K8ZygoSh8DnVwmIo0PHtd015RSc99y5kqLcvFdk0D3mcAH
         YKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=LjEjIzfJA5KpJv/2vrQIbqJyINd5uBvKHBOwXFK4cmg=;
        b=jJrXymowZQbFZizxoGMQlyMnm/UtdyMy+/6AjrGX5/bTr+7fg1onOmlyOIn4l7rG6f
         x74xDyA2mJJ0rPz/51u7bvCGDVDiFg2W3Zm+/61IOFR3JZLmo0o1R7MnMZ8f14MF9U44
         c8QnNqUc4dX1X84ZaUzocgHDoeko2n3Cl4gTQFfA0/P6TytqvCuPtvHk06FISunWFX5A
         t++Qf+0v5rEXVZzmSwUzpRZc1N/tSQnP46yYmWise76Z9a/qmIEIAyJqwOPPQSE/XU6J
         wjKGyiLYhrrVeuLmWDMI8YHJt6raocd+L2uWANLfWYoot/Gcc2T71r5X8JgnpOWyNpbj
         0YJA==
X-Gm-Message-State: AOAM533GhL6ndwUsgx8UbNvA09aET/yzMiBcihY95ElmJ32q7bJS8nd1
        y9R/gDj+mRPXBx5qvzx3loo1TAsGYvlqGQ==
X-Google-Smtp-Source: ABdhPJzY6mUhHJ/n6X00R9N9lhvuF6fONZbz97n/WGm0+v+0OVcoPJNICa/M+nSn2uobZtgV619lOQ==
X-Received: by 2002:a37:b947:: with SMTP id j68mr23322786qkf.108.1619534613016;
        Tue, 27 Apr 2021 07:43:33 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id f16sm35370qtq.43.2021.04.27.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 07:43:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Apr 2021 10:43:31 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     akpm@linux-foundation.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cgroup/cpuset: introduce cpuset.mems.migration
Message-ID: <YIgjE6CgU4nDsJiR@slm.duckdns.org>
References: <20210426065946.40491-1-wuyun.abel@bytedance.com>
 <20210426065946.40491-3-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210426065946.40491-3-wuyun.abel@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Apr 26, 2021 at 02:59:45PM +0800, Abel Wu wrote:
> When a NUMA node is assigned to numa-service, the workload
> on that node needs to be moved away fast and complete. The
> main aspects we cared about on the eviction are as follows:
> 
> a) it should complete soon enough so that numa-services
>    won’t wait too long to hurt user experience
> b) the workloads to be evicted could have massive usage on
>    memory, and migrating such amount of memory may lead to
>    a sudden severe performance drop lasting tens of seconds
>    that some certain workloads may not afford
> c) the impact of the eviction should be limited within the
>    source and destination nodes
> d) cgroup interface is preferred
> 
> So we come to a thought that:
> 
> 1) fire up numa-services without waiting for memory migration
> 2) memory migration can be done asynchronously by using spare
>    memory bandwidth
> 
> AutoNUMA seems to be a solution, but its scope is global which
> violates c&d. And cpuset.memory_migrate performs in a synchronous

I don't think d) in itself is a valid requirement. How does it violate c)?

> fashion which breaks a&b. So a mixture of them, the new cgroup2
> interface cpuset.mems.migration, is introduced.
> 
> The new cpuset.mems.migration supports three modes:
> 
>  - "none" mode, meaning migration disabled
>  - "sync" mode, which is exactly the same as the cgroup v1
>    interface cpuset.memory_migrate
>  - "lazy" mode, when walking through all the pages, unlike
>    cpuset.memory_migrate, it only sets pages to protnone,
>    and numa faults triggered by later touch will handle the
>    movement.

cpuset is already involved in NUMA allocation but it always felt like
something bolted on - it's weird to have cpu to NUMA node settings at global
level and then to have possibly conflicting direct NUMA configuration via
cpuset. My preference would be putting as much configuration as possible on
the mm / autonuma side and let cpuset's node confinements further restrict
their operations rather than cpuset having its own set of policy
configurations.

Johannes, what are your thoughts?

Thanks.

-- 
tejun
