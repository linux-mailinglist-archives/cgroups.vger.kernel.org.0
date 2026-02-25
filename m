Return-Path: <cgroups+bounces-14377-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDLNAdIun2mCZQQAu9opvQ
	(envelope-from <cgroups+bounces-14377-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:18:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE319B63D
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D9C308DBB4
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272423E9590;
	Wed, 25 Feb 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emxViB2P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6EA3E9589
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039761; cv=none; b=LvBjXB1/WmlnAtC7hS4O6oGzhKLePAXqQAMrNH1Gh7Cr/rbLfzI76I3Hbattkjs2sii4jYjZPHcqhvDzq3Exz34ZBm4sGJSxar3Q57BpFFHysf63ew+cWL7r3pdi+KNrssG7QpOXv0EhEKMI7p9oIfHK3cXY3htQjd4yAc6KGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039761; c=relaxed/simple;
	bh=jJdzvVKMl5cn0QuJzc7vXdV0mAMHYhsXz6osLCyQqkg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Zu1Pq08pBIudDOyhEtmzSB9FXYP8rXJxNsZSqZ/pMdz81X1OUPHXyyBRxpPN8ZHaGzWmHA5tLjp1aodaJDCxf1ZokIihKuM5zQREFRTuhrUF7EeBm6IAa7JfAlpA2mGMb1ZQ6MdTHXlMPTDYkZ0a/48HSNOzl1JYeLS7muR07aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emxViB2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F6C2BCB2;
	Wed, 25 Feb 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039761;
	bh=jJdzvVKMl5cn0QuJzc7vXdV0mAMHYhsXz6osLCyQqkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=emxViB2PRoqwP7d4rpdwXv6bTCYQD9BI/qjOXLPFK0TrQPZzPJGxNADxmpSJnb37j
	 YpsCB0CfrboereOvxHKjW58gmH5ODcAIpLzVpFXnau81eTf4/oEKThJrlILMhCa0NQ
	 5KXqx6V3m4mzhaaCgKvjZnIPAFc1A3MM+tPLkeDQnMwSAaNBHqxx2xckYmt8WUdztq
	 troKRrGbl8HVYsfLjzzNWQM6mHPPTvcSLErcfeQQlE16h8IMb6l34FJyk6p6w5IycN
	 mOp7VkzMrw8hL5bq4l92ZUNJ4TxTjkX2Ko4X1faJJ5API/6d1qrpQHFL2aI7+/KUJD
	 q1tpj4XcO9Tug==
Date: Wed, 25 Feb 2026 07:16:00 -1000
Message-ID: <a9027a23743a2ec1511d8555ce3ef382@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/6] cgroup/dmem: Add dmem_cgroup_common_ancestor
 helper
In-Reply-To: <20260225-dmemcg-aggressive-protect-v4-2-de847ab35184@gmx.de>
References: <20260225-dmemcg-aggressive-protect-v4-0-de847ab35184@gmx.de>
 <20260225-dmemcg-aggressive-protect-v4-2-de847ab35184@gmx.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14377-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15FE319B63D
X-Rspamd-Action: no action

Each cgroup already knows all its ancestors in cgrp->ancestors[] along with
its depth in cgrp->level (see cgroup_is_descendant() and cgroup_ancestor()).
This can be used to implement a generic cgroup_common_ancestor() a lot more
efficiently. Something like:

  static inline struct cgroup *cgroup_common_ancestor(struct cgroup *a,
                                                      struct cgroup *b)
  {
          int level;

          for (level = min(a->level, b->level); level >= 0; level--)
                  if (a->ancestors[level] == b->ancestors[level])
                          return a->ancestors[level];
          return NULL;
  }

This is O(depth) instead of O(n*m). Can you add a helper like the above in
include/linux/cgroup.h and use it here?

Thanks.
-- 
tejun

