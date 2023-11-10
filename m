Return-Path: <cgroups+bounces-315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FF7E7A07
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A46DB20F8B
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D12CA76;
	Fri, 10 Nov 2023 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="UY7Y5Wk4"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A179FF;
	Fri, 10 Nov 2023 08:20:57 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5397393E6;
	Fri, 10 Nov 2023 00:20:55 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C72DF10003B;
	Fri, 10 Nov 2023 11:20:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C72DF10003B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1699604452;
	bh=Oweu6l6Z4jWuzzNHij8vYKz5YVa1JDBrSEKBFwN/6S4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UY7Y5Wk4GHCGcEQUUQE2WdmhIHDPom2duH05o1m+Q7gyoFHBfHkREhNqCnSQHHQtk
	 p6cLxKvF2S/BcojkkX1fxTXRImVQnIUDDlkf8Hmgf/EM8DTPWvEkZ9NHLqIc85z6pJ
	 2QHsGajmLacooJhKDsYwO7sAfuojvxRhfsfXMRy45VAduZZdnhdzOhKe9XGNDRhGja
	 Y+V4rbLywmPcFnzQYZw4AjVkAtd2hO0eBA2yw2AImmlGpLZQYbk7eom0ubrDsFhjHS
	 xyiqtRsqHUH/eL3EO46hcS5wGhffvmRJagpU/ff/D64FqK8Ar3UEOpV1GeFAXTWhDs
	 HXAqreeP411KQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 Nov 2023 11:20:52 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 10 Nov 2023 11:20:52 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
	<shakeelb@google.com>, <muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 0/3] samples: introduce cgroup events listeners
Date: Fri, 10 Nov 2023 11:20:42 +0300
Message-ID: <20231110082045.19407-1-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
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

To begin with, this patch series relocates the cgroup example code to
the samples/cgroup directory, which is the appropriate location for such
code snippets.

Furthermore, a new cgroup v2 events listener is introduced. This
listener is a simple yet effective tool for monitoring memory events and
managing counter changes during runtime.

Additionally, as per Andrew Morton's suggestion, a helpful reminder
comment is included in the memcontrol implementation. This comment
serves to ensure that the samples code is updated whenever new events
are added.

Changes v2 since v1 at [1]:
    - create new samples subdir - cgroup
    - move cgroup_event_listener for cgroup v1 to samples/cgroup
    - add a reminder comment to memcontrol implementation

Links:
    [1] - https://lore.kernel.org/all/20231013184107.28734-1-ddrokosov@salutedevices.com/

Dmitry Rokosov (3):
  samples: introduce new samples subdir for cgroup
  samples/cgroup: introduce cgroup v2 memory.events listener
  mm: memcg: add reminder comment for the memcg v2 events

 MAINTAINERS                                   |   1 +
 mm/memcontrol.c                               |   4 +
 samples/Kconfig                               |   6 +
 samples/Makefile                              |   1 +
 samples/cgroup/Makefile                       |   5 +
 .../cgroup/cgroup_event_listener.c            |   0
 samples/cgroup/cgroup_v2_event_listener.c     | 330 ++++++++++++++++++
 tools/cgroup/Makefile                         |  11 -
 8 files changed, 347 insertions(+), 11 deletions(-)
 create mode 100644 samples/cgroup/Makefile
 rename {tools => samples}/cgroup/cgroup_event_listener.c (100%)
 create mode 100644 samples/cgroup/cgroup_v2_event_listener.c
 delete mode 100644 tools/cgroup/Makefile

-- 
2.36.0


