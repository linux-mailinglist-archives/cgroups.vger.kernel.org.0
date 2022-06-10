Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4817B546FDF
	for <lists+cgroups@lfdr.de>; Sat, 11 Jun 2022 01:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346996AbiFJXNo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 19:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343938AbiFJXNo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 19:13:44 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7611A25;
        Fri, 10 Jun 2022 16:13:42 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:13:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654902820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TrSEiM07rzBXOnvoC0Ky3MYG75s35r1Z3atOF4M4Vgo=;
        b=AMOxHK6N2JOosdOfl0+XPzd/eYTQapToCZY4I1JYebewZncs47nQy7E5QzcCHFfBbNnr1d
        ZZ43ny9GLnosRlHAAJIxP9VYN6T0mUCdJ2T5H+/4VrFnQApaZzyHxS7RtXV/3nGaJue2Wn
        YZOOFxIk562TyU5GacNnmu6acEjlYkk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 03/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <YqPQGrtp9v0Ly9SG@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-4-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 03:49:11PM +0800, Muchun Song wrote:
> Pagecache pages are charged at the allocation time and holding a
> reference to the original memory cgroup until being reclaimed.
> Depending on the memory pressure, specific patterns of the page
> sharing between different cgroups and the cgroup creation and
> destruction rates, a large number of dying memory cgroups can be
> pinned by pagecache pages. It makes the page reclaim less efficient
> and wastes memory.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.
> 
> We know that the LRU pages are not accounted at the root level. But
> the page->memcg_data points to the root_mem_cgroup. So the
> page->memcg_data of the LRU pages always points to a valid pointer.
> But the root_mem_cgroup dose not have an object cgroup. If we use
> obj_cgroup APIs to charge the LRU pages, we should set the
> page->memcg_data to a root object cgroup. So we also allocate an
> object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

LGTM

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
