Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE16D1557
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 03:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCaBvk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCaBvj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 21:51:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D663C4;
        Thu, 30 Mar 2023 18:51:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7327637pjc.1;
        Thu, 30 Mar 2023 18:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680227498; x=1682819498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XM31ZrRumkictGFOXR0ExRhhRTlkDKTwiG7dCR1Fgc=;
        b=JBYKiS094xTcv4zZS7qtqmMLeJJI3CBby4kLAUuMziXHD4GQX8kl0rVXktvDBOeoyg
         kE039cqtRpT4ykTduffb4U40BvtNgW7zV0FAZz2WV0BqlSt5QYJpN8xupFHalEgYBWe2
         Mcsh414OYAuBY4FJEwUvve3aBfy2EszbwJEObj//xKUmnHYc/UwK6WW03t6iLjufAyn2
         ssTRNhrXIek059u92KiSZc+dkINIxwv0V3n+b0U3qPZgOYecnTJr8KDPd568UBe+Om+Y
         JRzenMRK0Ov48J93rRexsFGKtXgwJ4lg877M0D9vxz9Zn9cUrB6aoYizchAGUP6OU+k8
         mySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680227498; x=1682819498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XM31ZrRumkictGFOXR0ExRhhRTlkDKTwiG7dCR1Fgc=;
        b=Uu4kLQFVfW8/YOQHC61hjDkn8UFrpE091wKQ8D/5jl8vfA4afcDiJQwh1o007IN0Oj
         13Q0/7/kLaaVqpuUlRT1yka8IblIyILK7ooQiHGSSYCIO1MjkdWFq933Phi5ABpzzpSj
         bbwOXUYKPkIlg/8SHIWnhOsli5l/8gavcdvm1W+BrnT+fU5lABOxHVVRsZ/JkSugUJJj
         iWXNYxDazy0zl9VSkW2vnLbJEr4v7Dud2BlJzqN0l4bzepWBU4cyzmPt12yhesdygC0b
         rJ/gt9osChXO19nNEsGrfzVXXyr0YLdgTloFFdmUEGw79PalB+20xTRttiIHKp1UX8I6
         dGcw==
X-Gm-Message-State: AO0yUKWB8Ii21XFQ7+0jCC+/PAJCJ0uDtPzEUm3eZLkDDo+ag5E9uSxk
        za1SquZxFXX1L6kEPBJe8K8=
X-Google-Smtp-Source: AK7set+UsxaaL85PLpysrGl07KRn5Za7qkDJ8HMzgvL3jq6cxWJYGFqxj4m0ugsbcUIAh+0HWFj1QQ==
X-Received: by 2002:a05:6a20:b291:b0:ce:ca9:ab56 with SMTP id ei17-20020a056a20b29100b000ce0ca9ab56mr23322786pzb.34.1680227497775;
        Thu, 30 Mar 2023 18:51:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b00627ed4e23e0sm497016pfo.101.2023.03.30.18.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 18:51:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 30 Mar 2023 15:51:35 -1000
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
Message-ID: <ZCY8p/i6DR2tXPLP@slm.duckdns.org>
References: <ZB5UalkjGngcBDEJ@slm.duckdns.org>
 <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
 <CALvZod6rF0D21hcV7xnqD+oRkn=x5NLi5GOkPpyaPa859uDH+Q@mail.gmail.com>
 <CAJD7tkY_ESpMYMw72bsATpp6tPphv8qS6VbfEUjpKZW6vUqQSQ@mail.gmail.com>
 <CALvZod41ecuCKmuFBNtAjoKJjQgWYzoe4_B8zRK37HYk-rYDkA@mail.gmail.com>
 <CAJD7tkZrp=4zWvjE9_010TAG1T_crCbf9P64UzJABspgcrGPKg@mail.gmail.com>
 <ZCSJDpPPOVvBYfOy@slm.duckdns.org>
 <f9b6410-ee17-635f-a35d-559fa0191dc3@google.com>
 <ZCSY8l/jVwszF6iA@slm.duckdns.org>
 <98cb3ce-7ed9-3d17-9015-ef7193d6627@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98cb3ce-7ed9-3d17-9015-ef7193d6627@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Hugh.

On Wed, Mar 29, 2023 at 01:38:48PM -0700, Hugh Dickins wrote:
> > So, in general, there's a trade off between local irq service latency and
> > inducing global lock contention when using unprotected locks. With more and
> > more CPUs, the balance keeps shifting. The balance still very much depends
> > on the specifics of a given lock but yeah I think it's something we need to
> > be a lot more careful about now.
> 
> And this looks a very plausible argument to me: I'll let it sink in.

Another somewhat relevant change is that flipping irq on/off used to be
relatively expensive on older x86 cpus. I forget all details about when and
how much but they should be a lot cheaper now. No idea about !x86 cpus tho.

> But I hadn't heard that the RT folks were clamouring for more irq disabling:
> perhaps they partition their machines with more care, and are not devotees
> of high CPU counts.

I think RT folks care a lot more about raw IRQ disables. These shouldn't
actually disable IRQs on RT kernels.

Thanks.

-- 
tejun
