Return-Path: <cgroups+bounces-10315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EBB8DD0A
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB1E93BEE66
	for <lists+cgroups@lfdr.de>; Sun, 21 Sep 2025 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50DB1C861A;
	Sun, 21 Sep 2025 15:07:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DD146588;
	Sun, 21 Sep 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758467261; cv=none; b=Pii5Pm59Ln3PsX6CXwtt9Y5lYj7+ygmvgfRPFZmovzS+q9CvbBhmo+83QBkkOlYP+12zTnQnVwwwb6An9HJtuFsb6g/cZnvVvguPg3YNR1cqqxocISBv2+acjsrIa5/NRfbuSoIgKvr+sOVEaXZSv8gC1p67da9p0hkC3RunCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758467261; c=relaxed/simple;
	bh=zGjM5yJYcZEOEyjJrZFhyRM2bHoMHaeyEK840LBY5oU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=i+ALTs+qibWljaqQebJS1Jyz/5dza0r5OtCZ9Fcmh482inNM8MoVOz1zjR99jxP45rDRzzkSGe4EO4p96qZfLvxhgwu1Rbe3c5v2RRUQwznKnRor4kyJRcEiUE/kM0kE+IVY127kiJO7jS68n07gau/vb1T81dcm1pcvO2tJDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cV8jr3Cy5z8Xs76;
	Sun, 21 Sep 2025 23:07:28 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 58LF7NMP070585;
	Sun, 21 Sep 2025 23:07:23 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 21 Sep 2025 23:07:26 +0800 (CST)
Date: Sun, 21 Sep 2025 23:07:26 +0800 (CST)
X-Zmail-TransId: 2af968d014ae464-25fd9
X-Mailer: Zmail v1.0
Message-ID: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgMC82XSBtZW1jZzogU3VwcG9ydCBwZXItbWVtY2cgS1NNIG1ldHJpY3M=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58LF7NMP070585
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Sun, 21 Sep 2025 23:07:28 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68D014B0.000/4cV8jr3Cy5z8Xs76

From: xu xin <xu.xin16@zte.com.cn>

v2->v3:
------
Some fixes of compilation error due to missed inclusion of header or missed
function definition on some kernel config.
https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/

v1->v2:
------
According to Shakeel's suggestion, expose these metric item into memory.stat
instead of a new interface.
https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/

Background
==========

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

xu xin (6):
  memcg: add per-memcg ksm_rmap_items stat
  memcg: show ksm_zero_pages count in memory.stat
  memcg: show ksm_merging_pages in memory.stat
  ksm: make ksm_process_profit available on CONFIG_PROCFS=n
  memcg: add per-memcg ksm_profit
  Documentation: add KSM statistic counters description in cgroup-v2.rst

 Documentation/admin-guide/cgroup-v2.rst | 17 ++++++
 include/linux/ksm.h                     |  1 +
 mm/ksm.c                                | 70 ++++++++++++++++++++++---
 mm/memcontrol.c                         |  5 ++
 4 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.25.1

