Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D16685E37
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 05:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBAEPU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 23:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjBAEPT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 23:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918E5422F
        for <cgroups@vger.kernel.org>; Tue, 31 Jan 2023 20:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675224872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eKFn64VzPTEGVhGDDJ4Rj8PWdwFHGYC51EzAnMCzcw=;
        b=brjveYrL/0ZZcQ4zTYRg6o3a1QMZR0DmPsf0iUU0M3BG0ochPV/FaNtOLw+Pf5yPfqUdRu
        nWIdaQ4a/rY8RNH/j60cyfBt3kHPTwbQ9DRTzPnjy9CFrWWXePqhAewt4/v4E6EoOmyEvD
        HKkvHd+NOV3/lfLmeTjnaMIyPdOt+Ws=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-2aJBGfx1PjeLOgckNusxEw-1; Tue, 31 Jan 2023 23:14:29 -0500
X-MC-Unique: 2aJBGfx1PjeLOgckNusxEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 652A329A9CC1;
        Wed,  1 Feb 2023 04:14:28 +0000 (UTC)
Received: from [10.22.8.85] (unknown [10.22.8.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB05CC15BAE;
        Wed,  1 Feb 2023 04:14:27 +0000 (UTC)
Message-ID: <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
Date:   Tue, 31 Jan 2023 23:14:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230131221719.3176-2-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/23 17:17, Will Deacon wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> There is a difference in behaviour between CPUSET={y,n} that is now
> wrecking havoc with {relax,force}_compatible_cpus_allowed_ptr().
>
> Specifically, since commit 8f9ea86fdf99 ("sched: Always preserve the
> user requested cpumask")  relax_compatible_cpus_allowed_ptr() is
> calling __sched_setaffinity() unconditionally.
>
> But the underlying problem goes back a lot further, possibly to
> commit: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}") which
> switched cpuset_cpus_allowed() from cs->cpus_allowed to
> cs->effective_cpus.
>
> The problem is that for CPUSET=y cpuset_cpus_allowed() will filter out
> all offline CPUs. For tasks that are part of a (!root) cpuset this is
> then later fixed up by the cpuset hotplug notifiers that re-evaluate
> and re-apply cs->effective_cpus, but for (normal) tasks in the root
> cpuset this does not happen and they will forever after be excluded
> from CPUs onlined later.
>
> As such, rewrite cpuset_cpus_allowed() to return a wider mask,
> including the offline CPUs.
>
> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20230117160825.GA17756@willie-the-truck
> Signed-off-by: Will Deacon <will@kernel.org>

Before cgroup v2, cpuset had only one cpumask - cpus_allowed. It only 
tracked online cpus and ignored the offline ones. It behaves more like 
effective_cpus in cpuset v2. With v2, we have 2 cpumasks - cpus_allowed 
and effective_cpus. When cpuset v1 is mounted, cpus_allowed and 
effective_cpus are effectively the same and track online cpus. With 
cpuset v2, cpus_allowed contains what the user has written into and it 
won't be changed until another write happen. However, what the user 
written may not be what the system can give it and effective_cpus is 
what the system decides a cpuset can use.

Cpuset v2 is able to handle hotplug correctly and update the task's 
cpumask accordingly. So missing previously offline cpus won't happen 
with v2.

Since v1 keeps the old behavior, previously offlined cpus are lost in 
the cpuset's cpus_allowed. However tasks in the root cpuset will still 
be fine with cpu hotplug as its cpus_allowed should track 
cpu_online_mask. IOW, only tasks in a non-root cpuset suffer this problem.

It was a known issue in v1 and I believe is one of the major reasons of 
the cpuset v2 redesign.

A major concern I have is the overhead of creating a poor man version of 
v2 cpus_allowed. This issue can be worked around even for cpuset v1 if 
it is mounted with the cpuset_v2_mode option to behave more like v2 in 
its cpumask handling. Alternatively we may be able to provide a config 
option to make this the default for v1 without the special mount option, 
if necessary.

Cheers,
Longman

