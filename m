Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B9D6CC9B2
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjC1Rxh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjC1Rxf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 13:53:35 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A5E1BF
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 10:53:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w9so53127267edc.3
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680026004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GBBAU6hZLECWp0UudInEHiiA2FkG0Dhl57EhHD71/2w=;
        b=WyJBv5Pqllid3pNI6/ikTPvxnNXwwYvm5BeSsZHlodYCQOrWeIKez1PCCxvY3x1D8c
         3+AZOlaWzwu1aKR+OAeUfaGWTxiIfflV7gGlohUIYiEqEskdjBV9QYa+PD/HDQeJZU3Y
         pFQhYKU+arSbJemfnq9SR0DQ6bDuZPsw4fp/k2p3LlpGJi35X785hbTi0EoGjexbJdKT
         /zo4sSXmA7NblVWxBBey8ZK0PCmLNdDA177py1CZsWHspE6EGmptD4//mQHui9cQkTEc
         kPDtXGZPdalt51dVpXNabobGHyskSSeC52qpMMTruKTKj6Vgxy77Pb7DYdWEsqx2UcyW
         ZVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680026004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBBAU6hZLECWp0UudInEHiiA2FkG0Dhl57EhHD71/2w=;
        b=F4MvazXmIhVFLsekG9yuDB7yjzZ6/RXoYjffVYNSLxNsIYJ6StDH8FjXkt08N9K+Uq
         u2derwSOlTx0MNfNGQeFB7BshjzG75ImkHkBlLg1BhMIxibWtn+zreZDBoF3WONtIRPR
         O3bwyGNK46zrZr+MPt2uuVbpx5azSnpRJiw34u1NAEB2DK8+hxpaJGoyBacj3RegmQK1
         xqefdrlnL0InegmrHIXrfruCI3W0b/ubrWGqgTJ7u9U6NeTLSSj4bp38YoaJvxyz1Qt3
         IF8D2hczcgtkeEYbEVUViogo7j3fQiUKmPp8DuG/z3IAMsK7zfm9M1sX/51YI98lGt7G
         +2RA==
X-Gm-Message-State: AAQBX9dKDip7+k1FfsVhqymJlUclnrOXV8xAIUHtky7bgc1mJCawaTYI
        Vd1jrQvet5Xj9yp6XEUozNPtpQ==
X-Google-Smtp-Source: AKy350ZpnwLB5iKCMGCbwwvWk9Vdlstn38oUzOZza2h97UWxvDmZVbQkVawtzBlghbIBM/+YOMAKfg==
X-Received: by 2002:a05:6402:716:b0:502:2494:b8fc with SMTP id w22-20020a056402071600b005022494b8fcmr15014577edx.7.1680026003884;
        Tue, 28 Mar 2023 10:53:23 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id t27-20020a50ab5b000000b004c0c5864cc5sm16157912edc.25.2023.03.28.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:53:23 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:53:22 -0400
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 5/9] memcg: replace stats_flush_lock with an atomic
Message-ID: <ZCMpklJZqwWHro0u@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-6-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-6-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:34AM +0000, Yosry Ahmed wrote:
> As Johannes notes in [1], stats_flush_lock is currently used to:
> (a) Protect updated to stats_flush_threshold.
> (b) Protect updates to flush_next_time.
> (c) Serializes calls to cgroup_rstat_flush() based on those ratelimits.
> 
> However:
> 
> 1. stats_flush_threshold is already an atomic
> 
> 2. flush_next_time is not atomic. The writer is locked, but the reader
>    is lockless. If the reader races with a flush, you could see this:
> 
>                                         if (time_after(jiffies, flush_next_time))
>         spin_trylock()
>         flush_next_time = now + delay
>         flush()
>         spin_unlock()
>                                         spin_trylock()
>                                         flush_next_time = now + delay
>                                         flush()
>                                         spin_unlock()
> 
>    which means we already can get flushes at a higher frequency than
>    FLUSH_TIME during races. But it isn't really a problem.
> 
>    The reader could also see garbled partial updates, so it needs at
>    least READ_ONCE and WRITE_ONCE protection.
> 
> 3. Serializing cgroup_rstat_flush() calls against the ratelimit
>    factors is currently broken because of the race in 2. But the race
>    is actually harmless, all we might get is the occasional earlier
>    flush. If there is no delta, the flush won't do much. And if there
>    is, the flush is justified.
> 
> So the lock can be removed all together. However, the lock also served
> the purpose of preventing a thundering herd problem for concurrent
> flushers, see [2]. Use an atomic instead to serve the purpose of
> unifying concurrent flushers.
> 
> [1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/
> [2]https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.com/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

With Shakeel's suggestion:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
