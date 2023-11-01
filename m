Return-Path: <cgroups+bounces-137-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1A7DDF5C
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467E7281882
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 10:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B5B10781;
	Wed,  1 Nov 2023 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="h/Y4OL1c"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E9291E;
	Wed,  1 Nov 2023 10:28:57 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE9DA;
	Wed,  1 Nov 2023 03:28:52 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 06658120034;
	Wed,  1 Nov 2023 13:28:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 06658120034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698834529;
	bh=QCGIxegnR2+PoSRp6JvHbydNNRPYlzZhJM6GnWlPEnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=h/Y4OL1cj2+uFZ5n1C6kQS9s+UmO7hoHoXXkgIHzwkAg3Dt7qHVBQ+odYU1zso4/b
	 xJldyr2ddaaABjT/Xw/kdJDHRp/W21qlHPO9vFl11JHiSaDxQ/WFmpRdzboQjTxoMI
	 gBGafiq3bJ5CLI55TgteCqfwhqNw76KIRkHbwutjM/AGnbZVJkWNUgAxHZsSJz4kP0
	 2NMlAsn2H4dZbkppqWlHgl81FLSH5iAj2CRhGgHi3iqmCWrhr0WvHiG/nWYJXOuUpe
	 wU6Kth/q+Pxxg9UYTm5vPAgu2DuJmwqlAJmm6jKOjN++jPS/7n9cXpAPG5JzNrDtgJ
	 XJDuEvC3iTo/g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 13:28:48 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 13:28:48 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 0/2] mm: memcg: improve vmscan tracepoints
Date: Wed, 1 Nov 2023 13:28:35 +0300
Message-ID: <20231101102837.25205-1-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 181040 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 06:18:00 #22376334
X-KSMG-AntiVirus-Status: Clean, skipped

From: Dmitry Rokosov <ddrokosov@sberdevices.ru>

The motivation behind this commit is to enhance the traceability and
understanding of memcg events. By integrating the function cgroup_name()
into the existing memcg tracepoints, this patch series introduces a new
tracepoint template for the begin() and end() events. It utilizes a
static __array() to store the cgroup name, enabling developers to easily
identify the cgroup associated with a specific memcg tracepoint event.

Additionally, this patch series introduces new shrink_memcg tracepoints
to facilitate non-direct memcg reclaim tracing and debugging.

Dmitry Rokosov (2):
  mm: memcg: print out cgroup name in the memcg tracepoints
  mm: memcg: introduce new event to trace shrink_memcg

 include/trace/events/vmscan.h | 91 ++++++++++++++++++++++++++++++-----
 mm/vmscan.c                   | 15 ++++--
 2 files changed, 90 insertions(+), 16 deletions(-)

-- 
2.25.1


