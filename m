Return-Path: <cgroups+bounces-15293-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FAgNF+4f3mkynwkAu9opvQ
	(envelope-from <cgroups+bounces-15293-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 13:07:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76C3F91E3
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 13:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DFB1301077E
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1023D811B;
	Tue, 14 Apr 2026 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VW8Jbnkt"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF33D75CF;
	Tue, 14 Apr 2026 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164840; cv=none; b=Sr1JDa8rNo8/aiQ5qbN/PnEGnM4i3g3K9lEg9sO1i7lT9+tZVNlKkXI+hCuwzp4Ht4wOcLMjBwYDQuBqjCtI4M190dLxaVwAIco5cBtQOivNUXGHcnUu2uJznimlz5YiyWSnIaWVTMc+Lp03S76WpKlK0fR4W2e+KwEIF22aFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164840; c=relaxed/simple;
	bh=Y8eeT+7o2AEJ8S44YbJfEHq4tO6opDMaCRGbOasJ/nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbH5/+MO0FkZTjvjtwV4WtFVJWcyAEwM34Mp4+zsrbdVSQz7LhcBzqwfUkA0TiPZ4vws095MwWHSmyZIvtc0QUAq0Ju8QN1fTaUvG3OMy/GhGUHfRMWuHKcv+FhSIZ8k7IqOmoQX4CDwG5C1bOMyEgovJ1etDsq/xM6hlv6tQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VW8Jbnkt; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Sg
	2tnVpaCRON/cP+7gSdWa+iWUUmwfSiFQT93SEuIFU=; b=VW8JbnktrCN31hXN/m
	ZRxuZMCswnlDTlAW8P2XreK8Dw/m569blPObWwb51TYYrfmmSxRl1yIQuM2bPZ3a
	qqDK4QWbFCDvGELskajRHbhSeKOh9AYb6rzAfbJawxfA1WU83m7WFJlqVPhID6It
	8OB3JNh436NC2mM/ZpMDjAbUo=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnrLh2H95pqLbvEg--.46126S4;
	Tue, 14 Apr 2026 19:05:32 +0800 (CST)
From: ranxiaokai627@163.com
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	kuba@kernel.org,
	hughd@google.com,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH 2/2] kselftests: cgroup: account for slab memory in test_percpu_basic
Date: Tue, 14 Apr 2026 11:05:24 +0000
Message-ID: <20260414110524.2414-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414110524.2414-1-ranxiaokai627@163.com>
References: <20260414110524.2414-1-ranxiaokai627@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnrLh2H95pqLbvEg--.46126S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4fGr17GF45WrWfCF18Grg_yoW8WF1xpF
	ykG34qya10gFnxCa10kr4kXrWrW3s5Za18Gw1DAw1xAwsxtr9rtr1SyFWUJr97CFZ2vr1Y
	v34ag3sxu3WUA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8OzxUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxhz4RWneH3yBlgAA3k
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15293-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B76C3F91E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

The test verifies memory.current approximates memory.stat.percpu within
a tolerance. However, memory.current includes slab overhead. On systems
with few CPUs(<= 4), slab consumption exceeds percpu usage. While percpu
usage grows linearly and dominates as CPU count increases, the
significant slab portion on such few CPU systems causes the difference
to exceed MAX_VMSTAT_ERROR, leading to false test failures.

Fix this by including slab memory in the calculation.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 tools/testing/selftests/cgroup/test_kmem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 15b8bb424cb5..263aedb0727a 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -360,7 +360,7 @@ static int test_percpu_basic(const char *root)
 {
 	int ret = KSFT_FAIL;
 	char *parent, *child;
-	long current, percpu;
+	long current, percpu, slab;
 	int i;
 
 	parent = cg_name(root, "percpu_basic_test");
@@ -386,8 +386,9 @@ static int test_percpu_basic(const char *root)
 
 	current = cg_read_long(parent, "memory.current");
 	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
+	slab = cg_read_key_long(parent, "memory.stat", "slab ");
 
-	if (current > 0 && percpu > 0 && labs(current - percpu) <
+	if (current > 0 && percpu > 0 && labs(current - percpu - slab) <
 	    MAX_VMSTAT_ERROR)
 		ret = KSFT_PASS;
 	else
-- 
2.25.1



