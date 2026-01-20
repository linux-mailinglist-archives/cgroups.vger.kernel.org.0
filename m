Return-Path: <cgroups+bounces-13324-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOMZJ42qb2lUEwAAu9opvQ
	(envelope-from <cgroups+bounces-13324-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 17:17:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABD24742D
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D573556C5D1
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A0438FED;
	Tue, 20 Jan 2026 13:57:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C542E00E;
	Tue, 20 Jan 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917472; cv=none; b=BHnmprvOMUdrkvb1hpwv+JC5fP2SaQyowRo4BXYPMTwLz/lFUUfIBhzGo5b0D0fKDyvlZpyqb4ZgephGEwziestQCMiW+VdRAdNv/BnYVinMk4o7JOEj/sGoxidKz9BYHWb/ZfHcs+fzlHn9Y1g3n8Ics7HQWSM82a7Ow8sCsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917472; c=relaxed/simple;
	bh=gO7haeB6OAyoc4gP3Xe+GTNXWpzZNpvHWJr/7KgmN5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhW31i9BNKKwmiq7gsG9i5AnW0syobwWFNa9qf+KxatcYloqseQdga0idXTE6vwbhLaMOX+Wk5JTEosXzQDiJw/0UlMF9ibdLrh4PbIay0w+kxCpwi42lLT0SIyodNi2eDVbQfF9GQ1aM5LJ7YjLKfBDeGQiKhq7CL/EHByxmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwTQP42y4zKHMjv;
	Tue, 20 Jan 2026 21:56:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DFF3A4056D;
	Tue, 20 Jan 2026 21:57:46 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S2;
	Tue, 20 Jan 2026 21:57:43 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	ryncsn@gmail.com
Subject: [RFC PATCH -next 0/7] Introduce heat-level memcg reclaim
Date: Tue, 20 Jan 2026 13:42:49 +0000
Message-Id: <20260120134256.2271710-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1Utw1rJFW7WrWUWw1Utrb_yoW5AFyUpa
	93Wasxtws5JF15AanrAayUWrWfZrn7J3W3XF98Kr97Ar13AFyvvFWIkr1ruFWDCrWxtry3
	XrnF93WDWF4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,huaweicloud.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13324-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 0ABD24742D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was originally introduced to improve scalability during
global reclaim, but it only supports gen lru global reclaim and its
implementation has become complex. Moreover, it has caused performance
regressions when dealing with a large number of memory cgroups [1].

Previous attempts to remove memcg LRU by switching back to iteration
implementation brought performance regression [3].

This series introduces a per-memcg heat level mechanism for reclaim,
aiming to unify gen lru and traditional LRU global reclaim. The core
idea is to track per-node per-memcg reclaim state, including heat,
last_decay, and last_refault. Three reclaim heat levels are defined:
cold, warm, and hot. Cold memcgs are reclaimed first; only if cold
memcgs cannot reclaim enough pages, warm memcgs become eligible for
reclaim. Hot memcgs are reclaimed last.

While the heat level design can be applied to all memcg reclaim scenarios,
this series takes a conservative approach and initially applies it only
to global reclaim. The first few patches introduce the heat level
infrastructure and apply it to traditional LRU global reclaim. The
subsequent patches gradually migrate gen lru global reclaim to the
heat-level-based approach, with the final patch combining shrink_many
into shrink_node_memcgs to complete the transition.

Performance results show significant improvements:

Traditional LRU results (2-hour run of test [2]):
Throughput (number of requests)         before     after        Change
Total                                   1,734,169  2,353,717    +35%

Gen LRU results (24-hour run of test [2]):
Throughput (number of requests)         before     after        Change
Total                                   22,879,701 25,331,956   +10%

The performance tests are based on next branch commit:
commit ef0d146624b0 ("Add linux-next specific files for 20251219")

This series has been rebased on next-20260119:
commit d08c85ac8894 ("Add linux-next specific files for 20260119")

[1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
[2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
[3] https://lore.kernel.org/lkml/20251224073032.161911-1-chenridong@huaweicloud.com/

Chen Ridong (7):
  vmscan: add memcg heat level for reclaim
  mm/mglru: make calls to flush_reclaim_state() similar for MGLRU and
    non-MGLRU
  mm/mglru: rename should_abort_scan to lru_gen_should_abort_scan
  mm/mglru: extend lru_gen_shrink_lruvec to support root reclaim
  mm/mglru: combine shrink_many into shrink_node_memcgs
  mm/mglru: remove memcg disable handling from lru_gen_shrink_node
  mm/mglru: remove memcg lru

 Documentation/mm/multigen_lru.rst |  30 --
 include/linux/memcontrol.h        |   7 +
 include/linux/mmzone.h            |  89 -----
 mm/memcontrol-v1.c                |   6 -
 mm/memcontrol.c                   |   7 +-
 mm/mm_init.c                      |   1 -
 mm/vmscan.c                       | 547 ++++++++++++------------------
 7 files changed, 231 insertions(+), 456 deletions(-)

-- 
2.34.1


