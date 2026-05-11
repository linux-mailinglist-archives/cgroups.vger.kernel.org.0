Return-Path: <cgroups+bounces-15736-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGWjMU62AWr2igEAu9opvQ
	(envelope-from <cgroups+bounces-15736-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:58:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBE50C5FC
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB61D302F999
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE33DA7F7;
	Mon, 11 May 2026 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFdoS2Ly"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DD3BD63C
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496724; cv=none; b=mfS35LRLLFYb50EzyluxOmd3hRRKILm13cri1HiPtgsY8dMnSvKz38h5a6VNjRgf4A7R/H/ZfoAFYrhiHeZVz3JSub/AgEm67Er3DXuLJDeGRkY2Gc/B3VtLIhRvXs9cBHgDHPIfzewWvH0w/J6h6uQM7Nl22tQ4jAiylx2ZZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496724; c=relaxed/simple;
	bh=XnB/2JOHyehUPoJKRScL1gkzyR01b6jxo9UdjDLCTJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FFAXzNbVuPIHJREV9RdUOReU3t8QHicU6ugVzB5Gw/sjW89eEsdpShyI8tQVtWeh5qIKiktvtOvbdTjIGFi4NiWdOqNrSbkzpwmvk+Z7Slvejv08k3QX4JShAtZZQXwRrMPe0RIWONLS/TkgMxZhdPPM8tbYrCmXGVPSSdn29x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFdoS2Ly; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba17c8cfacso42471515ad.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778496722; x=1779101522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg9BoGIRQX9a4/FMAbkw8BJqSowvqCXDuFdaccaN4l4=;
        b=YFdoS2Ly+orE5uvjoFsHg9X1qIWh7dNOZ+nRO9bhhJ/XSMLlf3PZY9/RbXvSxjEL71
         hdA+cjmL8fa2mmcDlmaPVeZfxeBYzfBFC8AdIaG1Lzmj7e3W28j91OBVAv3Ub5b+sitj
         6XcLAEqKoMuot10kqVYwBcXJm80EMDQyhXngb/1lXcoaGPITrzaglUibiQzeJYsoM8RJ
         UWCqI7rf9WG0VgL246pQEMX+71ge2Te5nThkky0O9i4baS1pRdGvldtjwD+zAAwnkIHI
         PKrwPrYCEl8Q8mqCeXuC4fYfA1Ij7SOuPaTG4CvwKbD0C+I2CeHzg6/DgfFlBFjSX8Uw
         2tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778496722; x=1779101522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qg9BoGIRQX9a4/FMAbkw8BJqSowvqCXDuFdaccaN4l4=;
        b=IRA0pSlIF6pFo0CWafV0pTCJT2ZKKKunapAgBffYicIyDszxUM6VVUt+t58PLEmnCY
         iZSl6sE5zw4RwwIY40vpfNF4RmcVxpe0de/+rHaLymQ1n1dtwI9i1zXtklSUWgjbPbtn
         d1ICOiLmvD0gEALckAEBJh7DcwLwfeLMQkrstIgix1c4ziwQlJ1dDyBeAfWrNSIMJcF6
         YI2Dm7g9dGx8HqoyZqvMS9XaxxsqVjpE6CNNS8meTJZRupdCpIxNKX+DT/lSLFWUtwpV
         5/hLfkciTCxDu18f473qG2EEeg+/0OuCZqFGYfGSzwmNYtwgey1I6eTGByvgzkqwmdct
         Bxyw==
X-Gm-Message-State: AOJu0YwJurEueErU9rH0iG75W67s9H+Yq/YjEEdXhmY6JZ069VCabvtq
	wwO3mLsDKR/A0Bv5gwXi1SuKxxvVtuiYKZboq2qKW/zcaH08bXRxhh6J
X-Gm-Gg: Acq92OGulVi93uYoYHPm1WXogw5SJP7aEZLGZmfaH15jXeYDT/xfTJlXSiqHqmWHKdK
	G9anee7y5PJrhYtzbVO/f8Adjzs9y1R3zj8CyJ37WluN+1tKc7j4QBCBgPL9qk3R4QbCg+llhsK
	2eel+tji6LuB3EKZiRJ3UCHDdUVBYL95GGx6L4Xv4wwvyg+F0VNP4Gyiob2uUSBuxXPVbmFh2Nn
	qgdLPK0rP+e+8Cv06K657mTqC2VMEFdKkU0Ow4Y1xn0xe1IF+ht9akOiHsoF31lOCCEj70puQcH
	YOGkIb61cnlTGaVyk8UYZiI7Dg1A2btSiG3MQGHIe0kQaUea0uKrxs+wLZsEeY87yjDOgLSrJBK
	jySprgq7CIL0dq4zyMWm4iLGn1Se/3abfsY7ALmwEJ67gBTbVrsoVUuEWTIqpFQOhQdu4jjwlDl
	2rQ5fTa6zSBFePnwXCTG+JZRQvrQTgr4aqMJ0pAixK357EndhPajlTMXWR+W5kRw==
X-Received: by 2002:a17:903:1ad0:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2ba792a0c08mr266735895ad.17.1778496722209;
        Mon, 11 May 2026 03:52:02 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm98571745ad.32.2026.05.11.03.51.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 03:52:01 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 0/3] mm/zswap: Implement per-cgroup proactive writeback
