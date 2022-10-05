Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB25F5846
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJEQaO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiJEQaM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 12:30:12 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D5E14D14
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 09:30:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f23so15831790plr.6
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIgSyoN94ADqU20gRcmOmyh9FdirVR3/a/n9qkAKtZM=;
        b=pJ841aP9R3YYjlZHcaKL4JqVDmnW1R6uCt2rV3ba70kepXv9mH8Oyq3he8OA52pVIc
         AKoD0jCdja0PT3R8DuX3PLkQ5yJ3Wbw+fQM1eOztB9+2PS6HhGG7Rok0CIaPbOxtqFoy
         qs+eHZMrAPb0R7SuoK5wD7yEPhMW7c/c5Wo3KMATlnL0jcxCVwezL1eN/JgacZud926T
         vN3bmZUfBdgYXOH+5ASAaa7nhO4k2oOTEnbtcu5YqhyKnWSJQnLJXdv3CdV978h69iyF
         T8EC84w1Vu7YLVN1BpDrhhHEcfR9xL+SMTNfASMjk7TCyz4psKsKYFOeFpgtn294FIkJ
         RCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIgSyoN94ADqU20gRcmOmyh9FdirVR3/a/n9qkAKtZM=;
        b=SQvRXOCRKAJM6MI5Q8G10Nuudet9Q6stC180Fpd/UorxVwtIJzt8aJNXh0Yh+3eNnq
         9fZx9PaaTgWltS+KV65VICOvYD2IeaDecuMZ0l77VuFIRWm1OkUfRKHnxaigVk9pCmxe
         gVVjmUgyglj2Mx7vU8IykBrrBa+YV3p+2dYv62hFbNooUJ7uNzIC040eMxWAht6Kbgob
         m1Au9XCgNAOAmvjZkwpoi9KRB7XblexBqDA0nRa+bJWhk9TwoOASfftblmwkJVDwYk0g
         KhCiRbfGWlHt4+M/Xog4nmmb3QAV1fg9F/KDilfkeNCtJxHlo/EY93wbqdSVg4weLhY5
         hImw==
X-Gm-Message-State: ACrzQf3NIMo3zosTb7uehxHthcuql1hVg5ab8GNXWIADy+659TEILEmc
        UhhxcFb50mth1mcRqry7/Io=
X-Google-Smtp-Source: AMsMyM4dZa2wFlO2eoUttBpzx40l+TSN4R3EXA/xgUAQygXzXxfhmBqeBLXW4BHo/49MKxyfo+FMJg==
X-Received: by 2002:a17:903:2691:b0:17a:8f3:bef0 with SMTP id jf17-20020a170903269100b0017a08f3bef0mr212119plb.17.1664987409070;
        Wed, 05 Oct 2022 09:30:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090a160900b001f319e9b9e5sm1332146pja.16.2022.10.05.09.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 09:30:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 5 Oct 2022 06:30:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [RFC] memcg rstat flushing optimization
Message-ID: <Yz2xDq0jo1WZNblz@slm.duckdns.org>
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
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

On Tue, Oct 04, 2022 at 06:17:40PM -0700, Yosry Ahmed wrote:
> We have recently ran into a hard lockup on a machine with hundreds of
> CPUs and thousands of memcgs during an rstat flush. There have also
> been some discussions during LPC between myself, Michal Koutný, and
> Shakeel about memcg rstat flushing optimization. This email is a
> follow up on that, discussing possible ideas to optimize memcg rstat
> flushing.
> 
> Currently, mem_cgroup_flush_stats() is the main interface to flush
> memcg stats. It has some internal optimizations that can skip a flush
> if there hasn't been significant updates in general. It always flushes
> the entire memcg hierarchy, and always invokes flushing using
> cgroup_rstat_flush_irqsafe(), which has interrupts disabled and does
> not sleep. As you can imagine, with a sufficiently large number of
> memcgs and cpus, a call to mem_cgroup_flush_stats() might be slow, or
> in an extreme case like the one we ran into, cause a hard lockup
> (despite periodically flushing every 4 seconds).

How long were the stalls? Given that rstats are usually flushed by its
consumers, flushing taking some time might be acceptable but what's really
problematic is that the whole thing is done with irq disabled. We can think
about other optimizations later too but I think the first thing to do is
making the flush code able to pause and resume. ie. flush in batches and
re-enable irq / resched between batches. We'd have to pay attention to
guaranteeing forward progress. It'd be ideal if we can structure iteration
in such a way that resuming doesn't end up nodes which got added after it
started flushing.

Thanks.

-- 
tejun
