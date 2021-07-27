Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C233D6E2A
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbhG0Fea (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 01:34:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:40398 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235396AbhG0FeY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 01:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=QOm/SWMV/Asmk/Sj3wEkt1IsJkdhz+j421ZJ6yW2Ajw=; b=vhl1qmBiYUKwAvV9lqD
        QMCbVBT3bPeLgAL4tCas91WdXWvkx8RMGHbZGanOuOoWB/DMRrRYbWwE21/q7zDJWrSM7vkgzXmSg
        wLCaGgc1EwknLaQ4Aj+gMMQusELjTBdTXq1iOedLAbvyJt9TxSEm6VtWckDYHy7CqsJEh70TSBo=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8FjT-005LZi-RM; Tue, 27 Jul 2021 08:34:23 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 10/10] memcg: enable accounting for ldt_struct objects
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
Message-ID: <38010594-50fe-c06d-7cb0-d1f77ca422f3@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:34:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627362057.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each task can request own LDT and force the kernel to allocate up to
64Kb memory per-mm.

There are legitimate workloads with hundreds of processes and there
can be hundreds of workloads running on large machines.
The unaccounted memory can cause isolation issues between the workloads
particularly on highly utilized machines.

It makes sense to account for this objects to restrict the host's memory
consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/ldt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index aa15132..525876e 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -154,7 +154,7 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	if (num_entries > LDT_ENTRIES)
 		return NULL;
 
-	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL);
+	new_ldt = kmalloc(sizeof(struct ldt_struct), GFP_KERNEL_ACCOUNT);
 	if (!new_ldt)
 		return NULL;
 
@@ -168,9 +168,9 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	 * than PAGE_SIZE.
 	 */
 	if (alloc_size > PAGE_SIZE)
-		new_ldt->entries = vzalloc(alloc_size);
+		new_ldt->entries = __vmalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	else
-		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL);
+		new_ldt->entries = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
 
 	if (!new_ldt->entries) {
 		kfree(new_ldt);
-- 
1.8.3.1

