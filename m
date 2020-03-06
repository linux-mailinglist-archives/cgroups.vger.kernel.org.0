Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4478B17B5C6
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2020 05:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCFElL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 23:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgCFElL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 5 Mar 2020 23:41:11 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C832072D;
        Fri,  6 Mar 2020 04:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583469670;
        bh=jMaNzWwGNyJXrXRBCiJpddGoeLBF0dNI2ZOpUjqJRJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mGdiXoYeYvFstIQEK7caAUrHjH8h4/xKtNznaLuGjgXgOFKJjYQw11NyqgTvnY4/M
         sU4aRm7gnUt4at7lCieJSD8xlulHfvn+rD51LaJwEQWd5XjtV4rrtX+TQA7R24EV2o
         Gz7apFZYMLJ5s7t0ZDiIIkveSU4NKvblbLuQXVFM=
Date:   Thu, 5 Mar 2020 20:41:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: optimize memory.numa_stat like memory.stat
Message-Id: <20200305204109.be23f5053e2368d3b8ccaa06@linux-foundation.org>
In-Reply-To: <20200304022058.248270-1-shakeelb@google.com>
References: <20200304022058.248270-1-shakeelb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue,  3 Mar 2020 18:20:58 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> Currently reading memory.numa_stat traverses the underlying memcg tree
> multiple times to accumulate the stats to present the hierarchical view
> of the memcg tree. However the kernel already maintains the hierarchical
> view of the stats and use it in memory.stat. Just use the same mechanism
> in memory.numa_stat as well.
> 
> I ran a simple benchmark which reads root_mem_cgroup's memory.numa_stat
> file in the presense of 10000 memcgs. The results are:
> 
> Without the patch:
> $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> 
> real    0m0.700s
> user    0m0.001s
> sys     0m0.697s
> 
> With the patch:
> $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> 
> real    0m0.001s
> user    0m0.001s
> sys     0m0.000s
> 

Can't you do better than that ;)

>
> +	page_state = tree ? lruvec_page_state : lruvec_page_state_local;
> ...
>
> +	page_state = tree ? memcg_page_state : memcg_page_state_local;
>

All four of these functions are inlined.  Taking their address in this
fashion will force the compiler to generate out-of-line copies.

If we do it the uglier-and-maybe-a-bit-slower way:

--- a/mm/memcontrol.c~memcg-optimize-memorynuma_stat-like-memorystat-fix
+++ a/mm/memcontrol.c
@@ -3658,17 +3658,16 @@ static unsigned long mem_cgroup_node_nr_
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 	unsigned long nr = 0;
 	enum lru_list lru;
-	unsigned long (*page_state)(struct lruvec *lruvec,
-				    enum node_stat_item idx);
 
 	VM_BUG_ON((unsigned)nid >= nr_node_ids);
 
-	page_state = tree ? lruvec_page_state : lruvec_page_state_local;
-
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += page_state(lruvec, NR_LRU_BASE + lru);
+		if (tree)
+			nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
+		else
+			nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
 	}
 	return nr;
 }
@@ -3679,14 +3678,14 @@ static unsigned long mem_cgroup_nr_lru_p
 {
 	unsigned long nr = 0;
 	enum lru_list lru;
-	unsigned long (*page_state)(struct mem_cgroup *memcg, int idx);
-
-	page_state = tree ? memcg_page_state : memcg_page_state_local;
 
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += page_state(memcg, NR_LRU_BASE + lru);
+		if (tree)
+			nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
+		else
+			nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
 	}
 	return nr;
 }

Then we get:

                     text    data     bss     dec     hex filename
now:               106705   35641    1024  143370   2300a mm/memcontrol.o
shakeel:           107111   35657    1024  143792   231b0 mm/memcontrol.o
shakeel+the-above: 106805   35657    1024  143486   2307e mm/memcontrol.o

Which do we prefer?  The 100-byte patch or the 406-byte patch?
