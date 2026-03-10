Return-Path: <cgroups+bounces-14741-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNF0IYl9sGl9jwIAu9opvQ
	(envelope-from <cgroups+bounces-14741-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 21:22:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05535257AA7
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 21:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B202A31BE516
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 20:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55093E92B5;
	Tue, 10 Mar 2026 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNHjGrUK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CDF1F09A8
	for <cgroups@vger.kernel.org>; Tue, 10 Mar 2026 20:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173907; cv=none; b=BYf0Euvir7tSHRS7Pw1W0jv3E/NXFod5Itw49yPCiX21xvnK3jTNDVclvimiMefbJd0ga+edV1lU27fgfzoDGxFQLK1D3fUNUp1QXTEb7hVVWSs0vuG9WpIzH/HN4smfLeO8dMNtlc5v4oBV/aCWsWO02JbXC8kr7FceE4qlRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173907; c=relaxed/simple;
	bh=l7YqOaZ9Cxh9OXa7MgS8e984/y7Zy/UdguEwUSgLLeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCrkYJnQmBDQ+rsahjBlnLR2uLLFeNCdqgDzLnsDOAXcoXG8kIGJTziBlzihtuintNzJ94d7aFepnBkxQHh7alDwl/Jv/bz3B5TV2vxfeqAqtEbGe/NLqCQK3ec2QfJ9j2DTEBXnCN2VVcunw46ipquu90bXAGaF19pGTe6cts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNHjGrUK; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 10 Mar 2026 13:18:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773173894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fo82tIF5+QnwYHGL8br4DawXmsD1Q8bLn239Zv/oPPQ=;
	b=uNHjGrUKra94eH3gTyRIEQ0bcFls29b3XMpYdV5WnmB3mrDzx1L4Q+tXUXL/4Wb9sXaraN
	/ghkAe4VwmTQLIRFKVMrm3AcCC4uVXx/6hQBdzMweVM4SBRC/f7T0HdblLTkhXfZRAc47F
	JWHcbPRDUTCvqa4XetG6PebEo03j5wU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftest: memcg: Skp memcg_sock test if address
 family not supported
Message-ID: <abB8Z_IV-8COna8U@linux.dev>
References: <20260310143936.720592-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310143936.720592-1-longman@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 05535257AA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14741-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 10:39:35AM -0400, Waiman Long wrote:
> The test_memcg_sock test in memcontrol.c sets up an IPv6 socket and
> send data over it to consume memory and verify that memory.stat.sock
> and memory.current values are close.
> 
> On systems where IPv6 isn't enabled or not configured to support
> SOCK_STREAM, the test_memcg_sock test always fails.  When the socket()
> call fails, there is no way we can test the memory consumption and
> verify the above claim. I believe it is better to just skip the test
> in this case instead of reporting a test failure hinting that there
> may be something wrong with the memcg code.
> 
> Fixes: 5f8f019380b8 ("selftests: cgroup/memcontrol: add basic test for socket accounting")
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

