Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F1B5389FB
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 04:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiEaCll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 22:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243637AbiEaClj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 22:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D95C6CDD
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 19:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653964897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqGPJPGu5WN/i1V+mwA4aFt/oqbHUtth4ZkdMSpoL5A=;
        b=YNlN32pXrgUqU8mcyD86p31sOF5QJB9nLZaRh2j01UqS6OpK5V6SWT9uen0FPycLGOC1tg
        8MezgSCIYif+cM7voJRGCtJ1ByluwVMtxeMyeHY20IEeaHrA4fow4rosb+3+P/IROd9wFa
        NJgBoQVuNyK84qZAmKMSGCZqC+4Vbfg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-Uu4laDedP6yfga6ESTEaeg-1; Mon, 30 May 2022 22:41:32 -0400
X-MC-Unique: Uu4laDedP6yfga6ESTEaeg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 849121C01B33;
        Tue, 31 May 2022 02:41:31 +0000 (UTC)
Received: from [10.22.32.183] (unknown [10.22.32.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F22A6492C3B;
        Tue, 31 May 2022 02:41:30 +0000 (UTC)
Message-ID: <1ecec7cb-035c-a4aa-3918-1a00ba48c6f9@redhat.com>
Date:   Mon, 30 May 2022 22:41:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
References: <20220530074919.46352-1-songmuchun@bytedance.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/30/22 03:49, Muchun Song wrote:
> This version is rebased on v5.18.
>
> Since the following patchsets applied. All the kernel memory are charged
> with the new APIs of obj_cgroup.
>
> 	[v17,00/19] The new cgroup slab memory controller [1]
> 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages [2]
>
> But user memory allocations (LRU pages) pinning memcgs for a long time -
> it exists at a larger scale and is causing recurring problems in the real
> world: page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted into
> a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> and make page reclaim very inefficient.
>
> We can convert LRU pages and most other raw memcg pins to the objcg direction
> to fix this problem, and then the LRU pages will not pin the memcgs.
>
> This patchset aims to make the LRU pages to drop the reference to memory
> cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> of the dying cgroups will not increase if we run the following test script.
>
> ```bash
> #!/bin/bash
>
> dd if=/dev/zero of=temp bs=4096 count=1
> cat /proc/cgroups | grep memory
>
> for i in {0..2000}
> do
> 	mkdir /sys/fs/cgroup/memory/test$i
> 	echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> 	cat temp >> log
> 	echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> 	rmdir /sys/fs/cgroup/memory/test$i
> done
>
> cat /proc/cgroups | grep memory
>
> rm -f temp log
> ```
>
> [1] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
> [2] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/
>
> v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedance.com/
> v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
> v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
> v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
> RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
> RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
> RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
> RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
>
> v5:
>   - Lots of improvements from Johannes, Roman and Waiman.
>   - Fix lockdep warning reported by kernel test robot.
>   - Add two new patches to do code cleanup.
>   - Collect Acked-by and Reviewed-by from Johannes and Roman.
>   - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq() since
>     local_lock/unlock_irq() takes an parameter, it needs more thinking to transform
>     it to local_lock.  It could be an improvement in the future.

My comment about local_lock/unlock is just a note that 
local_irq_disable/enable() have to be eventually replaced. However, we 
need to think carefully where to put the newly added local_lock. It is 
perfectly fine to keep it as is and leave the conversion as a future 
follow-up.

Thank you very much for your work on this patchset.

Cheers,
Longman


