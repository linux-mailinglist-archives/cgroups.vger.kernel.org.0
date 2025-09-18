Return-Path: <cgroups+bounces-10226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F897B82BF4
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 05:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788721B24E4F
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AC22756A;
	Thu, 18 Sep 2025 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xVgzKPzE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEA2582
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 03:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165968; cv=none; b=HduzoGIJy7kKuCJAOebcyEaGcFFzW4Pk8uCdKuq4lF3smAVVpiQw1EYnAcpYy+hUv6JMLQcbGjkTBPMkpLlp5c1hHPfZikDNIKNAfD6hyQffCp19FIb4/eUMFUdH4v/jdKVwaYMq7C3fgUyqMLE262rRt07WX46PMtg0GXD+1mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165968; c=relaxed/simple;
	bh=FirTgoA8QKBiq40eS+mg/EDHgGtgRWtep9eREaFgiiA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RaCT/YFCZdzCdZ4aR3hK6mq+Q88UAuIxoWROtdO/vZvixCr01dD4UbuR6exHuThCoS556rqGgTdshdYznv9gLosni4F/wJFHw7V8coPcCPzaM4rcgsnrrbityzuJgdopOxNd2UxBL1aGxHifBIy6TSZ+QDpgL2QehbAB9YpfczY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xVgzKPzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB00C4CEE7;
	Thu, 18 Sep 2025 03:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758165967;
	bh=FirTgoA8QKBiq40eS+mg/EDHgGtgRWtep9eREaFgiiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xVgzKPzEzthbiVN21aMkylYV6iPBCfv/X3+PoKtxmLcP6SqltCn1Mol99vLYS5tj4
	 DsY7p6p+UbDxmgCZTr5k+pw957/Vl92YAz+sgkSM0ENnv1XYmURCjfQg33F/0Su6wS
	 v3KynmH5fVpNewjzXG6gdlGFdT3UsCniUmZU7Rqg=
Date: Wed, 17 Sep 2025 20:26:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
 tj@kernel.org, muchun.song@linux.dev, venkat88@linux.ibm.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, Lance Yang <lance.yang@linux.dev>, Masami Hiramatsu
 <mhiramat@kernel.org>
Subject: Re: [External] Re: [PATCH v6] memcg: Don't wait writeback
 completion when release memcg.
Message-Id: <20250917202606.4fac2c6852abc5ba8894f8ee@linux-foundation.org>
In-Reply-To: <CAHSKhtdt9n-K6KGXTwofpRPo-pH0-YoKFLtEe3Z4CszmNL0rCg@mail.gmail.com>
References: <20250917212959.355656-1-sunjunchao@bytedance.com>
	<20250917152155.5a8ddb3e4ff813289ea0b4c9@linux-foundation.org>
	<CAHSKhtdt9n-K6KGXTwofpRPo-pH0-YoKFLtEe3Z4CszmNL0rCg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 18 Sep 2025 11:03:18 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:

> Hi,
> Thanks for your review and comments.
> 
> On Thu, Sep 18, 2025 at 6:22 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 18 Sep 2025 05:29:59 +0800 Julian Sun <sunjunchao@bytedance.com> wrote:
> >
> > > Recently, we encountered the following hung task:
> > >
> > > INFO: task kworker/4:1:1334558 blocked for more than 1720 seconds.
> > > [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_fn
> > >
> > > ...
> > >
> > > The direct cause is that memcg spends a long time waiting for dirty page
> > > writeback of foreign memcgs during release.
> > >
> > > The root causes are:
> > >     a. The wb may have multiple writeback tasks, containing millions
> > >        of dirty pages, as shown below:
> > >
> > > >>> for work in list_for_each_entry("struct wb_writeback_work", \
> > >                                   wb.work_list.address_of_(), "list"):
> > > ...     print(work.nr_pages, work.reason, hex(work))
> > > ...
> > > 900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
> > > 1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
> > >
> > > ...
> > >
> >
> > I don't think it's particularly harmful that a dedicated worker thread
> > has to wait for a long time in this fashion.  It doesn't have anything
> > else to do (does it?) and a blocked kernel thread is cheap.
> 
> It also delays the release of other resources and the update of
> vmstats and vmevents statistics for the parent cgroup.

This is new - such considerations weren't described in the changelog. 
How much of a problem are these things?

> But we can put
> the wb_wait_for_completion() after the release of these resources.

Can we move these actions into the writeback completion path which
seems to be the most accurate way to do them?

> >
> > > 3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
> > > 3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
> > >
> > >     b. The writeback might severely throttled by wbt, with a speed
> > >        possibly less than 100kb/s, leading to a very long writeback time.
> > >
> > > ...
> > >
> > >  include/linux/memcontrol.h | 14 +++++++++-
> > >  mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
> > >  2 files changed, 62 insertions(+), 9 deletions(-)
> >
> > Seems we're adding a bunch of tricky code to fix a non-problem which
> > the hung-task detector undesirably reports.
> 
> Emm.. What is the definition of 'undesirably' here?

Seems the intent here is mainly to prevent the warning.  If that
warning wasn't coming out, would we bother making these changes?  If
no, just kill the warning.

> >
> > Would a better fix be to simply suppress the warning?
> >
> > I don't think we presently have a touch_hung_task_detector() (do we?)
> > but it's presumably pretty simple.  And maybe
> > touch_softlockup_watchdog) should be taught to call that
> > touch_hung_task_dectector().
> >
> > Another approach might be to set some flag in the task_struct
> > instructing the hung task detector to ignore this thread.
> 
> To me, this feels kind of like a workaround rather than a real fix.

I don't see why.  It appears that the kworker's intended role is to
wait for writeback completion then to finish things up.  Which it does
just fine, except there's this pesky warning we get.  Therefore: kill
the pesky warning,

> And these approaches are beyond the scope of memcg,

So expand the scope?  If hung-task doesn't have a way to suppress
inappropriate warnings then add it and use it.

> I'm not sure how
> Tejun thinks about it since he mentioned before wanting to keep the
> modifications inside the memcg. Given the fact we already have an
> existing solution and code, and the scope of impact is confined to
> memcg, I prefer to use the existing solution.

mmm...  sunk cost fallacy!  Let's just opt for the best solution,
regardless of cost.


