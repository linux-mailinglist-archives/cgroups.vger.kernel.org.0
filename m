Return-Path: <cgroups+bounces-14748-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMtNKPu+sGm4mgIAu9opvQ
	(envelope-from <cgroups+bounces-14748-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D525A3A7
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 973E83031238
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17AB36DA09;
	Wed, 11 Mar 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgHUGpls"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519DD371067
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 01:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773190882; cv=none; b=dvQH82qroBzQRu7nFyd938rDKId9p665qGnnJ2kt0QfzWKHr4X1Q/oSYJTjZOfLeHU7pm1T2JeMZmEytJBt3apEmB6lHOst5tBt5rmH9lLmZopYnZ8ydjMKx1rZDWIxbzQYK35PYLuyDg4YKpsiT9o8zjALHbnajHdPXLmraJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773190882; c=relaxed/simple;
	bh=BRnvxecRJrtJR52VTI82H9eQekjTHMZcpnbZu9WnyQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw9iZPrt2aFemHwLmUyw0Eg709VcgmJqtq1ICpzAeXbo/eOl/vDqPkJ6iXAxm9IkbWD6rnSlQ5qGSnjQbMSckecOhYWI6z7laGu8UdyzoJMaNG8FdEWIDPXxtEfBqft4CDwYzExyHEJbMoVv8da3GV3AurN1AJs2SP8iauVdHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgHUGpls; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773190869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1zI0HjdpVIeLf9hsutuK6PY4JFf5qAhFtdlVI8aS1sw=;
	b=LgHUGplsk2p9syAn/wJWFocufn0GBEBbF/HLE+Hy6ni8L7uAVzEcVw7Zi4W98y97igwNd3
	ct3hRgGLQHsuKtE95Av+ETz/CnvanrSyODESwHGyblTNbf6APrdMKTbSSTKZRvOn7KUPk/
	Ju7/rXEFjmtKd1lL3Ymwc6MgnShnvxA=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] cgroup: improve cgroup_file_notify() scalability
Date: Tue, 10 Mar 2026 18:00:58 -0700
Message-ID: <20260311010101.3306366-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 477D525A3A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14748-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski reported that after the commit d929525c2e30 ("memcg:
net: track network throttling due to memcg memory pressure"), in
Meta fleet, the network intensive workloads started seeing extensive
spinlock contention in the rx path in the function
cgroup_file_notify().

cgroup_file_notify() uses a single global spinlock to protect the
cfile->kn pointer across all cgroups.  On systems with many cgroups
under memory pressure, this becomes a bottleneck as multiple CPUs in
reclaim call __memcg_memory_event(), which walks the cgroup hierarchy
calling cgroup_file_notify() at each level -- all serialized on the
same lock.

This series reduces the lock hold time by moving kernfs_notify()
outside the critical section, adds lockless fast-path checks to avoid
the lock entirely in common cases (torn-down files and rate-limited
bursts), and replaces the global lock with a per-cgroup_file lock to
eliminate cross-cgroup contention.

Changes since v1:
- Second patch moves rate-limiting code out of lock 

Shakeel Butt (3):
  cgroup: reduce cgroup_file_kn_lock hold time in cgroup_file_notify()
  cgroup: add lockless fast-path checks to cgroup_file_notify()
  cgroup: replace global cgroup_file_kn_lock with per-cgroup_file lock

 include/linux/cgroup-defs.h |  1 +
 kernel/cgroup/cgroup.c      | 53 ++++++++++++++++++++-----------------
 2 files changed, 29 insertions(+), 25 deletions(-)

-- 
2.52.0


