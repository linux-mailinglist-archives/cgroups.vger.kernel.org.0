Return-Path: <cgroups+bounces-13866-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCA/AHkUjWnoygAAu9opvQ
	(envelope-from <cgroups+bounces-13866-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:44:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A8B1285A8
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 00:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D675930FD913
	for <lists+cgroups@lfdr.de>; Wed, 11 Feb 2026 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3283587B3;
	Wed, 11 Feb 2026 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZwjXHtr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48935770A;
	Wed, 11 Feb 2026 23:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853471; cv=none; b=SoF1DHQ/eOhtxEfPWiavrQXwlfyWF9b5fXVXU/UMkJREKcdK0Gq/TM+7kJdqFw6QQRgUUz2Ap7TPUsGXj0m1BikY+v5RqKVX0t+ZeyJocL5g9TBlUgqBboS+fQuSXPomoXJzjgTB/p41Ir7gC8k+L3JPFI1hdZ+xnZVHJ2mrS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853471; c=relaxed/simple;
	bh=xUZk+hSptFMvGh+SYEqD8OqHF49CX+1CR5Qbs2ICPOw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Do4LWb+7421/d01+lqXoGOMESY75oR91pAn0zPx2J1DxgPVOdplswGdjWddpWaVpKbglmBD1kGWx7XNlCf66Yjmjdber4p+59nm9lsF9K4eA4D4A/LRfGQEuCkpBFSQCHYEqZBnwPaNJdE1gKZq/kitKLupimKVobQ9YFV8IHBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZwjXHtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB08C4CEF7;
	Wed, 11 Feb 2026 23:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853470;
	bh=xUZk+hSptFMvGh+SYEqD8OqHF49CX+1CR5Qbs2ICPOw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aZwjXHtrNxG0YsnH8cw31Dg0oA47vCsuhMUvzP7UupzcuOF1wK6oVz5L2IJrwNYOM
	 iLkoY4rrsvOoLb+sOdc2z0imRiDhvhmIAS2ahPA7xt0D7fByLGfeTlumz1080tAMtM
	 HGuG6ofRdIuZUEgMSBjBp6Q7kWeJHXxod6KDT95DjxHdoyRGeXBwjzljG0PH3iB8Oj
	 RC+4JZnpt6J8SqdMgDk+I2jSX4z8Cn9XWtDiHAT545gJnaAR2j1uga/5hCsL+pgLZ5
	 YqI0hy0cOEUTWrlo75nah9syFPnEeF93b+YqrECxOdQcDDomadjJKZfQmcqQM4ooxd
	 sEGMLFEAIxEhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22BD39EF966;
	Wed, 11 Feb 2026 23:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <b471e5dde7d713cf4ef69b41c3d3d3ae@kernel.org>
References: <b471e5dde7d713cf4ef69b41c3d3d3ae@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <b471e5dde7d713cf4ef69b41c3d3d3ae@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.20
X-PR-Tracked-Commit-Id: 8b1f3c54f930c3aeda0b5bad97bc317fc80267fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff661eeee26038f15ed9dd33c91809632e11d9eb
Message-Id: <177085346536.796778.5141677891046197218.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 23:44:25 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13866-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org]
X-Rspamd-Queue-Id: 52A8B1285A8
X-Rspamd-Action: no action

The pull request you sent on Mon, 09 Feb 2026 09:26:04 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff661eeee26038f15ed9dd33c91809632e11d9eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

