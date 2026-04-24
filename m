Return-Path: <cgroups+bounces-15495-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPsjKXpB62nZKAAAu9opvQ
	(envelope-from <cgroups+bounces-15495-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 12:10:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1645CC5D
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 12:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38603058161
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 10:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D714362157;
	Fri, 24 Apr 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h3Twi9g5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A5C35F8B7;
	Fri, 24 Apr 2026 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025166; cv=none; b=lua49A8JE0k8v8xWz2ZBjdk/gBR2WUf4wCdGB49cTbZWBfm5qSuAV40aV6ZJsLYI4hlQWdo8nDhFkYrgUizDxLqv3pZ3Ng+l1JRZZbt4bsU07h3vyulxUS7EYzNWc0bsKSv1V3mEWYt0iN7CIZIO9eyWe6PFHeEVR/ACK+lPRF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025166; c=relaxed/simple;
	bh=5QXbN60HW7CsXZ5gwYFqYgAkYkkEIgU02nf2dVj5W3Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lCyYy7/I2vabe2maRerwD7gMacjnB2JJTwStcxuuFMdJIKRbUqPiPZtTwcSvNUVNn1L61Lje2tPFILXGqyu9Z6iZ3l8CXGQw/EscIeat0AfYBFXceMXCdxnDnks1mL9jWh/LiE+XI57fDZBlDHRL1BQulhmrX/PuDg6HPrey+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h3Twi9g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C7C19425;
	Fri, 24 Apr 2026 10:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777025166;
	bh=5QXbN60HW7CsXZ5gwYFqYgAkYkkEIgU02nf2dVj5W3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3Twi9g569dZT07Ied/Me3zb+JPHA6eAsaQsNpHFXJrsrM4zUZlehSAh2LWT0VN/4
	 qKd3Usi/c2Y7+LBaDAlN7ZMeW3J/2WG2cgGiEo1CkFwqRMSAowxutZvnGNxVteJQA3
	 31c//zfVgdvryiRcUuP4ITuW/prdCVrvtsJdZkf4=
Date: Fri, 24 Apr 2026 03:06:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Wang <li.wang@linux.dev>
Cc: tj@kernel.org, longman@redhat.com, roman.gushchin@linux.dev,
 hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev,
 nphamcs@gmail.com, chengming.zhou@linux.dev, mkoutny@suse.com,
 shuah@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] selftests/cgroup: improve zswap tests robustness
 and support large page sizes
Message-Id: <20260424030605.6d0053c0df14bba325114e1b@linux-foundation.org>
In-Reply-To: <20260424040059.12940-1-li.wang@linux.dev>
References: <20260424040059.12940-1-li.wang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3EB1645CC5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15495-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,suse.com,kvack.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 12:00:51 +0800 Li Wang <li.wang@linux.dev> wrote:

> This patchset aims to fix various spurious failures and improve the overall
> robustness of the cgroup zswap selftests.

Great, thanks, I'll queue this in mm.git's mm-new branch.  Next week
I'll move it into mm-unstable, where it will receive liunx-next
exposure.

> The primary motivation is to make the tests compatible with architectures
> that use non-4K page sizes (such as 64K on ppc64le and arm64). Currently,
> the tests rely heavily on hardcoded 4K page sizes and fixed memory limits.

Well that's an oops.

> On 64K page size systems, these hardcoded values lead to sub-page granularity
> accesses, incorrect page count calculations, and insufficient memory pressure
> to trigger zswap writeback, ultimately causing the tests to fail.

I assume you've been testing on arm64 or ppc?

> Additionally, this series addresses OOM kills occurring in test_swapin_nozswap
> by dynamically scaling memory limits, and prevents spurious test failures
> when zswap is built into the kernel but globally disabled.

