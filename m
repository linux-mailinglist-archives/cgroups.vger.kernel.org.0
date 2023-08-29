Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD978CD0E
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 21:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjH2Tg6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Aug 2023 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjH2Tgb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Aug 2023 15:36:31 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F6EEA;
        Tue, 29 Aug 2023 12:36:28 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-26fb8225268so2572404a91.1;
        Tue, 29 Aug 2023 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693337788; x=1693942588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaMs62JQz4mOYmHMoUhCwPigQFveHohoGbGbhrjQBvI=;
        b=M+pTNidCw96WLUdkHnDhJ87b5LciOr/LAbsCi3ewxYMgTp9hC8OZHTn7jP+rq+YAtQ
         W7Qv2A3nqIMvMVifXMedn9J10NQD121MhoTjkPsD8jUrv9YVsLkOoiWo0X+V0PigkK0s
         PoXMARlyp3VLcRNegQyV0hbz6CyTcovaSs1lbpqHqw11hlm1cNC5ZcVxkNjmqi2O2ZiV
         Jtk8xkLw7M9PKZ8XW7Jqp8ta6ja0OXYgwJCL/Q9JY8+3bOfm3MYV0ezDRUWnS7jffrgB
         RnkvVNlx0MTfAfrIL+fz3V2fP6wLonUZ9po9Nn2L+CZMSdXp4p5exj2yzEYi7ubll9UF
         idIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337788; x=1693942588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaMs62JQz4mOYmHMoUhCwPigQFveHohoGbGbhrjQBvI=;
        b=EYFY0La6XUESNe6OtWxRbyLGsphrr7Z6GDJMs+GCbc+8AL8AE3mWOmCj+pv+CrMvcQ
         BvBF+LuwjIjBnMYDBng0mxmGt29JPfU0HQFtQIJchq4bhYRXvPpYf890H3SM2y4+32V0
         o9ko74ux7+kdr2tQ7bEl0DMGZiHo55yxNYTXqHDbGgDz+wdBBJwcQ6Ij1UWx8UR0OB7d
         5fL7/oRqaloNlrA3eGIupzGAqwHZzR72cVYIDtqh5Eh/4o7jSnQqNvQMEcG4jTrdcQF3
         +N0wHBwUfbsDvknonPJ8/yoJxOW7LHQmmd4kz8+Fc4ommAHwaJieJlZCZ1lD3Q2YIlR4
         TyfQ==
X-Gm-Message-State: AOJu0YxA/jB9pMGBePsmHnQ/HKfiwenQElLe/6uO2QnT4/IQoV9Z8QO5
        4nVBPMYFJhNyi0XP2WcrfuA=
X-Google-Smtp-Source: AGHT+IHrbBF6nDowgSO7qMCt5Mn9c9zYPOE9PfrAmloLN0Z3sq5tKWkVm7UWmv1s3lsL6GFTWeqoXQ==
X-Received: by 2002:a17:90a:f992:b0:26f:a6e7:abda with SMTP id cq18-20020a17090af99200b0026fa6e7abdamr144838pjb.46.1693337788109;
        Tue, 29 Aug 2023 12:36:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:f05])
        by smtp.gmail.com with ESMTPSA id e3-20020a17090a728300b00268dac826d4sm9225792pjg.0.2023.08.29.12.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 12:36:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 29 Aug 2023 09:36:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZO5IuULSCXMe9_pN@slm.duckdns.org>
References: <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <ZO48h7c9qwQxEPPA@slm.duckdns.org>
 <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaQ1hD9HHyYTK_vfCQ9PCVZag7qMBueKyB+sEn=swvNJA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 29, 2023 at 12:13:31PM -0700, Yosry Ahmed wrote:
...
> > So, the assumptions in the original design were:
> >
> > * Writers are high freq but readers are lower freq and can block.
> >
> > * The global lock is mutex.
> >
> > * Back-to-back reads won't have too much to do because it only has to flush
> >   what's been accumulated since the last flush which took place just before.
> >
> > It's likely that the userspace side is gonna be just fine if we restore the
> > global lock to be a mutex and let them be. Most of the problems are caused
> > by trying to allow flushing from non-sleepable and kernel contexts.
> 
> So basically restore the flush without disabling preemption, and if a
> userspace reader gets preempted while holding the mutex it's probably
> okay because we won't have high concurrency among userspace readers?
> 
> I think Shakeel was worried that this may cause a priority inversion
> where a low priority task is preempted while holding the mutex, and
> prevents high priority tasks from acquiring it to read the stats and
> take actions (e.g. userspace OOMs).

We'll have to see but I'm not sure this is going to be a huge problem. The
most common way that priority inversions are resolved is through work
conservation - ie. the system just runs out of other things to do, so
whatever is blocking the system gets to run and unblocks it. It only really
becomes a problem when work conservation breaks down on CPU side which
happens if the one holding the resource is 1. blocked on IOs (usually
through memory allocation but can be anything) 2. throttled by cpu.max.

#1 is not a factor here. #2 is but that is a factor for everything in the
kernel and should really be solved from cpu.max side. So, I think in
practice, this should be fine, or at least not worse than anything else.

> > Would it
> > make sense to distinguish what can and can't wait and make the latter group
> > always use cached value? e.g. even in kernel, during oom kill, waiting
> > doesn't really matter and it can just wait to obtain the up-to-date numbers.
> 
> The problem with waiting for in-kernel flushers is that high
> concurrency leads to terrible serialization. Running a stress test
> with 100s of reclaimers where everyone waits shows ~ 3x slowdowns.
> 
> This patch series is indeed trying to formalize a distinction between
> waiters who can wait and those who can't on the memcg side:
> 
> - Unified flushers always flush the entire tree and only flush if no
> one else is flushing (no waiting), otherwise they use cached data and
> hope the concurrent flushing helps. This is what we currently do for
> most memcg contexts. This patch series opts userspace reads out of it.
> 
> - Non-unified flushers only flush the subtree they care about and they
> wait if there are other flushers. This is what we currently do for
> some zswap accounting code. This patch series opts userspace readers
> into this.
> 
> The problem Michal is raising is that dropping the lock can lead to an
> unbounded number of waiters and longer worst case latency. Especially
> that this is directly influenced by userspace. Reintroducing the mutex
> and removing the lock dropping code fixes that problem, but then if
> the mutex holder gets preempted, we face another problem.
> 
> Personally I think there is a good chance there won't be userspace
> latency problems due to the lock as usually there isn't high
> concurrency among userspace readers, and we can deal with that problem
> if/when it happens. So far no problem is happening for cpu.stat which
> has the same potential problem.

Maybe leave the global lock as-is and gate the userland flushers with a
mutex so that there's only ever one contenting on the rstat lock from
userland side?

Thanks.

-- 
tejun
