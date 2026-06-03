Return-Path: <cgroups+bounces-16605-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWvrFSwvIGo4yQAAu9opvQ
	(envelope-from <cgroups+bounces-16605-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:42:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B6C6382C3
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:42:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16605-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16605-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BD0D30C7A04
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FED2D661C;
	Wed,  3 Jun 2026 13:27:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0D2C21F8;
	Wed,  3 Jun 2026 13:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493275; cv=none; b=spwJa2OtEM/hQL4E3Tgvp652OtJKNBfUK2Pq0I6pXuEtPtUa4rgL+uZbXrFLCsGEOtb1Qh6yr728W5GStfN5FuCCo4YNgM5WdoEDyv88tjFGLshuMNLMuEMJsyLRhU5cNU4+lypgCNdgo/3hmj0z/QozgKB0JbAEYAMzfIMeteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493275; c=relaxed/simple;
	bh=Tode6jzd2RHWnJg99+/egW5XlPIb2sKjlBLWEkFGGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gj+w8kHnI5dWcGgy0FAAAGt4GeC4NthiuykCLSB3CuryKP9LvvXcWAp74vGFXjKMOkhkNJ2IsJ7r80MLQdWS3tlB2dHa2QauXr4X8sJj/Qc51xrXj0NK+2cROmwoHD9Gml4Ek21I0nuBb26XkoAoHvaUQhfzJ4R6V+hfJiIZ4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277D21F00893;
	Wed,  3 Jun 2026 13:27:49 +0000 (UTC)
From: Yu Kuai <yukuai@fygo.io>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] blk-cgroup: fix blkg list and policy data races
Date: Wed,  3 Jun 2026 21:27:40 +0800
Message-ID: <cover.1780492756.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[fygo.io : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16605-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:from_mime,fygo.io:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3B6C6382C3

This small series fixes races between blkg destruction, q->blkg_list
iteration, and blkcg policy activation.

The first two patches serialize q->blkg_list walks in blkg_destroy_all()
and BFQ writeback weight-raising teardown with blkcg_mutex. The next two
patches close policy activation races with concurrent blkg destruction,
including skipping blkgs that are already dying. The final patch factors
the common policy data teardown loop.

This uses blkcg_mutex rather than extending queue_lock coverage because
the races are about blkg list visibility and policy-data lifetime, not
request-queue dispatch state. blkg_free_workfn() already uses
blkcg_mutex to serialize policy-data freeing with policy deactivation
and removes blkgs from q->blkg_list only after that teardown. Taking the
same mutex around the remaining q->blkg_list walkers gives one sleepable
serialization point for blkg lifetime, avoids adding more queue_lock
nesting, and prepares the follow-up conversion that removes queue_lock
from blkcg list protection entirely.

Yu Kuai (2):
  blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
    blkcg_mutex
  bfq: protect q->blkg_list iteration in bfq_end_wr_async() with
    blkcg_mutex

Zheng Qixing (3):
  blk-cgroup: fix race between policy activation and blkg destruction
  blk-cgroup: skip dying blkg in blkcg_activate_policy()
  blk-cgroup: factor policy pd teardown loop into helper

 block/bfq-cgroup.c  |  3 ++-
 block/bfq-iosched.c |  6 +++++
 block/blk-cgroup.c  | 65 ++++++++++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 31 deletions(-)

-- 
2.51.0

