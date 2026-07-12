Return-Path: <cgroups+bounces-17672-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3i8KNfXSU2pMfQMAu9opvQ
	(envelope-from <cgroups+bounces-17672-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:46:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D3745842
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 19:46:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bVmMcjmT;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17672-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17672-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4948F300A8FD
	for <lists+cgroups@lfdr.de>; Sun, 12 Jul 2026 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A567735DA43;
	Sun, 12 Jul 2026 17:46:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20264;
	Sun, 12 Jul 2026 17:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878382; cv=none; b=YmDiINhxtLlF4qC0QVB7uqDp9MbnMExfCmpnlpDb/1dt8LSlQiZ+2wkJ4O3AaJjga7tCB+SMW5j7Sb0H0s+nnp9a4M5jXKkKDz7JdlcNQ2D2N5lEOJhN65QLe0Ktkcv6ux16bXFxd2yVw/K/WrP1bg+oZrsTZD/hccAazQ1SaF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878382; c=relaxed/simple;
	bh=Ev5wa60DEOwIxPeL5BdpvBH45SUZ+vQMZKUDXqJJwKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnxaUhSE/P6wPXfIRykv1f/l5hdbpB7zQZy3zzluStNPahObwOnTXY8XHmA3ruetEcxIR6EVDeczRQR2yy5vbS65CoPzDejkSECX0GTOYBSKBt/FM0soFBxeJ0hpipatG6uKS9BhXk9T3mnB5GFd4fa/eI33ON6KvoDyx1pocO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVmMcjmT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61B11F000E9;
	Sun, 12 Jul 2026 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783878381;
	bh=kRg62pWz4XkNJnNd6d1PFoQbgUxWyXl6wWHRhz0Nf/4=;
	h=From:To:Cc:Subject:Date;
	b=bVmMcjmTIRgcQD44b2YW+cHjRS9OhfbABXW3GMNvXTXy/TQZCqqCw0vkkb/JjWNDv
	 OY+ZlQx3RQFcNXNmKs6iCVxOaMC3Oa0gmWh4gHqt9tdahcRK7Vr1GNxCsTH5BhJSzR
	 wYskKq2OeYRPTzcDHZC4apr5vbFSgjnkIoueVZS5Mk4etvBlfJpC4XkOCkjKvdkSIU
	 PAsqIeKNWVRaC4yJKLU/+2iJEH+FtEjnBPb1x6/h9s2WWfiWfI9WZ4kcyEX1OcQjW7
	 Iv6Yhs2SWd7S20D5nYrYWwf85y/QE1+Cm4A8hp8dz43K7+e76C6R1HnsIwSbffSpSu
	 vRbJhEkSMKnMg==
From: Tejun Heo <tj@kernel.org>
To: Matt Fleming <matt@readmodwrite.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Edward Adam Davis <eadavis@qq.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	"ziwei . dai" <ziwei.dai@unisoc.com>,
	"ke . wang" <ke.wang@unisoc.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	sched-ext@lists.linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2] sched/psi: Fix psimon fork deadlock and rtpoll_timer UAF
Date: Sun, 12 Jul 2026 07:46:17 -1000
Message-ID: <20260712174619.3553231-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17672-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:matt@readmodwrite.com,m:void@manifault.com,m:arighi@nvidia.com,m:changwoo@igalia.com,m:hannes@cmpxchg.org,m:surenb@google.com,m:peterz@infradead.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:zhaoyang.huang@unisoc.com,m:ziwei.dai@unisoc.com,m:ke.wang@unisoc.com,m:mfleming@cloudflare.com,m:sched-ext@lists.linux.dev,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:kernel-team@cloudflare.com,m:tj@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[manifault.com,nvidia.com,igalia.com,cmpxchg.org,google.com,infradead.org,qq.com,huaweicloud.com,unisoc.com,cloudflare.com,lists.linux.dev,vger.kernel.org,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 903D3745842

Hello,

v2: - Retagged sched/psi (was cgroup) (patch 1).
    - Added a fix for a pre-existing rtpoll_timer use-after-free that the
      Sashiko AI review flagged on the previous posting (patch 2).

v1: https://lore.kernel.org/r/20260710134945-psimon-fix-tj@kernel.org

a5b98009f16d ("sched/psi: fix race between file release and pressure
write") made pressure_write() fork the psimon kthread while holding
cgroup_mutex, which deadlocks against the sched_ext enable path blocking
forks before grabbing cgroup_mutex. Patch 1 moves the fork outside
cgroup_mutex. Patch 2 fixes the use-after-free from a schedule attempt
re-arming group->rtpoll_timer behind psi_trigger_destroy() by shutting
down the timer when the group is freed.

Matt, patch 1 is unchanged from the previous posting except for the
subject prefix, so test results against that posting still apply.

Peter, once these are reviewed and tested, how do you want them routed?
I can take them through the cgroup tree if that works for you.

Patches:

  [PATCH 1/2] sched/psi: Create the psimon kthread outside of cgroup_mutex
  [PATCH 2/2] sched/psi: Shut down rtpoll_timer in psi_cgroup_free()

Based on cgroup/for-7.2-fixes (97fef6025844).

 include/linux/psi.h    |  4 ++-
 kernel/cgroup/cgroup.c | 23 +++++++++++++++-
 kernel/sched/psi.c     | 75 +++++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 84 insertions(+), 18 deletions(-)

Thanks.

--
tejun

