Return-Path: <cgroups+bounces-16609-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wnZ5AHsvIGpDyQAAu9opvQ
	(envelope-from <cgroups+bounces-16609-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:43:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E86FF6382EE
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 15:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16609-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16609-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fygo.io (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EEBA31156C3
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE783168EF;
	Wed,  3 Jun 2026 13:28:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECF310651;
	Wed,  3 Jun 2026 13:28:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493288; cv=none; b=hILEopbn+VGy4gk3DtkkHQMwX+bzf1duenHr77tDjWHFW5C4tt7rSO8VDJkMgG0aEJkEsC1zwIjgVjLV/dO60Vu9VWjC9gLRKkdYhUgb34Pop9dkG27+jX2yj7cXMkl7QnGonKd8HTQKvor3VJANvwzsuQ/GzlS+l1IX+VPnhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493288; c=relaxed/simple;
	bh=oisoRXJ2gtTtelAnL7ChS1gY+yJ04+5vl2kmyW2L3Jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9fP7greUnqrIEaO3ttluoJxkLEnNmR/lkL+VAJKWY6oiYsEL8IzEzSLNuPRjZRDH1+YaSnPsgQ4SGGQ0m4ZFWFB8LwzQrQ2beJdEJOqt3gi9qCijkbQ2fmHPhqFe9LZTmDeo3UfoMJZrn5YIE+DiNNSTvm2wbJpOH4hlJewSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6CB1F00898;
	Wed,  3 Jun 2026 13:28:03 +0000 (UTC)
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
Subject: [PATCH 4/5] blk-cgroup: skip dying blkg in blkcg_activate_policy()
Date: Wed,  3 Jun 2026 21:27:44 +0800
Message-ID: <aefd4e655bb5825513eeb1b2c0ed3edd39b44241.1780492756.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780492756.git.yukuai@fygo.io>
References: <cover.1780492756.git.yukuai@fygo.io>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16609-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,toxicpanda.com,gmail.com,linux.ibm.com,acm.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:tom.leiming@gmail.com,m:nilay@linux.ibm.com,m:bvanassche@acm.org,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yukuai@fygo.io,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fygo.io:mid,fygo.io:from_mime,fygo.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E86FF6382EE

From: Zheng Qixing <zhengqixing@huawei.com>

When switching IO schedulers on a block device, blkcg_activate_policy()
can race with concurrent blkcg deletion, leading to a use-after-free in
rcu_accelerate_cbs.

T1:                               T2:
                                  blkg_destroy
                                  kill(&blkg->refcnt) // blkg->refcnt=1->0
                                  blkg_release // call_rcu(__blkg_release)
                                  ...
                                  blkg_free_workfn
                                  ->pd_free_fn(pd)
elv_iosched_store
elevator_switch
...
iterate blkg list
blkg_get(blkg) // blkg->refcnt=0->1
                                  list_del_init(&blkg->q_node)
blkg_put(pinned_blkg) // blkg->refcnt=1->0
blkg_release // call_rcu again
rcu_accelerate_cbs // uaf

Fix this by checking hlist_unhashed(&blkg->blkcg_node) before getting
a reference to the blkg. This is the same check used in blkg_destroy()
to detect if a blkg has already been destroyed. If the blkg is already
unhashed, skip processing it since it's being destroyed.

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/blk-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 007dfc4f9c59..b479a9796fb3 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1623,10 +1623,12 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
 		if (blkg->pd[pol->plid])
 			continue;
+		if (hlist_unhashed(&blkg->blkcg_node))
+			continue;
 
 		/* If prealloc matches, use it; otherwise try GFP_NOWAIT */
 		if (blkg == pinned_blkg) {
 			pd = pd_prealloc;
 			pd_prealloc = NULL;
-- 
2.51.0


