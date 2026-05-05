Return-Path: <cgroups+bounces-15595-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U5ABDw8/+WkZ7QIAu9opvQ
	(envelope-from <cgroups+bounces-15595-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A844C58D9
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 02:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE51930036D9
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 00:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E03019BA;
	Tue,  5 May 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6YAUxWq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AFE2FD69A;
	Tue,  5 May 2026 00:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777942282; cv=none; b=t+WODXhji49a44vZatgLF8VAlTh6+tRSFYFdVSPABa9LchELkrvn2hhOVq8qrPDGu59DjTbNB7epbpFACSjTnZTTPsoxmjcPvyVAUXLbSuEFMtJ0gUJ1m+u9Q9eulxEHqEn43qsPy5hg0ikhzhCx/KgQAVatpjODEyTyAsRdGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777942282; c=relaxed/simple;
	bh=AbEYHwz7wUqGFpOv66696wdy+DfVTHLCpXtbizOhw9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMv4608EorO8Zr+5tZoy8RyDOjAuYUCunndXBSGynYSgbFU0fPum/U7zXG6sNU8vpao5iEU7fZ3r16oUuXT8vJZFNUOMy+U7/XlD0J//Ejhn4PcxcQ3QlWY2zsQ14TK4mjtNdB4gj8wKALKCqyjTjC6bNKVHArsvmUoxEObbbQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6YAUxWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B2EC2BCB8;
	Tue,  5 May 2026 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777942282;
	bh=AbEYHwz7wUqGFpOv66696wdy+DfVTHLCpXtbizOhw9E=;
	h=From:To:Cc:Subject:Date:From;
	b=R6YAUxWqdoKW283Kv+cf/gSyXIDT60XH7GRYhWvnuPVauHSnI/I7pL2LGEQIEPIJ/
	 gvp3nCIQtHrVzkajxVy/RBr3/13Ks3rBMJnAIqKQHHGd+hbcg8Fjsb5snIRNdLX5ce
	 4LQsm702c+TpYx/8TkTkkicMl5XmcWK07+SqVBT+YD7psttG2cTbFpc0XkfPA4c8ez
	 D/eQBblIgM1CX7fZaKp9Gui5ZMrafRNXR++6ddeE29Qe8KgOzXx0VR05IWbkaNvd2b
	 oF57mCTlaO88xmlR5oe6P7vuZB99L5Ih9Wi27fr5dBoBqFvN+zpLvnaaSpUu+tRh8k
	 CvSzO27yAdiQw==
From: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>,
	Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET cgroup/for-7.2] cgroup: Per-css kill_css_finish deferral
Date: Mon,  4 May 2026 14:51:16 -1000
Message-ID: <20260505005121.1230198-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 79A844C58D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-15595-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

Follow-up to 93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir
until cgroup is depopulated") in cgroup/for-7.1-fixes, assumed merged
into cgroup/for-7.2.

That commit fixed the rmdir race by deferring kill_css_finish() at the
cgroup level so ->css_offline() runs only after PF_EXITING tasks have
left the cgroup. cgroup_apply_control_disable() has the same race shape
(PF_EXITING tasks pinning the dying controller's css while
->css_offline() runs), but fixing it requires switching
cgroup_lock_and_drain_offline()'s wait predicate from
percpu_ref_is_dying() to css_is_dying() to cover the deferral window -
too invasive for -stable, hence -7.2.

This series:

  - Replaces the cgroup-level deferral with a per-subsys-css mechanism
    so each controller css independently defers kill_css_finish() until
    its own subtree drains.

  - Pairs smp_mb()s in kill_css_sync() and css_update_populated() to
    interlock the synchronous- and deferred-fire decisions.

  - Wires cgroup_apply_control_disable() through the per-css deferral
    and switches drain_offline to wait on css_is_dying.

After the predicate switch, a +ctrl re-enable issued while a deferred
-ctrl is still draining blocks in TASK_UNINTERRUPTIBLE on offline_waitq
until the dying css drains. Pre-existing for rmdir; the apply path now
joins it.

Verified by 200001 iterations of repro-a72f73c4dd9b, per-commit
deterministic repros for the bug-chain commits, 5292 iterations of
stress-disable-control, and targeted ftrace coverage of rmdir,
apply_disable, and nested-destroy paths. No warnings or stalls.

Based on cgroup/for-7.2 (d8769544bde5) with cgroup/for-7.1-fixes
(93618edf7538) assumed merged.

Patches:

  [PATCH 1/5] cgroup: Inline cgroup_has_tasks() in cgroup.h
  [PATCH 2/5] cgroup: Annotate unlocked nr_populated_* accesses with READ_ONCE/WRITE_ONCE
  [PATCH 3/5] cgroup: Move populated counters to cgroup_subsys_state
  [PATCH 4/5] cgroup: Add per-subsys-css kill_css_finish deferral
  [PATCH 5/5] cgroup: Defer kill_css_finish() in cgroup_apply_control_disable()

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git cgroup-drain-for-7.2

 include/linux/cgroup-defs.h |  30 ++++---
 include/linux/cgroup.h      |  27 ++++++-
 kernel/cgroup/cgroup.c      | 188 +++++++++++++++++++++++++-------------------
 kernel/cgroup/cpuset-v1.c   |   2 +-
 kernel/cgroup/cpuset.c      |   2 +-
 5 files changed, 148 insertions(+), 101 deletions(-)

Thanks.

--
tejun

