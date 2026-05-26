Return-Path: <cgroups+bounces-16306-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DPbOReIFWpXWQcAu9opvQ
	(envelope-from <cgroups+bounces-16306-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:46:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B185D5195
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E02AC300980B
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781C3ED127;
	Tue, 26 May 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkVWvkUn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E623EB7E9
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795984; cv=none; b=esN+Ak2IeOzp5crSApUdA7i49+V35Zdun3DdUq7teuADkc2b+ExDZCfTucYpAcpD+iLKdl8kwIsl/vXAezNbDYLhOp1VhpbGJcD/w9LmSQg+mHT+WNR2ePKOG42cZc6GY/barGh0jA1SNRMLSHMqj1m37RAcCQnu1k0GuA8WjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795984; c=relaxed/simple;
	bh=HR7T48L4Vy+sBHGM47N+45shXRfXheO6QwhLsSflKE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhC5HNLuwMQT/NkOnhw0SPDaJaSQo+QS3/BMD+oxRkNRtyq4LygMYN99kPSRiXlDs0/qsSL7PNrbYGIHDidmn3BMcB5s7RpCnO7P9NZIcNy9HCuQ1OMh6Ih47xNBTHyeAsbeyV6GrVGjZp5HP0Pr4w9bxJcuwzm0YuMDapMcsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkVWvkUn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c8025f1c227so8175574a12.2
        for <cgroups@vger.kernel.org>; Tue, 26 May 2026 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779795973; x=1780400773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=983/W68Px22eGNnSr2lTrxriWPgIBrKprA/JK1mMbWU=;
        b=RkVWvkUnVvCZaxdNF6Ug4V08zeZ5G4svBoJNnUj+D4Str6VeL6jSEzpgaiGNra0EAT
         V7ZvdNNJ3jOtBjisbSrLAMXrqHs806zWBdRke5kJbSnVbVTsX3Z4qGa43G7JdqDxG2oK
         9yrBHabQsqIW/aMyXUKRe8wTvLH57ADdZf0Nt883DoaoldEVMye9v0Gn6LHhfeEzVGj1
         wb79opPQinXgD0a0hRCwZH6Rl6Ksa6R4RaMMwPZMZO7Luv/uAeNEAT5NQa8HFfxJwjGW
         626ohLYX2YUHWST8CuqKBmxs8cA8g1E+FFNJm2kYwURt6hM50jK65+V0pZ+sIaZy9qv+
         HwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795973; x=1780400773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=983/W68Px22eGNnSr2lTrxriWPgIBrKprA/JK1mMbWU=;
        b=Nj8gs2iL6qsCP0f55HJsVVpQp7i8+u4mKjk/ZuSOL/jHi8whUcXHI2IgYPVsqPM3li
         hA6v0rcFBM6P4Vf1+JbiQumTALVOAOPBZU1TRnlsTJQWZQw1M4IYaqBAKPBuf7zeX0q6
         lusoggc9gYduX/CPXF8Jrva52Ug8ZO63FwvAlUYNtRp79fOToj+P/44bylOFoItLDb7T
         lUsODVGdAv5nsasSv26BlmB4d9AVHEl5Zs7TZPOUmz8RsTvkgC66c+ndDTStuX6bIEfp
         IEErJi1zpT6RyqslScJx/CwmlqXU+dXv3AzBzS5MDfApgRTWj2wBrij6tcwH88VwZT9U
         NXhA==
X-Gm-Message-State: AOJu0Yx+gPAEXzxH/wqLGYAgkQImfIkuCfFve0GaqUuQLi/ocktuTLQo
	eo+P4NvZnvWhxcMbGNV62ewz9allSOy6JypcJ1xOMGslfrhsdueNI/t6
X-Gm-Gg: Acq92OGI85RjPsetHes/sz8MN1Fj1T1c816S/t2NLl5tlei1Q/40E26MNSQeqHX+7zj
	wLAdo21utrwtaijJweTrwh7s0Reut3isCjcqJ3CSQgSpDy0Oe+gBg/5tfX5gGTB9dw9QraR/9vm
	DA/o8GOiuD/FEbgqAftmq9AoqEEXDADIuTsLl/SW6h8x6ti0AhrjH8ZccQr8EWrYmXa/+HdmF2j
	O6qNmzmiGJMhWzLR5qLRO5VW9Wi5jG/aqonvJCnKRpH3EsWEe4pgB2t2qaoe9jrZ4pt+I7fbOOW
	CuoBU6nc9ZY9gdXZK14pYH4abl30id5jTLDp28TPKBcYFWTl4jZviC77QfVQvv2ElEHSBIgXQjU
	8B38azhiavZ77nqMqja26D4go0Jqoq8BJ3d/Jo3U3lbCCe+LB8urk1Vy1W4+uow8jUNEK7MqeJS
	V1+o0WEj66Aubf0gZ9HVW39/f6JfluDhkSSuTnundypP0Y0t/E/Ew=
X-Received: by 2002:a05:6a21:a45:b0:3aa:3fbf:d0a3 with SMTP id adf61e73a8af0-3b328fb7b6fmr20340231637.47.1779795973481;
        Tue, 26 May 2026 04:46:13 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852028fe99sm10304341a12.4.2026.05.26.04.46.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 May 2026 04:46:12 -0700 (PDT)
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
Subject: [PATCH v3 0/4] mm/zswap: Implement per-cgroup proactive writeback
Date: Tue, 26 May 2026 19:45:57 +0800
Message-Id: <20260526114601.67041-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16306-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,linux.dev,suse.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiahaokernel@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E6B185D5195
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hao Jia <jiahao1@lixiang.com>

Zswap currently writes back pages to backing swap reactively, triggered
either by the shrinker or by the pool reaching its size limit. Although
proactive memory reclaim can automatically write back a portion of zswap
pages via the shrinker, it cannot explicitly control the amount of
writeback for a specific memory cgroup. Moreover, proactive memory reclaim
may not always be triggered during a steady state.

In certain scenarios, it is desirable to trigger writeback in advance to
free up memory. For example, users may want to prepare for an upcoming
memory-intensive workload by flushing cold memory to the backing storage
when the system is relatively idle.

This patch series introduces a "zswap_writeback_only" key to memory.reclaim
cgroup interface, allowing users to proactively write back cold compressed
pages from zswap to the backing swap device. When specified, this key
bypasses standard memory reclaim and exclusively performs proactive zswap
writeback up to the requested budget. If omitted, the default reclaim
behavior remains unchanged.

Example usage:
  # Write back 100MB of pages from zswap to the backing swap
  echo "100M zswap_writeback_only" > memory.reclaim

Patch 1: Move the global zswap shrink cursor into struct mem_cgroup as a
  per-memcg zswap_wb_iter, so patch 2 can scope writeback to a given memcg
  and make forward progress across its subtree on repeated invocations.

Patch 2: Extend the memory.reclaim cgroup v2 interface with a new
  "zswap_writeback_only" key, allowing users to trigger proactive zswap
  writeback up to a requested budget.

Patch 3: Add a zswpwb_proactive counter to memory.stat and /proc/vmstat
  to track the number of writebacks triggered by proactive writeback.

Patch 4: Add tests for zswap proactive writeback.

v2->v3:
    - Align the return value of zswap_proactive_writeback() with
      memory.reclaim and update the corresponding documentation accordingly.
    - Resolve conflicts in test_zswap.c on the mm-unstable branch.
    - Enhance the zswap proactive writeback selftests to guard against potential
      future regressions.

v1->v2:
    - As suggested by Yosry and Nhat, extend the memory.reclaim cgroup v2
      interface with a "zswap_writeback_only" key instead of adding a new
      dedicated cgroup interface.
    - Update the zswap documentation and add selftests for proactive writeback.

[v2] https://lore.kernel.org/all/20260525122242.36127-1-jiahao.kernel@gmail.com
[v1] https://lore.kernel.org/all/20260511105149.75584-1-jiahao.kernel@gmail.com


Hao Jia (4):
  mm/zswap: Make shrink_worker writeback cursor per-memcg
  mm/zswap: Implement proactive writeback
  mm/zswap: Add per-memcg stat for proactive writeback
  selftests/cgroup: Add tests for zswap proactive writeback

 Documentation/admin-guide/cgroup-v2.rst     |  22 +-
 Documentation/admin-guide/mm/zswap.rst      |  11 +-
 include/linux/memcontrol.h                  |   3 +
 include/linux/vm_event_item.h               |   1 +
 include/linux/zswap.h                       |  16 ++
 mm/memcontrol.c                             |   4 +
 mm/vmscan.c                                 |  14 +
 mm/vmstat.c                                 |   1 +
 mm/zswap.c                                  | 292 +++++++++++++++++---
 tools/testing/selftests/cgroup/test_zswap.c | 155 ++++++++++-
 10 files changed, 471 insertions(+), 48 deletions(-)

-- 
2.34.1


