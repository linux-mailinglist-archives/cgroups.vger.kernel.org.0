Return-Path: <cgroups+bounces-15057-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKvgDjN5xGkpzgQAu9opvQ
	(envelope-from <cgroups+bounces-15057-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 01:09:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB96932D8B9
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43AC1302B768
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 00:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4A86341;
	Thu, 26 Mar 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvbKhnhY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65C45C0B;
	Thu, 26 Mar 2026 00:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483755; cv=none; b=S4Ro8pSL9BVeYUbDNqC7cfuaaO1gg+5ZmT6EZwzxCH14cJEkURhCBiQFyV+gjXdO6YLBV4Hpz1XP7ZewSOfzp1d3Lac07caCjwTJYFS1xUpPJKstvYii/8euXdgPg+ed7rKWXOif5qJSVUftzC3ohNrjLxK8OnmY4pijxm8KJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483755; c=relaxed/simple;
	bh=VmaD37WXPGQSvuLKFT2fUj0oK545HtswXhwSFdPLL0Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fn59qGsHZlZXszTlzIfFBn03EIWL2ZyJayubbvAuin/VLh2ionNCh9e09Ay4eJ3g5iIZ/bJHjBvejeFcO/MED8/jbNnFdTHdEHlMmCurNpoWtvjrpU702/IP6Xz8erXBWbJqUdHFMiL5jFGUwcFHSju3g8DWejTFb6fPqbR4080=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvbKhnhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B897AC2BCB0;
	Thu, 26 Mar 2026 00:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774483754;
	bh=VmaD37WXPGQSvuLKFT2fUj0oK545HtswXhwSFdPLL0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvbKhnhYFkZy86JdChLNFdMMqoawWknzAq0zT6k1j/d7Yw+le7INlB/+JPRKHSe+R
	 Iw6gM1fSn1XpTbyKRHGG7jKJeA5iHzVQzbohlE+MCrLjGpwlrlVgapwkVPj3RmiWmx
	 XqK2jXzQxxQ2s10zvoq7DPomRCpZsXA9T8odOd/oj6H0PRnZBT4w4IyO8wfFtJ1ZuS
	 tl6aMb+2fIpwNK9brekr4bk81NdA3Q6Ub3X2kmAyF4WTFCA4vifN7IAJVUy/0SBu10
	 qqzRhswj7cUx51uP5DyHfDTrgutzxo/xYQg/vqhQBWgTmsHVvKtzmgRYmFYljLaIao
	 9doGKzMnBUD8g==
Date: Wed, 25 Mar 2026 14:09:13 -1000
Message-ID: <7bfbcd3ee9af63f0f4c50b574bf468bf@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Koutny <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix
 cgroup_drain_dying() testing the wrong condition
In-Reply-To: <20260325172348.1836430-1-tj@kernel.org>
References: <20260325172348.1836430-1-tj@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15057-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB96932D8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied to cgroup/for-7.0-fixes.

Thanks.

-- 
tejun

