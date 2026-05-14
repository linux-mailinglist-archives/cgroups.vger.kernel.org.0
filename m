Return-Path: <cgroups+bounces-15956-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB4gL8lCBmqWhQIAu9opvQ
	(envelope-from <cgroups+bounces-15956-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:46:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C3F54722E
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2654E3011F29
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302F3A7581;
	Thu, 14 May 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrWSgfhX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370772DEA6B;
	Thu, 14 May 2026 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795205; cv=none; b=aC5wWW32xnyosya6d8vWaKi77SJXrXplqJRkKKWD1AkiwhTp4F1cPS/lPGmRDKw9aaRaivqkWpakeLHrWjantbE6peQZuSZLYh1xEJmtiCH4qHuEvizdR7ze7LJBKscVR2fEWZj+wtyFpJWJKthw6ehmnkPn22RAE/dCC/Ek5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795205; c=relaxed/simple;
	bh=dFMza+LOA3j1RPMzHZrCKeh2X8WHzsClp5b7OuzWCkE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=osBwVhWP6Upx3ajFGDp5plTGjrkRYDReIi18AqJ/lUGn4y1cuI3GIA4K+rLQ7o59jPC3QZWxZOpRK9JcBgIh5VlGA4jXN3tbEMGsScQ6w0MpXpqaOWV1JbKTM2TltGp1L47KfxZyt/daT3wowup1LcXw80fUaVDjoVMQwESNaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrWSgfhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01242C2BCB3;
	Thu, 14 May 2026 21:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778795205;
	bh=dFMza+LOA3j1RPMzHZrCKeh2X8WHzsClp5b7OuzWCkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrWSgfhXvccYwpeJvRT0RlsBcAoymoqv6ki2HIR9Wbsux4LjMXaTRNnONO10DIeR+
	 l9XVrIT6pB0j6pZn350f6tzWcojhA+kl4VYQFfsQIIZA2zTr3P4vKmJAy9qKp2ymLg
	 midi2hZIH2w+UFOnljU182VP6v5SzHYmFag6tgjGLsqW7guOragbw5Mwk0ATu44xiE
	 p5RmzW/fJnMSr5JZULqCroB3LNduHe3wFkPAVvGSALDnEP9l4IW63SwI1NT9Kkak85
	 upbWfcFbRDE7jEewcz6IxkGlVtPFsO6U0BZwKN8B68ESCY9SNS13EWU06xuVKHjAPI
	 4g3ACno5RI0ZA==
Date: Thu, 14 May 2026 11:46:44 -1000
Message-ID: <4f49602d35d987e029b8e92a577f0c60@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutný <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH cgroup/for-next 0/4] cgroup/cpuset: Support multiple source/destination cpusets for cpuset_*attach()
In-Reply-To: <20260514170240.575156-1-longman@redhat.com>
References: <20260514170240.575156-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 25C3F54722E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15956-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Quick AI-assisted review pass; passing the points along for human eyes.

Patch 4:

- The leader loop comment says "Only v1 supports memory_migrate", but
  CS_MEMORY_MIGRATE is set unconditionally on v2 cpusets in
  cpuset_css_alloc(). With v2 controller-disable folding children with
  differing effective_mems into the parent, picking a single
  llist_entry(src_cs_head.first, ...) as oldcs passes the wrong source
  nodemask to cpuset_migrate_mm() for every leader whose actual source
  differs. Looks like the source needs to be looked up per leader.

- cs->old_mems_allowed updates are inconsistent across destinations: the
  mid-loop transition assigns cs->effective_mems (raw) while the tail
  assignment uses cpuset_attach_nodemask_to (after guarantee_online_mems).
  The v2 fast-path also updates only the first-task cs, leaving other
  destinations on dst_cs_head stale.

Patch 3:

- Changelog says "the newly cloned task isn't the group leader", but for
  CLONE_INTO_CGROUP without CLONE_THREAD the new task is its own
  group_leader, so the new mpol_rebind_mm() block in cpuset_attach_task()
  does run from cpuset_fork(). Either acknowledge as an incidental
  improvement or guard the new path.

Patch 1:

- alloc_dl_bw() reads confusingly next to the scheduler's dl_bw_alloc()
  while doing more (pick cpu, call dl_bw_alloc, record cs->dl_bw_cpu).
  Something like cpuset_reserve_dl_bw() would be clearer.

- The relocated "Mark attach is in progress" comment sits inside a
  braceless else; either move it above the if (ret) or brace both arms.

Patch 2 looked clean.

Thanks.

--
tejun

