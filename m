Return-Path: <cgroups+bounces-528-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AECD57F590D
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5076FB20FFB
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176816436;
	Thu, 23 Nov 2023 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="orKhJIw6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42978109;
	Wed, 22 Nov 2023 23:20:02 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id E26FC120007;
	Thu, 23 Nov 2023 10:20:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E26FC120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700724000;
	bh=4xqDYEZxoQBKfiroxVAcCaTQ0QNc/WhY15vgNkVDJCI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=orKhJIw62iEDOIX8Eo122DiZ9ABea2OkrpyBXvy1q4BEINmqjrEPfxqvpJkzoASye
	 0k8ivVu56ck2hQ0OK9iFWoM880QCHg1z7W1Mzbrd2SogdxqsCknmIyee6eYAPbj6I/
	 1Q1F3vSHK8twKbcd49ZNuDdAW7PlZve+cJ1CKoJ/6OsIdFMoJggTEAN50uNNqekbGA
	 4o9ofIP2//am+lWImoqWaX/icU1NWCKq6US4qJOYp7j/UgAoibUojuHxAi6v8u1URz
	 Aj8Ht6iZb7myhpul2Fm2YRflSvyOLw9dJFTCZ6aeWhmMF9AGl4yKgCweZWaoLm+W1v
	 0cSEpdgm0QtOw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 10:20:00 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 10:20:00 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 3/3] mm: memcg: add reminder comment for the memcg v2 events
Date: Thu, 23 Nov 2023 10:19:45 +0300
Message-ID: <20231123071945.25811-4-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231123071945.25811-1-ddrokosov@salutedevices.com>
References: <20231123071945.25811-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181550 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 04:50:00 #22507336
X-KSMG-AntiVirus-Status: Clean, skipped

To maintain the correct state, it is important to ensure that events for
the memory cgroup v2 are aligned with the sample cgroup codes.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 mm/memcontrol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..a75c4584f58f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6555,6 +6555,10 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+/*
+ * Note: don't forget to update the 'samples/cgroup/memcg_event_listener'
+ * if any new events become available.
+ */
 static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 {
 	seq_printf(m, "low %lu\n", atomic_long_read(&events[MEMCG_LOW]));
-- 
2.36.0


