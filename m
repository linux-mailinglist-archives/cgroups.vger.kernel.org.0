Return-Path: <cgroups+bounces-16452-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAqOFGXcGWpGzggAu9opvQ
	(envelope-from <cgroups+bounces-16452-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:35:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC460748B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420FA3055C13
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E9408006;
	Fri, 29 May 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kglDwHUF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD530F815;
	Fri, 29 May 2026 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079341; cv=none; b=q0D5P1RrCE4dptWaDrbmhl3nal+k4aiFZadUBSewDuzRSDhIUZhi16erfIK4bC60qlKOff7OR+vlpBJZj24CC5LDpK05C/4db9N3sF7zMGW2dvjmAB1dRnmjO5MsXKaeYIAeBX2I2e3xwAIqkvWGqZtv3ZIC6QzVRO+BmHSc+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079341; c=relaxed/simple;
	bh=aHE7dg8zR1n2cV+21RjFRqDg+YTC8jxfFWgZhu+jLWM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Ge4WSZWZ7QKYfeZekeBPAdBLvXKFelTtldd/QadUhYRBCF397LYct0W42T6L9O9aOmsVbySwZpQlxYDNxPLVNbZhxfWNeCZWaZtx2xnq26E9pboIoVwBexnJYYUI5YZOKCYE2LdXdrMTPIMrR2UsB6PQYaLsl0JXN1bRoyPa7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kglDwHUF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE911F00893;
	Fri, 29 May 2026 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780079339;
	bh=aHE7dg8zR1n2cV+21RjFRqDg+YTC8jxfFWgZhu+jLWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kglDwHUFRvAurfkeV5IWCbs5lkftOcFs6tOGuNCHv2JmwCpi2OUuTG5GqdC6DypIY
	 6Lylo/U1aJ7e8QQR6HgWV3lvI1UrGuniVSipbF6UNwjWsejmupA2PfoaUJWkv1++ES
	 0/TOhUlW/C0xSpHJYaaPR/JwJk6dJ8yAYrnrwZCFnpfU0xXdmlq/qcw5/m5PXmtitx
	 B60L80ICuqhXl8YSlD9qp5vuuTl9QQ4xNfwyi/omYr3xAgzBepNzVpg1coMkRMf05o
	 4MtsIAJhqFQPW4k28kNVgkj9fUOzoQ3Rz/TTO+XjXn6FG+Pq/NdorKFSXY5WZ9GbKU
	 Za69PYHT6lklg==
Date: Fri, 29 May 2026 08:28:58 -1000
Message-ID: <42685aa3cdaaaf17051558637a36c879@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Guopeng Zhang <guopeng.zhang@linux.dev>
Cc: Waiman Long <longman@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Guopeng Zhang <zhangguopeng@kylinos.cn>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Free sched domains on rebuild guard
 failure
In-Reply-To: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
References: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16452-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2BC460748B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied to cgroup/for-7.2.

Thanks.

--
tejun

