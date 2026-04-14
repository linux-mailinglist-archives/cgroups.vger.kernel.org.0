Return-Path: <cgroups+bounces-15291-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMlAJhkg3mk1ngkAu9opvQ
	(envelope-from <cgroups+bounces-15291-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 13:08:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD1F3F920D
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 13:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C25D3061D5A
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8803D8102;
	Tue, 14 Apr 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iNH3A08B"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154B3C3BF3;
	Tue, 14 Apr 2026 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164792; cv=none; b=QBYXS1zY4uw3e41Xbb1mIUva8MSsyHCCQL2zccoWWTOHt52pSdp/kO+50jMonzLLyoVi+qSCzN7k/LC8waJnR1WOYGuag6OHIVARfkkbeejn00+NqRF4yk1WCsAr4jG4yAoF8eEtLK9h9sNnCTwa0bIgMt000RYYE7oSh0msH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164792; c=relaxed/simple;
	bh=byfPGoxk08LxeCR5IypvjYRIhJrfAVsxsgWvci09i9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLLTJT+76G5OXk+h3JmFs8wa40q8lsqnilG0yyMZcJjH6pZMA9eKYXOaNnLkEtiYGZZlpjc01wqqAvMrcj0vnPDXnyYUCs4J6h27wgKeoePE28V1B4R21PJ0lf0PwwJnfuzRlugX2ZL4GLVS/SczlBWD/Z3TqsvOqbrUY5qJ/Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iNH3A08B; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=I9
	2jEmAumgZ6rFCY267aGWR2wa0hUFuBr3FV+HxJgc8=; b=iNH3A08BSSQ5of74kH
	JO0tw6AZiH+i7rBX39iLvoVEap6FpzIQI/8+tMXa21QVs1pAilZ84h5J3RbEjZqM
	f3wdQdq6KzNuSPoKg6SK8/VvgGRgERNc210pktlgiIn9xdYXiPoPsI7s8ZdKXJvb
	Zdrn55msPR5wL8AfgDP06bqsc=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBnrLh2H95pqLbvEg--.46126S2;
	Tue, 14 Apr 2026 19:05:28 +0800 (CST)
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
Subject: [PATCH 0/2] kselftests: cgroup: fix test_kmem false failures
Date: Tue, 14 Apr 2026 11:05:22 +0000
Message-ID: <20260414110524.2414-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnrLh2H95pqLbvEg--.46126S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw47WF4ftFW7AFW3CrW3Wrg_yoWDuwcEva
	y2yrZ7t395AayqkFZrtrn8XrWS93y7JF4aqF1qqF17JFyUJr4UJFn7Xr1UZ3WxWa13GFya
	vF9YvFyftr1IyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRAa9aDUUUUU==
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7Rj3RGneH3iPtwAA3u
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,zte.com.cn,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15291-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,zte.com.cn:email]
X-Rspamd-Queue-Id: DBD1F3F920D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

This patchset fixes two issues in testing/selftests/cgroup/test_kmem.c
that cause false test failures under certain system configurations.

Patch 1/2 updates the MAX_VMSTAT_ERROR tolerance to account for the
multi-memcg percpu charge cache introduced by commit f735eebe55f8
("memcg: multi-memcg percpu charge cache") with NR_MEMCG_STOCK
(currently 7) slots per CPU, the worst-case discrepancy between
memory.current and memory.stat.percpu has increased.

Patch 2/2 fixes the test_percpu_basic test to account for slab memory
overhead. On systems with few CPUs (<= 4), slab consumption exceeds
percpu usage, causing the test to fail even when the percpu accounting
is working correctly.

Ran Xiaokai (2):
  kselftests: cgroup: update kmem test tolerance for multi-memcg stock
  kselftests: cgroup: account for slab memory in test_percpu_basic

 tools/testing/selftests/cgroup/test_kmem.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.1



