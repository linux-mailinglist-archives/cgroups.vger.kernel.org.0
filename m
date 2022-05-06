Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E651DDB7
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbiEFQoE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 12:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiEFQoD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 12:44:03 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6426F6;
        Fri,  6 May 2022 09:40:18 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id j6so6270741qkp.9;
        Fri, 06 May 2022 09:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tFroZ33tNBSAN1tcZa2Cw4zWBMi2iBtFH4Bzz4YsosU=;
        b=1g3R79/JZIjzSixj9uXtVSHj9hn7aspX+hluZvudL5HjakKQICBACLpIo9dPrfUaB4
         KAFH6ONTbThZS1zKik09jYohsAPquNtsQeWLlRW8JQlgHq0eSa4Hdh/CAqvk9ZtD6/0A
         r/bihZePW50J33JLQqNjKe0b8UKw1QEWOdW+a732j33Qys0VsYlOlJFuwvt97rgopnpl
         nB4dD0++hXkWMiE4+teBFF2m9uQxiU7uWxO4v2Np3Q0wnmnRzoP9xnu7oh6+ka9KMOBn
         yIRUnJdsnDe1UTmBWnNcHMAo61Vlllp3EcT82NhQKOmHJ+0/9lP2nPmNsY13tuBv8cM9
         VrjA==
X-Gm-Message-State: AOAM5337DVXAMAHP5vohY5E/1sspSrMc1UXA5TjaHFD5VlUd/01rfctG
        CUr1goiQWbcmn3z4uuAPJfY=
X-Google-Smtp-Source: ABdhPJxyETxODGJra6xsGRAaLJvcj4Q8KJz+eh5+aO7lgt55G5ib6uq66idy09jNJJ0Ht6o/l8Hj+A==
X-Received: by 2002:a05:620a:4045:b0:69f:e555:3fdf with SMTP id i5-20020a05620a404500b0069fe5553fdfmr3016293qko.365.1651855217645;
        Fri, 06 May 2022 09:40:17 -0700 (PDT)
Received: from dev0025.ash9.facebook.com (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id o22-20020ac84296000000b002f39b99f6a0sm2717130qtl.58.2022.05.06.09.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 09:40:17 -0700 (PDT)
Date:   Fri, 6 May 2022 09:40:15 -0700
From:   David Vernet <void@manifault.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, tj@kernel.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, kernel-team@fb.com,
        Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v2 2/5] cgroup: Account for memory_recursiveprot in
 test_memcg_low()
Message-ID: <20220506164015.fsdsuv226nhllos5@dev0025.ash9.facebook.com>
References: <20220423155619.3669555-1-void@manifault.com>
 <20220423155619.3669555-3-void@manifault.com>
 <20220427140928.GD9823@blackbody.suse.cz>
 <20220429010333.5rt2jwpiumnbuapf@dev0025.ash9.facebook.com>
 <20220429092620.GA23621@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429092620.GA23621@blackbody.suse.cz>
User-Agent: NeoMutt/20211029
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry for the delayed reply, Michal. I've been at LSFMM this week.

On Fri, Apr 29, 2022 at 11:26:20AM +0200, Michal Koutný wrote:
> I still think that the behavior when there's no protection left for the
> memory.low == 0 child, there should be no memory.low events (not just
> uncounted but not happening) and test should not accept this (even
> though it's the current behavior).

That's fair. I think part of the problem here is that in general, the
memcontroller itself is quite heuristic, so it's tough to write tests that
provide useful coverage while also being sufficiently flexible to avoid
flakiness and over-prescribing expected behavior. In this case I think it's
probably correct that the memory.low == 0 child shouldn't inherit
protection from its parent under any circumstances due to its siblings
overcommitting the parent's protection, but I also wonder if it's really
necessary to enforce that. If you look at how much memory A/B/E gets at the
end of the reclaim, it's still far less than 1MB (though should it be 0?).
I'd be curious to hear what Johannes thinks.

> What might improve the test space would be to have two configs like
> 
> Original one (simplified here)
> 	parent		memory.low=50M	memory.current=100M
> 	` child1	memory.low=50M	memory.current=50M
> 	` child2	memory.low=0M	memory.current=50M
> 
> New one (checks events due to recursive protection)
> 	parent		memory.low=50M	memory.current=100M
> 	` child1	memory.low=40M	memory.current=50M
> 	` child2	memory.low=0M	memory.current=50M
> 
> The second config assigns recursive protection to child2 and should
> therefore cause memory.low events in child2 (with memory_recursiveprot
> enabled of course).

Something like this would work, though I think it's useful to specifically
validate the behavior of the memcontroller when the children overcommit the
parent's memory.low protection, which the current test does. So I'm
inclined to keep this testcase, and add your next suggestion:

> Or alternative new one (checks events due to recursive protection)
> 	parent		memory.low=50M	memory.current=100M
> 	` child1	memory.low=0M	memory.current=50M
> 	` child2	memory.low=0M	memory.current=50M

This definitely sounds to me like a useful testcase to add, and I'm happy
to do so in a follow-on patch. If we added this, do you think we need to
keep the check for memory.low events for the memory.low == 0 child in the
overcommit testcase? It arguably helped to catch the SWAP_CLUSTER_MAX
rounding issue you pointed out. Again, curious to hear what Johannes thinks
as well.

Thanks,
David
