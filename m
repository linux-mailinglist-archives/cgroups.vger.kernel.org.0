Return-Path: <cgroups+bounces-12234-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF9C9245F
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 15:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ED93A9620
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9599227E95;
	Fri, 28 Nov 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O3UYfeL9"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1751322A7E6
	for <cgroups@vger.kernel.org>; Fri, 28 Nov 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339403; cv=none; b=A/tiesKyd4fxohnH7wptUBUBbDBjNE0x1PVZUdSaiUbNpyy5/JdgznvPGt8cnRQFT3wZkJ3YEV1Y4NyLzODlfeEckaPoB0S/znYDZ9TAtQA1XdVX/euY4KVbLe96fUbPK7dfhsL01nxRbu/bHRhQpWnCZKULGDPoY21dxqLRJKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339403; c=relaxed/simple;
	bh=QCjAP8jX5xRzn7TcauJhsRgk5qklbh8vAWgZHuaM9Fs=;
	h=Cc:From:Mime-Version:Content-Disposition:References:To:Date:
	 In-Reply-To:Content-Type:Subject:Message-Id; b=qtMZQsq2p/sw7hd1oHfeuaTquz+Qc4TWo1qwNvs0nj+N2Diu58S8Vn53Yo6APCpBpMczgIvZyTkN42Yrb3w3wl56aLYjFRbdvw0DfXkOFf+2KX+r73O/0atcvF1fuam6zCpxLsDTk2a4c7WWKxS4ha21lS7ZdTUjeRGmln6a6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O3UYfeL9; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1764339388; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=S9f3GMwP3oe5AIthOqm0AJhKKA4bfzQFGGdZN8zW1tg=;
 b=O3UYfeL9dUR/se6i8KBW/eQmciMXBCXen9X/loJ35bHej9hZaCnTwKBegpUDPNgSZnkPhd
 Z6KGhubIIXVaPuzmYpB9muZ0HIdIJcPh+eWXbcmCqHomWLEAuHVxQJpgO3oAB1qoaZHce/
 e4je0Sv8e9RLGpVZJQQAkvae4spdNZORb0jyRs2BFofq2aIaB1ZadbmnOTO+hNl4uXghv+
 dH8K9GmDTN5ahybol1WIama1XpRXwufKhVxGLc9KjhehC5yfkQGctcOIhCxLOeqT2bDRxZ
 pw4wZYnbhTiXByqAzOIufIKVA5D5sSp4HJUE5TRROBM0yv+nncpTgcWhQoeaDA==
X-Lms-Return-Path: <lba+26929aeba+c11716+vger.kernel.org+ziqianlu@bytedance.com>
Cc: "xupengbo" <xupengbo1029@163.com>, "Ingo Molnar" <mingo@redhat.com>, 
	"Juri Lelli" <juri.lelli@redhat.com>, 
	"Vincent Guittot" <vincent.guittot@linaro.org>, 
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, 
	"Valentin Schneider" <vschneid@redhat.com>, 
	"David Vernet" <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<cgroups@vger.kernel.org>
From: "Aaron Lu" <ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
References: <20250827022208.14487-1-xupengbo@oppo.com> <20251128115445.GA1526246@bytedance.com> <20251128134017.GL3245006@noisy.programming.kicks-ass.net>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
Content-Transfer-Encoding: 7bit
To: "Peter Zijlstra" <peterz@infradead.org>
Date: Fri, 28 Nov 2025 22:15:57 +0800
In-Reply-To: <20251128134017.GL3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v5] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Message-Id: <20251128141557.GA1598584@bytedance.com>

On Fri, Nov 28, 2025 at 02:40:17PM +0100, Peter Zijlstra wrote:
> On Fri, Nov 28, 2025 at 07:54:45PM +0800, Aaron Lu wrote:
> > Hello,
> > 
> > On Wed, Aug 27, 2025 at 10:22:07AM +0800, xupengbo wrote:
> > > When a task is migrated out, there is a probability that the tg->load_avg
> > > value will become abnormal. The reason is as follows.
> > > 
> > > 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> > > is a possibility that the reduced load_avg is not updated to tg->load_avg
> > > when a task migrates out.
> > > 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> > > calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> > > function cfs_rq_is_decayed() does not check whether
> > > cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> > > __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> > > updated to tg->load_avg.
> > > 
> > > Add a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> > > which fixes the case (2.) mentioned above.
> > > 
> > > Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> > > Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> > > Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> > > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > Signed-off-by: xupengbo <xupengbo@oppo.com>
> > 
> > I wonder if there are any more concerns about this patch? If no, I hope
> > this fix can be merged. It's a rare case but it does happen for some
> > specific setup.
> > 
> > Sorry if this is a bad timing, but I just hit an oncall where this exact
> > problem occurred so I suppose it's worth a ping :)
> 
> Totally missed it. Seems okay, let me go queue the thing.

Thanks Peter!

