Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57550A805
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386670AbiDUS0U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377142AbiDUS0U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 14:26:20 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0849259;
        Thu, 21 Apr 2022 11:23:29 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650565408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIa5soDBi1Ey1JpoFC00xu4CdnKdTNoCVLlSrOEyJHA=;
        b=rLUW31KQXVqJ4gmKuv+FfgLV44BDnDfmsT9gI0IjdHUJ8PxJZGj3vmJahKFtDYEEynFS6S
        i0uh61AdEuViShIPzJ/AGUoHmWtd/O8zMr5ZUz7fW4KX03xsgB2bXufPWkzUjnM+wKB2h+
        NwA9+MdwN06miLtR2YvggqgIwkyXqJ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: make cgroup_memory_noswap static
Message-ID: <YmGhGsNIK+xEsfbR@carbon>
References: <20220421124736.62180-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421124736.62180-1-lujialin4@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 08:47:36PM +0800, Lu Jialin wrote:
> cgroup_memory_noswap is only used in mm/memcontrol.c, therefore just make
> it static, and remove export in include/linux/memcontrol.h
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
