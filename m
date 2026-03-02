Return-Path: <cgroups+bounces-14496-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH8sLZV9pWm6CAYAu9opvQ
	(envelope-from <cgroups+bounces-14496-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:07:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC571D8155
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C52A300F13B
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 12:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA3536405C;
	Mon,  2 Mar 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sq4jSr0Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAoOmV2j"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE435D5E2
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453263; cv=none; b=U0K8BVMZcBHKBBVpit8/AKYJYUnD3XvG5UVe16VM9Z9mejJ64dp2nBu25TYA0XS9dz0OniSRiYVEJTqtqyMD3laIkuptisXkbeswLoSH8O5CjlrsDnSOklc5Q/8EX9XFt+PIs8eGEmeeD9ukrPFQAGFSVXUWUe0PiIpCcl/rh+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453263; c=relaxed/simple;
	bh=rUB5mLnb0mEeaBwSa+gwwDDE6mi9pN4f0tTksn/xiMY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XxhuvIIdTFgPJE2Y0Xcl5jc2d/3f8/Yhtz2lJZ/MlWB2UMWv4Dn3dADmpcGJdqRzVvP61QetWlkKfQpnrGw/NFmexCZQwAnJgWRPvpXBceMZCcH5tRARpUrVz4R6+HWSfZtjTsUSxJGYXUBdUnIhY86lyvSFBPa0mTDsqlvrIP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sq4jSr0Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAoOmV2j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Mar 2026 13:07:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772453260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hl1I0Oe6lHGfHRSZJeWUuSaTERnL2syLi1Bpcz2DPtM=;
	b=sq4jSr0ZdMeiQTeSYzOcwZXJWeOBfhyPJmVkaBy9TKJqrDNPDMZRUpn7vhNdWANP/dcl8Y
	yKQsRi9/QT1o+YkH9oYc0dXZpMgCeXSvGxNmRLxUcCKOiSqkmld2tDd+yz7LPgmV30cAES
	FFfi+eldEeCVo1Ct4g76kRpO4ZGzCP6F2dPNAOe908pXVj/WlGM3fjbLWdyhRAPX+0yXhx
	8AZJnWbAonBo8bAyiO3hqxMoyp7UksYlFqu0RydBWY/bTogagVzi8OLQAOaLE+jLUqONg9
	xZSY4bdIwpF8P1931e0vQeR1lqRZBsvcE4xmIc3KlFh7OvitDN6WtH7qRxiVBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772453260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=hl1I0Oe6lHGfHRSZJeWUuSaTERnL2syLi1Bpcz2DPtM=;
	b=zAoOmV2j/V5Yo2vVFwaCRZtqU+rgyweExScq3+mb0v105O6/GpSxvKcS4EqbeYDF3OGJoj
	ENtA5fZNwgx8GLAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH] cgroup: Don't expose dead tasks in cgroup
Message-ID: <20260302120738.6KkDipsR@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,goodmis.org,web.de];
	TAGGED_FROM(0.00)[bounces-14496-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim,linutronix.de:email]
X-Rspamd-Queue-Id: 2DC571D8155
X-Rspamd-Action: no action

Once a task exits it has its state set to TASK_DEAD and then it is
removed the cgroup it belonged to. The last step happens on the task
gets out of its last schedule() invocation and is delayed on PREEMPT_RT
due to locking constrains.

As a result it is possible to receive a pid via waitpid() of a task
which is still listed in cgroup.procs for the cgroup it belonged
to. This is something that systemd does not expect and as a result it
waits for its exit until a time out occurs.

This can be avoided by skipping tasks which are in the DEAD state. There
is no need to verify both task states under task_struct::pi_lock because
once the task is exiting after is its last schedule, there will not be
any sleeping locks.

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20260219164648.3014-1-spasswolf@web.de/
Tested-by: Bert Karwatzki <spasswolf@web.de>
Fixes: 9311e6c29b348 ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Tejun, with this change, would it be okay to
- replace the irq-work with kworker? With this change it should address
  your concern regarding "run in definite time" as mentioned in [0]. So
  it might be significantly delayed but it shouldn't be visible.
  This would lift the restriction that a irq-work needs to run on this
  CPU and the kworker could run on any CPU. 

- would it be okay to treat RT and !RT equally here (and do this delayed
  cgroup_task_dead() in both cases)

[0] https://lore.kernel.org/all/aQzg9kcnCsdRQiB4@slm.duckdns.org/

 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c22cda7766d84..a8254229d62d3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5283,6 +5283,11 @@ static void *cgroup_procs_start(struct seq_file *s, loff_t *pos)
 
 static int cgroup_procs_show(struct seq_file *s, void *v)
 {
+	struct task_struct *tsk = v;
+
+	if (READ_ONCE(tsk->__state) & TASK_DEAD)
+		return 0;
+
 	seq_printf(s, "%d\n", task_pid_vnr(v));
 	return 0;
 }
-- 
2.51.0

