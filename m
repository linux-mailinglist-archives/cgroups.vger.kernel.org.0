Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D286CF3F3
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 22:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjC2UBB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjC2UAz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 16:00:55 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D42697;
        Wed, 29 Mar 2023 13:00:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l7so15138324pjg.5;
        Wed, 29 Mar 2023 13:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680120052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwysfnQkAd80wlNyJ6XzThTPiLtn2B/tyA3fjQAFkXU=;
        b=VhGF9AnSesD95PbIw4HKQtmtguZMl7HEDnjXJr5VTDVRIevs+1HBUeQ5jfnJOor6Uk
         VGnu7EvlPqhvNxv8RZkHktwn+oBeH+Pnnf1g3tb+S0UFbD5H/EVLQ7WSVvtpCJlJD4qF
         7WQdVImaam9FqrqmDuRw2Sq3cKQbxxS8w6lkd/SzoMxPwFfREAwPn8bPp7a3XoFqAWFt
         Hd9WBZMtBQzMHWAZlCrnKrd5hwd48+xbCLXjnP7LePyuuo/yjboiAxWuCKIOggXKhNC+
         AAs/7O15Dtlcb5z865sBl3TbnMRLyLavIcjyeMqUHVcD8RPDq2PxXPvBzBprp/8JgpoG
         Fulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680120052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwysfnQkAd80wlNyJ6XzThTPiLtn2B/tyA3fjQAFkXU=;
        b=u8hBHtpYjVs47hCk+1LVfuJnuKsWOLcTNPUrAbIopRGXluDWKZKbGYuRQ0NyXPRTKG
         He21GhvuYcS5Dsjct0mKw0nlUGv59/eJ4E+yVwjwav0VR8zI8wZeIu6TKxqm0tPx3Ds3
         SpZcYCqjCDPCvrP0DIMdISdvQU3LjqHWWke+zQtU/vAMjhN3VU+2E6wo1cWoxNsRBd1K
         VbXlIuOTvUFkjKWLluX5WO+QGtShOfz2jOJtBk//7FYkkskoJxB+csbvQoM2VAd5M/uI
         owIoNkqhCXPeq0AwXXUjMzWe10Ku+nqR6e/Q0YmONJhwP3mjzfSZkLZfztGIOEwHEUgg
         N5ng==
X-Gm-Message-State: AO0yUKWjOOKMQoo0555W3wulzD9HEDKZRQeEXmJHh53Tc1xSzPYMIr8o
        JnFop5H8ZoP5AXP8QaoYs7Y=
X-Google-Smtp-Source: AK7set/hUGyEZjDACyGqVfdIw/bpUvUdmMhhbxm3aUkYiMQ4iG1YGdBAY5KP8EqrQQnHaA6jV87MwA==
X-Received: by 2002:a05:6a20:1321:b0:d4:fd7e:c8b0 with SMTP id g33-20020a056a20132100b000d4fd7ec8b0mr16282702pzh.7.1680120052315;
        Wed, 29 Mar 2023 13:00:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79117000000b005a8173829d5sm21406589pfh.66.2023.03.29.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 13:00:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 29 Mar 2023 10:00:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
Message-ID: <ZCSY8l/jVwszF6iA@slm.duckdns.org>
References: <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com>
 <ZB5UalkjGngcBDEJ@slm.duckdns.org>
 <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
 <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
 <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
 <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Hugh. How have you been?

On Wed, Mar 29, 2023 at 12:22:24PM -0700, Hugh Dickins wrote:
> Hi Tejun,
> Butting in here, I'm fascinated.  This is certainly not my area, I know
> nothing about rstat, but this is the first time I ever heard someone
> arguing for more disabling of interrupts rather than less.
> 
> An interrupt coming in while holding a contended resource can certainly
> add to latencies, that I accept of course.  But until now, I thought it
> was agreed best practice to disable irqs only regretfully, when strictly
> necessary.
> 
> If that has changed, I for one want to know about it.  How should we
> now judge which spinlocks should disable interrupts and which should not?
> Page table locks are currently my main interest - should those be changed?

For rstat, it's a simple case because the global lock here wraps around
per-cpu locks which have to be irq-safe, so the only difference we get
between making the global irq-unsafe and keeping it so but releasing
inbetween is:

 Global lock held: G
 IRQ disabled: I
 Percpu lock held: P
 
1. IRQ unsafe

 GGGGGGGGGGGGGGG~~GGGGG
 IIII IIII IIII ~~ IIII
 PPPP PPPP PPPP ~~ PPPP

2. IRQ safe released inbetween cpus

 GGGG GGGG GGGG ~~ GGGG
 IIII IIII IIII ~~ IIII
 PPPP PPPP PPPP ~~ PPPP

#2 seems like the obvious thing to do here given how the lock is used and
each P section may take a bit of time.

So, in the rstat case, the choice is, at least to me, obvious, but even for
more generic cases where the bulk of actual work isn't done w/ irq disabled,
I don't think the picture is as simple as "use the least protected variant
possible" anymore because the underlying hardware changed.

For an SMP kernel running on an UP system, "the least protected variant" is
the obvious choice to make because you don't lose anything by holding a
spinlock longer than necessary. However, as you increase the number of CPUs,
there rises a tradeoff between local irq servicing latency and global lock
contention.

Imagine a, say, 128 cpu system with a few cores servicing relatively high
frequency interrupts. Let's say there's a mildly hot lock. Usually, it shows
up in the system profile but only just. Let's say something happens and the
irq rate on those cores went up for some reason to the point where it
becomes a rather common occurrence when the lock is held on one of those
cpus, irqs are likely to intervene lengthening how long the lock is held,
sometimes, signficantly. Now because the lock is on average held for much
longer, it become a lot hotter as more CPUs would stall on it and depending
on luck or lack thereof these stalls can span many CPUs on the system for
quite a while. This is actually something we saw in production.

So, in general, there's a trade off between local irq service latency and
inducing global lock contention when using unprotected locks. With more and
more CPUs, the balance keeps shifting. The balance still very much depends
on the specifics of a given lock but yeah I think it's something we need to
be a lot more careful about now.

Thanks.

-- 
tejun
