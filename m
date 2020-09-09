Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EE1262555
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 04:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIICoo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 22:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIICon (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 22:44:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D9C061573;
        Tue,  8 Sep 2020 19:44:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m8so976523pgi.3;
        Tue, 08 Sep 2020 19:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ZdmUVaaik0Cd28h3Zbe2m43Ssgf1GR/sAhP0i4ZEkE=;
        b=AnELXMNtpHPPvFIglx8F3SVHWevil/Qj/z/vpbBRAvIn5Z+8QZvRRdtDrnet3+bsLM
         5mCLGxCFpyFhqz95Hx4U4HTvz5lQjzyhOuSdSEsfTMrNQimYLdlqYew1C5g66rd5/su2
         CNH0k30TqQpa5zqkDQirUnbrGnTL0LJeLOdkLsfi2Z7BI4YZu/TDAbvV38KLLXcrhNH6
         zfotW278dwua1xutDu6WQ4z4I55XsYNz9vIlb2ToKsKtYIXaTYjXBj6Dr7qzfXmWutZN
         ZY89N3EA5hpaqooLt1MKRRrIEkQhWYLwuREAdK6vuhA2hQvMXg+kaJBSOiAgPVm5ebo/
         hrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ZdmUVaaik0Cd28h3Zbe2m43Ssgf1GR/sAhP0i4ZEkE=;
        b=lgUfN4KK0n3awGsKwwYCRGSK7EgB2/HCL5KDe0Y/VbGLHdSuNn4kwULEnHrRC05B6K
         wK4B1vU7sDFXfKHa+yFBIbvU/qaRh7wjsUY7oQN8fB+bydxGWQcke4fBsr4YdCq4Gxgr
         RBJr4B141tzsqzjuidOy6mw+IhJsQLzRnQs4uOEaVHfZJ1PMq/gh0xFTgLObasKBCHoA
         sOSKsWaHwHFFo5z8CbBwqSyJe3MJOZHYKnuL5cRh8PGKl1Ql3VsaZUIrdqtjlaoyf0bR
         QCZC3IaM6c9+EOJOkpsQwc61fP8jIREfuB7+8ZUkilE43mHQrAdc/JBsdrn9qq85DWNm
         S1dQ==
X-Gm-Message-State: AOAM531aZVaRWKbnCyeUXsA+neHxGluxzFHIHEguM+XNygZ0lQhXjPTu
        Xo5Rjbv1qfQAYvm1TfujVdk=
X-Google-Smtp-Source: ABdhPJy4R6mz9uYwCQ+w3R9a2nnsXjsgw2amLudcvUNkXcUDKVv/IUKrWuLgI1C9iMeS6XgZAub9AQ==
X-Received: by 2002:a63:110c:: with SMTP id g12mr1261586pgl.91.1599619482359;
        Tue, 08 Sep 2020 19:44:42 -0700 (PDT)
Received: from desktop-ziqianlu ([47.89.83.67])
        by smtp.gmail.com with ESMTPSA id m190sm684741pfm.184.2020.09.08.19.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 19:44:41 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:44:32 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200909024432.GA9736@desktop-ziqianlu>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
 <20200826011946.spknwjt44d2szrdo@ca-dmjordan1.us.oracle.com>
 <01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com>
 <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 27, 2020 at 09:40:22PM -0400, Daniel Jordan wrote:
> I went back to your v1 post to see what motivated you originally, and you had
> some results from aim9 but nothing about where this reared its head in the
> first place.  How did you discover the bottleneck?  I'm just curious about how
> lru_lock hurts in practice.

I think making lru_lock per-memcg helps in colocated environment: some
workloads are of high priority while some workloads are of low priority.

For these low priority workloads, we may even want to use some swap for
it to save memory and this can cause frequent alloc/reclaim, depending
on its workingset etc. and these alloc/reclaim need to hold the global
lru lock and zone lock. And then when the high priority workloads do
page fault, their performance can be adversely affected and that is not
acceptible since these high priority workloads normally have strict SLA
requirement.
