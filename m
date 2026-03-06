Return-Path: <cgroups+bounces-14688-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PKnBqUpq2luaQEAu9opvQ
	(envelope-from <cgroups+bounces-14688-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 20:23:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C163227057
	for <lists+cgroups@lfdr.de>; Fri, 06 Mar 2026 20:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC8F301CF81
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2026 19:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963E371D0B;
	Fri,  6 Mar 2026 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyyfKJ7Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fnrjYVl/"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3336EAA3
	for <cgroups@vger.kernel.org>; Fri,  6 Mar 2026 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824960; cv=none; b=WBRPNf98dykB59/NxX2NKqDJMQpsouL2rvsKm6XWGwqzUDEBm8ecUglKQwtbP3/L0rakAcqzRdUTLlqPYXT2SvcZYFXSeQugx+hYrQxifEIUIm0YaiIk7w1OIGV+SGzJjjxUojrAdPJDuCZltbjrx2GhCU7LVgbDaRTbpq54ATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824960; c=relaxed/simple;
	bh=TEIn2leqPGGY/1DzdNb84U/JWY83T3pQBcY3iEc8ns8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=II1tykKz87txIJIFg6xDk4pCPL6YK0IGFUL7hpJecvHHMgeVVk2A5N/Ids3Qtuy8dSLNZt/iuOwDRHGXytE9R8Z8WMf8L3+AP0LMUmiPoDol01Ity3D8fYI9rTta4fKLlGkd/RkIk6dBl5MiBQbGVcoBbIn4rSLXZArbQfhHVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyyfKJ7Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fnrjYVl/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 6 Mar 2026 20:22:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772824957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bg/3VweDR91D2OkPYV0QQ/7hasio9/b4QIBc3FqEk+k=;
	b=CyyfKJ7YmFw6jMkQ1ILSrZYDSRYa0Jz5HIGXD+7nMk5VfgBeBa8bJRPBLze11MHl4Exd+n
	WR2RdRjdtH5efHm2pHts6P3KUwfSicLtSCu6emZSZtSTDnip2dSwgcqkp7pnsI9Xlgvooj
	bxxw75uYoXqc8+XZ3X2ExGs6PxqUAYqgZofy+vuP3unaOx754J2RfpHvJpzdHpw1dbbkgS
	crTzaK934lCn8gajn7P3w4SbCZi9YSI2yDa9wwip4P99l1licBVgJ3mHNzPaRFzXmKzXzo
	6jHzJYKC+aWf33emKnlUNy/HrW/OURRuGyznIIKxzWSaKn+2c9CKes2DTDeASg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772824957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bg/3VweDR91D2OkPYV0QQ/7hasio9/b4QIBc3FqEk+k=;
	b=fnrjYVl/MPzFqV9Wm2LIcjACSL6VHCYcHntshRdltdCXiwVFdHx12/eZAg2qJePh23BbtW
	KMIcoG72blgn0fCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Bert Karwatzki <spasswolf@web.de>
Subject: [PATCH v2] cgroup: Don't expose dead tasks in cgroup
Message-ID: <20260306192235.DY60tMnM@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6C163227057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,cmpxchg.org,suse.com,kernel.org,goodmis.org,web.de];
	TAGGED_FROM(0.00)[bounces-14688-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Once a task exits it has its state set to TASK_DEAD and then it is
removed the cgroup it belonged to. The last step happens on the task
gets out of its last schedule() invocation and is delayed on PREEMPT_RT
due to locking constrains.

As a result it is possible to receive a pid via waitpid() of a task
which is still listed in cgroup.procs for the cgroup it belonged
to. This is something that systemd does not expect and as a result it
waits for its exit until a time out occurs.
This can also be reproduced on !PREEMPT_RT kernel with a significant
delay in do_exit() after exit_notify().

Hide the task from the output which have PF_EXITING set which is done
before the parent is notified. Keeping zombies with live threads
shouldn't break anything (suggested by Tejun).

Reported-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20260219164648.3014-1-spasswolf@web.de/
Tested-by: Bert Karwatzki <spasswolf@web.de>
Fixes: 9311e6c29b348 ("cgroup: Fix sleeping from invalid context warning on=
 PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 v1=E2=80=A6v2: https://lore.kernel.org/all/20260302120738.6KkDipsR@linutro=
nix.de/
   - Close the race window filtering out PF_EXITING tasks instead.
   - Document the possible race window after it has been verified.

 kernel/cgroup/cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c22cda7766d84..eef01b80ec933 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5108,6 +5108,12 @@ static void css_task_iter_advance(struct css_task_it=
er *it)
 		return;
=20
 	task =3D list_entry(it->task_pos, struct task_struct, cg_list);
+	/*
+	 * Hide task which are exitting but not yet removed. Keep zombie
+	 * leaders with live threads visible.
+	 */
+	if ((task->flags & PF_EXITING) && !atomic_read(&task->signal->live))
+		goto repeat;
=20
 	if (it->flags & CSS_TASK_ITER_PROCS) {
 		/* if PROCS, skip over tasks which aren't group leaders */
--=20
2.53.0


