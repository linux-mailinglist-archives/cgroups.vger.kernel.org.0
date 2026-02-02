Return-Path: <cgroups+bounces-13606-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IaII80DgWnZDgMAu9opvQ
	(envelope-from <cgroups+bounces-13606-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:06:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE3D0EDC
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3CEE3008CBB
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 20:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965B230DD0A;
	Mon,  2 Feb 2026 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6dVYSEn"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812F2E6CD9;
	Mon,  2 Feb 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062715; cv=none; b=QaykTBOq3huD+Z3JOxRoxSLUyOJi73LnYaH5KQIYFUiJWp6IUZY1RxeAvUcAh0MLBFDBQhhKfqKcse1dV0RLXsELuPI58N3Egkp0I/hcX/2t3V5T+7AqVSSD70b/sE1q4WVwjoP6LFjQuOyCuU+GZ7+B1sFl2SW4sC6Jhl0UuMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062715; c=relaxed/simple;
	bh=7tUAdfG6+/G0PkbLR5JQlA8/Gz/RMGzOtYhhqnrrimo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OA692PixQ1GPGneHGr4xUkPB4jlYVCppeDMkLVD500eX0m9/tpdpNncX4O0RgckSA2ZIq5auRS6kG1ApNnawY2v2BGMfaZh7NQSnCmK1uml1Cjpxa96HwhFjrM9u66DHu51vBDCGBlqTZ3JihERKMBIHfrss2aX0YixoICntH00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d6dVYSEn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t7JLiGEHAJ1HuwqlJP1W6z7nGth+lLjp142+X35LU1w=; b=d6dVYSEnmH5NMKExwnhQ0cnuID
	HLTmwfKB79Z7TJcW97BTRZqh4rwwP5ZtRyF7NmzW2mLbtuXMXKSpictm6SPuZsALkJ1e7sDhs56Mg
	2g4IFgTApJafmC3UZ8sdZisD8mvJbPA1sVGGd2Heyl3TpUsIQIRzw5KT+XrMHJcOGn3WlNh76OlYE
	r9FcY6b5vWAy0MWAY2IZKJ8+C3MAdjgv7hyZddCT9Iw+zqCaaQHxCELROduO/WacabystXwdKdBo+
	4kbJLjDhKUbwOA9HNWakaAI/OV3haz7L9exkMPE2cw2BV/eE7Sq2+FBIZGPCc66w150Nkg6ehJdRR
	CrruVLXQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn0AM-0000000Gzwo-1kPJ;
	Mon, 02 Feb 2026 20:04:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B8D873008E2; Mon, 02 Feb 2026 21:04:57 +0100 (CET)
Date: Mon, 2 Feb 2026 21:04:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
Message-ID: <20260202200457.GJ1282955@noisy.programming.kicks-ass.net>
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-2-longman@redhat.com>
 <20260202130526.GE1395266@noisy.programming.kicks-ass.net>
 <ca4e6c43-2bf3-42b9-91eb-dfce4777b5da@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca4e6c43-2bf3-42b9-91eb-dfce4777b5da@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13606-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: A2CE3D0EDC
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:21:43PM -0500, Waiman Long wrote:

> Yes, I am going to remove cpuset_locked in the next version. As for
> __guarded_by() annotation, I need to set up a clang environment that I can
> use to test it before I will work on that. I usually just use gcc for my
> compilation need.

Debian experimental has clang-22, but there is also:

  https://github.com/llvm/llvm-project/releases/tag/llvmorg-22.1.0-rc2

See: Documentation/kbuild/llvm.rst


