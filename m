Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABADD199E80
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 21:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgCaTA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 15:00:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45881 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCaTAQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 15:00:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so27375380wrw.12
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2020 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9IrgvrpAHB9aS+VPQ8RyBpYcd3EPPgK7vjW1jH9p/4=;
        b=XlBIjLveJjou8vYvEmG/DJx7mb+4KKLdTK5ypO1SHhbzlYriS/T8ZXZE3Wa5KV193/
         Pt4nO+/WESvTu0W0j2wldBx99V2JUHDktLGmq1Mhw8wkFO2D0MY6EUQozw62SPqveQ1V
         D5ueKKEpdimT6w62FPk6JmNFP6h3CdsZSqftE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9IrgvrpAHB9aS+VPQ8RyBpYcd3EPPgK7vjW1jH9p/4=;
        b=i2DZM79mW7chrixJ1neL8nZPBXncJ1hIDZof79Sf3SmhUB523Q/X6pw37/d+Y3ens3
         hi71MSQ6bMX5Pn2kHgSyV2VwGZ53dblbOJfK8fHohoRpFm282gZGglVQENJAXh+pG3V4
         pQ0t9tPG4mYQmaHlml4mhnqtOmsYpzpVvT37LRXl0r9PX0pA+/MIhQhuOS+IytAaCtpK
         1gTXRiToxcqhAU8t9fwQLaJaluUGtz7Ie+oOlyyD1onnTi4bHBRxO1la134fzBY6dGjf
         A9Y3ZWAgoRT8l8oH+jNHPNzwyhpmXWn3gpVFqSxB1AvwGEkx7LjO3VxubHaS71ULkyJK
         SjJQ==
X-Gm-Message-State: ANhLgQ2jWI2hanN50M4yvKoDdFgBcS2K+5RIeKjWU8+hHeAY6asg7RzE
        AwDbqd32vqk7ITaq2kk2mVK/JQ==
X-Google-Smtp-Source: ADFU+vtetMwU3V29SeqsQ+M7amRpcn8G+/5XH6Mdx9niPX2FZYtRZ1RncB5huWjEgJ+5w7spOeGFGg==
X-Received: by 2002:a5d:4146:: with SMTP id c6mr21051315wrq.181.1585681214980;
        Tue, 31 Mar 2020 12:00:14 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id k9sm29062108wrd.74.2020.03.31.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:14 -0700 (PDT)
Date:   Tue, 31 Mar 2020 20:00:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331190013.GC972283@chrisdown.name>
References: <20200331152424.GA1019937@chrisdown.name>
 <20200331155752.GN30449@dhcp22.suse.cz>
 <20200331170410.GB972283@chrisdown.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20200331170410.GB972283@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Chris Down writes:
>Michal Hocko writes:
>>I find this paragraph rather confusing. This is essentially an unsigned
>>underflow when any of the memcg up the hierarchy is below the high
>>limit, right?  There doesn't really seem anything complex in such a
>>hierarchy.
>
>The conditions to trigger the bug itself are easy, but having it 
>obviously visible in tests requires a moderately complex hierarchy, 
>since in the basic case ancestor_usage is "similar enough" to the test 
>leaf cgroup's usage.

Here is another reason why this wasn't caught -- division usually renders the 
overage 0 anyway with such a large input.

With the attached patch applied before this fix, you can see that usually 
division results in an overage of 0, so the result is the same. Here's an 
example where pid 213 is a cgroup in system.slice/foo.service hitting its own 
memory.high, and system.slice has no memory.high configuresd:

	[root@ktst ~]# cat /sys/kernel/debug/tracing/trace
	# tracer: nop
	#
	# entries-in-buffer/entries-written: 33/33   #P:4
	#
	#                              _-----=> irqs-off
	#                             / _----=> need-resched
	#                            | / _---=> hardirq/softirq
	#                            || / _--=> preempt-depth
	#                            ||| /     delay
	#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
	#              | |       |   ||||       |         |
		(bash)-213   [002] .N..    58.873988: mem_cgroup_handle_over_high: usage: 32, high: 1
		(bash)-213   [002] .N..    58.873993: mem_cgroup_handle_over_high: 1 overage before shifting (31)
		(bash)-213   [002] .N..    58.873994: mem_cgroup_handle_over_high: 1 overage after shifting (32505856)
		(bash)-213   [002] .N..    58.873995: mem_cgroup_handle_over_high: 1 overage after div (32505856)
		(bash)-213   [002] .N..    58.873996: mem_cgroup_handle_over_high: 1 cgroup new overage (32505856)
		(bash)-213   [002] .N..    58.873998: mem_cgroup_handle_over_high: usage: 18641, high: 2251799813685247
		(bash)-213   [002] .N..    58.873998: mem_cgroup_handle_over_high: 2 overage before shifting (18444492273895885010)
		(bash)-213   [002] .N..    58.873999: mem_cgroup_handle_over_high: 2 overage after shifting (19547553792)
		(bash)-213   [002] .N..    58.874000: mem_cgroup_handle_over_high: 2 overage after div (0)
		(bash)-213   [002] .N..    58.874001: mem_cgroup_handle_over_high: 2 cgroup too low (0)
		(bash)-213   [002] .N..    58.874002: mem_cgroup_handle_over_high: Used 1 from leaf to get result

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-temp.patch"

From df96928bc8d482d8b26c277c4ca0b075783c7aed Mon Sep 17 00:00:00 2001
From: Chris Down <chris@chrisdown.name>
Date: Tue, 31 Mar 2020 19:16:23 +0100
Subject: [PATCH] temp

---
 mm/memcontrol.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eecf003b0c56..c33e317c3667 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2328,11 +2328,14 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 {
 	unsigned long penalty_jiffies;
 	u64 max_overage = 0;
+	int i = 0, i_overage = 0;
 
 	do {
 		unsigned long usage, high;
 		u64 overage;
 
+		i++;
+
 		usage = page_counter_read(&memcg->memory);
 		high = READ_ONCE(memcg->high);
 
@@ -2342,18 +2345,29 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 		 */
 		high = max(high, 1UL);
 
+		trace_printk("usage: %lu, high: %lu\n", usage, high);
 		overage = usage - high;
+		trace_printk("%d overage before shifting (%llu)\n", i, overage);
 		overage <<= MEMCG_DELAY_PRECISION_SHIFT;
+		trace_printk("%d overage after shifting (%llu)\n", i, overage);
 		overage = div64_u64(overage, high);
+		trace_printk("%d overage after div (%llu)\n", i, overage);
 
-		if (overage > max_overage)
+		if (overage > max_overage) {
+			trace_printk("%d cgroup new overage (%llu)\n", i, overage);
+			i_overage = i;
 			max_overage = overage;
+		} else {
+			trace_printk("%d cgroup too low (%llu)\n", i, overage);
+		}
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
 
 	if (!max_overage)
 		return 0;
 
+	trace_printk("Used %d from leaf to get result\n", i_overage);
+
 	/*
 	 * We use overage compared to memory.high to calculate the number of
 	 * jiffies to sleep (penalty_jiffies). Ideally this value should be
-- 
2.26.0


--T4sUOijqQbZv57TR--
