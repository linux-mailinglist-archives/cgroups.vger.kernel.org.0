Return-Path: <cgroups+bounces-17823-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4cyDd9FV2rJIQEAu9opvQ
	(envelope-from <cgroups+bounces-17823-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:33:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD175BEBF
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:33:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Krlh4gLe;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17823-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17823-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4941830548FC
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54183CC334;
	Wed, 15 Jul 2026 08:32:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7673CDBD3;
	Wed, 15 Jul 2026 08:32:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104379; cv=none; b=Z1in2WP9yNMj8s9BOFwMEeuCEIomfDiZZetJvWWaKX7K+fvLlnwLQ1JvCaC3/+NaQEE7kXWLMQj5oxpPGkx+FgRLxzirO846a1k7Gz9k++HRcv3vhooVTmlUlH12Nj9OV+0+WYe9366HPSATdQlDK6M2Dqiu6oXARCXJaiXOszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104379; c=relaxed/simple;
	bh=Ezo4kpSOexsqvmKsAzG7XnZeQCrPBWkKyCwMiOE7nrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jh5xy/gVWsINlewN9YSzkBppciztoepyudqrMm8tMwJIfdPRPT2bcRwS3cAzQ9iHb9DW/o1MHdqkiy+mJTOHL73DUcRNaqqIZZq9VW2VThGx++f/cQAXl57jCMYuwFyZ5w93m0BOY5ge3DV5ydLKF0GoUYE0mMVmkOTUIa0m1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Krlh4gLe; arc=none smtp.client-ip=115.124.30.98
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784104367; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LpLHc0gQHrfcQjAgQsVGU8GKc379gROaUr2U1y9iHZg=;
	b=Krlh4gLetinfqlpFgQ4mxp3FxsqMMyRXzTifAK5zq7B8cjWMq8yuO13vrHFQPEr/ESnqXUew8Cuy1MtyG7bD5OKWVagY+y28LttNxmNUXpendpo0ZrqsJipDDTH4DCd1QfVH4cihWSHd7UUE1+qRrLtdIGDWZY6IX4tuzzPOQ0U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X78YblO_1784104366;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X78YblO_1784104366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 16:32:46 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: chenridong@huawei.com,
	tj@kernel.org,
	lulie@linux.alibaba.com,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eadavis@qq.com,
	chenridong@huaweicloud.com,
	akpm@linux-foundation.org,
	surenb@google.com,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.12.y 0/2] sched/psi: fix race in pressure_write (CVE-2026-52991)
Date: Wed, 15 Jul 2026 16:32:43 +0800
Message-Id: <20260715083245.32115-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17823-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,linux.alibaba.com,bytedance.com,cmpxchg.org,vger.kernel.org,qq.com,huaweicloud.com,linux-foundation.org,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:chenridong@huawei.com,m:tj@kernel.org,m:lulie@linux.alibaba.com,m:lizefan.x@bytedance.com,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eadavis@qq.com,m:chenridong@huaweicloud.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:dust.li@linux.alibaba.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FD175BEBF

Backport of the CVE-2026-52991 fix.

  1/2 (94a4acfec146) clear of->priv on release, turning the UAF into an
      easier-to-detect NULL deref.
  2/2 (a5b98009f16d, the CVE fix) extend cgroup_mutex to cover all
      of->priv accesses, read ctx after taking the kn lock, and NULL-check
      of->priv. It depends on 1/2 as discussed in [0].

[0] https://lore.kernel.org/all/8a06c5c3-8f7a-4252-a3b1-0c0d812e2654@oracle.com/

Chen Ridong (1):
  cgroup/psi: Set of->priv to NULL upon file release

Edward Adam Davis (1):
  sched/psi: fix race between file release and pressure write

 kernel/cgroup/cgroup.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--
2.47.3


