Return-Path: <cgroups+bounces-15955-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALFDJGQ+BmqmggIAu9opvQ
	(envelope-from <cgroups+bounces-15955-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:28:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6350A5470C4
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D285D303FF9D
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 21:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD053C1416;
	Thu, 14 May 2026 21:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8znoV+8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AC3AE1B9
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794028; cv=none; b=FMYd5rQssQ+k8mDji/Zy1gC8Ns2lF8dxWYtY41mC0DQWR9k+RoF0+K8BelnPHpXs3l2ELRCIqyZTXBwJXEEVzYP0ZTBv+16kpGOG8nS7mYkAF9npbg3vNdGYKsR08zH9e8wIVTcPJzmGxfFPGIAEuil9ebydOeipUntMZcrxLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794028; c=relaxed/simple;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tahSkYoSKnTb2EP/FWOhZEU+lMcYkd5I6Y2n0s5C3RNj5tvRyLcI1qh9CRF8kFvVCSBx19eITHdJTAbycSlA+bRh3dgiao97GhYPXZkGGFVouyT7BnpjtdAWkFdMcOHSLyQqzxj8MNrR7C6ntbou3nwHG6kLISgwJdH6/cMs0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8znoV+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62477C2BCB3;
	Thu, 14 May 2026 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794028;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A8znoV+8g9i8oiHAL4mkJqpOz2lJSxRV+FMR+diSjHyzWhOgrDLvATbK0L3NfJipE
	 3GgUbvAOU0V7cSev+ipTtg0gTmwIPyJUeysRHlGEPHx8CwOqv1HgulZ4S99HNOY53S
	 hsUl14XBXMIIKrCPXMVG31JsSVJBWZHYaI5lqTa8/f+KCCqu4OV/TMgXrtlgFxwON+
	 y6lTR+9e/lCDj/63o2SX4y7PsqwghXOnmxSJtKwtcD7WEA7Zy9C2B2mPtL2UiU+oX1
	 4w5iT8CHIrvkOuzwAUU4r1//IMWvktX9DGDpvDp7fnTl3zLb36AYzO7KmTPamDjJ3P
	 cgmuG2FTxNoSQ==
Date: Thu, 14 May 2026 11:27:07 -1000
Message-ID: <fecd5643b3b87f7e40741975b9f5e4a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v3 0/4] cgroup/rdma: add rdma.peak and rdma.events[.local]
In-Reply-To: <20260514065034.387197-1-cuitao@kylinos.cn>
References: <20260514065034.387197-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 6350A5470C4
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
	TAGGED_FROM(0.00)[bounces-15955-lists,cgroups=lfdr.de];
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

> Tao Cui (4):
>   cgroup/rdma: add rdma.peak for per-device peak usage tracking
>   cgroup/rdma: add rdma.events to track resource limit exhaustion
>   cgroup/rdma: add rdma.events.local for per-cgroup allocation failure
>     attribution
>   cgroup/rdma: document rdma.peak, rdma.events and rdma.events.local

Applied 1-4 to cgroup/for-7.2.

One follow-up: the new event counters use READ_ONCE() on reads but plain
++ on writes, and all accesses are under rdmacg_mutex. Please send a
follow-up patch dropping the READ_ONCE()s.

Thanks.

--
tejun

