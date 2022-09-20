Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7BE5BDA49
	for <lists+cgroups@lfdr.de>; Tue, 20 Sep 2022 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiITClm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Sep 2022 22:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiITClh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Sep 2022 22:41:37 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53051405;
        Mon, 19 Sep 2022 19:41:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663641695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8CRGXcYJbg7e39VGUOoP0cvfANv2U6Hp6Ub75UWqSA=;
        b=ncELY/m2Pq+Ul9c9A06Wnwt6KrLq04OoRYfFX2fukI0jrRq8cokDk/JGwuncwPwuutyb5N
        7brzDS886ctW/mVWCfXMWGPfvw6TV6dU3hhz1+n5pVghA9EsC24JfUxVU0KUKHfPojZhS0
        84fBopquCieZPExOJ3OqXUilQDuATUE=
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] mm: memcontrol: use memcg_kmem_enabled in
 count_objcg_event
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220919180634.45958-2-ryncsn@gmail.com>
Date:   Tue, 20 Sep 2022 10:41:29 +0800
Cc:     cgroups@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F663F4D0-8F04-456D-B6CA-9C611FE04B63@linux.dev>
References: <20220919180634.45958-1-ryncsn@gmail.com>
 <20220919180634.45958-2-ryncsn@gmail.com>
To:     Kairui Song <kasong@tencent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Sep 20, 2022, at 02:06, Kairui Song <ryncsn@gmail.com> wrote:
> 
> From: Kairui Song <kasong@tencent.com>
> 
> There are currently two helpers for checking if cgroup kmem
> accounting is enabled:
> 
> - mem_cgroup_kmem_disabled
> - memcg_kmem_enabled
> 
> mem_cgroup_kmem_disabled is a simple helper that returns true
> if cgroup.memory=nokmem is specified, otherwise returns false.
> 
> memcg_kmem_enabled is a bit different, it returns true if
> cgroup.memory=nokmem is not specified and there was at least one
> non-root memory control enabled cgroup ever created. This help improve
> performance when kmem accounting was not actually activated. And it's
> optimized with static branch.
> 
> The usage of mem_cgroup_kmem_disabled is for sub-systems that need to
> preallocate data for kmem accounting since they could be initialized
> before kmem accounting is activated. But count_objcg_event doesn't
> need that, so using memcg_kmem_enabled is better here.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

