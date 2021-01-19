Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8169C2FB131
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 07:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbhASGLg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 01:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731658AbhASFep (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 00:34:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B37C061575
        for <cgroups@vger.kernel.org>; Mon, 18 Jan 2021 21:34:04 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n7so12339842pgg.2
        for <cgroups@vger.kernel.org>; Mon, 18 Jan 2021 21:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEEMV7863xltVpOu5dQdeBuAa/L7iHBBzSh9lFg+Kn0=;
        b=mwxZeLnxMtuvQXXMcMBQsTFESo6aiXFL43N5Ft8TdGjcyIu/StwJ3A3lW8hC+9BQfm
         qvqCffOW80GeEY4cGwo2tkrrFTWeUL3471eOzgweQvi1pLYkHqYIw1ICBBoJ77i3jVBZ
         Y9imH6F6215IdJ6eJgOvOjf0v4joL8ol/PWEPUpDHU1EMw5m3P1mXe+gKRjv8jg31GJo
         gW2wp/txsbZbS9BHBsT4bTflX5ir+ZFxBI72wyDTaGq8ZJsyjM55zz2pmiDzcvOaYth2
         0mEjuA23VeUwUlK5j333DwpSRHDhln8Hqjo7pln6+GZxOsvZO+eMuBOG61a0N6FOygNj
         BqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEEMV7863xltVpOu5dQdeBuAa/L7iHBBzSh9lFg+Kn0=;
        b=RaqyVm/MTDXGUyz5iEFBL0ZYXmMRatB/qPMTNrFgyD5wrw1IXK6QlsCLyyvnhjMuO+
         GZdh7RPNP8PN7gz3EKLeg+wGm7VM48RZMklvXgfuUncyxpZqekgJFc1Xy8QnlOjTcLun
         pKj9naEvrmNUoMIi7r6//MdITN4RBRplvHwGE/iXvin8WXYkRFpqSoPMNuN475dlHMBV
         7r9gxdgZa7AuMbRJoxEQRtCEyN4wqZlEj4C8JPobuljwDFSYYJtDxWQSqbGDbDomdgR4
         OZH+C1WjrEPqFbJNGpMJTk3hJNtDPFDuewdDq6yg/KhkkyJEf56VzUaAC2r1XHvT9eVR
         RVQg==
X-Gm-Message-State: AOAM532Oo3LoFPLbGx3uVWfKt3UI9kAEu+uXlrZTtaVbf6AkYNZrcVB1
        h+9CMs4jw3CvTkOg15SMxlpJ9A==
X-Google-Smtp-Source: ABdhPJz9yUYJS3K8GJIRHJtp+tSiIfEl1ITZVDGbqtywXleCleCvjD7QQffAm6mPSgO+5Jn9Cafdyg==
X-Received: by 2002:a65:5882:: with SMTP id d2mr2917346pgu.323.1611034443734;
        Mon, 18 Jan 2021 21:34:03 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id a18sm17425822pfg.107.2021.01.18.21.34.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 21:34:03 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: skip propagate percpu vmstat values to current memcg
Date:   Tue, 19 Jan 2021 13:27:44 +0800
Message-Id: <20210119052744.96765-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current memcg will be freed soon, so updating it's vmstat and
vmevent values is pointless. Just skip updating it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c0a90767e264..597fbe9acf93 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3700,7 +3700,7 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
 		for (i = 0; i < MEMCG_NR_STAT; i++)
 			stat[i] += per_cpu(memcg->vmstats_percpu->stat[i], cpu);
 
-	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
+	for (mi = parent_mem_cgroup(memcg); mi; mi = parent_mem_cgroup(mi))
 		for (i = 0; i < MEMCG_NR_STAT; i++)
 			atomic_long_add(stat[i], &mi->vmstats[i]);
 
@@ -3716,7 +3716,8 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
 				stat[i] += per_cpu(
 					pn->lruvec_stat_cpu->count[i], cpu);
 
-		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
+		for (pi = parent_nodeinfo(pn, node); pi;
+		     pi = parent_nodeinfo(pi, node))
 			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
 				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
 	}
@@ -3736,7 +3737,7 @@ static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
 			events[i] += per_cpu(memcg->vmstats_percpu->events[i],
 					     cpu);
 
-	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
+	for (mi = parent_mem_cgroup(memcg); mi; mi = parent_mem_cgroup(mi))
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
 			atomic_long_add(events[i], &mi->vmevents[i]);
 }
-- 
2.11.0

