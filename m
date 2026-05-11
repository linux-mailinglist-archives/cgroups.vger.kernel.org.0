Return-Path: <cgroups+bounces-15710-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDR/HhI4AWplSAEAu9opvQ
	(envelope-from <cgroups+bounces-15710-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 03:59:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51838507167
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CC9D301D6A6
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13994242D6A;
	Mon, 11 May 2026 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlGz0HfE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C916B17555;
	Mon, 11 May 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464756; cv=none; b=gxUIad7f9/UmFyf9wqfw6PYEkVFMD1UFgI5B7iVqzcrB9+ShH2tbJWJt9k8qcGfiHJQndwlQbx15OGYb5FNPVEYstFtJVg2kVkXBS5nIL1BAfDfoiCYTz0M5kdB+5kKJtVTwXpJt81ynetmgkD0YXKy7X8UYR2mPuAn9S8xhp+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464756; c=relaxed/simple;
	bh=/bnuSi6Jyx6Ck/Xl8v6v+2RU46QHYn5Jj0iPaddHTv8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=GQZcpTxSra9Ehxv4FiVwsGmafDOgIkykiEhUsPxQu/wNu3vn1Qzvz6cYp65PNbmUBOeUDsy17Ll4ka1ROCDRblraTMyg2oaah4FJrFxO6x21Rx4qpJ1PwNx95UzIwMbqfy1TlfjQ6BgiQ6qOt7+yHO0mK1nl716nFtLl7As1SvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlGz0HfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE59C2BCB8;
	Mon, 11 May 2026 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778464756;
	bh=/bnuSi6Jyx6Ck/Xl8v6v+2RU46QHYn5Jj0iPaddHTv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PlGz0HfEd+KnfvDQO1xiakQ4Ephkc3idA45CVkYFpy1puVO4HKc/m+Hpy7yOqMYae
	 b1iYs4UkdYr5HkzyjVFuTD6sKY2J6xHFsyTAv5W4tykHt/z0dGyOLKBhdrnR4dUfum
	 zHktdXGGE6qnDk75U7bK6ZAVpg3hXGgj6jPK1uE08hIQ/ft9/Dr1ZC8lVnGAi8UhwB
	 HZ3nK+5HvWrpb+EIko4/LH2djeAOK0wjT/UXxBtJoiz73d/FFRFQEWNfsK91PhVXSg
	 ONy1dvffGPVbr2EqNste2kR0kPCTTCILdymmBmufTwadpyvmRKIUXtRvB9Q7uHdWbS
	 p+zc/EAikTX3A==
Date: Sun, 10 May 2026 15:59:15 -1000
Message-ID: <ac005a30532c0c8660bd9f57c22e3e7e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutný <mkoutny@suse.com>,
 Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cgroup: fix string comparison in write_test
In-Reply-To: <20260511013957.1749665-1-lihongfu@kylinos.cn>
References: <20260511013957.1749665-1-lihongfu@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 51838507167
X-Rspamd-Server: lfdr
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15710-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

Applied to cgroup/for-7.1-fixes with the subject capitalized to "Fix
string comparison in write_test".

Thanks.

--
tejun

