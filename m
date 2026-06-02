Return-Path: <cgroups+bounces-16579-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ot3bAjciH2oehwAAu9opvQ
	(envelope-from <cgroups+bounces-16579-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:34:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F87631221
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:34:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lo2I1hw1;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16579-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16579-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AD83011841
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 18:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18984395AC0;
	Tue,  2 Jun 2026 18:34:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E73939C9;
	Tue,  2 Jun 2026 18:34:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425266; cv=none; b=ATxXrXDz+N8k6OhTA1DoGX5KTPk6aWzup8xb+qLuGAVJ9lJURgrHY+EjvPSKMFna5WI8LnoV644LL4OVAGEYTNgu3flGxXxPf3ILa9O2hz6ugUhA7K/wq8CLY4a6QmgkfUtDrOzGIxoB8dFtP+/3Y15Xru36ako8T5TqkqxqeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425266; c=relaxed/simple;
	bh=UvAFOrEJ9rVai8ttmGCzo7ViaDMyasXrSoxT0mvoo+E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=J58MdtsJYzfOPH7nHQ3S13TRZ3r1tDePi5erG353uUnpJ/WlNTpwuSNDr3/kbTEXxBODqCyPkYutqBmEUlwrXIUZD/l51OSgGhg4z0iW6esc35xFgsWGSUj5HBa1K1kMsTVYYnobuzE65Y/uxfvyG1js03Qm5fdaChIvsfnZvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lo2I1hw1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F281F00893;
	Tue,  2 Jun 2026 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425265;
	bh=UvAFOrEJ9rVai8ttmGCzo7ViaDMyasXrSoxT0mvoo+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lo2I1hw1I3B5N9riFWQINDoW1kVjJ41lM2MvjGXhyJlck5Gw5EzYSTFdT60hHiJl2
	 Wh3j3SdUVf1JhwJye4rUAPKDr/3e1cX7ZyzGgFEOb3yks3/+25ypu7gbVpTpaftU9P
	 VUo45C8iLv8LoWR6Mlvc/ik6NOzKfaD7uJ3C/zWihJCWQZFlL+MoOC0s1qDPaatj+z
	 Ik35Td5W5U3uPAYkK0rAxP7XbU3nYrPhwigPFRmyN76j+PtGf+eR7tWm1YdXLX7g3I
	 bn5Z+xyI9S5nDSZxKOLEZlYbE/vkzesVM/KrBOZBkRbmBby8/Re0cITFm8BSlp5byA
	 8Q9Zv8LztuIeA==
Date: Tue, 02 Jun 2026 08:34:24 -1000
Message-ID: <99e251a1003f30586d8a64841747996f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Malat <oss@malat.biz>, kernel test robot <oliver.sang@intel.com>, Martin Pitt <martin@piware.de>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH] cgroup: Migrate tasks to the root css when a controller is rebound
In-Reply-To: <20260601190256.1815778-1-tj@kernel.org>
References: <20260601190256.1815778-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,web.de,cmpxchg.org,suse.com,linutronix.de,malat.biz,intel.com,piware.de,arm.com];
	TAGGED_FROM(0.00)[bounces-16579-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:broonie@kernel.org,m:spasswolf@web.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:bigeasy@linutronix.de,m:oss@malat.biz,m:oliver.sang@intel.com,m:martin@piware.de,m:Aishwarya.TCV@arm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79F87631221

Applied to cgroup/for-7.2.

Thanks Mark and Bert for the reports and the testing.

--
tejun

