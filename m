Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B59360F51
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhDOPsF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 11:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhDOPsF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 11:48:05 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6D6C061574;
        Thu, 15 Apr 2021 08:47:40 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id er3so3392436qvb.6;
        Thu, 15 Apr 2021 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AoDRJbLhMyQN2f8H9fWTQ1c7bXpVm9d9RpwiX2eJiww=;
        b=jFxMl4vLIYgEpSsFOV8F7i3rw0jACscm7gLRIKbiEuAbWE6cjlPjmSkDy3RSDhymgc
         Mf3aIPkQgNSQkNsoUBiSu60LBVb+j8HeD5EGEylP2G1Mj88RGelW/CajdtkuRAPEfkdh
         b1PMRpJy8OvtXd56NpLVQQSYxbvehwATyTdFLpAIPJMEgsI3agh1t6pQznu3Bfkpd0rW
         3mjDu7+0mVhQcpyLAJQpDIaRLrfBcmY99jrBLcAS0qew2TyXueJLZdwgZvS1XBXP1E/+
         NmqNrPgAuyE/qyeC9gJeoO27v8xUHMBxkE8nuKxSPEOYd/5WNHTdc23ERpAI5PgLVONm
         GElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AoDRJbLhMyQN2f8H9fWTQ1c7bXpVm9d9RpwiX2eJiww=;
        b=HPfJRjCZjIFJLrFiXbzl6/Zh6PgS+ruzUPnxH+/j8wzwJZfOcRGLv3CHMP3qhztO7w
         qwqVkXXfu5BFeKrcNff/RzYjVela+GMSoak6D/yB6AU68ap7nCqTJC+xwNanisZ7OUy5
         cxOrQouGjtmvioFf5CYCpKixejPlHYywuX3Nf/O9ab2OlgpEUs9MfQT/5MFc96K2CCYN
         ZBZl0BF6AemH22AjjGutep3JXEHHAYoQNI4b6gKm2ki39FfbglM8rR8asM3hX6QEudHg
         JrJhzEsvLnKHm/dZLqLImxUVYsqKSPPVOPyvSDY941LZQ5Pg05OtWL9nfQWpMGGvn+Lc
         L8gw==
X-Gm-Message-State: AOAM53090pYEyynpoaELFjCRoVddS6E5cGG0T2M/mBEC/sxHZ08SlqI1
        fCAgBiTjJ7nFOM1M5OpigQ==
X-Google-Smtp-Source: ABdhPJzadBXtYG4nxpGRKGezUFM6iBFLYf9gyscWOakHrs8tSavr6EtXDHjn3yGuy0+TzjeUTGjx5g==
X-Received: by 2002:ad4:4052:: with SMTP id r18mr4097682qvp.8.1618501659858;
        Thu, 15 Apr 2021 08:47:39 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id t17sm1959248qtr.42.2021.04.15.08.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:47:39 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:36 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
Message-ID: <20210415154736.snzrxq625p5l4lz2@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210415032642.gfaevezaxoj4od3d@gabell>
 <12cba05a-e268-3a5d-69d7-feb00e36ef40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12cba05a-e268-3a5d-69d7-feb00e36ef40@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 15, 2021 at 09:17:37AM -0400, Waiman Long wrote:
> I was focusing on your kernel module benchmark in testing my patch. I will
> try out your pgbench benchmark to see if there can be other tuning that can
> be done.

Thanks a lot!

> BTW, how many numa nodes does your test machine? I did my testing with a
> 2-socket system. The vmstat caching part may be less effective on systems
> with more numa nodes. I will try to find a larger 4-socket systems for
> testing.

The test machine has one node.

- Masa
