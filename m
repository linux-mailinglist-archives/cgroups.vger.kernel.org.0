Return-Path: <cgroups+bounces-10413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE6B98DD6
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 10:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78EB34E2D08
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA74280CD5;
	Wed, 24 Sep 2025 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rHsC47U7"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2022F56;
	Wed, 24 Sep 2025 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702517; cv=none; b=YcCyJun+4ao3Zo8MWOR7IR21W7ZrNihTxZn3KMUTy4ZK9DCvDXkAYrEKDEjB9TtDgaP42jn7JjRnKpZCtDFi117UkodU03/hRzmTadBj9CFxfKbfYX9Z3nyxpw/TC7XV9VktgYqRXzIdjc5TJnmz9W9/td/MRPDV4RsmRFvbmaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702517; c=relaxed/simple;
	bh=/l6pEDmoMNTo9JaJyHwB6O8+8ZhdCAKZ0T5ZM4kk0E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBduX8XKHB8t+6huMBcIt9GmA0QiBHAJpUYYUh44Oz7nZsRJLTnYg/BAhhOX8OobONGM7IzgSM/vYC/zocn/5CvCm2VJxDrixQ4WT9taK7UZWNDaeUZu5x1IxYDyi+yPG/UppXCxItqeGkxJCsv7Fp02vKN+VZvw3LfGhDsOUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rHsC47U7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kdMRagcce4kuVQFoW4RA1DbRO+PtAKXUxldV4VeorZw=; b=rHsC47U7KY3p7KkbV3cyt4+Fmq
	7eK6PTDpPyOc3DACjuSdcTBRaarmBt5jpmVZzvAXQjz/1a5IQgDl+7ijQvKR1G4HNA0IICxIXfnyr
	KMoIJLvm9O0gj5ZfZjDDYPu4qN2iGwOTyxRlcUeCOCGLtR3T+1EahvvfcyYYNWABD2LZ06+sEAJb/
	Ff/kh40taKcEAS3HscPod5UDrSuehEHKVzKW1628ntx5Z9/AHOQXi71EZUMOubaQI/Fqt2zF/xi98
	7Lh6Q/SMDqn/g/oY7hkB1dCDA4sBOXGuXdBwu+ypkPg9jEC6Recjfsfy4xJY8qzcn4R/RdmWzlkCB
	/rGrr1dQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1KrP-0000000Byjo-3kWo;
	Wed, 24 Sep 2025 08:28:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 71B4A30043D; Wed, 24 Sep 2025 10:28:23 +0200 (CEST)
Date: Wed, 24 Sep 2025 10:28:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, lance.yang@linux.dev,
	mhiramat@kernel.org, yangyicong@hisilicon.com, will@kernel.org,
	dianders@chromium.org, mingo@kernel.org, lihuafei1@huawei.com,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org
Subject: Re: [External] Re: [PATCH v2 2/2] memcg: Don't trigger hung task
 warnings when memcg is releasing resources.
Message-ID: <20250924082823.GV3245006@noisy.programming.kicks-ass.net>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
 <20250924034100.3701520-3-sunjunchao@bytedance.com>
 <20250924063219.GR4067720@noisy.programming.kicks-ass.net>
 <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37fd969e-3799-48d0-a8e0-1937e5a4ae38@bytedance.com>

On Wed, Sep 24, 2025 at 03:50:41PM +0800, Julian Sun wrote:
> On 9/24/25 2:32 PM, Peter Zijlstra wrote:
> > On Wed, Sep 24, 2025 at 11:41:00AM +0800, Julian Sun wrote:
> > > Hung task warning in mem_cgroup_css_free() is undesirable and
> > > unnecessary since the behavior of waiting for a long time is
> > > expected.
> > > 
> > > Use touch_hung_task_detector() to eliminate the possible
> > > hung task warning.
> > > 
> > > Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> > 
> > Still hate this. It is not tied to progress. If progress really stalls,
> > no warning will be given.
> 
> Hi, peter
> 
> Thanks for your review and comments.
> 
> I did take a look at your solution provided yesterday, and get your point.
> However AFAICS it can't resolve the unexpected warnings here. Because it
> only works after we reach the finish_writeback_work(), and the key point
> here is, it *already* takes a long time before we reach
> finish_writeback_work(), and there is true progress before finish the
> writeback work that hung task detector still can not know.

But wb_split_bdi_pages() should already split things into smaller chunks
if there is low bandwidth, right? And we call finish_writeback_work()
for each chunk.

If a chunk is still taking too long, surely the solution is to use
smaller chunks?

> If we want to make the hung task detector to known the progress of writeback
> work, we need to add some code within do_writepages(): after each finish of
> a_ops->writepages(), we need to make detector to known there's progress.
> Something like this:
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3e248d1c3969..49572a83c47b 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2635,6 +2635,10 @@ int do_writepages(struct address_space *mapping,
> struct writeback_control *wbc)
>                 else
>                         /* deal with chardevs and other special files */
>                         ret = 0;
> +               /* Make hung task detector to known there's progress. */
> +               if (force_wake)
> +                       wake_up_all(waitq);
> +
>                 if (ret != -ENOMEM || wbc->sync_mode != WB_SYNC_ALL)
>                         break;
> 
> which has a big impact on current code - I don't want to introduce this.

You sure? It looks to me like the next level down is wb_writeback() and
writeback_sb_inodes(), and those already have time based breaks in and
still have access to wb_writeback_work::done, while do_writepages() no
longer has that context.

> Yes, the behavior in this patch does have the possibility to paper cover the
> real warnings, and what I want to argue is that the essence of this patch is
> the same as the current touch_nmi_watchdog() and touch_softlockup_watchdog()
> - these functions are used only in specific scenarios we known and only
> affect a single event. And there seems no report that
> touch_nmi/softlockup_watchdog() will paper cover the real warnings (do we?).
> 
> Correct me if there's anything I'm missing or misunderstanding.

The thing with touch_nmi_watchdog() is that you need to keep doing it.
The moment you stop calling touch_nmi_watchdog(), you will cause it to
fire.

That is very much in line with the thing I proposed, and rather unlike
your proposal that blanket kill reporting for the task, irrespective of
how long it sits there waiting.


