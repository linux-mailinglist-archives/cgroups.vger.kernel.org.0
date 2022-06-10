Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA52546FC8
	for <lists+cgroups@lfdr.de>; Sat, 11 Jun 2022 01:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiFJXB7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 19:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiFJXB6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 19:01:58 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C931C2D58;
        Fri, 10 Jun 2022 16:01:57 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:01:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654902115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/6mUBgZNpbkGWs/QZgEhqh7EhqSsLFJVzEHebhLLQ4=;
        b=PnfPfdpvq7qb1g0zYrY/UVmlMtf6qD7NeI5CnBHO8P6J9B3BR5z5axnlGN+hN5BUmBlis9
        sI0zeOhSZqywW1ercqgEpcbAcoVS+g9Wqz8CJ4R5pLQI4UG5qqMMwzXBV049TfrMJAY14K
        rBUevuGY7TKG/zIg0hHGKtU5Lr7f9G4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 01/11] mm: memcontrol: remove dead code and comments
Message-ID: <YqPNXb8k3xFdfKVj@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-2-songmuchun@bytedance.com>
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

On Mon, May 30, 2022 at 03:49:09PM +0800, Muchun Song wrote:
> Since no-hierarchy mode is deprecated after
> 
>   commit bef8620cd8e0 ("mm: memcg: deprecate the non-hierarchical mode")
> 
> so parent_mem_cgroup() cannot return a NULL except root memcg, however, root
> memcg cannot be offline, so it is safe to drop the check of returned value
> of parent_mem_cgroup().  Remove those dead code.
> 
> The comments in memcg_offline_kmem() above memcg_reparent_list_lrus() are
> out of date since
> 
>   commit 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")
> 
> There is no ordering requirement between memcg_reparent_list_lrus() and
> memcg_reparent_objcgs(), so remove those outdated comments.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Nice cleanup!
