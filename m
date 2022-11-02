Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB66163C5
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 14:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKBNVq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 09:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiKBNVp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 09:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153A32A949
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667395256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b49q1XHQiuNrTW4a7AJc1gkwX+9NO+6eMUUebYAkoIk=;
        b=DQCFMPWNg+7u4F6W4v1k8yZajlJeoqWvdiSoKA9oSu3trSOMEYEpqS4UEMrjlwEn/l6TpK
        teipeSUPEhBz3pCnNaZ+N6vXWHLbD6aJV/mi7jonQKuxngiFBH51xxQ+j0PE97IveTC5Ph
        C02sVYfsFTdObwfEFvPNsS3jYuz22S8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-_B9dybYVNdaISa1roMvJXg-1; Wed, 02 Nov 2022 09:20:50 -0400
X-MC-Unique: _B9dybYVNdaISa1roMvJXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D24E85A59D;
        Wed,  2 Nov 2022 13:20:50 +0000 (UTC)
Received: from [10.22.10.104] (unknown [10.22.10.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C848A42220;
        Wed,  2 Nov 2022 13:20:49 +0000 (UTC)
Message-ID: <d0b43b7d-54d3-00bd-abe0-78212ee9355a@redhat.com>
Date:   Wed, 2 Nov 2022 09:20:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 0/2] cpuset: Skip possible unwanted CPU-mask updates.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221102105530.1795429-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/2/22 06:55, Sebastian Andrzej Siewior wrote:
> Hi,
>
> while playing with cgroups and tasks which alter their CPU-mask I
> noticed a behaviour which is unwanted:
> - Upon enabling the cpuset controller, all currently set CPU-mask are
>    changed. Here one could argue how bad it is assuming that the
>    controller gets only enabled once during boot.
>
> - While having a task limited to only one CPU (or more but a subset of
>    the cpuset's mask) then adding an additional CPU (or removing an
>    unrelated CPU) from that cpuset results in changing the CPU-mask of
>    that task and adding additional CPUs.
>
> The test used to verify the behaviour:
>
> # Limit to CPU 0-1
> $ taskset -pc 0-1 $$
> # Enable the cpuset controller
> $  echo "+cpu" >> /sys/fs/cgroup/cgroup.subtree_control ; echo "+cpuset" >> /sys/fs/cgroup/cgroup.subtree_control
>
> # Query the CPU-mask. Expect to see 0-1 since it is a subset of
> # all-online-CPUs
> $ taskset -pc $$
>
> # Update the mask to CPUs 1-2
> $ taskset -pc 1-2 $$
>
> # Change the CPU-mask of the cgroup to CPUs 1-3.
> $ echo 1-3 > /sys/fs/cgroup/user.slice/cpuset.cpus
> # Expect to see 1-2 because it is a subset of 1-3
> $ taskset -pc $$
>
> # Change the CPU-mask of the cgroup to CPUs 2-3.
> $ echo 2-3 > /sys/fs/cgroup/user.slice/cpuset.cpus
> # Expect to see 2-3 because CPU 1 is not part of 2-3
> $ taskset -pc $$
>
> # Change the CPU-mask of the cgroup to CPUs 2-4.
> $ echo 2-4 > /sys/fs/cgroup/user.slice/cpuset.cpus
> # Expect to see 2-4 because task's old CPU-mask matches the old mask of
> # the cpuset.
> $ taskset -pc $$
>
> Posting this as RFC in case I'm missing something obvious or breaking an
> unknown (to me) requirement that this series would break.

Yes, that is a known issue which is especially problematic when cgroup 
v2 is used. That is why I have recently posted a set of patches to 
enable persistent user requested affinity and they have been merged into 
tip:

851a723e45d1 sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
da019032819a sched: Enforce user requested affinity
8f9ea86fdf99 sched: Always preserve the user requested cpumask
713a2e21a513 sched: Introduce affinity_context
5584e8ac2c68 sched: Add __releases annotations to affine_move_task()

They should be able to address the problem that you list here. Please 
let me know if there are still problem remaining.

Thanks,
Longman

