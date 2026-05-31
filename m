Return-Path: <cgroups+bounces-16497-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPe+IDhrHGrnNgkAu9opvQ
	(envelope-from <cgroups+bounces-16497-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 19:09:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2F61749A
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 19:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854D0301CF94
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECD3921DE;
	Sun, 31 May 2026 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIJE5abn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC53911C9;
	Sun, 31 May 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247347; cv=none; b=ECOSVK4fVYG4oL8fN2ugB/lbYHBdgNfbJdRYbjfoSmP9FytVD50irPsOIuUt3blzAE65iPEuAr8BGmyqDPrrRq7smX9Chl0Zj61adlQD1u/e/r/fi2v/TZXtFJBxEaixalSxjxjLXs4zrUZu3nl81qBw/raNnOaUJu/G7RMpRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247347; c=relaxed/simple;
	bh=SVEJL4GEwkXkrp6OsZZkCybl5z2/KKltadlzYqj29wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=uGew4Z0169J43ksRPKFjHo9U7K22extxftF3PWoxFdQOf7ng4Em4S5m5SV2aTQDSNBlPi5yX4w+GGyht0qD9KdiXjBlD5u44l/vgQ7gnnYSyeKX67m2ps6kgkQsKDdtwbTfoVUj6Y8aSE4s5/0xkY1jRklW+3GZyNXx4n6VqVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIJE5abn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897FF1F00893;
	Sun, 31 May 2026 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780247346;
	bh=SVEJL4GEwkXkrp6OsZZkCybl5z2/KKltadlzYqj29wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VIJE5abn5CItq56HmUAdW+Knc3RYlzlx17YNtux49HXAuFoZ5mrgTdG42OZxZ20XW
	 zfe/XXcBnZAMbDuWNIh2CNnXDOB9QtCMdDlORVJtZiOa2f7KFhI5ZsQ+QVbwgrokbi
	 BzQdroh8CHBXMyQ3RM0lCTErePv+oXad+PA4DrKKE12M79hS8nnabqO++Ml7MRi/jk
	 876Tt8TcYO/m5XbWAShgoX2dVkCpKp5ZTSaTG+RyLOn4z/pw5g4lqnxYSW32tuKZuN
	 +mnja4ml2mMwSkQo9K2R6ai1tO83yq9cgZQdfdMLSgaVA/zzJIh7+CVm7vpe3MfznR
	 Eklpd0LVEZ1Rw==
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Johannes Weiner <hannes@cmpxchg.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Natalie Vock <natalie.vock@gmx.de>
Cc: Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6] cgroup/dmem: implement dmem.high soft limit via prioritized eviction
In-Reply-To: <20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com>
References: <20260531-feature-dmem-high-v6-1-20563ecd6dc7@gmail.com>
Message-ID: <20260531070612.GA03193@kernel.org>
Date: Sun, 31 May 2026 07:06:12 -1000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16497-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,intel.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,cmpxchg.org,suse.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1FA2F61749A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I don't think we want to define dmem.high (or dmem.max) in terms of a
specific reclaim mechanic. These interface files should express a
generic resource-distribution concept that stays valid regardless of
how the underlying reclaim works. As written, dmem.high comes down to
"evicted first in the high-priority eviction pass". It isn't consulted
on charge and dmem has no proactive reclaim, so the file does nothing
until a dmem.max hit elsewhere triggers eviction. That's an
implementation detail, not something I'd want to commit to in the
cgroup interface.

It also reads as a way to work around dmem's reclaim behavior rather
than a soft limit in its own right. A dmem.max hit doesn't just fail
today: the charge returns -EAGAIN and TTM already falls back to evicting
buffers and retrying before the allocation fails. So the question isn't
"max fails immediately, add reclaim via high" but which buffers reclaim
should target and when, which is a property of the max reclaim behavior.

If we work around that with a high knob whose meaning is the current
eviction order, we bake an implementation detail into the ABI and make
it harder to give dmem.high a proper soft-limit semantics later.

I'm not against a dmem soft limit. I'd rather improve the max reclaim
behavior so it makes sense in general, and then define high as a concept
on top of that, rather than the other way around.

The whole max-vs-high distinction and what a soft limit should mean has
had a lot of thought put into it on the memcg side, so adding the memcg
folks for their input.

Thanks.

--
tejun

