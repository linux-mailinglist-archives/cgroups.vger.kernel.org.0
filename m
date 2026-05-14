Return-Path: <cgroups+bounces-15953-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL0tAl0+BmqmggIAu9opvQ
	(envelope-from <cgroups+bounces-15953-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:27:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3A5470B6
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75B853021E64
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 21:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3F3B8406;
	Thu, 14 May 2026 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCa/hBaY"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AB25B094
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794018; cv=none; b=WEdphJpC5FmVaawZPqWZibsU5d/YshL62pzUfIj60JJMqQZNxop1bbGuIsfRT5X/mi3lnH3bVQHRntmMe2paByUR45LIHAZaNn27HA3BLPwE2ZsB/lEYqo5p6Dza6DG7QKYv4JRF0cBVqG5xr8/WWcAef0CS9zMUICfq2QHAfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794018; c=relaxed/simple;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WAfy+KN3P2MTgMxl1hhQTz79H0DiJvzvkRwAbtwXNBnc71xxpxFs9CffMWwEqg45pqA1vIrZWJZ3P6SfXx6fI7hF9VDF5illYefjeaugTutImHs/iRTOYY1WlyZxawIpPDQdqYpn3nbY/f+85PtJUJT8Wyb4HU36uzbGUivA/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCa/hBaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B1AC2BCB3;
	Thu, 14 May 2026 21:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794018;
	bh=ICqq6yT6L0OzuLwOLkwbzZUQ1wutvXU4NnOmK1n5JFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCa/hBaYstQu8mlPmiFKdz3Tn/I/TpXrkdVY+QLN6BguNlL/GrZOUq2+hxCj5cbRG
	 z8gOAe77YZmmImPkShlCGoRH3C/i18bdXIAKh3BBY4u14gp714Z8Bd+YR3HNIHnYQW
	 YzOEakFnO128VnP+gJ8cVBhc1y6rKwXD8xcqdxiAeCWOK032QgTlG1zt00vYSozT0E
	 N0sSMc6GRQ2oUo76XhZQg4W2wdYrDeAkQ7ozuDN1SyDvOog+iTy50h67eNlxBd05o5
	 4g++KNUuphevX3va6myPIX9Vf+6uJ8fR5VUlhY0bpl9nn0uVGXgyMJwW7Ytn0hpVne
	 9MbzQv6sPW2qw==
Date: Thu, 14 May 2026 11:26:56 -1000
Message-ID: <1d47de9b305b1576a24c242aa9e72c28@kernel.org>
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
X-Rspamd-Queue-Id: 91C3A5470B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15953-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

