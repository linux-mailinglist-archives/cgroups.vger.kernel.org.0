Return-Path: <cgroups+bounces-15629-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKEhLsZp+mlbOwMAu9opvQ
	(envelope-from <cgroups+bounces-15629-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 00:05:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3D4D430B
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF288301E25E
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E184A33FC;
	Tue,  5 May 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpa+XVhw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867E61FC110;
	Tue,  5 May 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018740; cv=none; b=VbHS9Rstkzqj6HZf1cNMCbEPpW0dFfR/DWOwxM7XjIPYfxkv5q9QS83BhzRkH/IKHIZ930prNxJgOKRrE1fiV2ENpCmLhweAoHyC09Gk+14DO8IN8DOyrop2wY8dNrBr7a+BSlpi9l++/tvXLxDifTP2PRALFRQgMiNd5Ia4cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018740; c=relaxed/simple;
	bh=MF76jSWcfmbdQcv7mOkVB8lgG+j2xi80v/OC7YRzDOw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=XMPGLpr7DelmBS0baB4ZdujHtD4trP2NDiPWVxsMuPxisKs25nxHvuNs+c39j+J4BzVC7LhE53MYTZkGnveYNyQIM0AKTjmjPstY99kCme6v7CbMTPanHdqO3/mM/wwkIwEgyxD33BuWXtX38D/0T5a8EEF/RI51Pvhcaj4LHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpa+XVhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F65DC2BCB4;
	Tue,  5 May 2026 22:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018740;
	bh=MF76jSWcfmbdQcv7mOkVB8lgG+j2xi80v/OC7YRzDOw=;
	h=Date:From:To:Cc:Subject:From;
	b=Mpa+XVhwdyZByd7yejGkvXXWl44yx7duLRlBAQ7qCaaO7gsJRJa62143Oirh83QVr
	 nM8U5wZyM7B123nfDKU/W3mpDMcjHOrWWpP8Usa98v7HaQwXzDoaLT1S7pdI0iOOvD
	 W35YqyNONrpAPTBiDH5vv5xT7iZnvzUlm68fI6A7QxtVATPFvM23o8Tq8hqRjGCiLo
	 KOYDJ8Css+qfQ8FMwre/WnYMUKop9w94NbCI5S4kVBv+GZqdpkewp1ezPZVjrBr1sC
	 JGTIa1rpapqL93+2OFuK9OvCyVvwmCF1XzraEhaZ5fme6QJKJKlUL5QUff4FDcYBEk
	 xJyIzFeCQHBzA==
Date: Tue, 05 May 2026 12:05:39 -1000
Message-ID: <f5258b93b0a513c90b4129177a2eb50d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup: Fixes for v7.1-rc2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: BFC3D4D430B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15629-lists,cgroups=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello,

The following changes since commit 981cd338614c96070cf9854679014fd027c1fb1d:

  docs: cgroup: fix typo 'protetion' -> 'protection' (2026-04-27 07:55:40 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc2-fixes

for you to fetch changes up to d8769544bde51b0ac980d10f8fe9f9fed6c95995:

  docs: cgroup-v1: Update charge-commit section (2026-05-04 11:02:12 -1000)

----------------------------------------------------------------
cgroup: Fixes for v7.1-rc2

- During v6.19, cgroup task unlink was moved from do_exit() to after the
  final task switch to satisfy a controller invariant. That left the kernel
  seeing tasks past exit_signals() longer than userspace expected, and
  several v7.0 follow-ups tried to bridge the gap by making rmdir wait for
  the kernel side. None held up. The latest is an A-A deadlock when rmdir
  is invoked by the reaper of zombies whose pidns teardown the rmdir itself
  is waiting on, which points at the synchronizing approach being
  fundamentally wrong:

  - Take a different approach: drop the wait, leave rmdir's user-visible
    side returning as soon as cgroup.procs is empty, and defer the css
    percpu_ref kill that drives ->css_offline() until the cgroup is fully
    depopulated.

  - Tagged for stable. Somewhat invasive but contained. The hope is that
    fixing forward sticks. If not, the fallback is to revert the entire
    chain and rework on the development branch.

  - Doesn't plug a pre-existing analogous race in
    cgroup_apply_control_disable() (controller disable via subtree_control).
    Not a regression. The development branch will do the more invasive
    restructuring needed for that.

- Documentation update for cgroup-v1 charge-commit section that still
  referenced functions removed when the memcg hugetlb try-commit-cancel
  protocol was retired.

----------------------------------------------------------------
T.J. Mercier (1):
      docs: cgroup-v1: Update charge-commit section

Tejun Heo (1):
      cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated

 Documentation/admin-guide/cgroup-v1/memcg_test.rst |   6 +-
 include/linux/cgroup-defs.h                        |   4 +-
 kernel/cgroup/cgroup.c                             | 250 ++++++++++-----------
 3 files changed, 121 insertions(+), 139 deletions(-)

Thanks.

--
tejun

