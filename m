Return-Path: <cgroups+bounces-15682-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDY4M4YG/mnumAAAu9opvQ
	(envelope-from <cgroups+bounces-15682-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 17:51:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 798574F903B
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 17:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D030F30065EB
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66D306486;
	Fri,  8 May 2026 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRJl6D/C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58762FFDCC;
	Fri,  8 May 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255491; cv=none; b=Axns/i3lPVDPFojNG3j8cVVAUcnFqh5QNgiqQPmuOagNr6wu64xJF54E/sLqgTriMTw3SKWwA6vIionDFK3lh95lDBfPPHpsPx8EBgAkujNqjZVu95KSTomFaKDDxC6KYSTJOic3Ol6ACeRUxBrZthhbdDHpwIIwCZJJRyLBW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255491; c=relaxed/simple;
	bh=Kxlk9BoN8eK+FNKkDL+ZScIhpFgNCmmdYamMS73UYMY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=fONukhdVRuxft43e8Y9Oz/Dxu61A2pmK/ZOrJFw/Bgwuk4yZtSRN+hYhqgkfJI3kX4QXLvWR7Ef61zcEuIvcNb+Wc0O7W480PwcVJ3+7UmUwocJWQXdQ7KYxnuSKMj+rtvNHznuyjtNVUVTGUncht2f8eab3zEOW0GVs5oOfGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRJl6D/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65275C2BCB0;
	Fri,  8 May 2026 15:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255490;
	bh=Kxlk9BoN8eK+FNKkDL+ZScIhpFgNCmmdYamMS73UYMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TRJl6D/Cdwnju3b4Axwu0o+6SrR+ensPOMPhL3HHcSNYl3YevvpAt7nF41Y41t+o8
	 Oo/PSkQ/qgJl1GV6pZPdspoqzTspQkf6QbG75y+AipNtsdKqD/UGeLIDr1KlgJ2X1D
	 MY5pcehfi5/RBmas22y+seTzzkIKS30lSa/yjNIJWWBL0YT0xCZZzRxoP5yK5BdlLW
	 TDIq2QAGhT4I6LWm8Yzk8qer7Ntwphju3u4AJA3CWY5xBBUjsrrWwFzK+FZpOB4S9O
	 MzM4KrvHOXT/9TbtVEFvDg+zFBeKdtdvBEApJb0XghmA/XS8LcVs468ffotZfQh459
	 WbPNlWCp7O+iw==
Date: Fri, 08 May 2026 05:51:29 -1000
Message-ID: <202d0aa0f8da75986a895ffbd564b78d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Wandun <chenwandun1@gmail.com>
Cc: longman@redhat.com,
	chenridong@huaweicloud.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: skip hardwall ancestor scan in v2 mode in cpuset_current_node_allowed()
In-Reply-To: <20260508062940.4094652-1-chenwandun@lixiang.com>
References: <20260508062940.4094652-1-chenwandun@lixiang.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 798574F903B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15682-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

is_in_v2_mode() is also true for v1 mounted with cpuset_v2_mode, where
cpuset.mem_exclusive / cpuset.mem_hardwall are still settable. Would
that be a problem here? cpuset_v2() looks like a tighter fit.

Thanks.

--
tejun

