Return-Path: <cgroups+bounces-12232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5C2C91E2D
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 12:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 856B434E497
	for <lists+cgroups@lfdr.de>; Fri, 28 Nov 2025 11:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98083325713;
	Fri, 28 Nov 2025 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LA/6Kezz"
X-Original-To: cgroups@vger.kernel.org
Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED790325700
	for <cgroups@vger.kernel.org>; Fri, 28 Nov 2025 11:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330928; cv=none; b=APZc+6eSnIDY0ehhPyjFJRCPB35SNNGa9ArnT821RDGmNKeoWCPH8VvMWOuV2uej3HDp5XXvUe0AUnqNBFKjz1UFsDXhsEBdcTo4YDLZee6DJzm1XfQ3Uazm9zYgF/bZEI5tJ7nG3DarA2JE3TDX/Z3i5dUfQ17+6BR7c5Q14k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330928; c=relaxed/simple;
	bh=5rN2sNDWFEg+BMAs4tkyzOnRPb4F0IabpRF+4FiZPNI=;
	h=To:Cc:Content-Disposition:In-Reply-To:Subject:Content-Type:
	 References:From:Date:Message-Id:Mime-Version; b=Z1DazBzfwBRISwZ6AZOdwaY72/eiFXBUEUswbUA26ibsQkWYTqpyzgGSGuiGdspx9XWeW0ZJ2CCkPkgmcCjOd1OtevSFFxSYA7y00UHRdFvsRPZP3VJPndzBV1hV8zzSm5IUFTEPkSoJ1tAgG0i3y78z49JJPNWW4ixtx9v7c1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LA/6Kezz; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1764330913; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cxw/0blW+uUqCI4a4MpZbbL98vAmlxV1NVJypIpHH7Q=;
 b=LA/6Kezz3CxjqxLMQAfiINqhJ0UHeIfPvIb1s2zeuqc+HoPi03WQljySpkvoJQoLsirPVW
 b4YarNPJy0bO38FAWKOPYnxVAJn2k8tjCOaJiwT98WD9YY2bExSe/WCo1f/cGaXtLf1NVY
 h/J1263fbzbC8k1XrJnazIDQPGNjRXklJqtfSElMgJwekTO3xRUUEvtjCEyW1Su/c3PqJQ
 cW3hZ6YEZm/ojHpn0UeA/eetuRpCrgV7w8y6WA9w4YWXqFojA4NGa1BBamBSpeOojcLBzE
 7jj75uH5eLeeKPXz9lSsjpbgApiowFDRilyhIjQRuhZHTImXKmVuHNWesUWfEw==
To: "xupengbo" <xupengbo1029@163.com>, "Ingo Molnar" <mingo@redhat.com>, 
	"Peter Zijlstra" <peterz@infradead.org>
Cc: "Juri Lelli" <juri.lelli@redhat.com>, 
	"Vincent Guittot" <vincent.guittot@linaro.org>, 
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, 
	"Steven Rostedt" <rostedt@goodmis.org>, 
	"Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>, 
	"Valentin Schneider" <vschneid@redhat.com>, 
	"David Vernet" <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<cgroups@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20250827022208.14487-1-xupengbo@oppo.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] sched/fair: Fix unfairness caused by stalled tg_load_avg_contrib when the last task migrates out.
Content-Type: text/plain; charset=UTF-8
References: <20250827022208.14487-1-xupengbo@oppo.com>
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
From: "Aaron Lu" <ziqianlu@bytedance.com>
X-Lms-Return-Path: <lba+269298d9f+eebf62+vger.kernel.org+ziqianlu@bytedance.com>
Date: Fri, 28 Nov 2025 19:54:45 +0800
Message-Id: <20251128115445.GA1526246@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hello,

On Wed, Aug 27, 2025 at 10:22:07AM +0800, xupengbo wrote:
> When a task is migrated out, there is a probability that the tg->load_avg
> value will become abnormal. The reason is as follows.
> 
> 1. Due to the 1ms update period limitation in update_tg_load_avg(), there
> is a possibility that the reduced load_avg is not updated to tg->load_avg
> when a task migrates out.
> 2. Even though __update_blocked_fair() traverses the leaf_cfs_rq_list and
> calls update_tg_load_avg() for cfs_rqs that are not fully decayed, the key
> function cfs_rq_is_decayed() does not check whether
> cfs->tg_load_avg_contrib is null. Consequently, in some cases,
> __update_blocked_fair() removes cfs_rqs whose avg.load_avg has not been
> updated to tg->load_avg.
> 
> Add a check of cfs_rq->tg_load_avg_contrib in cfs_rq_is_decayed(),
> which fixes the case (2.) mentioned above.
> 
> Fixes: 1528c661c24b ("sched/fair: Ratelimit update to tg->load_avg")
> Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: xupengbo <xupengbo@oppo.com>

I wonder if there are any more concerns about this patch? If no, I hope
this fix can be merged. It's a rare case but it does happen for some
specific setup.

Sorry if this is a bad timing, but I just hit an oncall where this exact
problem occurred so I suppose it's worth a ping :)

Best regards,
Aaron

