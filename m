Return-Path: <cgroups+bounces-15855-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFytFVJqA2rf5gEAu9opvQ
	(envelope-from <cgroups+bounces-15855-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:58:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E8152665E
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DC993173888
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7E3E5A1A;
	Tue, 12 May 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMXi0X3J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9813C09F7
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608146; cv=none; b=jHkMX17YOpHd18LCKRr8Qgw7PeyWu15rVKp1NgYFY6KD9pN39eOoUFM0kJpm0jKcCYe9VAOzhhrFppQw9JGNQy1QTdhivaLIeRavXLIQlP/FX6AwF+a2OItgHhsfhUNZQPn0B/5kIPKqzcMFEMu0+iF6HNbGmX90hEVzvau4Mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608146; c=relaxed/simple;
	bh=Z5+kxEKRAMlWehZixemGOI302b8t3FuEq7M1QlnLDms=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qM6T7J1EbYhOvDcoUZTHmHP4LoETwpCO7K17fXiAbc1XJiHv0RUIJRldQKg0osGoYbwm/EENaNOxo8hadLKkktX/W1tPUtB8nArN3ObIwBrEAmNU49XodjyHdDIK/X5L9G4ArHHG+phOSqlhBXch3cCSXNxEtK9yRmtwCj4T1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMXi0X3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BAFC2BCB0;
	Tue, 12 May 2026 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778608146;
	bh=Z5+kxEKRAMlWehZixemGOI302b8t3FuEq7M1QlnLDms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMXi0X3JAOgHblGv6H5CZbjToOQRhRB88YHo3Iy+vC9Ws3AN9yp6tFXqTv+HG8VtV
	 qN3x2ipRG6VzzVZFzZLF3kLhUXBNDeRMP7m/cae35HwD0hvftLLwkKIRqkkGCCBL5K
	 vHBAR4tvCuq8l328BCqdVmZAt5n5MPTsNjkWD/n1pqmLBcQk/DdNIg+fX2uAORjqpa
	 1uMUA4BrOxJzT2aAMTCDp4HMgJZlbeSWAhO2Vb/sJcwj0P/EnDS51oWriJXdjnPGIs
	 L0ccQN1e3EbTheR6lNr8XURh0+dKGrNCgxSI/aPfhTP8yq1h518a/tYFWBNfKiSKtz
	 lbt17SSUWRhXQ==
Date: Tue, 12 May 2026 07:49:05 -1000
Message-ID: <8545cad8e29f27e927e76c7bbe1334ea@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH 0/3] cgroup/rdma: add rdma.peak and rdma.events[.local]
In-Reply-To: <20260512031719.273507-1-cuitao@kylinos.cn>
References: <20260512031719.273507-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B6E8152665E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15855-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rdma.events:url]
X-Rspamd-Action: no action

Hello,

The list below is from an AI-assisted review with some input from me.

* Patches 2 and 3 don't extend the rpool-free condition in
  uncharge_cg_locked() and rdmacg_resource_set_max() to the new event
  counters, so a "set limit -> hit limit -> uncharge to 0 -> write
  'max max'" sequence frees the rpool and zeros the counts.

* rdmacg_event_locked() creates rpools in ancestors of over_cg via
  get_cg_rpool_locked() just to host event counters. Those rpools have
  usage_sum==0, num_max_cnt==max, peak==0, so the next real uncharge
  through any such ancestor frees them.

* Patch 3 says failcnt covers "this cgroup (or its descendants)" but
  the code only increments the directly-requesting cgroup. Either the
  description or the propagation is wrong.

* rdma.events / rdma.events.local print "mlx4_0 hca_handle.max 5
  hca_object.max 0 " (trailing space). That doesn't match any of the
  formats in Documentation/admin-guide/cgroup-v2.rst. rdma.current and
  rdma.max are nested-keyed; the new files should be too:
  "mlx4_0 hca_handle.max=5 hca_object.max=0".

* Please document rdma.peak / rdma.events / rdma.events.local in
  Documentation/admin-guide/cgroup-v2.rst.

* "failcnt" is cgroup-v1 vocabulary; pids.events.local uses
  "fork_fail" for the same role.

* Event counters are atomic64_t but all updates are under
  rdmacg_mutex. Plain u64 with READ_ONCE on the read side would do.

* Patch 1 reflows an unrelated comment ("No user of the rpool ...");
  please drop the churn.

Thanks.

--
tejun

