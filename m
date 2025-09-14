Return-Path: <cgroups+bounces-10056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A6DB56769
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FC0189EB87
	for <lists+cgroups@lfdr.de>; Sun, 14 Sep 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671C71E8332;
	Sun, 14 Sep 2025 10:00:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595E2DC795;
	Sun, 14 Sep 2025 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757844050; cv=none; b=PgcEEOD5cbKrpdqoZD2SU0QdrVy09s4hx1nPJHPXP6VmYpVrZDEzcJI7CFmFUjbI17nDf1czIq2Ff970o8SvQmrmXm7gaHwObed34Om/taQ+fM0OmOUP5Q8dSuLzT8jtXE/oHlJ72UkTyRHOYEiOhONqbTGeFjTrAp/R7Wa4P2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757844050; c=relaxed/simple;
	bh=jOZ3xrPMf0XjAiuKHi3CY+ZrNevolLCnY+Ai9r4qCbo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=LNRRS7KFSF3WbVzcrc3WYjOZZVHnHSOVad04Bo9MrCs5DBeqq/uCFye4Lzi+4JemxKpMWitizV1qVQ9hp9U05p1VOacn1h3c4Xo1O7z7ZkxrL3b7UMYhQZIiyhPGmJG3tUzFc9tfq+dEStxNdXsCA/n8byl06b9eeBFSCEl4F9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cPkF26HF1z8Xs70;
	Sun, 14 Sep 2025 18:00:38 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 58EA0U06091794;
	Sun, 14 Sep 2025 18:00:30 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 14 Sep 2025 18:00:31 +0800 (CST)
Date: Sun, 14 Sep 2025 18:00:31 +0800 (CST)
X-Zmail-TransId: 2afb68c6923ff12-45441
X-Mailer: Zmail v1.0
Message-ID: <20250914180031197jk6ngo5pQjpXkNtNsjzSo@zte.com.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>, <shakeel.butt@linux.dev>,
        <hannes@cmpxchg.org>, <mhocko@kernel.org>, <roman.gushchin@linux.dev>
Cc: <david@redhat.com>, <chengming.zhou@linux.dev>, <xu.xin16@zte.com.cn>,
        <muchun.song@linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNV0gbWVtY2c6IFN1cHBvcnQgcGVyLW1lbWNnIEtTTSBtZXRyaWNzwqDCoA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 58EA0U06091794
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sun, 14 Sep 2025 18:00:38 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68C69246.000/4cPkF26HF1z8Xs70

From: xu xin <xu.xin16@zte.com.cn>

Dear all,

This is the v2 of patchset, as Shakeel suggested:
https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/

With the enablement of container-level KSM (e.g., via prctl [1]), there is
a growing demand for container-level observability of KSM behavior. However,
current cgroup implementations lack support for exposing KSM-related metrics.

So add the counter in the existing memory.stat without adding a new interface.
To diaplay per-memcg KSM statistic counters,  we traverse all processes of a
memcg and summing the processes' ksm_rmap_items counters instead of adding enum
item in memcg_stat_item or node_stat_item and updating the corresponding enum
counter when ksmd manipulate pages.

Now Linux users can look up all per-memcg KSM counters by:

# cat /sys/fs/cgroup/xuxin/memory.stat | grep ksm
ksm_rmap_items 0
ksm_zero_pages 0
ksm_merging_pages 0
ksm_profit 0

Q&A
====
why don't I add enum item in memcg_stat_item or node_stat_item like
other items in memory.stat ?

I tried the way of adding enum item in memcg_stat_item and updating them when
ksmd manipulate pages, but it failed with error statistic ksm counters of
memcg. This is because of the following reasons:

1) The KSM counter of memcgroup can be correctly incremented, but cannot be
properly decremented. E,g,, when ksmd scans pages of a process, it can use
the mm_struct of the struct ksm_rmap_item to reverse-lookup the memcg
and then increase the value via mod_memcg_state(memcg, MEMCG_KSM_COUNT, 1).
However, when the process exits abruptly, since ksmd asynchronously scans
the mmslot list in the background, it is no longer able to correctly locate
the original memcg through mm_struct by get_mem_cgroup_from_mm(), as the
task_struct has already been freed.

2) The first issue could potentially be addressed by adding a memcg
pointer directly into the ksm_rmap_item structure. However, this
increases memory overhead, especially when there are a large
number of ksm_rmap_items in the system (due to a high volume of
pages being scanned by ksmd). Moreover, this approach does not
resolve the same problem for ksm_zero_pages, because updates to
ksm_zero_pages are not performed through ksm_rmap_item, but
rather directly during unmap or page table entry (pte) faults
based on the mm_struct. At that point, if the process has
already exited, the corresponding memcg can no longer be
accurately identified.

xu xin (5):
  memcg: add per-memcg ksm_rmap_items stat
  memcg: show ksm_zero_pages count in memory.stat
  memcg: show ksm_merging_pages in memory.stat
  memcg: add per-memcg ksm_profit
  Documentation: add KSM statistic counters description in cgroup-v2.rst

 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++
 include/linux/ksm.h                     |  1 +
 mm/ksm.c                                | 67 ++++++++++++++++++++++---
 mm/memcontrol.c                         |  5 ++
 4 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.25.1

