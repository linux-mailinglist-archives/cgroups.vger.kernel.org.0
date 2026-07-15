Return-Path: <cgroups+bounces-17825-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OWmQCN1IV2p0IgEAu9opvQ
	(envelope-from <cgroups+bounces-17825-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:46:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B1575C05C
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:46:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=kLF7flyU;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17825-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17825-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C55093051AA9
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6163CEB90;
	Wed, 15 Jul 2026 08:43:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF853B4EBC;
	Wed, 15 Jul 2026 08:42:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104982; cv=none; b=DuRRe+YCgynKdIjVVW1gOsLOjEU3vTEdJowxp7cw5Rz7ts3AfONVo6oR/OmOiCmGnVWQuGgzcKMPwj7OKP/ui+jtn2BCzB7i4Zz+R6Sd8ZCA6RHkI0/O8uYEryIhuxHoLrSAF9EffIczx+nv7tHnlt3efykjzUykP/g+gs8/Vc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104982; c=relaxed/simple;
	bh=wM6CLola6B2GFF3988xRVkSeHvzK8Am3QE6zZhvJbBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l5b9PS2gEG18N9dcTo1mmBWe7sdhSK1Ki3BN6mwbLCDvqkv5E+Q1w+oXCMx6jrVdDqENIN12CVLwLn7M8unGhixupN7sFHEgq+W/GEcci5IDMfzXi1YWY8hwFOlCiMNx9DQkVIlNL8uAMozGdsXvnjvFZ6coiDkt0Lw1MFLDe6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kLF7flyU; arc=none smtp.client-ip=115.124.30.99
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784104974; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xfldyTNDHCFTa6fvmjV4MUiBwe8GJdvnuUp7ls7VEqg=;
	b=kLF7flyUQKyOa90P0RsgE5l5oreI5z9qCWq02jQMxY4J6Ld6tDR2jHGjzOfMZODKC7BeEbvt8bA/oEvrE2j7LzKADkmRDQqHXn9G5RnIa/bcnbmYhvMyqaqZliFiEMV7S0AEcxttpnTsRJVNZ2UkuFMt6ip5xU+bckApf6wbHVI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X78c-OI_1784104973;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X78c-OI_1784104973 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 16:42:54 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eadavis@qq.com,
	surenb@google.com,
	akpm@linux-foundation.org,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.1.y 0/2] sched/psi: fix race in pressure_write (CVE-2026-52991)
Date: Wed, 15 Jul 2026 16:42:51 +0800
Message-Id: <20260715084253.43276-1-lulie@linux.alibaba.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,vger.kernel.org,qq.com,google.com,linux-foundation.org,linux.alibaba.com];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eadavis@qq.com,m:surenb@google.com,m:akpm@linux-foundation.org,m:dust.li@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17825-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66B1575C05C

This patchset is same as that for 6.12.y.

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


