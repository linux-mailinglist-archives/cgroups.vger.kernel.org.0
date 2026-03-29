Return-Path: <cgroups+bounces-15094-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFUtABtkyWlXxwUAu9opvQ
	(envelope-from <cgroups+bounces-15094-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:40:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51467353645
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 19:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A753014552
	for <lists+cgroups@lfdr.de>; Sun, 29 Mar 2026 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79453859FD;
	Sun, 29 Mar 2026 17:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA1kGb/3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB35226B973
	for <cgroups@vger.kernel.org>; Sun, 29 Mar 2026 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774806017; cv=none; b=jRE72zDtjIS0IB7QGM2oIEGFltdFj9MhVWiiEzUa+lgaApCNpvytOQHUfC9mGZqQU4xL+WtLZm0p+zX6lO1sLYCnaJD6xYhGaBDofV5vEIWh1LQy/BoJ6z1Iqu0Yh/s3asjY6gdGrlwal8z/EWsX1LtNMbwSAFNu4uabFFU1Wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774806017; c=relaxed/simple;
	bh=rMVuAkCy8bzMyfoJGOTGlaerfOtgrhHAPXCPG7TjUDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmP1qh8CfyYW7E+rm3GyJZ7lxFSCtXSkhP9OY9FJVQXwTGgrjsDujoIRuLW0j0mOcPq5EulCPz/AoOPijocfeiy4sdAHEWoXZzKd9METEbqTFIgIFOpKTWF+hANLmjBAxhbG1YlEbiRBiZqJlbfp++7hjglnB41+THcl1YrrUps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BA1kGb/3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774806013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=psEP3ErlslJOPXd08MWsqaYwhIEwmpWxbQ3DzJy5kCM=;
	b=BA1kGb/32TuSPOrl9LwsTunIxwE5ZhP+wwiqj3ADHjo2Slcrjj6tszfcTSngUL8V5Lo5/6
	r5p/c5fTam4p9exlBZdkIBNmJGswu/INRlhGHow4qXtBuKo6QqNsl9F1tAkuV0VSvOi0RE
	5lrKvb+pQGjU6EXftB5cIIE0fgSTjiQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-auLv6YYlPIuunlYDpCp8Iw-1; Sun,
 29 Mar 2026 13:40:10 -0400
X-MC-Unique: auLv6YYlPIuunlYDpCp8Iw-1
X-Mimecast-MFC-AGG-ID: auLv6YYlPIuunlYDpCp8Iw_1774806009
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F06AC19560B4;
	Sun, 29 Mar 2026 17:40:08 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.75])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 361F119560AB;
	Sun, 29 Mar 2026 17:40:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/3] cgroup/cpuset: Fix v1 task migration failure from empty cpuset
Date: Sun, 29 Mar 2026 13:39:55 -0400
Message-ID: <20260329173958.2634925-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15094-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51467353645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 v2: 
  - Add a new CS_TASKS_OUT flag to signal that task migration out of
    empty cpuset is allowed without setsched security check as suggested
    by Tejun.
  - Add 2 more patches with minor changes.

As it is found that the cpuset v1 task migration out of cpuset with no
CPU can be blocked by a strict security policy, we need to work around
that issue by treating it as an exceptional case that is allowed without
security check. This is now enabled by setting a special CS_TASKS_OUT
flag of the affected cpuset to allow cpuset_can_attach() to skip security
check in this special case.

Waiman Long (3):
  cgroup/cpuset: Simplify setsched decision check in task iteration loop
    of cpuset_can_attach()
  cgroup/cpuset: Skip security check for hotplug induced v1 task
    migration
  cgroup/cpuset: Improve check for v1 task migration out of empty cpuset

 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset-v1.c       | 13 +++++++++----
 kernel/cgroup/cpuset.c          | 33 ++++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.53.0


