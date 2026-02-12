Return-Path: <cgroups+bounces-13906-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP86HksOjmmS+wAAu9opvQ
	(envelope-from <cgroups+bounces-13906-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:30:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2F12FEED
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 18:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 505D6307FC3F
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBC2E7635;
	Thu, 12 Feb 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuqMpT3e"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34A25F995;
	Thu, 12 Feb 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770917395; cv=none; b=pAuBDVxIxhDQlFhYDkm3ah37U6FEvu+dhu4hfdm6eWwQ2SGi0UicGRPQbmqLHKO9tPAEvZHY4eAtZZdfX4NGns1a4mUhG0kcwJNgIIIdpTGwuyGHXetfaUUROjpToeoiNeJtmkFmt30O2jVtGS+kdZ+z5GCVEwUv83hOXCkxmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770917395; c=relaxed/simple;
	bh=H9o5V25tiaD+glvfYxgnKwGcMJ1VtRAONPzl19nBFCM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FGHKkwI3XHZGVVlbiwAfRO6brqM52olQrevPjWd98i+4piIh4fyiOvmQ5Hc8gldiaf7tIZrfRSAstEyuSsgwqnctvJ6ktl1CEU1Vfo6vxwGVve+/G6cGg38dnYeDPfcQHzK0axoa0wDJyt7pmJRsCe9BeihHshP2sz3KR0EyCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuqMpT3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC30CC19425;
	Thu, 12 Feb 2026 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770917395;
	bh=H9o5V25tiaD+glvfYxgnKwGcMJ1VtRAONPzl19nBFCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RuqMpT3exlaZ+7VxnfqAGNiSjli2QwBWGcuhEI0VTl12DThCRJ0aN6JU00TtdcGuC
	 Rh5TYSwOWOxf5txE8VsXvDkzQn5ajEBAWyVRtDEVU2Rf0pXllWQVFLg3A6Rio0Qvzw
	 IIQO7gnM0eN7kXu8IRiqyhsHgzRGBbBxbm4l6Iibogsds+UzKUoUGfc9LOTP0LcbEv
	 BInihsYKY58UazPWO2y/UH8nU1a+zN2xJYCDrOJzXJJFnnqvnJH9ekFbuSWjIfSefM
	 hkyAj+CUHHbWka4tyLaxG0lvJaRGV4H4rMEBfpI+HJRv/NRECUqjXjBbiK8HW8QQda
	 yp27e8F7FOWEg==
Date: Thu, 12 Feb 2026 07:29:54 -1000
Message-ID: <dca4402ee16f11f7c6dec77e1a80a291@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhaoqingye <zhaoqingye@honor.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix race between task migration and iteration
In-Reply-To: <8092ea7ae48d4a988fdcb7390e1be0b1@honor.com>
References: <8092ea7ae48d4a988fdcb7390e1be0b1@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13906-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28B2F12FEED
X-Rspamd-Action: no action

Applied to cgroup/for-7.0-fixes with the following Fixes tag added.

  Fixes: b636fd38dc40 ("cgroup: Implement css_task_iter_skip()")

Thanks.

-- 
tejun

