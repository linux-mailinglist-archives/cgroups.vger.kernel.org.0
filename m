Return-Path: <cgroups+bounces-7853-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E82A9E6A3
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1338E3BBDFD
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD601C84D7;
	Mon, 28 Apr 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkb+LBSM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB31C3306
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811406; cv=none; b=T0fAkfcM5qXAMvz+1g1O5DzdmQyRnOXma7jCMQgCXFkMdk01PES/8rQT6yYGJee2dR0Mdw3uXZ14WHLCMY6fy6zOSgQ6Sk4JYROS1gWa73TwkUefGrpT4t5IMCeS4oFZyDJZKG1GHfiF6BC65TovqZ9ON5fOeq676jcNnXqsFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811406; c=relaxed/simple;
	bh=2bUbxHD5Dxg5eYui3jDltoOsngL8VyFix5jEfVdSLG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhOr4xRVtzaNgbgacS1CySBsxBHtbt06Z7hxj17/mDzDGCwGqNc5j2mM+7nByKVPAdmkdn0N+B5ytJK2k5ClnwnQYP6uvBmH9u5Let3b2nSDJtnhNlL4CEHG8D8Db+73f1JWGRopjM6Qu3IqA9WRlS8ndtFjjysx7eS1m9HFRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkb+LBSM; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pVLyMgxEgIhuDOYAYLLDexoPQY+fmhXjZ45o9+pIZwY=;
	b=rkb+LBSMsHwLB7IGdALJ3Zig+Z0TfDZlFUKQ3AjaYNm2NIPMmXkltcH/lgWAMD6KlkYQIQ
	vOIfLeVlKGKzeNULNK80f3sawYAGn4pFstkoWF6WU0/xMrhgdcSO9i9SJg7Pr8tMV0ovUl
	pvDbVFOWTc4TPMf3lqk1xTij1KeWzeA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 03/12] bpf: treat fmodret tracing program's arguments as trusted
Date: Mon, 28 Apr 2025 03:36:08 +0000
Message-ID: <20250428033617.3797686-4-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

*** DO NOT MERGE! ***

This is a temporarily workaround, which will be fixed/replaced
in the next version.

--

Bpf oom handler hook has to:
1) have a trusted pointer to the oom_control structure,
2) return a value,
3) be sleepable to use cgroup iterator functions.

fmodret tracing programs fulfill 2) and 3).
This patch enables 1), however this change contradicts
the commit c6b0337f0120 ("bpf: Don't mark arguments to fentry/fexit
programs as trusted.").

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 kernel/bpf/btf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a91822bae043..aa86c4eabfa0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6424,7 +6424,14 @@ static bool prog_args_trusted(const struct bpf_prog *prog)
 
 	switch (prog->type) {
 	case BPF_PROG_TYPE_TRACING:
-		return atype == BPF_TRACE_RAW_TP || atype == BPF_TRACE_ITER;
+		switch (atype) {
+		case BPF_TRACE_RAW_TP:
+		case BPF_TRACE_ITER:
+		case BPF_MODIFY_RETURN:
+			return true;
+		default:
+			return false;
+		}
 	case BPF_PROG_TYPE_LSM:
 		return bpf_lsm_is_trusted(prog);
 	case BPF_PROG_TYPE_STRUCT_OPS:
-- 
2.49.0.901.g37484f566f-goog


