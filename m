Return-Path: <cgroups+bounces-15858-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GVcDH1wA2p15wEAu9opvQ
	(envelope-from <cgroups+bounces-15858-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:25:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF4152789A
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC4EC3046AE5
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 18:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667A381AE7;
	Tue, 12 May 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDb7t29T"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ACB3812C8;
	Tue, 12 May 2026 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610052; cv=none; b=kzq6vav8qx/MiCPOVKIDGSkMn0eKDh5PJoFYIt0lWzPfXQAaL4+1xmUv804zGU4WD8LBTiLrIM1XKnUBbCP5SVm6pJNYi41rzx/wT2OTKKjb8d8l+n8xyoFqPnW1LxktD4ibunuyQfJZr/Dy64xOH/z+vn8B63buXP3QzY1ih3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610052; c=relaxed/simple;
	bh=V3W42SBmQf4d+KigTBwM8MJb1z78Kgg0dhdU64pdM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnnL+dNQwnJwd41U1P8zOqgOu6BCjdUojoQayRmpRdHyM2TqIKvde2T55gKeTlR9GrmrYvSORdfnCFfuA7YMdTYXo3agBUc7C4qK03hSQj7BIrAGHNH7CZFKt8qoWl2iw5xoeqK7rFWkujVUWRJPIfR8a10YjwQ9ysIw5IX6ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDb7t29T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA7C2BCB0;
	Tue, 12 May 2026 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778610051;
	bh=V3W42SBmQf4d+KigTBwM8MJb1z78Kgg0dhdU64pdM0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DDb7t29TUPL6s/59AWia8vypqivnxK2p/U0uizuLS6J6OUMV+AlnttnbJ/FAyRnEd
	 eqjjKu1waqlK5rVtfC/wSJfzV/J93D94F6ZXy55yYBWMFSWqmnVDQbhTRjZaS/nIxu
	 ipqURz8n+VDp6Dn0tJjuw+wDMa2CMHgw416w6wy9tJPblbl2/fTFWSraHlnF8at9ZD
	 6oNNU2AyoNBoP2dn3FPQOt5XCClU4O6uGaDFfUJwOsJzulCyZisWq7X/35KUcvzbQW
	 gQqEp5VF3QKzpwQhFl4sc5HtUf1V0USPSrXDkgUqxLZO03UnqkiqM9AfPBdoKo75kd
	 ZNf0LWvQxOqtg==
Date: Tue, 12 May 2026 08:20:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Cc: luca abeni <luca.abeni@santannapisa.it>,
	Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agNvghphiv9sCJrq@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507163058.2c435922@nowhere>
 <agIfvZuvXEtK45em@slm.duckdns.org>
 <c446b9be-38d7-425c-9ca8-eda721fe1c9e@santannapisa.it>
 <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b549b3cb062f2823ba6d4723b7b9260b@kernel.org>
X-Rspamd-Queue-Id: 4EF4152789A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15858-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[santannapisa.it,infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 08:19:02AM -1000, Tejun Heo wrote:
> How is a delegated subtree prevented from setting cpu.rt.min = 'root' and
> escaping its ancestors' cpu.rt.max budget?

Hmm.. I guess the same problem exists w/ separate rt controller too. If the
users on the system already started using rt, how do you enable the
controller from the top down with budgets already being used down in the
hierarchy?

Thanks.

-- 
tejun

