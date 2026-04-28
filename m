Return-Path: <cgroups+bounces-15544-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCBbLrL48GkpbgEAu9opvQ
	(envelope-from <cgroups+bounces-15544-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:13:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268848A846
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD4DF30CA900
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980A746AEE1;
	Tue, 28 Apr 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I849QHV0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166A31D371
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399811; cv=none; b=b/YePKqcgwm6f6q6McU2yub1xdW7dltA1wpL/2UgmwEQziXnJrDVCXeqrIOxHs6t4w7SIwM8mtFFvCgAD8raorEfRucFBPqVPJpwmmGJpOVt7QjUMvKAjlYNYRu5L0mML/0+3tbg72ntcr8GgYjoj6Y7RUjTsshoMrBBH1VRV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399811; c=relaxed/simple;
	bh=uLbktZmtWPtLrfOgiMLpDLglBi5LnXEobVjQPTqKXYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfRLlv0PcDY/TNPrG8hEnrt5bRjIJcsxt/i6M12AnZKoAaLESe26oPwAFnStGXyKjSAU2cZO3x5Ug2+7V9FAPGBcs4XSLd3lHMvZuud8COt+Yvd6WlU54A7WF1gN1WCCK6mEHQqfn07W/4vOrzV0e364+7HP+rPpvNiIsRDKXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I849QHV0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777399808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kne1iSJh3DS53BgsW2y42djGYIvb/HsZgOjbew6dk9o=;
	b=I849QHV0pljNHRYyfU+B6N/xL64SjXlXqjDQNCyCzOi4kQdsJTmNLuZkV5dUgJsaywceXj
	vtADMvm2EHrILxYiB0ZpDGwR7lqtPJ3p+/61cS6ToyHAtF0oH1h1Ni2Nnu4CADCRM0HblF
	o14BXkYeIhX10Kxu+yGkqwvk8+y3BfI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-TzbV_nYdPAyl--NY-Pd9Jg-1; Tue,
 28 Apr 2026 14:10:04 -0400
X-MC-Unique: TzbV_nYdPAyl--NY-Pd9Jg-1
X-Mimecast-MFC-AGG-ID: TzbV_nYdPAyl--NY-Pd9Jg_1777399803
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E79619560B4;
	Tue, 28 Apr 2026 18:10:02 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.177])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 13FE1196B8FB;
	Tue, 28 Apr 2026 18:09:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xie Maoyi <maoyi.xie@ntu.edu.sg>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Clarify the delegation rules of partition
Date: Tue, 28 Apr 2026 14:09:35 -0400
Message-ID: <20260428180935.806284-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 3268848A846
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15544-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Creation of remote partition is currently not allowed without privilege.
On the other hand, creation of local partition is allowed without
privilege as long as its parent is also a partition root.

The current setup allows a delegator to delegate an exclusive set of
CPUs to the delegatee by making the root of a delegated sub-hierarchy
a partition root. The delegatee is then allowed to create a local
sub-partition underneath it if necessary. Creation of a remote
partition is not currently allowed across delegation boundary without
privilege. Clarify the partition delegation rules by stating the current
behavior in cgroup-v2.rst file.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..5b4ebde6fffe 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2599,8 +2599,7 @@ Cpuset Interface Files
 
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
-	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
-	and is not delegatable.
+	cpuset-enabled cgroups.
 
 	It accepts only the following input values when written to.
 
@@ -2708,6 +2707,15 @@ Cpuset Interface Files
 	their parent is switched back to a partition root with a proper
 	value in "cpuset.cpus" or "cpuset.cpus.exclusive".
 
+	This file is owned by the parent cgroup and is not delegatable.
+	The delegator can delegate an exclusive set of CPUs to the
+	delegatee by making the root of a delegated sub-hierarchy a
+	partition root. The delegatee is then allowed to create a local
+	sub-partition underneath it if needed. The delegator should
+	not set "cpuset.cpus.exclusive" at the root without making it
+	a partition root as the creation of remote partition is not
+	allowed without privilege.
+
 	Poll and inotify events are triggered whenever the state of
 	"cpuset.cpus.partition" changes.  That includes changes caused
 	by write to "cpuset.cpus.partition", cpu hotplug or other
-- 
2.53.0


