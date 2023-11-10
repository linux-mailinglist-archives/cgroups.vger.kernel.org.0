Return-Path: <cgroups+bounces-317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72367E7A0B
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 09:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DE128157C
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6DDD525;
	Fri, 10 Nov 2023 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ETxP9BNy"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9679FC;
	Fri, 10 Nov 2023 08:20:57 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5323493E5;
	Fri, 10 Nov 2023 00:20:55 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9C6E9100055;
	Fri, 10 Nov 2023 11:20:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9C6E9100055
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699604453;
	bh=eohC8GA+wehGLdFcqpgwGNVkXeQrwyMu8sDPWJjxuws=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ETxP9BNyJG4siFE5OrEsJ8wo4yqFkJ1JAWfdEn6DU1UUUbZmkwoj45YRwvpwKwQaF
	 aAFcT7rZt44GotUxqfYuRtGhLRDWIkDQNhYh0tox3ANqHBQYMyOetRcomIJQHkA+Sb
	 2l0ZUeJhKZiplyrFQi7T6TYnQA7AV3CqMSjQT9AqyAJTZZr4oXdPx4JcWp8H1vNmKZ
	 Gk8n0KYmUQosUKPT14ycMaiVT5rfmHqoC+5qMpqu+p+EkfYA0VbnOJlyFSLykczjIT
	 CUfBo4V3MaAz+pAmOgfg0c/Qsj+AMWaDENdcMAJfTAqjgbjuo5zVATxfAwPZsl2v2M
	 3p4xl1rMw8qEQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Nov 2023 11:20:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 10 Nov 2023 11:20:53 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 1/3] samples: introduce new samples subdir for cgroup
Date: Fri, 10 Nov 2023 11:20:43 +0300
Message-ID: <20231110082045.19407-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231110082045.19407-1-ddrokosov@salutedevices.com>
References: <20231110082045.19407-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181265 [Nov 10 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/10 06:25:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/10 06:25:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/10 05:52:00 #22426579
X-KSMG-AntiVirus-Status: Clean, skipped

Move the cgroup_event_listener for cgroup v1 to the samples directory.
This suggestion was proposed by Andrew Morton during the discussion [1].

Links:
    [1] - https://lore.kernel.org/all/20231106140934.3f5d4960141562fe8da53906@linux-foundation.org/

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 MAINTAINERS                                       |  1 +
 samples/Kconfig                                   |  6 ++++++
 samples/Makefile                                  |  1 +
 samples/cgroup/Makefile                           |  5 +++++
 {tools => samples}/cgroup/cgroup_event_listener.c |  0
 tools/cgroup/Makefile                             | 11 -----------
 6 files changed, 13 insertions(+), 11 deletions(-)
 create mode 100644 samples/cgroup/Makefile
 rename {tools => samples}/cgroup/cgroup_event_listener.c (100%)
 delete mode 100644 tools/cgroup/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index d516295978a4..6a0a580c34dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5243,6 +5243,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
+F:	samples/cgroup/*
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
diff --git a/samples/Kconfig b/samples/Kconfig
index bf49ed0d7362..339c8e2ee749 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -287,6 +287,12 @@ config SAMPLE_KMEMLEAK
           Build a sample program which have explicitly leaks memory to test
           kmemleak
 
+config SAMPLE_CGROUP
+	bool "Build cgroup sample code"
+	depends on CGROUPS && CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build samples that demonstrate the usage of the cgroup API.
+
 source "samples/rust/Kconfig"
 
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index 0a551c2b33f4..b85fa64390c5 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -3,6 +3,7 @@
 
 subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
+subdir-$(CONFIG_SAMPLE_CGROUP) += cgroup
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
 obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
diff --git a/samples/cgroup/Makefile b/samples/cgroup/Makefile
new file mode 100644
index 000000000000..deef4530f5e7
--- /dev/null
+++ b/samples/cgroup/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+userprogs-always-y += cgroup_event_listener
+
+userccflags += -I usr/include
diff --git a/tools/cgroup/cgroup_event_listener.c b/samples/cgroup/cgroup_event_listener.c
similarity index 100%
rename from tools/cgroup/cgroup_event_listener.c
rename to samples/cgroup/cgroup_event_listener.c
diff --git a/tools/cgroup/Makefile b/tools/cgroup/Makefile
deleted file mode 100644
index ffca068e4a76..000000000000
--- a/tools/cgroup/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Makefile for cgroup tools
-
-CFLAGS = -Wall -Wextra
-
-all: cgroup_event_listener
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $^
-
-clean:
-	$(RM) cgroup_event_listener
-- 
2.36.0


