Return-Path: <cgroups+bounces-17171-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxK4AbTvOWqvzAcAu9opvQ
	(envelope-from <cgroups+bounces-17171-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 04:30:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027A6B38B9
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 04:30:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="enn/IsI/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17171-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17171-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 663F33028128
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2DE34EEEA;
	Tue, 23 Jun 2026 02:30:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8042D47F4
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 02:30:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782181807; cv=none; b=C8tGm7k0svvDtXhkh7XbIMUW6jIzXugzzX0E2TjWgPNTNYdbV4Kh81pk1lWKhQ6GK/HIb24Nk+WReKhyyHodreAWDHtvW8OLyiNEsIr2i2eIZuW+PeQ8z1vU3PCickBwS5AS0YIH+K480611iD6jlMCmRMG0Q4VSIZNaBWnPLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782181807; c=relaxed/simple;
	bh=zxXyeej4ZKaN0HsuyCoNR4Lk/nya5fqhPVDG1Ymxrj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TlQ2LbDd1EHYCoIa5cnK9Gu69G0PG9I203H7RVztA11xLwRgtHxHaahZD1e6kN40aqETvfWLAm2sBZmS0F9EC9Q1IczPJgz613ADkEYfSFEUKQPNRSsBw33L7RE07f+VheQZUjNk8pgct7RVyM0gDcozWsUKH4Qu+OSIAH7aiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=enn/IsI/; arc=none smtp.client-ip=91.218.175.181
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782181804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mWGKirvZ5AUIVxGsMAqDNZZQE4VwpRYJ/mV7mG39AwE=;
	b=enn/IsI/ehr2hVpceDsPR4HP4Axod7dENbEzZXFmJ6lWpm9MyP7H7HSqWuYy12kBfNSyCf
	YcSb6XzHmfkMhYcigl5m4S7yXAt1DjZWqrWjlN6CnhCFAVPRGWx6srk88NK6TPncPxNFYk
	vB9jYi0Y2+zvqCxXHqUiHXiBat6llLE=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] cgroup: Use READ_ONCE() for task->flags in task_css_set_check()
Date: Tue, 23 Jun 2026 10:29:46 +0800
Message-Id: <20260623022946.525885-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17171-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6027A6B38B9

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

task_css_set_check() uses rcu_dereference_check() to verify that
task->cgroups can be dereferenced. One accepted condition is that the
task is already exiting, tested by checking PF_EXITING in task->flags.

This is a lockless snapshot used only for the CONFIG_PROVE_RCU debug
predicate. This was found by KCSAN during fuzz testing. KCSAN can report
a data race when another task flag bit is updated concurrently. One report
shows pids_release() reading task->flags through task_css_set_check() while
do_task_dead() sets PF_NOFREEZE:

  KCSAN: data-race in task_css() [inline]
  KCSAN: data-race in pids_release()

  task_css()
  pids_release()
  cgroup_release()
  release_task()
  wait_task_zombie()

  value changed: 0x0040004c -> 0x0040804c

The changed bit is PF_NOFREEZE, not PF_EXITING. PF_EXITING remains set
before and after the update, so the task_css_set_check() condition does
not change. This is not a race on task->cgroups and does not indicate
incorrect pids charging or uncharging.

Use READ_ONCE() to document the intended lockless snapshot of task->flags.

No functional change intended.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 include/linux/cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f2aa46a4f871..8afc4ec7f7a1 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -480,7 +480,7 @@ static inline void cgroup_unlock(void)
 		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
-		((task)->flags & PF_EXITING) || (__c))
+		(READ_ONCE((task)->flags) & PF_EXITING) || (__c))
 #else
 #define task_css_set_check(task, __c)					\
 	rcu_dereference((task)->cgroups)
-- 
2.25.1


