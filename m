Return-Path: <cgroups+bounces-7294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549BAA78DBA
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 14:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64D8188743E
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB61238143;
	Wed,  2 Apr 2025 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7BJW10G"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F91F193C;
	Wed,  2 Apr 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595350; cv=none; b=fkPMvhlo/JHgbTL62/LChlCbXQ5/VqvOJkC+WXBFpu4THuTk/FH9ppJyhhd/S+yUkfUgsgoy9lwPH4RzduH/lLXU2+aIe57ILECqlUGsWsL5JJerpRCN9dk9mlb6UqCin9Wo4bfhuNGh4j9mgnEuDqKU3hLZZ7ej34G6/22lkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595350; c=relaxed/simple;
	bh=/uRe8juAyNjvT074UUFtT7BzdAjIF+8Vp2kQuJpbXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyzQ44otR+tHRxLq8tSfpqOEdKZRhua2nKxMb+CLSZlOTIUSXA+x6tT/l5r+vdenlsQQn/v9exW9Wekb8F+pD5Dz6ClH/LIzLssWtPnzspVv8+oW568p0C7kEN1GqDtpBTSXGBHoq7vcCeddKsTscc/YQU/IRmC4qjoeYeeKpw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l7BJW10G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=J5HzyVg1ibODAqAdqBdQkWXm7C+2v/eTopikm1aV9kE=; b=l7BJW10GJUnhWWEWFDPzvHKSqJ
	PV0Yxl0Al7whfrVZtNhH7KdxjVq3nbRLx0E7oNcktWcGP4O4QRxZ1r2RXTBRfUEx1s4/jv7PUoSzv
	XDt45e3LeqM/DnwtGpriuJdwKhkyDqsy9WVUA0UeEBNCwjjehjslVfY2A9irZhHxCbtnzbiD8ynix
	Tm32CCuPn7FBAb9YAznIjhD2wZo+0Ta+sSh5XRt3Br1nlxKQ2eAQaZGU9YuD+4yIzFJEnH1gqD/Ai
	cH1uekb2j9yuc+k8jq97A9vOVV+Ca+q07Hyr3KcQOqrfV6ZR2gOgIONb2z6ivEdBG3czpZ9UJ8Gcs
	Q1GCLrCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzwnW-00000009PuK-2KBE;
	Wed, 02 Apr 2025 12:02:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC46D30049D; Wed,  2 Apr 2025 14:02:21 +0200 (CEST)
Date: Wed, 2 Apr 2025 14:02:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 06/10] sched: Bypass bandwitdh checks with runtime
 disabled RT_GROUP_SCHED
Message-ID: <20250402120221.GI25239@noisy.programming.kicks-ass.net>
References: <20250310170442.504716-1-mkoutny@suse.com>
 <20250310170442.504716-7-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310170442.504716-7-mkoutny@suse.com>

On Mon, Mar 10, 2025 at 06:04:38PM +0100, Michal Koutný wrote:
> When RT_GROUPs are compiled but not exposed, their bandwidth cannot
> be configured (and it is not initialized for non-root task_groups neither).
> Therefore bypass any checks of task vs task_group bandwidth.
> 
> This will achieve behavior very similar to setups that have
> !CONFIG_RT_GROUP_SCHED and attach cpu controller to cgroup v2 hierarchy.
> (On a related note, this may allow having RT tasks with
> CONFIG_RT_GROUP_SCHED and cgroup v2 hierarchy.)

Can we make it so that cgroup-v2 is explicitly disallowed for now? As I
said earlier, we're looking at a new implemention with a incompatible
interface.

