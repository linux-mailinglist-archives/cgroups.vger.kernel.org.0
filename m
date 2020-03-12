Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87241837A4
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 18:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLRcy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 13:32:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33551 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgCLRcy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 13:32:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so8595087wrd.0
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 10:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CcUuUlC43ZZSpfh7MoEkxpHRz/YQaDQ0sa4yKp/08VA=;
        b=LB2RpnhyFSTH3hVgjWSNFLifh6wVwkygWTfWLNDnxQPIIBKr4BpapuRzF1lJYa0M15
         UbSB1s+QSe7P8Bx+GLZMQ+cV7gO4cfbRWGjeLOLvLCaijAjS6Lpr8ZOYSHWG8HOqN/hu
         kT1oLw9Sjvc/qjL4Kh04/aFvpCsvKUXlmqg/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CcUuUlC43ZZSpfh7MoEkxpHRz/YQaDQ0sa4yKp/08VA=;
        b=mgAXrzrcJ2KeUNtqsUhPRrb6GWCDrr9/QwO5tIykibxXMf9p74DD8rWIvtdXlSraw+
         Vh/ytjmbgp+JjV0clc962k1kYGUaARroEISI/b5TGSTFk70/6DkjZ+JnWDvean9QiXg2
         J7o6PhYOQiTtm+FGskKHbA4YRiBi6EVV5nhkn7CCtJeHJWjjfq3bDcPOAmz/ebMRPJit
         DVIsDcFYfat2GMJqFwFlKW+j0UwpPWYtRtHrIoBJ6LgH94s62+yEhpzc2nWsS6f3DOUi
         Nt57WH9UtlkWC8PVIp3aMrA9I0WXvPkmjrF7+vK30YirnZZyCx1Vg9Zf/N+FN0VY/8Al
         hDnA==
X-Gm-Message-State: ANhLgQ0anho5zyrq2+jm+OWn0FqHUhBDZRNMgcwPjH5CerE7EbGeDjyg
        D+2FkfG9QEzVYKHREyWXAKSviw==
X-Google-Smtp-Source: ADFU+vtgf9rQPYcJ7fNM8yiJe0orpohUFakZwlPq0AegakMNuqTr8+u5nhAj4dJIgtmv3wka95/7/g==
X-Received: by 2002:a05:6000:1008:: with SMTP id a8mr6809577wrx.8.1584034372767;
        Thu, 12 Mar 2020 10:32:52 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id z6sm20259371wru.15.2020.03.12.10.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:32:52 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:32:51 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/6] mm, memcg: Prevent memory.high load/store tearing
Message-ID: <2f66f7038ed1d4688e59de72b627ae0ea52efa83.1584034301.git.chris@chrisdown.name>
References: <cover.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A mem_cgroup's high attribute can be concurrently set at the same time
as we are trying to read it -- for example, if we are in
memory_high_write at the same time as we are trying to do high reclaim.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..d32d3c0a16d4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2228,7 +2228,7 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			 gfp_t gfp_mask)
 {
 	do {
-		if (page_counter_read(&memcg->memory) <= memcg->high)
+		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
@@ -2545,7 +2545,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * reclaim, the cost of mismatch is negligible.
 	 */
 	do {
-		if (page_counter_read(&memcg->memory) > memcg->high) {
+		if (page_counter_read(&memcg->memory) > READ_ONCE(memcg->high)) {
 			/* Don't bother a random interrupted task */
 			if (in_interrupt()) {
 				schedule_work(&memcg->high_work);
@@ -4257,7 +4257,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-		unsigned long ceiling = min(memcg->memory.max, memcg->high);
+		unsigned long ceiling = min(memcg->memory.max,
+					    READ_ONCE(memcg->high));
 		unsigned long used = page_counter_read(&memcg->memory);
 
 		*pheadroom = min(*pheadroom, ceiling - min(ceiling, used));
@@ -4978,7 +4979,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->high = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	if (parent) {
 		memcg->swappiness = mem_cgroup_swappiness(parent);
@@ -5131,7 +5132,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-	memcg->high = PAGE_COUNTER_MAX;
+	WRITE_ONCE(memcg->high, PAGE_COUNTER_MAX);
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -5947,7 +5948,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	memcg->high = high;
+	WRITE_ONCE(memcg->high, high);
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
-- 
2.25.1

