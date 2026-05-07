Return-Path: <cgroups+bounces-15658-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIt7Aodw/Gm8QAAAu9opvQ
	(envelope-from <cgroups+bounces-15658-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:59:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 715774E7233
	for <lists+cgroups@lfdr.de>; Thu, 07 May 2026 12:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD483302F250
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2026 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B437418C;
	Thu,  7 May 2026 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC8QDxJj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770513ED11C
	for <cgroups@vger.kernel.org>; Thu,  7 May 2026 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151292; cv=none; b=dCJUwYZF3RfT91ROURBQOveGjDU1GNchbINESbsCbxypp7PWpYrVImdfqS5GFdg4c/H4fQwFDCh2m5nb1jtG1fxh+WMIGxgXDckGO5F2BI89BWgmvSu7rnWpBZxGztjCl5yK/NSRaksnMmMPexljpi7X3MIBsCvnyDQM0yV/xUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151292; c=relaxed/simple;
	bh=U3CPPGK6K4+AyYWoP8vcr58iqNl7s0IMZ7Gx//WlteQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcBj3jbHjaMvQ8s+FJwCB8/ePEO5nXm6bNpJEhZDvwJfE6Y81TAMHx+TxS56OVoY+eFQNlMpehAfTCNs03Gxk/GgD2rFu+CLVhzYw4TxkhhRpKVa7WfHcxDShtUXQeYpuM/UooJFudInHeP68q7mQHm8pbOfH7c9ApJ0R5ZAKo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC8QDxJj; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c822652f82aso448222a12.3
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151282; x=1778756082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+L6fy6avhrQ4Ubnijze0dregbUMX614xcgQRJNc0Y4=;
        b=jC8QDxJjETa+KPKdpTRz/KBm72+y5q9yrQRd2zrDSLEGq2Uky8zKHiImMWcbMnk2b/
         hSlT1kMrn/+sWdisNqlt0rIM0KrYCJ4cCgbLHbG54pH0YfzLBQ4JGhLBT8Yrb7EA2Yxh
         8BZvSSeYtwvzWqynC5q/M0nV/07tzraaxCTt2TrEq0fhZlyNug1tW9/d3iXRWeww6BUs
         Wd3cLf8RnrMQ1L3i010aryjr+yK6In90G50TSfyMCmmwJR+I0a+MZsJQY44pwz+D2n62
         pyB1DzJXI2BhH6tiMbVEpnmwTN89QtEFsUrWYcULXToT7qD8mPQbTFqpTCJ2Il1cft+H
         PUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151282; x=1778756082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+L6fy6avhrQ4Ubnijze0dregbUMX614xcgQRJNc0Y4=;
        b=UsIyhRYXDyCbFWQws6KYOfy8dThpNItsHOvW6ue7b10BGGBU1f2RA8URrXL/HZ7UId
         gc1sPXC5LcYRsA10OK2YykHr2FmPNtQd/ZN0yH1O3T7VJ9Kjco82NRubdMPcSRViahVU
         ibliwvWIAopL/xgEh7NmCJuZJbEk0Qo67oCVI9UnoduUPF5qewlyynko+OwvoneMHeQQ
         +wDsi7J++IkiS/5KStPmq19/v81sSGS6X79IAS+24iTxqjQUShUrmd/cZ0nsRs7Jf0lo
         Y5NIOHpZ05ojBBOTiIxggFs1/qzGvhBawyd1GerOpC90Su2pmXAzCVDsSyYs2jUtW6Q9
         dOPQ==
X-Gm-Message-State: AOJu0Yx2UOsvDWenC/BL8s7ruuhYr8q1vvCuRx4vsifL0ueqzKeqAVUu
	JVVKiC2pI4yQ0npJocJT7NOmlTd3H7eC3QCXx3IKDBFa0xZ9QGGR3W8t
X-Gm-Gg: AeBDiesZU0M1GFz+Ajujaq7sDOHiamnBgWNvYMCV9fGeumfifqpWlthJ19Ka7dKYJvA
	9ZQPH+l+qW5btubJLP8FrQ2qakELVphEVQRUI1QSiw3m/PsfFQhrEl3aQO6MT0eMTi1LimJyq43
	/m8WtVwOGflfIZetoV4hm/KvV2HM9d1AUZ/tdvP67mavx8O7NRHwwW+dImdpKFSR27K8NAzfv2n
	gpt+Cvury2rbvOpiDqLKQg4UUUcCe3wxqvR3pqugRHDGyjkoEwmrDeRL3qhL8Eg3+7c6y6CCses
	g5JdpHa9puZuDgWr5D5a18A4IeBnZG8GREOPhlc8NqKUP/fDoYJt1wD/+3TRV+h4Kjz2Vxy8c0V
	5qvy3/K/6EwD5YlrqAO7sBTzA7pLSsXQ/D4B+CgDWb1YNa1O5gNBcVxcxdEf70mt+m5sdDGZSkb
	odJvzv3dnQqR93jzhqILmTBu6/fDPMq2KluvpKiS/wjq/DMCsp
X-Received: by 2002:a05:6a20:394d:b0:398:71e4:6287 with SMTP id adf61e73a8af0-3aa5a830dacmr7784784637.10.1778151282215;
        Thu, 07 May 2026 03:54:42 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253b399efsm1889949a12.18.2026.05.07.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:54:41 -0700 (PDT)
From: Chen Wandun <chenwandun1@gmail.com>
X-Google-Original-From: Chen Wandun <chenwandun@lixiang.com>
To: longman@redhat.com,
	chenridong@huaweicloud.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup/cpuset: move PF_EXITING check before __GFP_HARDWALL in cpuset_current_node_allowed()
Date: Thu,  7 May 2026 18:54:34 +0800
Message-ID: <20260507105434.3266234-1-chenwandun@lixiang.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 715774E7233
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-15658-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lixiang.com:email,lixiang.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Since prepare_alloc_pages() unconditionally adds __GFP_HARDWALL for the
fast path when cpusets are enabled, the __GFP_HARDWALL check in
cpuset_current_node_allowed() causes the PF_EXITING escape path to be
skipped on the first allocation attempt.  This makes it unreachable in
the common case, so dying tasks can get stuck in direct reclaim or even
trigger OOM while trying to exit, despite being allowed to allocate from
any node.

Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
can allocate memory from any node to exit quickly, even when cpusets
are enabled.

Also update the function comment to reflect the actual behavior of
prepare_alloc_pages() and the corrected check ordering.

Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
---
 kernel/cgroup/cpuset.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e3a081a07c6d..a48901a0416a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4176,11 +4176,11 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
  * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
  * yes.  If current has access to memory reserves as an oom victim, yes.
- * Otherwise, no.
+ * If the current task is PF_EXITING, yes. Otherwise, no.
  *
  * GFP_USER allocations are marked with the __GFP_HARDWALL bit,
  * and do not allow allocations outside the current tasks cpuset
- * unless the task has been OOM killed.
+ * unless the task has been OOM killed or is exiting.
  * GFP_KERNEL allocations are not so marked, so can escape to the
  * nearest enclosing hardwalled ancestor cpuset.
  *
@@ -4194,7 +4194,9 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  * The first call here from mm/page_alloc:get_page_from_freelist()
  * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets,
  * so no allocation on a node outside the cpuset is allowed (unless
- * in interrupt, of course).
+ * in interrupt, of course).  The PF_EXITING check must therefore
+ * come before the __GFP_HARDWALL check, otherwise a dying task
+ * would be blocked on the fast path.
  *
  * The second pass through get_page_from_freelist() doesn't even call
  * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
@@ -4204,6 +4206,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
  *	in_interrupt - any node ok (current task context irrelevant)
  *	GFP_ATOMIC   - any node ok
  *	tsk_is_oom_victim   - any node ok
+ *	PF_EXITING   - any node ok (let dying task exit quickly)
  *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
  *	GFP_USER     - only nodes in current tasks mems allowed ok.
  */
@@ -4223,11 +4226,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	 */
 	if (unlikely(tsk_is_oom_victim(current)))
 		return true;
-	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
-		return false;
-
 	if (current->flags & PF_EXITING) /* Let dying task have memory */
 		return true;
+	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
+		return false;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
-- 
2.43.0


