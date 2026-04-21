Return-Path: <cgroups+bounces-15442-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEGyIMqp52lQ+wEAu9opvQ
	(envelope-from <cgroups+bounces-15442-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 18:46:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F28743D8FC
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770303022625
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FB637BE75;
	Tue, 21 Apr 2026 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUqpMfhu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6F379EF2
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789755; cv=none; b=B2/G4tVg0Ix6myr75bpqdUZkD6+Dq0o7DgFamZCKJ434Pyo0J8tGitHXmcrmhEY2UuxfF1DT/BIC7uqDP9bYr+OHG4BxTDD+EiwqixRgUpIr2CVSZe6XFrDJP3qK6aOx9Vh2z3EpL8vEo+7p0PwyGeYy9JhKpjy4ze8difFyFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789755; c=relaxed/simple;
	bh=B++9kSKZzk08fqCFslcC5aKChgxXQgzQSAhxtR5y1sU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BTZ39XMf2vgenbfFHuEikx4ckH2yQ+pCObtwFf2o1ViQbkb2gan9vQC++xd9QiYIQMGuWf6uu9/JygMcRhLXFrszi9SUd6m/T23kL3XXSAeerGYbixysr50Ji/Zn70dJHfJpknkF6BbcodmPXQHMROtTdYxuJ61+I9nAm3+FMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUqpMfhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA7C2BCB0;
	Tue, 21 Apr 2026 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776789755;
	bh=B++9kSKZzk08fqCFslcC5aKChgxXQgzQSAhxtR5y1sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kUqpMfhuYvGSuY52fp2QzKV1kK6T9D+8iRzAwdjrKQbn7VqARj7eJ0n9TAkykbJwG
	 q84zVURnAxkFlvgnik07QdpATIa8xLLmQasKFoDAn4yV2H9mTushiaXeHLCfVpb1t6
	 UKLFk3U3/Bd0TBnCk0MA+fRT9mKNFLwXrMSu6N9P1k2VqXwKrt37jJ/Q/f01f+X3ji
	 4ZmTdUCNilPuG8aKAXTKDF7vXI8r1bIbWRjH9Il2MZ7iXOcpgmNzjl3zeHb0OmdeoO
	 tq2RpT0EHixOCN16s5S2eAb/BFeUkGukxOiYroG+D+UIT6jb5mVq7znLhBqh+XPv+N
	 O3OFy5H1fy8GQ==
Date: Tue, 21 Apr 2026 06:42:34 -1000
Message-ID: <d2d00a690c69213cad3d469f0ef478a9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cuitao <cuitao@kylinos.cn>
Cc: mkoutny@suse.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org
Subject: Re: [PATCH v2] cgroup/rdma: refactor resource parsing with
	match_table_t/match_token()
In-Reply-To: <20260420045233.116375-1-cuitao@kylinos.cn>
References: <t2cbjvctdgzipxzovr5zkbovhptkxdaoxljeuxwrxboqqbkzqu@bcazimapp6ci>
	<20260420045233.116375-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-15442-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F28743D8FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

A few things for a respin:

- Can you use your real name in the Signed-off-by? Something like
  "Firstname Lastname <email>" rather than the account handle.

- The patch also drops this comment in rdmacg_resource_set_max():

    /*
     * No user of the rpool and all entries are set to max, so
     * safe to delete this rpool.
     */

  That's unrelated to the parser refactor. Please keep it, or split
  it out as a separate cleanup patch.

- The old strncmp(value, RDMACG_MAX_STR, strlen(value)) also silently
  accepted "hca_handle=" (empty value) as "max" because strncmp with
  n=0 always returns 0. v2 fixes this too - worth mentioning in the
  changelog alongside the "ma" case.

Thanks.

--
tejun

