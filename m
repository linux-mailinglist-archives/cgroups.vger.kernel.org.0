Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4D659617B
	for <lists+cgroups@lfdr.de>; Tue, 16 Aug 2022 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiHPRw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Aug 2022 13:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiHPRwz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Aug 2022 13:52:55 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE28276B;
        Tue, 16 Aug 2022 10:52:54 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w14so9869897plp.9;
        Tue, 16 Aug 2022 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=eQ2NahsvhVwzDF3w07e6eihKRt+nAgyrGOVPsy4ALjQ=;
        b=btGDKJUPdlCBMrCw0W7r+qRR0ygNQM+t19v7X/E8232ZCf5d1iJ5myUaogZDT0bQ+r
         P5HD4RaRb+zs7sWXrIcFBQgiYQhl6Bs2UEdFxTX+cFRiu0qaH2dYUfWBHTXgbym5bfRB
         SslXBcZNrxU0Ff9BRXgujiqqE48oYo2NT3XmBYEnPWfBl8Fcgl+WJkFxK0Iv8L+CSD4P
         18THZJfa0IDp2ZfwOX1m7OoctLlK1IG2qEjwVhqxtefmHCkjDAW71MdQO70B2pHpqI5A
         9989hu8AEup2dHvUaz2KIjm2pi5wAFxPdjK66SV6P6+d6KAcGKs9VUrYlOL+tzoZo8RC
         bOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=eQ2NahsvhVwzDF3w07e6eihKRt+nAgyrGOVPsy4ALjQ=;
        b=lJINZVF5n5vdDnjq0XnU6+0oi6geT4dOKY9XVEp1vIl0pHMM8256qCDwOd/GnGVcv3
         hhbM+q2+68YYBSYq3JZz2fZS3OEAYp+d1xLpnDYZ1bQKDG3E9gX83YQL8GFvL8c9DP9J
         8Li+5xo7wN0SU192TIZGLK1O6qYGAmogNvvnSEHTA1+IvUaF7roA8FFF6wuUVL9szhei
         tmPNWv4f+BlxbbUOrzoFjmtvruJZjWm7qKAsbtzSr1DIgl4fiIk2jdPNelRxihgAl+0u
         zI/kJFUUscbckZuLo8FZNYHSYHiSzIDLJ/+OnYOyZKHmTWuuwmjxSwPvUcFaOeS7E8wP
         2HZQ==
X-Gm-Message-State: ACgBeo3cwMTFO45cbgHBQLMefa/YfrW5yf5ttbdDjl6LkqSz2VJHKB5K
        gEvkMdM+5pyZTW8QDB+03mM=
X-Google-Smtp-Source: AA6agR6suTxg0+380p9y19bYi3P4d4Cc09btoXZfIQnGg/9fGAdD/xAXirdyO5Gpq83J5m5fAWY/ZQ==
X-Received: by 2002:a17:90b:350e:b0:1f5:1c63:b563 with SMTP id ls14-20020a17090b350e00b001f51c63b563mr25357476pjb.24.1660672373573;
        Tue, 16 Aug 2022 10:52:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id ix15-20020a170902f80f00b00171311470eesm9369665plb.8.2022.08.16.10.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:52:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 07:52:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/3] cgroup/cpuset: Keep user set cpus affinity
Message-ID: <YvvZc7KgZT/bRoKl@slm.duckdns.org>
References: <20220816151119.29534-1-longman@redhat.com>
 <20220816151119.29534-4-longman@redhat.com>
 <YvvR2Sa6LxZLwXsJ@slm.duckdns.org>
 <349849aa-937d-8b08-a836-7c5c70168139@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349849aa-937d-8b08-a836-7c5c70168139@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 16, 2022 at 01:38:17PM -0400, Waiman Long wrote:
> Yes, a race like this is possible. To completely eliminate the race may
> require taking task_rq_lock() and then calling
> __set_cpus_allowed_ptr_locked() which is internal to kernel/sched/core.c.
> 
> Alternatively, we can check user_cpus_ptr again after the scond
> set_cpus_allowed_ptr() and retry it with the other path if set. That will
> probably address your concern. Please let me know if you are OK with that.

I think this would look better if structured the other way around - make the
scheduler side call out to cpuset to query the current restrictions and
apply it atomically.

Thanks.

-- 
tejun
