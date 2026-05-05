Return-Path: <cgroups+bounces-15628-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FPNNilN+mndMAMAu9opvQ
	(envelope-from <cgroups+bounces-15628-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 22:03:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F464D361B
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 22:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01E9E301E240
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA93BED44;
	Tue,  5 May 2026 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsfgsgMD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A18191F98;
	Tue,  5 May 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011020; cv=none; b=t7H7r4iP9jdoA1DndJRqzuKv+sF97213vmmjxXfDh564ok2DSB1pN1fGuh2YUrxp0JLyQiJgWWTUJg4PRD/iwzoODVG9jW53p0uoCWV4D1kpyhQgI34l8ffz5XpVteP52SBIpYUahsg007lJpUMG/JreLbsOqyOa8X7ELUK2ops=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011020; c=relaxed/simple;
	bh=opI4nRge+pnDPw6dlEInDU8nwonqI8rpKgI7ADyuHaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AboiTSvjYzplG5kQJNsW4Xh9vlYSOhnyjbqOG8Xc/g8A2hQCGlOfCZ0XEAD4PTUGbGfAMjao0SDv5bN22LeiThecI9vGnmxZjJYFdiqm4zCcHoFaxezmPpPa0/A3gxJT4lsnAjwRhO9jbLT5hwGFlWPTkD3dsmmj0WP1/cyHdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsfgsgMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E21C2BCB4;
	Tue,  5 May 2026 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778011019;
	bh=opI4nRge+pnDPw6dlEInDU8nwonqI8rpKgI7ADyuHaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsfgsgMD5s82Kcae2a+cW5/cYF2A3ZDVlVMlnk7O9DMrT7b5RWYdLhr2RtKabDCIB
	 GiB0T/YeL3ej4Mr0TcHGdjulI4xXp8YmApkxxw6/bBQZ6zf8JP7WXoo9S6sLUszh/F
	 /rXixGnhPmOylAS9OPZhD98dxKzaifRzWfrgK5uKfJITo0VVHoJ+RVTWvZR7Hj9Ykp
	 qf5qiK4lDRXWEI3oFqnZyaZFbY6LMVyMlV1JpbK+aWCCs0is2Z9S3UO4d1nXxIVvtH
	 oF44cfaQyAX45VpS2S28pvKADDOcWLXDwYHsyM+Q2Ucsj28koHE0EL/7tiT300Mjid
	 vyI5np2Iu6DeQ==
Date: Tue, 5 May 2026 09:56:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <afpLir8tD0Ycb3D8@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: E0F464D361B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15628-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid]

Hello,

Some high level comments:

- Please align it with existing cgroup2 interface files. See cpu.max. This
  can be e.g. cpu.rt.max without about the same semantics.

- cgroup2 enforces that internal cgroups w/ controllers enabled cannot have
  threads in them. No need to enforce that separately.

- However, the cpu controller is a threaded controller which means that it
  can have threaded sub-hierarchy where the no-internal-process rule doesn't
  apply. This was created explicitly for cpu controller. The proposed change
  blocks it effectively forcing cpu controller into regular domain
  controller behavior subject to no-internal-process rule. Note these are
  enforced at controller granularity and this means that users who use the
  threaded mode will be forced to pick between the two.

- This has the same problem with cgroup1's rt cgroup sched support where
  there is no way to have a permissive default configuration, which means
  that users who don't really care about distributing rt shares
  hierarchically would get blocked from running rt processes by default,
  which basically forces distros to disable rt cgroup sched support. This is
  not new but it'd be a shame to put in all the work and the end result is
  that most people don't even have access to the feature.

Here's my suggestion if there is desire for this to become something most
people have easy access to:

- Don't make it impossible to use in conjunction with other resource control
  mechanisms especially not CPU controller itself. Don't force people to
  choose between threaded mode and rt control. Allow them to co-exist in a
  reasonable manner.

- The same in the wider scope. Don't let it get in the way of people who
  don't care about it. Compromising on interface / failure mode is better
  than people not being able to use it in most cases.

Thanks.

-- 
tejun

