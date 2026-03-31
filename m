Return-Path: <cgroups+bounces-15131-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA9XOuLly2myMQYAu9opvQ
	(envelope-from <cgroups+bounces-15131-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:18:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A11C36B8D9
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6872E30CBCF0
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196B940244D;
	Tue, 31 Mar 2026 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MH/Gfot5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8140243E
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774969881; cv=none; b=uP9dz9ngZ3hMYadC8ceIGGfNlysVVhekq7ysv43R3xTA9xk7uuekHV0NSWiZ4bqNOFWyhAUgZGbsYJHUc2iZxzzlKs1DZMMVui1udc9WPXdNzBySaQm54FeiP8OdNiLWDY8z8SYioR2puG8abJMl8mGpHPOz8VE5B1swGfsWGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774969881; c=relaxed/simple;
	bh=EA6rlHfxZyKWGrlwTFvRW6KzRrCe7XGguPxp3G46sMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pdvv4FZoWceFS2vvk1WEP5Gv9ktX3kFoxiwW3TC5TrG28Rnds4YZO/LHUkkq2XTbXg/BVyqwW6lFvoLnLdilijY8pV1s4IpsxFaSH+sywfMTHZQlrOA1WmYO48DU4w6vrRWw979xOU8LLLP5IENuA1ypg3QYc45uHUz1onmMBPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MH/Gfot5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774969879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X/pTBXFVuiNpT85qY0ij0LigCXXVDfAXP3Qc+y0wCQQ=;
	b=MH/Gfot5JRZ2ILJn21PI/T2s+ptVQkoaHH6sthfb5dRbR0J+p+lU2py3CQcQrlHDC6U5YR
	wgVhWjxNCJazX+pv0EXO23hjpRjx3JHXWp4/eXwit5oGkwb5+lkr21TKTSn3BR2HrZX52t
	GVZqka8RfNLaLKVOLFCyc/2BozvTAXY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-x3esBRnHOOq4zhGcWdMrJw-1; Tue,
 31 Mar 2026 11:11:15 -0400
X-MC-Unique: x3esBRnHOOq4zhGcWdMrJw-1
X-Mimecast-MFC-AGG-ID: x3esBRnHOOq4zhGcWdMrJw_1774969874
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 101EB19560B5;
	Tue, 31 Mar 2026 15:11:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56FED1953952;
	Tue, 31 Mar 2026 15:11:11 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/2] cgroup/cpuset: Fix v1 task migration failure from empty cpuset
Date: Tue, 31 Mar 2026 11:11:06 -0400
Message-ID: <20260331151108.2771560-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15131-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A11C36B8D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


v3:
 - Drop patch 3
 - Further simplify patch 2 by dropping the flag and only check for
   v1 cpuset with no CPU to disable security check.

v2:
  - Add a new CS_TASKS_OUT flag to signal that task migration out of
    empty cpuset is allowed without setsched security check as suggested
    by Tejun.
  - Add 2 more patches with minor changes.

As it is found that the cpuset v1 task migration out of cpuset with no
CPU can be blocked by a strict security policy, we need to work around
that issue by treating it as an exceptional case that is allowed without
security check in cpuset_can_attach().

Waiman Long (2):
  cgroup/cpuset: Simplify setsched decision check in task iteration loop
    of cpuset_can_attach()
  cgroup/cpuset: Skip security check for hotplug induced v1 task
    migration

 kernel/cgroup/cpuset.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

-- 
2.53.0


