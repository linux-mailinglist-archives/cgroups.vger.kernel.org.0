Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C042B391CDD
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhEZQUc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhEZQUb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4FC061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:19:00 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 27so1370816pgy.3
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pl6dvHU30PgX6inAcxI6IEegFN0mmkGWsJaYSmJnWfo=;
        b=H1iSHg/ma1Xsf1EM6/6EaiMPq6PgnGV3dfuWqsO/+rxQm+dS7MOO88auKUH80uZjma
         x0EDL0h0MjNBsI9h4evzDOmlTCpQbB2H+wOdUWCekdgmqM3TAP9pins9czC5lqXkh9TM
         SNglB/DSaOsTplFXR9SBXOrfY09JkU10llOSYtUcruCe7EdpHkRPSD3BrKO2VIAL/oaq
         P6DZshctJHsEbi5PH/LpozNSV2lwAkMBnkxONPa4rgYKb7NcP4LHVzEQRvIjCuT5thux
         bHCruQgQtP+6a+5UGRdp4qsR5j1wRZ1+UOrfYu3HG2d4G3xRF51UtzX+xAh3GzvmpCP5
         OKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pl6dvHU30PgX6inAcxI6IEegFN0mmkGWsJaYSmJnWfo=;
        b=CAQiQNhCKXextmWbythlxmqmfgYEC0MT25Djuf5AbnaC53L9EQtlWjrywr11l2NHYa
         aJTBFFsUPt3rqNlbyO858Yiu4r54xIVygKx4x1OkWS1Rwh8hJZpSyyadrM5WUvUjcM8P
         JaBxzTmgv1MCF8onSQjkMny/y8V60zZ+ldDI0lrJGD6R/tWMIGewrrm+i9DgR1C8qDh6
         T46FX77VOQ0BsxC6ZA2W0eiLNPckX5nv7TP4i3y+FmXS1+oMKIJM7SvpjXN4hUtbj4A0
         NTZBVL9XhnvE35md4VN7AOqJJAQWKIeFrOL/UJJFJuwbRx4Ze0rUwURJY22xC8kYCtjt
         XS/g==
X-Gm-Message-State: AOAM532YsPQdPXaBU66Zby6OwQlK3jwOigWOl8Km+SgAwO3mF5APQqq3
        6RHjD9Oc9j+ewX5skoZtoyw=
X-Google-Smtp-Source: ABdhPJygB4J7JzYL6dO0fhbXJrJkH7YUKEmHtxkRu8lgKj13yWlrFTeYCl6dXysBcuYMK6Oh5gYCiA==
X-Received: by 2002:aa7:9f95:0:b029:2dc:99b9:8e66 with SMTP id z21-20020aa79f950000b02902dc99b98e66mr36799238pfr.30.1622045939919;
        Wed, 26 May 2021 09:18:59 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:59 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: [RFC 7/7] mm: introduce mst low and min watermark
Date:   Thu, 27 May 2021 00:18:04 +0800
Message-Id: <8bcece04ee8ac9a065ad7603fc07a097c69a1278.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Memory allocation speed throttle aims to avoid direct reclaim caused
by memory usage burst, which mostly happens under memory pressure.
As unconditional throttling could introduce unnecessary overhead, we add
two watermarks to control the throttling.

When mst low wmark reached, we start to throttle memory speed if it is
overspeed. And if mst min wmark reached, we do throttling directly everytime
charging without checking the memory allocation speed.

Signed-off-by: Jiang Biao <benbjiang@gmail.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 59e6cb78a07a..011d1426a924 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -241,6 +241,12 @@ struct mem_spd_ctl {
 	atomic_t updating;
 	atomic_long_t nr_throttled;
 };
+
+enum mst_wmark_stat {
+	WMARK_OK = 0,
+	WMARK_REACH_LOW,
+	WMARK_REACH_MIN,
+};
 #endif
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ca39974403a3..b1111dc8e585 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1546,18 +1546,47 @@ static int mem_cgroup_mst_overspd_tree(struct mem_cgroup *memcg)
 	return ret;
 }
 
+static enum mst_wmark_stat mem_cgroup_mst_wmark_ok(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	for_each_online_node(nid) {
+		unsigned long free, low, min;
+		struct zone *zone;
+
+		zone = &NODE_DATA(nid)->node_zones[ZONE_NORMAL];
+		free = zone_page_state(zone, NR_FREE_PAGES);
+		low = low_wmark_pages(zone);
+		min = min_wmark_pages(zone);
+		min += (low - min) >> 2;
+
+		if (free <= min)
+			return WMARK_REACH_MIN;
+
+		if (free <= low)
+			return WMARK_REACH_LOW;
+
+	}
+	return WMARK_OK;
+}
+
 static void mem_cgroup_mst_spd_throttle(struct mem_cgroup *memcg)
 {
 	struct mem_spd_ctl *msc = &memcg->msc;
 	long timeout;
 	int ret = 0;
+	enum mst_wmark_stat stat;
 
 	if (!memcg->msc.has_lmt || in_interrupt() || in_atomic() ||
 		irqs_disabled() || oops_in_progress)
 		return;
 
+	stat = mem_cgroup_mst_wmark_ok(memcg);
+	if (stat == WMARK_OK)
+		return;
+
 	ret = mem_cgroup_mst_overspd_tree(memcg);
-	if (!ret)
+	if (stat == WMARK_REACH_LOW && !ret)
 		return;
 
 	atomic_long_inc(&msc->nr_throttled);
-- 
2.28.0