Date: Mon, 11 May 2026 18:51:46 +0800
Message-Id: <20260511105149.75584-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50EBE50C5FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15736-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Hao Jia <jiahao1@lixiang.com>

Zswap currently writes back pages to backing swap devices reactively,
triggered either by memory pressure via the shrinker or by the pool
reaching its size limit. However, this reactive approach makes writeback
timing indeterminate and can disrupt latency-sensitive workloads when
eviction happens to coincide with a critical execution window.

Furthermore, in certain scenarios, it is desirable to trigger writeback
in advance to free up memory. For example, users may want to prepare for
an upcoming memory-intensive workload by flushing cold memory to the
backing storage when the system is relatively idle.

To address these issues, this patch series introduces a per-cgroup
interface that allows users to proactively write back cold compressed
pages from zswap to the backing swap device.

Users can trigger writeback by writing to this interface with the following
parameters:

- "max=<bytes>" : Optional. The maximum amount of data to write back.
    (default: unlimited).
- "<age>" : Required. The minimum age of the pages to write back
    (in seconds). Only pages that have been in the zswap pool for at
    least this amount of time will be written back.

Example usage:
  # Write back pages older than 1 hour (3600 seconds), max 10MB
  echo "max=10M 3600" > memory.zswap.proactive_writeback

Patch 1: Move the global zswap shrink cursor into struct mem_cgroup as a
  per-memcg zswap_wb_iter, so patch 2 can scope writeback to a given memcg
  and make forward progress across its subtree on repeated invocations.

Patch 2: Add the memory.zswap.proactive_writeback cgroupv2 interface,
  allowing users to trigger writeback with optional size limit and
  age threshold.

Patch 3: Add a zswpwb_proactive counter to memory.stat and /proc/vmstat
  to track the number of writebacks triggered by proactive writeback.

Hao Jia (3):
  mm/zswap: Make shrink_worker writeback cursor per-memcg
  mm/zswap: Implement proactive writeback
  mm/zswap: Add per-memcg stat for proactive writeback

 Documentation/admin-guide/cgroup-v2.rst |  28 +++
 include/linux/memcontrol.h              |   6 +
 include/linux/vm_event_item.h           |   1 +
 include/linux/zswap.h                   |  17 ++
 mm/memcontrol.c                         |  80 +++++++
 mm/vmstat.c                             |   1 +
 mm/zswap.c                              | 303 ++++++++++++++++++++----
 7 files changed, 390 insertions(+), 46 deletions(-)

--
2.34.1

