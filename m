Return-Path: <cgroups+bounces-17485-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l6NoFlxkSWqp1AAAu9opvQ
	(envelope-from <cgroups+bounces-17485-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:51:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0CD7084EA
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 21:51:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eyGDj+l9;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17485-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17485-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABEE93025D34
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448C2FD665;
	Sat,  4 Jul 2026 19:51:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913BF12FF69;
	Sat,  4 Jul 2026 19:51:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194706; cv=none; b=dJw1M9tQFxTmFTs7hFoPKxWLyMqd4DpYp1aW4JAYoNFgNhfL/EKqBGKfs7PtnkN67Tlgbf0ec2QzjF1lVOQ0jXk5jJ5jZPMtytyF1864FS0YHCyBuBpi6ykhJfMSBMJuVPZ4QNzi2e2omV8dvgm2NSV1tf+Bs1iyDKcr0Eboq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194706; c=relaxed/simple;
	bh=SzNrAnwW1lRUyp0FZqIxKmarVC5X/hKSnp3uWTm97d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgMzkZSQ0YOcYcq/uWaz/0WgIHt5OC50VM4GLb7ey0jhxUdLYIsax21CgPKr+yuqmLnhcq3uL4Wl3n0NGorgC84WG4KdWiyUy6SHWTE58EyCBdITHWQglzyCdLqmXtvV5mYHRR4hi1kpTP4kI7rYUs1pZuFRBo00XwWhzJfxrnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyGDj+l9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6A41F000E9;
	Sat,  4 Jul 2026 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783194705;
	bh=XBefwgHbcKa8lF9fx4CimAkm/mOI1OLeJiYAKnbJMVM=;
	h=From:To:Cc:Subject:Date;
	b=eyGDj+l9ou1O5f59vydhkXwbA3fDVbVY5wPAk+z0treKXGPKqXslTE3lUBAsGocd7
	 j4HWvk4BMNpWicrOIm4gLY3YVgF3Q6UEhK7cReG0YCnUSyd7h/IgSYc0DKYXfWNGK2
	 4NTeA2Sr3moCGhheLA2o94lnROHcghNi1lucHAcN49jDn2x5ypWvXlRjRz19Rb4+79
	 D3BUC+ZGPqCZb8zqM+3k0kbrkEvOlPw3Ll9PYCZOu2J/UuiBjkZaboSHjLU787V9b2
	 JaEC6vggxII6Lo1jd3LNPsKr4cE4QactM2ublptM5aeMxzXzOBZq6U+mCcpHFheYal
	 aWylKO5MUd0xw==
From: Yu Kuai <yukuai@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	linux-bcache@vger.kernel.org
Subject: [RFC PATCH v1 00/17] blk-cgroup: protect blkgs with blkcg_mutex
Date: Sun,  5 Jul 2026 03:51:07 +0800
Message-ID: <20260704195124.1375075-1-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17485-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	URIBL_MULTI_FAIL(0.00)[fygo.io:server fail,vger.kernel.org:server fail,sea.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A0CD7084EA

From: Yu Kuai <yukuai@fygo.io>

This RFC moves queue-local blkg topology synchronization from
q->queue_lock to q->blkcg_mutex.

q->queue_lock is a hot block-layer spinlock used by request queue runtime
paths, and it is also used in irq-disabled or otherwise atomic contexts.
Using it to protect blkg topology makes blkg lookup, creation,
destruction, policy activation, and policy-state walks inherit those atomic
locking constraints.  That forces awkward preallocation schemes such as
radix-tree preloading and prevents missing-blkg creation from sleeping,
even though blkg creation is a blkcg control-plane operation rather than a
queue dispatch fast-path operation.

q->blkcg_mutex is a better fit for blkg protection because it is already a
queue-local blkcg lock, it can serialize the full lookup/create/destroy and
policy activation path, and it allows allocation and parent lookup to run
from sleepable contexts.  Moving blkg topology under q->blkcg_mutex also
separates blkcg topology from queue runtime locking, reducing queue_lock
scope and making the locking rules for blkcg policy users explicit.

bio_set_dev() and bio allocation with a bdev can associate a bio with the
destination queue's blkg.  Once missing blkg creation is serialized by
q->blkcg_mutex, those helpers may sleep when they create a blkg.  The first
part of the series therefore audits callers that can reach these helpers
from completion, spinlocked, irq-disabled, GFP_NOWAIT, or other
non-blocking paths, and either moves association to process context or uses
a nowait association path that avoids sleeping.

The preparatory patches cover NVMe multipath requeue, dm-thin and
dm-snapshot map paths, blk-throttle's private runtime lock, atomic bio
allocation helpers, bcache, dm-bufio, dm-pcache, DM NOWAIT clones/remaps,
and BFQ's locked cgroup update path.  The final blkcg patches then move
blkg lookup/create/destroy, policy activation, and configuration
preparation to q->blkcg_mutex; remove radix-tree preloading; move blkg
allocation into blkg_create(); and share creation code between bio
association and config preparation.

This is RFC because the locking conversion changes a central blkcg lifetime
path and relies on all non-sleepable bio association users either being
converted or tolerating nowait association failure.

One intentional tradeoff is left in the nowait paths.  They first associate
with an existing blkg.  If a thread issues IO to a queue for the first time
from a GFP_NOWAIT or otherwise non-blocking path, the cgroup's blkg for
that queue may not exist yet.  After blkg topology moves to q->blkcg_mutex,
preemptible task-context callers try q->blkcg_mutex and attempt blkg
creation.  Once allocation moves into blkg_create(), that opportunistic
nowait creation uses GFP_ATOMIC.  If the caller is in atomic context,
q->blkcg_mutex is contended, or allocation fails, the nowait helper still
fails and the caller needs to retry from a blocking context, defer the
association, or fall back to an existing slow path.

Patch layout:

Patch 1: move NVMe multipath failover bio retargeting to requeue work so
bio_set_dev() runs from process context instead of completion context.

Patches 2-3: remove or avoid bio_set_dev() while dm-thin and dm-snapshot
locks are held, and restore blkcg association later where needed.

Patch 4: give blk-throttle its own runtime-state lock so blkcg topology
can be moved away from queue_lock.

Patches 5-7: add bio_alloc_atomic(), make bio association nowait-aware,
and make bio allocation with a bdev fail rather than sleep for
non-blocking callers.

Patches 8-12: convert bcache, dm-bufio, dm-pcache, block helper
allocations, and DM NOWAIT remaps/clones to the new nowait or deferred
association model.

Patch 13: avoid a sleeping blkg lookup from BFQ while bfqd->lock is held.

Patch 14: protect queue-local blkg lookup, creation, destruction, policy
activation, and policy state walks with q->blkcg_mutex.  This also makes
preemptible nowait bio association try q->blkcg_mutex instead of failing
immediately after an RCU lookup miss.

Patch 15: remove radix-tree preloading after blkg creation no longer runs
under queue_lock.

Patch 16: allocate blkgs inside blkg_create() and use GFP_ATOMIC for the
nowait bio-association trylock creation path.

Patch 17: share blkg creation between bio association and config
preparation.

Yu Kuai (17):
  nvme-multipath: retarget failedover bios from requeue work
  dm thin: avoid bio_set_dev under pool lock
  dm snapshot: avoid bio_set_dev in locked map paths
  blk-throttle: protect throttle state with td lock
  block: add bio_alloc_atomic() for atomic bio users
  blk-cgroup: support non-blocking bio association
  block: support non-blocking bio allocation with a bdev
  bcache: avoid sleeping blkg association from locked paths
  dm bufio: avoid blkg association from GFP_NOWAIT bio init
  dm pcache: handle non-blocking bio clone init failure
  block: avoid scheduling from non-blocking helper allocations
  dm: avoid sleeping blkg association from NOWAIT remaps
  bfq: avoid blkg lookup from locked cgroup update
  blk-cgroup: protect blkgs with blkcg_mutex
  blk-cgroup: remove blkg radix tree preloading
  blk-cgroup: allocate blkgs in blkg_create
  blk-cgroup: share blkg creation between lookup and config prep

 block/bfq-cgroup.c                 |  26 +-
 block/bio.c                        |  50 +++-
 block/blk-cgroup.c                 | 397 ++++++++++++-----------------
 block/blk-cgroup.h                 |  16 +-
 block/blk-crypto-fallback.c        |   2 +-
 block/blk-iocost.c                 |   5 +-
 block/blk-iolatency.c              |   7 +-
 block/blk-lib.c                    |   3 +-
 block/blk-map.c                    |   7 +-
 block/blk-throttle.c               |  93 +++++--
 drivers/md/bcache/journal.c        |   9 +-
 drivers/md/bcache/request.c        |   4 +-
 drivers/md/dm-bufio.c              |   9 +-
 drivers/md/dm-linear.c             |   2 +-
 drivers/md/dm-pcache/backing_dev.c |  10 +-
 drivers/md/dm-snap.c               |  29 ++-
 drivers/md/dm-stripe.c             |   6 +-
 drivers/md/dm-switch.c             |   2 +-
 drivers/md/dm-thin.c               |   3 -
 drivers/md/dm-unstripe.c           |   2 +-
 drivers/md/dm.c                    |  28 +-
 drivers/md/md.c                    |   2 +-
 drivers/nvdimm/nd_virtio.c         |  11 +-
 drivers/nvme/host/multipath.c      |   4 +-
 fs/gfs2/lops.c                     |   3 +-
 fs/ocfs2/cluster/heartbeat.c       |  15 +-
 include/linux/bio.h                |  53 ++--
 include/linux/device-mapper.h      |   8 +
 include/linux/writeback.h          |   2 +-
 mm/page_io.c                       |   2 +-
 30 files changed, 467 insertions(+), 343 deletions(-)


base-commit: a1c8bdbbd72564cebb0d02948c1ed57b80b2e773
-- 
2.51.0

