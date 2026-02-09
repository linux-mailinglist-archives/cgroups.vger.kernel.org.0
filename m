Return-Path: <cgroups+bounces-13812-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKrHJNI0iml5IQAAu9opvQ
	(envelope-from <cgroups+bounces-13812-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 20:26:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F29114110
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 20:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 85B32300AB27
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F54218B6;
	Mon,  9 Feb 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMFFhM0l"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDF3A1D05;
	Mon,  9 Feb 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665165; cv=none; b=n+he3tzZAdvmf239epx4OHUGgC7RPujMxARiPAUoXy6/yYpax7QTQlFr15aIwH8UOmp5lLjRKwhcmsWcOZYJFu3NPMO+p31eWwGncEW02bysbhGnZvpplw0tRqYyFRtQOMrZi5CWZxMez3id5DADgcOu3TdMJFgZV1gj3PZcG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665165; c=relaxed/simple;
	bh=rle6Uex1508iZQBpSPiGj6bcJDIcluSPpGjT7rsa0y0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=SdmQOACWMvbKrYUIjdQgodFFs8UFom+FsMjQJYbAUMzKwuVblDjkNUkECqRZ2rKIMcDIxfeJIFM4ZzvEp04fW4fDChMiqpzp9JY71pgmukDEPPGnPHBGksmd9FJdrGCg60w8Z7cw6/thK1Isr1Wy894Mx+fb507j/xrwZvpmaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMFFhM0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCCAC116C6;
	Mon,  9 Feb 2026 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770665165;
	bh=rle6Uex1508iZQBpSPiGj6bcJDIcluSPpGjT7rsa0y0=;
	h=Date:From:To:Cc:Subject:From;
	b=fMFFhM0lWBnsbIs/RXjbMEYbeQdbEruyFw7mIucyBT8uBg3JInFhnTa6UDWQdflV0
	 N18/oamY6cO/sGZGNNhDImgKyScTcQC3ta7gUR1ZDgjCIu2dfCQEHRLvTtzfl5VVyc
	 LgMbURMSFDwv3YGT+Vtb+EXOhX+xO8stIZpwpnFzkVw/m+WSvRpVXk7SIGCj/bgP8R
	 /5HZvSzrq2LqtCltblvt5Htyo8nOqPLAXlXchKiFpm+kjgnQOXaODw1Ln8Bc8g4EhJ
	 x7eOWPgI9XJqxngFRuOsek3nNP65eNt2oiAdXoDc/vUBQKS4oFnolO/s7yfSdDGKfP
	 IqGTTGOWiacmw==
Date: Mon, 09 Feb 2026 09:26:04 -1000
Message-ID: <b471e5dde7d713cf4ef69b41c3d3d3ae@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v6.20
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13812-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35F29114110
X-Rspamd-Action: no action

Hi Linus,

The following changes since commit 3309b63a2281efb72df7621d60cc1246b6286ad3:

  cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated (2025-12-08 08:26:56 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.20

for you to fetch changes up to 8b1f3c54f930c3aeda0b5bad97bc317fc80267fd:

  cpuset: fix overlap of partition effective CPUs (2026-02-01 06:49:52 -1000)

----------------------------------------------------------------
cgroup: Changes for v6.20

- cpuset changes:

  - Continue separating v1 and v2 implementations by moving more
    v1-specific logic into cpuset-v1.c.

  - Improve partition handling. Sibling partitions are no longer
    invalidated on cpuset.cpus conflict, cpuset.cpus changes no longer
    fail in v2, and effective_xcpus computation is made consistent.

  - Fix partition effective CPUs overlap that caused a warning on cpuset
    removal when sibling partitions shared CPUs.

- Increase the maximum cgroup subsystem count from 16 to 32 to
  accommodate future subsystem additions.

- Misc cleanups and selftest improvements including switching to
  css_is_online() helper, removing dead code and stale documentation
  references, using lockdep_assert_cpuset_lock_held() consistently,
  and adding polling helpers for asynchronously updated cgroup
  statistics.

----------------------------------------------------------------
Chen Ridong (11):
      cgroup: switch to css_is_online() helper
      cpuset: Remove unnecessary checks in rebuild_sched_domains_locked
      cpuset: add lockdep_assert_cpuset_lock_held helper
      cpuset: add cpuset1_online_css helper for v1-specific operations
      cpuset: add cpuset1_init helper for v1 initialization
      cpuset: move update_domain_attr_tree to cpuset_v1.c
      cpuset: separate generate_sched_domains for v1 and v2
      cpuset: remove v1-specific code from generate_sched_domains
      cpuset: remove dead code in cpuset-v1.c
      cgroup: increase maximum subsystem count from 16 to 32
      cpuset: fix overlap of partition effective CPUs

Guopeng Zhang (3):
      selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key with retries
      selftests: cgroup: make test_memcg_sock robust against delayed sock stats
      selftests: cgroup: Replace sleep with cg_read_key_long_poll() for waiting on nr_dying_descendants

Tejun Heo (1):
      cgroup: Remove stale cpu.rt.max reference from documentation

Waiman Long (5):
      cgroup/cpuset: Streamline rm_siblings_excl_cpus()
      cgroup/cpuset: Consistently compute effective_xcpus in update_cpumasks_hier()
      cgroup/cpuset: Don't fail cpuset.cpus change in v2
      cgroup/cpuset: Don't invalidate sibling partitions on cpuset.cpus conflict
      cgroup/cpuset: Move the v1 empty cpus/mems check to cpuset1_validate_change()

Zhao Mengmeng (1):
      cpuset: replace direct lockdep_assert_held() with lockdep_assert_cpuset_lock_held()

 Documentation/admin-guide/cgroup-v2.rst            |  44 +-
 fs/fs-writeback.c                                  |   2 +-
 include/linux/cgroup-defs.h                        |   8 +-
 include/linux/cpuset.h                             |   2 +
 include/linux/memcontrol.h                         |   2 +-
 include/trace/events/cgroup.h                      |   2 +-
 kernel/cgroup/cgroup-internal.h                    |   8 +-
 kernel/cgroup/cgroup-v1.c                          |  12 +-
 kernel/cgroup/cgroup.c                             |  50 +--
 kernel/cgroup/cpuset-internal.h                    |  54 ++-
 kernel/cgroup/cpuset-v1.c                          | 271 ++++++++++-
 kernel/cgroup/cpuset.c                             | 499 +++++----------------
 kernel/cgroup/debug.c                              |   2 +-
 mm/memcontrol.c                                    |   2 +-
 mm/page_owner.c                                    |   2 +-
 tools/testing/selftests/cgroup/lib/cgroup_util.c   |  21 +
 .../selftests/cgroup/lib/include/cgroup_util.h     |   5 +
 tools/testing/selftests/cgroup/test_cpuset_prs.sh  |  29 +-
 tools/testing/selftests/cgroup/test_kmem.c         |  33 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   |  20 +-
 20 files changed, 593 insertions(+), 475 deletions(-)

Thanks.

--
tejun

