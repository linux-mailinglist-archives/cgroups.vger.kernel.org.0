Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABAB74A8AD
	for <lists+cgroups@lfdr.de>; Fri,  7 Jul 2023 03:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjGGB4G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jul 2023 21:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGGB4F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jul 2023 21:56:05 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 18:56:02 PDT
Received: from out-39.mta0.migadu.com (out-39.mta0.migadu.com [91.218.175.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7603919B7
        for <cgroups@vger.kernel.org>; Thu,  6 Jul 2023 18:56:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688694503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pp8ftPIqIMWudMuh7pf3FOr9N5RY8pAcKRI4zNvC1xk=;
        b=NAnGKJVhSLp4yv2kkSMp6ADs5X+O14sYJ3GsIbaqOhhGuEqWS8qfljYCRlUZlp9ICcdIYz
        5FxxKOSECYnAUDSrDCflNCisXuLUqXM51woWVHg9ky1pusXt5nfstpC1xnpzNla/MRsAEM
        pVfOzYEieXPnM9NljXB2CjqfStTa/c0=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memcg: remove definition of MEM_CGROUP_ID_MAX when
 !CONFIG_MEMCG
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230706112820.2393447-1-linmiaohe@huawei.com>
Date:   Fri, 7 Jul 2023 09:47:46 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Transfer-Encoding: 7bit
Message-Id: <892B507C-CFE8-4792-BA5F-3C698290A8EE@linux.dev>
References: <20230706112820.2393447-1-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Jul 6, 2023, at 19:28, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> MEM_CGROUP_ID_MAX is only used when CONFIG_MEMCG is configured. Remove
> unneeded !CONFIG_MEMCG variant.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

MEM_CGROUP_ID_MAX is also only used in mem_cgroup_alloc(), maybe you also
could move it from memcontrol.h to memcontrol.c. And define it as:

#define MEM_CGROUP_ID_MAX ((1U << MEM_CGROUP_ID_SHIFT) - 1)

I am not suggesting defining it as USHRT_MAX, because if someone changes
MEM_CGROUP_ID_SHIFT in the future, then MEM_CGROUP_ID_MAX will not updated
accordingly.

For this patch, LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

