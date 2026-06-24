Return-Path: <cgroups+bounces-17217-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9EasIGN/O2pJYwgAu9opvQ
	(envelope-from <cgroups+bounces-17217-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:55:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 768BA6BBED2
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 08:55:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Zxjvgiav;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17217-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17217-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E10C6302CF1C
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 06:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8838D01B;
	Wed, 24 Jun 2026 06:46:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCB38B7B4;
	Wed, 24 Jun 2026 06:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782283598; cv=none; b=HjMjwpIPhKTxPYxwKovxLTTbKCUsbbQF7dOd3bLlhU1RZR9VsFZ9yaszFDc+NxzqsJmHVH0zFuQDXYcwXlVuCwkQO2MC1kKZnwiiT8HQvZw2un7LOMVM/f095hTMF5kyg8afpJHYF4NdqP+38V1yTPl7EJKLTk+n2rjw8audNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782283598; c=relaxed/simple;
	bh=mqeOltsU41ecYb4Pv/kiN9MaPfvWNqWaZUrDPH9aFTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4ZUkLh1HwpzNu2tNzh8kSMZDK244U46T1YTC2sK6oIm8diwKSezltoMli0AZnmd0ZKRrZyRgwNF4bxapNd2plbAxuQUtORRVTZRnZM12kBsjnG9JJdGPbsv6NgNwUJ73jMPoGMakL+8Mzncc+yAKACzdXALjViegqqzOsAQVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxjvgiav; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B364F1F00A3D;
	Wed, 24 Jun 2026 06:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782283597;
	bh=tQ5U75gZxbS9I0gcWftk3zWcpca0EZZnduvUXjeJdPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zxjvgiavs+9YgX5lq0yGW5X/md5UU2qGxBQtMfNzEZp1srr73so28YnRtBfTowj+E
	 PrNdMPdU9rbHd8u+KWrTWc0ClFZDDy5w3Ldi6UD8ZuNa7zdKpJCT1SdNm0OQunbsbC
	 RMKek2MweP5nbRJiFmeLwypVRjgcitKmM8dCY7H9OfOwUQzho/0PyKKBDlClUEArJS
	 7Ebe6ltPcXJVIG3QL4KxyWCc0GLDYeE2S2xOwq4z7/iwi2tTYmk8qSyH7J38GuiTI0
	 KcD/+ZdJ60ScXF4HalG7l/YdlHpjcwAllZBhOjrIy0PFUPNY1/aqIU1makpwdgrl7Y
	 L+Et3c+GtJJQg==
From: Yu Kuai <yukuai@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Zheng Qixing <zhengqixing@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Tang Yizhou <yizhou.tang@shopee.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] blk-cgroup: fix blkg list and policy data races
Date: Wed, 24 Jun 2026 14:46:21 +0800
Message-ID: <20260624064625.1743650-3-yukuai@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260624064625.1743650-1-yukuai@kernel.org>
References: <20260624064625.1743650-1-yukuai@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [5.84 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:email];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17217-lists,cgroups=lfdr.de];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:zhengqixing@huawei.com,m:hch@lst.de,m:yizhou.tang@shopee.com,m:nilay@linux.ibm.com,m:ming.lei@redhat.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fygo.io:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 768BA6BBED2

From: Yu Kuai <yukuai@fygo.io>

Hi,

This series fixes races around q->blkg_list and blkg policy data
lifetime.

Patch 1 protects blkg_destroy_all()'s q->blkg_list walk with
blkcg_mutex.

Patches 2-3 fix races between blkcg_activate_policy() and concurrent
blkg destruction.

Patch 4 factors the policy data teardown loop into a helper after the
race fixes.

Changes since v1:
- Drop the BFQ q->blkg_list patch because the current block tree already
  has a stronger fix in commit 17b2d950a3c0 ("block, bfq: protect async
  queue reset with blkcg locks").
- Add Reviewed-by tags from Tang Yizhou.

Yu Kuai (1):
  blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with
    blkcg_mutex

Zheng Qixing (3):
  blk-cgroup: fix race between policy activation and blkg destruction
  blk-cgroup: skip dying blkg in blkcg_activate_policy()
  blk-cgroup: factor policy pd teardown loop into helper

 block/blk-cgroup.c | 65 +++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

-- 
2.51.0

