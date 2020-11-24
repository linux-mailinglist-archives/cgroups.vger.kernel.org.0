Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D02C2365
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbgKXK6n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 05:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732354AbgKXK6n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Nov 2020 05:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606215521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=93iiWXlJJ6IXGgnGTBAqbCv2bSJUjXfqZiq9BMzLTt8=;
        b=U/is7sloglMBZMt3jdw1KgxWeNHZU3N8l+xPagEIp6xVArivT3+R7PlwZXDOSXAnNCkmGB
        NBSPkdZaPqLGS3R4eSru7DP69uQKNdKsqp0DN6XFmk5FIXYkQ5hZuzRh7H+1oBzlhJFffq
        XeWivHlDTIJCJCq0gzmVtQY3c1sjw1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-i56ZME7aMlWE14Ilb1raBg-1; Tue, 24 Nov 2020 05:58:39 -0500
X-MC-Unique: i56ZME7aMlWE14Ilb1raBg-1
Received: by mail-wm1-f71.google.com with SMTP id g125so732704wme.9
        for <cgroups@vger.kernel.org>; Tue, 24 Nov 2020 02:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=93iiWXlJJ6IXGgnGTBAqbCv2bSJUjXfqZiq9BMzLTt8=;
        b=OtdNnbPwDrIwvDTuemu/LP/+Gl12SoGgEtUXuZor3zsq270da/fOUYB6LczNv0w8HS
         ZAsKiMfTBqX18Ld1TdkoCd8iK6q3yxF4mftlWoaekvv0FMzaRrKSl9BY59r/V0iHnHp5
         Qt+pzwAa6od2l6EXulVyn9ifk4QPhWjk2OrkIBXxVMaNJiA9VVwCJ0nalwQqwH6RMCfJ
         +iKlvrCLHLhaeptrxg9q5tsD5IS3QallRVeKmTtlntpDyP5de0Bp0Awm5XknwoaHmGWw
         nYBtY+B5t9w+kfg8GEWywsdIoKDwR8GVFKeRYSDpyqZjF5dJ4GD92FM5RE80cphPoz46
         4HEw==
X-Gm-Message-State: AOAM532PN5aX7piq9liR757sqlAwDz+0VOInGB+/6TX2kUAThGyP+wP5
        vgrhK9lrri+iAcrjmZy3B+ux8/9RjRiECXjCTELkx6YI2NNkrq9Lpti60Q62U+VGJf0w6Vak+fu
        MtJ7FgJbeEv5c/jQI
X-Received: by 2002:adf:b78d:: with SMTP id s13mr4473676wre.383.1606215518035;
        Tue, 24 Nov 2020 02:58:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyEy0NaSDK6xRfNiQMCFfdk60eQ8DmNfigWwS2jLBAhm8rLw3v70xbgbAFeeO+jjelCbnI1dg==
X-Received: by 2002:adf:b78d:: with SMTP id s13mr4473660wre.383.1606215517859;
        Tue, 24 Nov 2020 02:58:37 -0800 (PST)
Received: from localhost (cpc111767-lutn13-2-0-cust344.9-3.cable.virginm.net. [86.5.41.89])
        by smtp.gmail.com with ESMTPSA id p4sm25611598wrm.51.2020.11.24.02.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:58:37 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] memcg: add support to generate the total count of children from root
Date:   Tue, 24 Nov 2020 10:58:36 +0000
Message-Id: <20201124105836.713371-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each memory-controlled cgroup is assigned a unique ID and the total
number of memory cgroups is limited to MEM_CGROUP_ID_MAX.

This patch provides the ability to determine the number of
memory cgroups from the root memory cgroup, only.
A value of 1 (i.e. self count) is returned if there are no children.
For example, the number of memory cgroups can be established by
reading the /sys/fs/cgroup/memory/memory.total_cnt file.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/memcontrol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29459a6ce1c7..a4f7cb40e233 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4535,6 +4535,19 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+static int mem_cgroup_total_count_read(struct cgroup_subsys_state *css,
+				      struct cftype *cft)
+{
+	struct mem_cgroup *iter, *memcg = mem_cgroup_from_css(css);
+	int num = 0;
+
+	for_each_mem_cgroup_tree(iter, memcg)
+		num++;
+
+	/* Returns 1 (i.e. self count) if no children. */
+	return num;
+}
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 #include <trace/events/writeback.h>
@@ -5050,6 +5063,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write_u64 = mem_cgroup_oom_control_write,
 		.private = MEMFILE_PRIVATE(_OOM_TYPE, OOM_CONTROL),
 	},
+	{
+		.name = "total_cnt",
+		.flags = CFTYPE_ONLY_ON_ROOT,
+		.read_u64 = mem_cgroup_total_count_read,
+	},
 	{
 		.name = "pressure_level",
 	},
-- 
2.26.2

