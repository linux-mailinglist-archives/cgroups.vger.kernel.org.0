Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B6E6C6ECB
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjCWR1h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjCWR1f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 13:27:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4031CB777
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 10:27:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id o44so11643504qvo.4
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679592453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z/h2YRuqxkbq2WVy9rSukgPkz7MffMXHVCaEQ8JsfSI=;
        b=0b1sytAcRxnizGxvw+p+lkYnbDhWMhQxrXGPJPm5sHacyMrIEdNLQJWaWguMuI6iRT
         gIob4qZ61pz7VHAvob8ln+eERCrG8SD695iKZx3xXdVhxJf2AK68WpjLNHTbfR1+mL/h
         W7T8K7/p+oIhtsGd2HUyWvFwIy6iY8DRoXXxq5zUNE26HtDLdvCeI65VKxv5w/6Cz/WF
         fEPo60DJZK/R6TZ+NZeMzWnHn7sJXOyNF2qPFslVrcEcKc1n5cSCHU1BEimYAOU8AJaR
         A2BbTJLzfny7Nv4w5tfJ4xLxwqSSQOmSgthksXW6BG1tzizPpqODzSDd5+8QtbLdZvtY
         p2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/h2YRuqxkbq2WVy9rSukgPkz7MffMXHVCaEQ8JsfSI=;
        b=ZQZ1QWuxXYvnvuk1XjXmrpNuydxRnsDoglNQCNs+CWv3AL+7yV27cJKDDGVdRfpEjK
         R1FbtuGkFgen+RKytdDu9b6wmzoM8kLZda+lbch2rjdDpvSvpiL74eQlZhAjGKHa+9xu
         LseOkyx0GSZxcBPR4YYL6ijuRPcDGFdqPzL/lphyo4e0E0yUb+KMbQwRw+UwBLt6iBj4
         CaLnRbNzULudoo5i8RwGAt+yr5rh0vCMOgwwjwA768cGn751w/YS6OtL0VzGwXIPaxGn
         Nw8Ma2rxM8SBw8a9G/2nc/D8xJJITQzJm5/nRU0kIlWdEe2BYz1DrXbEQznc+BRtByaa
         7PLA==
X-Gm-Message-State: AO0yUKU5lfQrtBltxB36NOL2mqcOUG9gvV9+L2rPLjWkNZW3Feiu4C5J
        0lYYmN0iJL9J6exINaEAevzcXA==
X-Google-Smtp-Source: AK7set8dWjwTTSIaOdmksX5IwKh8t2lW/W7AGyyEyTnTU89teSPpKydWtKCANGNduWs4VknW+c/exA==
X-Received: by 2002:a05:6214:5010:b0:56b:fb30:49c6 with SMTP id jo16-20020a056214501000b0056bfb3049c6mr12890918qvb.50.1679592453212;
        Thu, 23 Mar 2023 10:27:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id 123-20020a370581000000b007456df35859sm9126833qkf.74.2023.03.23.10.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:27:32 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:27:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <20230323172732.GE739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com>
 <20230323155613.GC739026@cmpxchg.org>
 <CAJD7tkZ7Dz9myftc9bg7jhiaOYcn7qJ+V4sxZ_2kfnb+k=zhJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZ7Dz9myftc9bg7jhiaOYcn7qJ+V4sxZ_2kfnb+k=zhJQ@mail.gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 23, 2023 at 09:01:12AM -0700, Yosry Ahmed wrote:
> On Thu, Mar 23, 2023 at 8:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> > > @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
> > >               return;
> > >
> > >       flush_next_time = jiffies_64 + 2*FLUSH_TIME;
> > > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> > > +     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);
> >
> > How is it safe to call this with may_sleep=true when it's holding the
> > stats_flush_lock?
> 
> stats_flush_lock is always called with trylock, it is only used today
> so that we can skip flushing if another cpu is already doing a flush
> (which is not 100% correct as they may have not finished flushing yet,
> but that's orthogonal here). So I think it should be safe to sleep as
> no one can be blocked waiting for this spinlock.

I see. It still cannot sleep while the lock is held, though, because
preemption is disabled. Make sure you have all lock debugging on while
testing this.

> Perhaps it would be better semantically to replace the spinlock with
> an atomic test and set, instead of having a lock that can only be used
> with trylock?

It could be helpful to clarify what stats_flush_lock is protecting
first. Keep in mind that locks should protect data, not code paths.

Right now it's doing multiple things:

1. It protects updates to stats_flush_threshold
2. It protects updates to flush_next_time
3. It serializes calls to cgroup_rstat_flush() based on those ratelimits

However,

1. stats_flush_threshold is already an atomic

2. flush_next_time is not atomic. The writer is locked, but the reader
   is lockless. If the reader races with a flush, you could see this:

					if (time_after(jiffies, flush_next_time))
	spin_trylock()
        flush_next_time = now + delay
        flush()
        spin_unlock()
					spin_trylock()
					flush_next_time = now + delay
					flush()
					spin_unlock()

   which means we already can get flushes at a higher frequency than
   FLUSH_TIME during races. But it isn't really a problem.

   The reader could also see garbled partial updates, so it needs at
   least READ_ONCE and WRITE_ONCE protection.

3. Serializing cgroup_rstat_flush() calls against the ratelimit
   factors is currently broken because of the race in 2. But the race
   is actually harmless, all we might get is the occasional earlier
   flush. If there is no delta, the flush won't do much. And if there
   is, the flush is justified.

In summary, it seems to me the lock can be ditched altogether. All the
code needs is READ_ONCE/WRITE_ONCE around flush_next_time.
