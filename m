Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA41538BF6
	for <lists+cgroups@lfdr.de>; Tue, 31 May 2022 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244509AbiEaH3j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 May 2022 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiEaH3i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 May 2022 03:29:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6BF8BD27
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 00:29:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c196so574982pfb.1
        for <cgroups@vger.kernel.org>; Tue, 31 May 2022 00:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ynHr+f3HdbTV3fIx5fiKz75mjaU0slPzyjQUZFWsNNE=;
        b=3BSBjnH3ZVmWwEIVHzHXEhghdgZpFnAo+yvYtAzpgRfIXkbyBVhTXgf5d/xjNpaQHS
         sz0UFZvQzv5e5HRgAt9iGDSpGTZx9tTCiezIhnMbEdJOAJ7K+A0IMSH0rp5jdGF1tm8K
         EIrFKWV2qoxlzowMCVlAVqGHTETYK99rGlF5k+vSuVBHe/TdQ3E8MnxKfl9JfYEjOtJH
         gnrlRHJsGlcnnMfhwsuKx9xFyDr/GEvdyf13nvjHmdiDKABo1mgxQFAJZxSAAZaNhZhd
         NeqvDimuZDLbss4uGUDTImQXiGHwgXTn0NpL9vNjO1nvo7gCeAaXNnUrMKHbLulytSh2
         JmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ynHr+f3HdbTV3fIx5fiKz75mjaU0slPzyjQUZFWsNNE=;
        b=uFrLlwBsq7a5L+Zdh/ChCeGXqA2MYLePOGIKcq7yU0LN3w8bn2eYXKJa1bszj5T2ze
         nWLLkmfU0b3ELtVmcxLKFJFaQbtQeDcaEGOXIcmd5rHaWk/JbxaxZkIpXTwFK+a0aiLH
         EYlzuYk+OUq6P6YeymLq53dgCc8TG927gTRAl9FXf1c1XkQh6yrv8Yx4YC3aHq08Jk6M
         yexjMpYi7Yt5fL9HLXUodtBdqhDlQ2Ih18n9PomgQ78vj0yE1U0dGh0OcTnRglMKPwRh
         XWKdl86/Vod8I4zBoAsugH69dNZ13AMDcvqE2D8pTNTuSVD+QB/SIaX3joazn9kkml9Q
         6p+g==
X-Gm-Message-State: AOAM533AMTCqMBjiMFJ83mwuEv+FKygImSqPGnOjE6Q4DPoDJb8Z6Wis
        8TZXZLgTP4zYjTuIwupavwNB9A==
X-Google-Smtp-Source: ABdhPJz+sPjbBPJuUyu8J0KCWi2CcYAAAGGaUdZO4DWuoXNJnb+8eFlVVZ9wEVss1F0lkZnI3TSv0A==
X-Received: by 2002:a63:7156:0:b0:3fb:fa23:480e with SMTP id b22-20020a637156000000b003fbfa23480emr9579581pgn.553.1653982176034;
        Tue, 31 May 2022 00:29:36 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:94c7:fca6:824f:4dab])
        by smtp.gmail.com with ESMTPSA id j190-20020a6380c7000000b003fbea5453c5sm4901384pgd.9.2022.05.31.00.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 00:29:35 -0700 (PDT)
Date:   Tue, 31 May 2022 15:29:27 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Waiman Long <longman@redhat.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YpXD12Qa51/5EUdy@FVFYT0MHHV2J.usts.net>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <1ecec7cb-035c-a4aa-3918-1a00ba48c6f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecec7cb-035c-a4aa-3918-1a00ba48c6f9@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 10:41:30PM -0400, Waiman Long wrote:
> On 5/30/22 03:49, Muchun Song wrote:
> > This version is rebased on v5.18.
> > 
> > Since the following patchsets applied. All the kernel memory are charged
> > with the new APIs of obj_cgroup.
> > 
> > 	[v17,00/19] The new cgroup slab memory controller [1]
> > 	[v5,0/7] Use obj_cgroup APIs to charge kmem pages [2]
> > 
> > But user memory allocations (LRU pages) pinning memcgs for a long time -
> > it exists at a larger scale and is causing recurring problems in the real
> > world: page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted into
> > a new cgroup every time. Unreclaimable dying cgroups pile up, waste memory,
> > and make page reclaim very inefficient.
> > 
> > We can convert LRU pages and most other raw memcg pins to the objcg direction
> > to fix this problem, and then the LRU pages will not pin the memcgs.
> > 
> > This patchset aims to make the LRU pages to drop the reference to memory
> > cgroup by using the APIs of obj_cgroup. Finally, we can see that the number
> > of the dying cgroups will not increase if we run the following test script.
> > 
> > ```bash
> > #!/bin/bash
> > 
> > dd if=/dev/zero of=temp bs=4096 count=1
> > cat /proc/cgroups | grep memory
> > 
> > for i in {0..2000}
> > do
> > 	mkdir /sys/fs/cgroup/memory/test$i
> > 	echo $$ > /sys/fs/cgroup/memory/test$i/cgroup.procs
> > 	cat temp >> log
> > 	echo $$ > /sys/fs/cgroup/memory/cgroup.procs
> > 	rmdir /sys/fs/cgroup/memory/test$i
> > done
> > 
> > cat /proc/cgroups | grep memory
> > 
> > rm -f temp log
> > ```
> > 
> > [1] https://lore.kernel.org/linux-mm/20200623015846.1141975-1-guro@fb.com/
> > [2] https://lore.kernel.org/linux-mm/20210319163821.20704-1-songmuchun@bytedance.com/
> > 
> > v4: https://lore.kernel.org/all/20220524060551.80037-1-songmuchun@bytedance.com/
> > v3: https://lore.kernel.org/all/20220216115132.52602-1-songmuchun@bytedance.com/
> > v2: https://lore.kernel.org/all/20210916134748.67712-1-songmuchun@bytedance.com/
> > v1: https://lore.kernel.org/all/20210814052519.86679-1-songmuchun@bytedance.com/
> > RFC v4: https://lore.kernel.org/all/20210527093336.14895-1-songmuchun@bytedance.com/
> > RFC v3: https://lore.kernel.org/all/20210421070059.69361-1-songmuchun@bytedance.com/
> > RFC v2: https://lore.kernel.org/all/20210409122959.82264-1-songmuchun@bytedance.com/
> > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
> > 
> > v5:
> >   - Lots of improvements from Johannes, Roman and Waiman.
> >   - Fix lockdep warning reported by kernel test robot.
> >   - Add two new patches to do code cleanup.
> >   - Collect Acked-by and Reviewed-by from Johannes and Roman.
> >   - I didn't replace local_irq_disable/enable() to local_lock/unlock_irq() since
> >     local_lock/unlock_irq() takes an parameter, it needs more thinking to transform
> >     it to local_lock.  It could be an improvement in the future.
> 
> My comment about local_lock/unlock is just a note that
> local_irq_disable/enable() have to be eventually replaced. However, we need
> to think carefully where to put the newly added local_lock. It is perfectly
> fine to keep it as is and leave the conversion as a future follow-up.
>

Totally agree.
 
> Thank you very much for your work on this patchset.
>

Thanks.
