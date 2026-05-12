Return-Path: <cgroups+bounces-15853-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDMdOUJlA2oq5gEAu9opvQ
	(envelope-from <cgroups+bounces-15853-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:37:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DA525E81
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB3A30115BF
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1083E0724;
	Tue, 12 May 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ566vjS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0153DC85B;
	Tue, 12 May 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607422; cv=none; b=l2BamXSRfXrh8EdmEV/gh7KUQwbW/1r2TL0Vs6mcqT7T+H/KBlZHGN6gWeghrItyp2cqvUnEJIPspjXRqxhnK91cPKsOd/rkMNkHtSoMTqJdeodbRH4KD7CW2esevPZXbQUXSDPZ7BNYJrSO0gZsowVEnYAWYjKNrvJxrK5LCKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607422; c=relaxed/simple;
	bh=1YWLm6P5dl6Nqn/xSQpMmjICfYZmlh32zBqzh9A+p8A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=FCQMc2KNHtJzcQ335oqs5st01osly8N5xxEGH6VyvkkJN7pAPXh7r+k5wVj03CGMirebhnF7zWSnanTy0Za4NDkf1wr9Gk/zkN3mwKaVOcEwTOky6U1POiQZDBsAj9Vl65oQ98SJdBHz5V5uVWwE8CsgO/z8KivaQj8cUfZTSi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ566vjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D284C2BCB0;
	Tue, 12 May 2026 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778607422;
	bh=1YWLm6P5dl6Nqn/xSQpMmjICfYZmlh32zBqzh9A+p8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJ566vjSXgweHDlHu8LJSIbOY1CkCckjo6GvLQnAACBt5LOXs8Csa98m7zLt//ePU
	 1klnV/b3K5XQLftE0R87bAjMZMWFv6cQ7QZgl97gWK0lts0vfTXRkWdcWbioR3Ksj4
	 E7GPKogEEbPRizsN7xSJLLHKqnUzM8Nmq98fn9Tn2VqhOAJzjyPvBc/3AskWvO4+Qj
	 vGsO1XvRCICUqEdB5j854egpqlzvWd7rC0u+I6ZYlvu5aV8xs9twLdGeRAiRVepNpr
	 oYQBJwgqrn5oBsNeNTZHVb/hR5YnQXGhoztu0lNmVr7wfugkoxgxVq3TSavAMAULe/
	 ezsKx6s7/HMSQ==
Date: Tue, 12 May 2026 07:37:01 -1000
Message-ID: <efa2a7a0fd633cd8fc6a9f5d40eff1c4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	mkoutny@suse.com,
	shuah@kernel.org,
	vishal.moola@gmail.com,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: check malloc return value in alloc_anon functions
In-Reply-To: <20260512071424.59449-1-lihongfu@kylinos.cn>
References: <20260512071424.59449-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: B95DA525E81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,suse.com,gmail.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15853-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

> Hongfu Li (1):
>   selftests/cgroup: check malloc return value in alloc_anon functions

Applied to cgroup/for-7.2.

Thanks.

--
tejun

