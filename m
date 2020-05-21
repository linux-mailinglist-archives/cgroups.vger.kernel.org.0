Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF71DCDB1
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 15:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgEUNFg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 09:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgEUNFe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 09:05:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B3C061A0E
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 06:05:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id g9so6593697edr.8
        for <cgroups@vger.kernel.org>; Thu, 21 May 2020 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lIVlACF4LDO220gEGSvhc/aauhEeT3bDk/ER46APYDY=;
        b=lm15zqD7bQsCw4wiTNv6NzVw1jCgcLOsWTU1x6wfuW5NkSlsXD99ZPhpzoFHTLPOU8
         b29eUZlH28mu05WYQ2aUGv31+3wJp8CLc5ANp+8VlL/Yd5xKTarIVPKSxWu3uJWSpvsU
         I9xvM12xty15SeSsxedimd/k5ql9zjCbFIxvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lIVlACF4LDO220gEGSvhc/aauhEeT3bDk/ER46APYDY=;
        b=qtHeENEWtnsbHbWEkYKsAQhLu4qOft424tnG1I0An43E/76XeBhr6v19kfDZA7w4wE
         wXg/aYG6IkX8jLJh94A1GW6GBxcWwZNhqXHQ4yxhGfXd4/bx8utsnpTtpwRNeAF+QTRR
         XbatgxyEQASovqS63fLUACU208pCtTtqSY6UmJxeCWFUQ7v+uLrSw7CKhIuGGIIuWmsf
         lwK9YVS9MAz/CtBkDpk4vcfJ84gl2FC1PpLjcfndSI2ZcN9OgPNfMr2vxd+qDJliMZYU
         l+emI34ufFZtlwEHKCS9oFXoLO8y94oFSVA+AWxYimAsV0WSLMT64RVdXIDRrP/5beXR
         XJAA==
X-Gm-Message-State: AOAM530/rJMvxjQ1D+Cn8ODEKbA35Myv7bEwtB34sZcPSuh47uCXzyLA
        Ja7+fbuJaYhogIOVLErMl7SwuA==
X-Google-Smtp-Source: ABdhPJw3rAmdCOdWp+3NYJhOme20reqKS4bSnIvR84PMg8X2oYRibYSG/X+k07nw/mVqMFTIJed2HQ==
X-Received: by 2002:aa7:d1c6:: with SMTP id g6mr7728524edp.303.1590066331942;
        Thu, 21 May 2020 06:05:31 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id r1sm4850187ejz.59.2020.05.21.06.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:05:31 -0700 (PDT)
Date:   Thu, 21 May 2020 14:05:30 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521130530.GE990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521125759.GD990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Chris Down writes:
>>I believe I have asked in other email in this thread. Could you explain
>>why enforcint the requested target (memcg_nr_pages_over_high) is
>>insufficient for the problem you are dealing with? Because that would
>>make sense for large targets to me while it would keep relatively
>>reasonable semantic of the throttling - aka proportional to the memory
>>demand rather than the excess.
>
>memcg_nr_pages_over_high is related to the charge size. As such, if 
>you're way over memory.high as a result of transient reclaim failures, 
>but the majority of your charges are small, it's going to hard to make 
>meaningful progress:
>
>1. Most nr_pages will be MEMCG_CHARGE_BATCH, which is not enough to help;
>2. Large allocations will only get a single reclaim attempt to succeed.
>
>As such, in many cases we're either doomed to successfully reclaim a 
>paltry amount of pages, or fail to reclaim a lot of pages. Asking 
>try_to_free_pages() to deal with those huge allocations is generally 
>not reasonable, regardless of the specifics of why it doesn't work in 
>this case.

Oh, I somehow elided the "enforcing" part of your proposal. Still, there's no 
guarantee even if large allocations are reclaimed fully that we will end up 
going back below memory.high, because even a single other large allocation 
which fails to reclaim can knock us out of whack again.
