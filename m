Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1607D222D53
	for <lists+cgroups@lfdr.de>; Thu, 16 Jul 2020 22:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgGPU6W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jul 2020 16:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPU6V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jul 2020 16:58:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942BDC061755
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 13:58:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so4405293ple.0
        for <cgroups@vger.kernel.org>; Thu, 16 Jul 2020 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kxhHxWSY/EeOqL085lgvyjHtFXlx52qCOAF6Jf9tnk4=;
        b=oxEJuMEpdGw4BUMJcxYEgG52h/uvb7q2mmajsxp33ECVDv3GOgvi1AVFXEpAj//Fpq
         mxgK5gWcuNSMrrqkY/4H1htStrel93Se8s+vHvOoLlIE0H6Ucwg4BTirbn/T4O5STI2s
         ksi8EDO3LCOpksdq8VmSI5mVG+c/1LUnz+ugQ9TdaVIyOm0meIlIE0gUQr0r3Phdq9b6
         aFRT+JongrkxKz591trMPY4tWkF/gA+xYJES3hjV4kjKzO26BY3QMeBzYCCj1grcmjt7
         ByObvgdoTAFoYdA6ySKBMFjGatz2BfUaHv126vgfldA6X8t1xtvKAJudJG/CwtoPxXv/
         RcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kxhHxWSY/EeOqL085lgvyjHtFXlx52qCOAF6Jf9tnk4=;
        b=hxtatGOvpGuLamIdk/o/JakqOl6Td4512um3oQxKnM/mjTNjNqjEEKIgCLSN6GRw/i
         y5HoeJ1aTA8c3OjKvf2G5S3EtrtzQDkAWit2Uk/46tp86+aO8gcVRnQvxgeOk8VAbUDJ
         W/N8eAeaYEzfTxzorqcxEP6bpDRNmsVOzvynx3Ur0U4zNzx883gSsBLEjyrfqX6NV1IU
         6vPK7ajkV+SCEDzsdaNe9DCB7bUrM1f48JkmsfiYXMimr+ZRyFp2lEZ+q3MbutAtjpiM
         /60UYadCbNzUeWmHrpdYDOkIgMpBPI3ArflNJOsAEW+g0ksRQU+J6Nzh8C5WYpV6r+vu
         7TXQ==
X-Gm-Message-State: AOAM532NKOqEsxIZUrE5mykXW5a2PEaGDq21JTl8jRg1rAjlx3Jqy6gg
        erj3u0nr/YwJWlTMeGFVnhSmKA==
X-Google-Smtp-Source: ABdhPJxpHKcKS3ne/oV23aUkXMDVK9WF6TJ5tR53ZnGc0j269hYsvMNOi4CwmA6CaKQI46d3PPIB1Q==
X-Received: by 2002:a17:902:c211:: with SMTP id 17mr4937449pll.302.1594933100849;
        Thu, 16 Jul 2020 13:58:20 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 19sm5584565pfy.193.2020.07.16.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 13:58:20 -0700 (PDT)
Date:   Thu, 16 Jul 2020 13:58:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, memcg: provide an anon_reclaimable stat
In-Reply-To: <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
References: <20200715071522.19663-1-sjpark@amazon.com> <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Userspace can lack insight into the amount of memory that can be reclaimed
from a memcg based on values from memory.stat.  Two specific examples:

 - Lazy freeable memory (MADV_FREE) that are clean anonymous pages on the
   inactive file LRU that can be quickly reclaimed under memory pressure
   but otherwise shows up as mapped anon in memory.stat, and

 - Memory on deferred split queues (thp) that are compound pages that can
   be split and uncharged from the memcg under memory pressure, but
   otherwise shows up as charged anon LRU memory in memory.stat.

Both of this anonymous usage is also charged to memory.current.

Userspace can currently derive this information but it depends on kernel
implementation details for how this memory is handled for the purposes of
reclaim (anon on inactive file LRU or unmapped anon on the LRU).

For the purposes of writing portable userspace code that does not need to
have insight into the kernel implementation for reclaimable memory, this
exports a stat that reveals the amount of anonymous memory that can be
reclaimed and uncharged from the memcg to start new applications.

As the kernel implementation evolves for memory that can be reclaimed
under memory pressure, this stat can be kept consistent.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +++++
 mm/memcontrol.c                         | 31 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1296,6 +1296,12 @@ PAGE_SIZE multiple when read back.
 		Amount of memory used in anonymous mappings backed by
 		transparent hugepages
 
+	  anon_reclaimable
+		The amount of charged anonymous memory that can be reclaimed
+		under memory pressure without swap.  This currently includes
+		lazy freeable memory (MADV_FREE) and compound pages that can be
+		split and uncharged.
+
 	  inactive_anon, active_anon, inactive_file, active_file, unevictable
 		Amount of memory, swap-backed and filesystem-backed,
 		on the internal memory management lists used by the
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 	return false;
 }
 
+/*
+ * Returns the amount of anon memory that is charged to the memcg that is
+ * reclaimable under memory pressure without swap, in pages.
+ */
+static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
+{
+	long deferred, lazyfree;
+
+	/*
+	 * Deferred pages are charged anonymous pages that are on the LRU but
+	 * are unmapped.  These compound pages are split under memory pressure.
+	 */
+	deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
+			       memcg_page_state(memcg, NR_INACTIVE_ANON) -
+			       memcg_page_state(memcg, NR_ANON_MAPPED), 0);
+	/*
+	 * Lazyfree pages are charged clean anonymous pages that are on the file
+	 * LRU and can be reclaimed under memory pressure.
+	 */
+	lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
+			       memcg_page_state(memcg, NR_INACTIVE_FILE) -
+			       memcg_page_state(memcg, NR_FILE_PAGES), 0);
+
+	return deferred + lazyfree;
+}
+
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
@@ -1363,6 +1389,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
 	 *
+	 * All values in this buffer are read individually, so no implied
+	 * consistency amongst them.
+	 *
 	 * This list is ordered following a combination of these gradients:
 	 * 1) generic big picture -> specifics and details
 	 * 2) reflecting userspace activity -> reflecting kernel heuristics
@@ -1405,6 +1434,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
 		       HPAGE_PMD_SIZE);
 #endif
+	seq_buf_printf(&s, "anon_reclaimable %llu\n",
+		       (u64)memcg_anon_reclaimable(memcg) * PAGE_SIZE);
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
 		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
