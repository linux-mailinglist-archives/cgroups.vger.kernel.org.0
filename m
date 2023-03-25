Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21C26C8A0F
	for <lists+cgroups@lfdr.de>; Sat, 25 Mar 2023 02:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCYByy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 21:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYByx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 21:54:53 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CC52128;
        Fri, 24 Mar 2023 18:54:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so3466925plg.4;
        Fri, 24 Mar 2023 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679709292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZD4yeAZYRZA0h6Sa2287K8z27FVJ3yK8JKUr0lQOXE=;
        b=mC2DwxizegktL3ml5ZkgW4iCveIfhyJtMgfrimZIa1j1Y8YW2I4IZ0tdvhZc1A2gBf
         bPpL453iMfkKE7Q2iWa4l856pfAiURxN5/VWU5iRKWYdb8bkZ3t7oIn4Ot9AMCUHitJ1
         fCBSfv9sMBPT7l1ZZx+O8DWyTvwkVSxYlGe9lG/wtPJtTqKF+eHZphHY8fK58NNu/2RP
         gJ6z0onrbm2DECMNfgl9WtEt3NFf22+/uIlkkjpNvmM6Bun+RuVdmYM0bG3VPR8NAMhS
         fy/MyqxnmIPai73OJB0s480cJGQXc7QfJTxlb9Gf6+IA3XpIVl5ws2XDBcGAJ5Rj3nhv
         6k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679709292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZD4yeAZYRZA0h6Sa2287K8z27FVJ3yK8JKUr0lQOXE=;
        b=foSxrAun58eoPwjaqBixSDbsStCoQLq6LTSbK4yZbWBlOMuJBxA07qQMZX3EDQnytC
         dG9s4XvOjpYvguULEi35Z/1L/3WH5WZj+K5S6uDRpU0XXM6mx/gKzkUvfjBjOK54y6yc
         5aBw7Clal18anfOvuH001VO1z9+Jp1/EW0Z5hFi32ymWtA6Tg+TQaHe2ZaPQysZu3HgG
         qNw88JT/jnI3NNLxXYc34olOY61Ueeg7YAR59JVb9rmCwXJ6+e4b79gVKElfJ2fwIYQu
         RzFvneax9q+ItSPKE9BgUbU5+Nzy4/DMU/pETUahbf7ns11bOwKPuC1oLPsmPVr/ylPU
         yDpQ==
X-Gm-Message-State: AAQBX9cr3p/Pv+2c7dmdDYpMzRUIzagRzy0KTrRbUeR7MOD7x5ByMK/F
        G6Cdc8TH4qU7p81uRcV5Vfc=
X-Google-Smtp-Source: AKy350ayeAKBbmYB88nMPmyXyjU6HNDMbK6lhYJvfZOmCtey/uCIZ7/8QwM1J7mRvwtCkk9eMFLdBg==
X-Received: by 2002:a17:902:d4c7:b0:19e:6760:305b with SMTP id o7-20020a170902d4c700b0019e6760305bmr4705364plg.47.1679709292101;
        Fri, 24 Mar 2023 18:54:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bf11-20020a170902b90b00b00194caf3e975sm2019425plb.208.2023.03.24.18.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 18:54:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 24 Mar 2023 15:54:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Message-ID: <ZB5UalkjGngcBDEJ@slm.duckdns.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com>
 <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Mar 24, 2023 at 12:22:09AM -0700, Yosry Ahmed wrote:
> I think a problem with this approach is that we risk having to contend
> for the global lock at every CPU boundary in atomic contexts. Right
> now we contend for the global lock once, and once we have it we go
> through all CPUs to flush, only having to contend with updates taking
> the percpu locks at this point. If we unconditionally release &
> reacquire the global lock at every CPU boundary then we may contend
> for it much more frequently with concurrent flushers.
> 
> On the memory controller side, concurrent flushers are already held
> back to avoid a thundering herd problem on the global rstat lock, but
> flushers from outside the memory controller can still compete together
> or with a flusher from the memory controller. In this case, we risk
> contending the global lock more and concurrent flushers taking a
> longer period of time, which may end up causing multi-CPU stalls
> anyway, right? Also, if we keep _irq when spinning for the lock, then
> concurrent flushers still need to spin with irq disabled -- another
> problem that this series tries to fix.
> 
> This is particularly a problem for flushers in atomic contexts. There
> is a flusher in mem_cgroup_wb_stats() that flushes while holding
> another spinlock, and a flusher in mem_cgroup_usage() that flushes
> with irqs disabled. If flushing takes a longer period of time due to
> repeated lock contention, it affects such atomic context negatively.
> 
> I am not sure how all of this matters in practice, it depends heavily
> on the workloads and the configuration like you mentioned. I am just
> pointing out the potential disadvantages of reacquiring the lock at
> every CPU boundary in atomic contexts.

So, I'm not too convinced by the arguments for a couple reasons:

* It's not very difficult to create conditions where a contented non-irq
  protected spinlock is held unnecessarily long due to heavy IRQ irq load on
  the holding CPU. This can easily extend the amount of time the lock is
  held by multiple times if not orders of magnitude. That is likely a
  significantly worse problem than the contention on the lock cacheline
  which will lead to a lot more gradual degradation.

* If concurrent flushing is an actual problem, we need and can implement a
  better solution. There's quite a bit of maneuvering room here given that
  the flushing operations are mostly idempotent in close time proximity and
  there's no real atomicity requirement across different segments of
  flushing operations.

Thanks.

-- 
tejun
