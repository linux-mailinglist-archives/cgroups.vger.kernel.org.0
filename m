Return-Path: <cgroups+bounces-15496-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAOLKIZS62nkKwAAu9opvQ
	(envelope-from <cgroups+bounces-15496-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 13:22:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAAB45DA94
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 13:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE2A302B3B5
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA03A6405;
	Fri, 24 Apr 2026 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uujKu3cf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1A3A6B7C
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029293; cv=none; b=oO0rnZeXxE9p6VLTgNrYpigmuhCz0ZNvMntmQZqaDtxuejNKHLT2+K42pgBQ/SNRiGSmzX9xPZF0npHeluDbmn7BPXD0s9hXXvY97ZzdCYEwS69kOUeXeJg5+KbbMK3X2+oYmdFbU3DoYmsqoOSKf4HngfLiCRbd8qkZLciO0iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029293; c=relaxed/simple;
	bh=OFut7LZ25ijJm3DlyJ6ibNueK54bfaRrIDkTxZ+829s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+iZfPUeGX4iENPq4QP1DuxUvUrBBK1uFVIWR7aEGJkZ5KPc+BWqNMzCpi0XMnVeuhELEHrM63aIvC01pqk5/2DiaIuRM/w9nagDsuw/z9S89VnyJ5sLWd1FMznBQmWoRyS9UuNqrcnPOZy99a2bX6RTh/KJc+FAlaRd7s1+gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uujKu3cf; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Apr 2026 19:14:39 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777029289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8nxhobJIEqRPMXJNaKk3lQ6NoKAj8IkBVR0FHTowZBw=;
	b=uujKu3cfZCrIAwlGqAVxSFfErknaSpXGBuDAe2HoHz7u9UEM1kaw9otuktgVxsOvP4LsIX
	DI6NDkjEvIcjxbFiv7WfScKJ0cklj79gzgNOzoaYIeqH93JAqkbzYZwjntCPMkfel30YRj
	SjZhjVufLMOW9iTxjG647Li6GA3+AB4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tj@kernel.org, longman@redhat.com, roman.gushchin@linux.dev,
	hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev,
	nphamcs@gmail.com, chengming.zhou@linux.dev, mkoutny@suse.com,
	shuah@kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] selftests/cgroup: improve zswap tests robustness
 and support large page sizes
Message-ID: <aetQn9H_0Hi-4jht@linux.dev>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424030605.6d0053c0df14bba325114e1b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424030605.6d0053c0df14bba325114e1b@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 2AAAB45DA94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15496-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,suse.com,kvack.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[li.wang@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 03:06:05AM -0700, Andrew Morton wrote:
> On Fri, 24 Apr 2026 12:00:51 +0800 Li Wang <li.wang@linux.dev> wrote:
> 
> > This patchset aims to fix various spurious failures and improve the overall
> > robustness of the cgroup zswap selftests.
> 
> Great, thanks, I'll queue this in mm.git's mm-new branch.  Next week
> I'll move it into mm-unstable, where it will receive liunx-next
> exposure.
> 
> > The primary motivation is to make the tests compatible with architectures
> > that use non-4K page sizes (such as 64K on ppc64le and arm64). Currently,
> > the tests rely heavily on hardcoded 4K page sizes and fixed memory limits.
> 
> Well that's an oops.
> 
> > On 64K page size systems, these hardcoded values lead to sub-page granularity
> > accesses, incorrect page count calculations, and insufficient memory pressure
> > to trigger zswap writeback, ultimately causing the tests to fail.
> 
> I assume you've been testing on arm64 or ppc?

Yes, before sending, I teseted the patchset on:

    x86_64(4k), aarch64(4K, 64K), ppc64le(64K)

-- 
Regards,
Li Wang

