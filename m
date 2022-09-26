Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC265EA9F7
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 17:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiIZPO4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiIZPOR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 11:14:17 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A111EC52
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id c6so4323361qvn.6
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+6iJEmxp4bl9ohblP/ldB8IdtUPtHQigooDS1dl/Wc4=;
        b=etTRTh75O0L4i1MKIV2WPz590yQ569uvsT2rLsbPXxXGZXz2RBYFV5wchPr7zQK5tL
         oKGHX2usHRR86OnURr2MSY5OsLn+FPSGi0cWEjYbrBecrnPDlDdIsXtPuhTteUv6OR3a
         j1i0QT1+oNdpUtMM/f4xY4B9BSZJNunaqZhsqJn+WVGvKfDDTfgT/MCt1pQVZ+y3Ehma
         DketzHiCsnHYz+XZLjsvaxacOFveJcQ5rSZm/TZuvbXYyQtmkhekX4aNfwoyTdpAqF0J
         d0qnwZlfllTz+GnXoV8iFQtjUTzGkfeExjCA+2BCn5FZUQiquYNkxnmPLs4fEq73CRFc
         SvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+6iJEmxp4bl9ohblP/ldB8IdtUPtHQigooDS1dl/Wc4=;
        b=w4HU3cW0Bs8O9MlIiE90yT+LHuF/NJM77DiV/f4bYq7XAD2S7G7W4IaL02LZ6+g9Hc
         u866vxPvEmcV4z0GdO6UGHK2754EB+iVsLhVF+LLKWMMmI4QGHlsBhujbXXFwp0QuR9i
         R91Kwr+HAUY+yAuvZgJfiw6y/SLWM+pBPUU28O75ZakSZhEg74eLTUR81vb94QP/IUC6
         qwRQw8CFxs8WDaKn995iFZMkfgmVJc14l+/TRxCymTv0MM6LqKz9WL/hud+8Zu6WlhAx
         wW7dor0qga+JPLSFPg1zBh937qQZPzPu+X7chVDRyLj499D/ni9BQ6jxe67QTPy7EbBA
         W8KA==
X-Gm-Message-State: ACrzQf00jGjjamuRN6jmZlZp+/2DB/dZp8TgtWiL9LPPW22bSe5PsQMt
        h+BZDmgytNsiLeC+MO/WFAvEuJVnP1XS8Q==
X-Google-Smtp-Source: AMsMyM5bOx93hkMCNRDGZm4BGsvx4b//fZgec4uv6OS22XlPPvI7A2qmMP0JLkBjQPe7FgcA5u1bqQ==
X-Received: by 2002:a05:6214:27c6:b0:4ac:94f9:c727 with SMTP id ge6-20020a05621427c600b004ac94f9c727mr17339942qvb.51.1664200633825;
        Mon, 26 Sep 2022 06:57:13 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id h7-20020ac85047000000b0035d0520db17sm10745315qtm.49.2022.09.26.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:57:13 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: memcontrol: don't allocate cgroup swap arrays when memcg is disabled
Date:   Mon, 26 Sep 2022 09:57:01 -0400
Message-Id: <20220926135704.400818-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926135704.400818-1-hannes@cmpxchg.org>
References: <20220926135704.400818-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 2d1c498072de ("mm: memcontrol: make swap tracking an
integral part of memory control"), the cgroup swap arrays are used to
track memory ownership at the time of swap readahead and swapoff, even
if swap space *accounting* has been turned off by the user via
swapaccount=0 (which sets cgroup_memory_noswap).

However, the patch was overzealous: by simply dropping the
cgroup_memory_noswap conditionals in the swapon, swapoff and uncharge
path, it caused the cgroup arrays being allocated even when the memory
controller as a whole is disabled. This is a waste of that memory.

Restore mem_cgroup_disabled() checks, implied previously by
cgroup_memory_noswap, in the swapon, swapoff, and swap_entry_free
callbacks.

Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c  | 3 +++
 mm/swap_cgroup.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6b74bbdc2659..9e3c010ca676 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7459,6 +7459,9 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 5a9442979a18..db6c4a26cf59 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -170,6 +170,9 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
+	if (mem_cgroup_disabled())
+		return 0;
+
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
 
 	array = vcalloc(length, sizeof(void *));
@@ -204,6 +207,9 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
+	if (mem_cgroup_disabled())
+		return;
+
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl = &swap_cgroup_ctrl[type];
 	map = ctrl->map;
-- 
2.37.3

