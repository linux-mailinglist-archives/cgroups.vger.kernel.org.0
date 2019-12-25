Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABF12A632
	for <lists+cgroups@lfdr.de>; Wed, 25 Dec 2019 06:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfLYFhA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Dec 2019 00:37:00 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:60365 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfLYFhA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Dec 2019 00:37:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TlsqoyK_1577252212;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TlsqoyK_1577252212)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Dec 2019 13:36:57 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [RFC] memcg: Add swappiness to cgroup2
Date:   Wed, 25 Dec 2019 13:36:48 +0800
Message-Id: <1577252208-32419-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Even if cgroup2 has swap.max, swappiness is still a very useful config.
This commit add swappiness to cgroup2.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 mm/memcontrol.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74..e966396 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swappiness",
+		.read_u64 = mem_cgroup_swappiness_read,
+		.write_u64 = mem_cgroup_swappiness_write,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.7.4

