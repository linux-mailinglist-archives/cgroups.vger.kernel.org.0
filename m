Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B207C6C7521
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 02:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCXBjl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 21:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXBjj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 21:39:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220040C0;
        Thu, 23 Mar 2023 18:39:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id kc4so516512plb.10;
        Thu, 23 Mar 2023 18:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679621977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=diknpbDhmJOoggKEsWIo361E1xjQ+rSUkFKYJZdkY28=;
        b=gnLz9UYgts87Q3W2eAEqb/mHOi71mt9PGOMXo3NEdCjx7le5V/SdRfNH8QY4DX91PR
         mCvDShHmWN+U7wlmjHd9cNHfFqLwHTUB+uMCgGW9/AhNY0yULgXlcZ4Yr6gh/o4Q76pD
         cpevHL0IWLcIVZwFvShEgeRYVAOmSQ439XwAhpgltMNrVpWg6AP/2rmWh2ioK5uFVZu+
         5o1qQYTV+9U6tf8A347nKJPhMMsepQ9SGZRRmNplq7DNiyWcq7TmfeLRBH8sG0ZbzbPv
         0nPC1d127qZAyd2STxenO3kLgZbv3SE2IDCsan4ukhVtSm1eAZoY1dhs1c1XqtCOMOe9
         nA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679621977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diknpbDhmJOoggKEsWIo361E1xjQ+rSUkFKYJZdkY28=;
        b=erxmBPiCJRFwCG0Q87PgsIXkIPgTPUF+xEEKYBFlQjNz2RCG4ciOONux3B9bjtLleh
         xpWbORQ1cRwIaKc8/Yzx334kkh0U5xY8iXt5sKCxT+1FeHAvA2m5YHQ6eGAt9KLqhJFq
         /di/G5Xus09mWMMN3nfKsVa/HQitCIQChzTyvm80pqgjukphpV9fc+OY0gcwlsJ02jKE
         3eRfRgAo1eJN4ZgTsudmx0I7Ofy6tYOYjVGJ/P4ouBUc9ydltY/eHfNl9qwy0fsdXZE1
         /2FRb6xjwkYWXqOOetwEKxhFpcD0it+qDe/xVl2TFI9w2VttH9IJq0NTaQ/yBNtzmy75
         wqTg==
X-Gm-Message-State: AAQBX9eI4IIWZo8g03iTA/9vErNnsEDI1lGGsQxOA+oqt5rf+WA+Qt60
        rojynH84IrteAIGXJV+WZkQ=
X-Google-Smtp-Source: AKy350Z2/Lmf5xqmVragfODC9cX5JhU/nXhgivLUccuwhKWSqvt3QF7E94kIlv5aol/eYR0rE7fg+w==
X-Received: by 2002:a17:902:f546:b0:19c:be57:9c82 with SMTP id h6-20020a170902f54600b0019cbe579c82mr999628plf.65.1679621977225;
        Thu, 23 Mar 2023 18:39:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902728d00b001994fc55998sm12884105pll.217.2023.03.23.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 18:39:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Mar 2023 15:39:35 -1000
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
Message-ID: <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-2-yosryahmed@google.com>
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

On Thu, Mar 23, 2023 at 04:00:31AM +0000, Yosry Ahmed wrote:
> Currently, when sleeping is not allowed during rstat flushing, we hold
> the global rstat lock with interrupts disabled throughout the entire
> flush operation. Flushing in an O(# cgroups * # cpus) operation, and
> having interrupts disabled throughout is dangerous.
> 
> For some contexts, we may not want to sleep, but can be interrupted
> (e.g. while holding a spinlock or RCU read lock). As such, do not
> disable interrupts throughout rstat flushing, only when holding the
> percpu lock. This breaks down the O(# cgroups * # cpus) duration with
> interrupts disabled to a series of O(# cgroups) durations.
> 
> Furthermore, if a cpu spinning waiting for the global rstat lock, it
> doesn't need to spin with interrupts disabled anymore.

I'm generally not a fan of big spin locks w/o irq protection. They too often
become a source of unpredictable latency spikes. As you said, the global
rstat lock can be held for quite a while. Removing _irq makes irq latency
better on the CPU but on the other hand it makes a lot more likely that the
lock is gonna be held even longer, possibly significantly so depending on
the configuration and workload which will in turn stall other CPUs waiting
for the lock. Sure, irqs are being serviced quicker but if the cost is more
and longer !irq context multi-cpu stalls, what's the point?

I don't think there's anything which requires the global lock to be held
throughout the entire flushing sequence and irq needs to be disabled when
grabbing the percpu lock anyway, so why not just release the global lock on
CPU boundaries instead? We don't really lose anything significant that way.
The durations of irq disabled sections are still about the same as in the
currently proposed solution at O(# cgroups) and we avoid the risk of holding
the global lock for too long unexpectedly from getting hit repeatedly by
irqs while holding the global lock.

Thanks.

-- 
tejun
