Return-Path: <cgroups+bounces-10767-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B3BDDC86
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CB44501FE4
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 09:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CC31A802;
	Wed, 15 Oct 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsvUljDs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20331A04F
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520480; cv=none; b=hLJmFEmVQ8TDqg+SVdy9xHNbjds38/LEa1cnFGb8C68Ie+aYyniBN0DbSTHqcqzDrMktUfTwImjx37994q06RMvtA3C1h/YvK810itXwo7PFFKJCCU3+O5XK/RyfCrWTAxcdW6xaudVGrnBJ93sc5yEJOSbddz3ywNesIftpnJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520480; c=relaxed/simple;
	bh=sPEg7pbtP1zrTtIJbq5Abj7JdtBqRqEL/3AmT/ihs9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URjwqRVefA5/oqYWy1kFkLk+Eq/7YMCSEqld9PvmaUyHwcSwuEnun9pOU3I2R/a0sBYAZ0JlOUHsItx3vGglvQM75KAb4XvMcezS1ranxWIVWUaXvho0X3gQG/WxQZqrp/RyHlxNFEKt8Vi/WIQa1B5tiQffIogblGTsJ852Yp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsvUljDs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760520477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FvuC0nI11pMcake8zb9ZQ7cv8pD2b0TiH26/DUH8Ho=;
	b=QsvUljDseVEkZm+Cs1Wc42GLisee5i/MNyjA+2DO+yw4lDq/C7oWOUp/0piCbJh4UenuAw
	8ftilas3/eA4SgQ3pidd/nTaWwUcHXa9378zLMXrDzMG2JZVnYwyjbV1nLLAs/XQQyrfCi
	VdKlZSGAj5iygm309nOz9cOdf3NT4SA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-jFU6B8r8NgieqhpcBtUZ-Q-1; Wed,
 15 Oct 2025 05:27:53 -0400
X-MC-Unique: jFU6B8r8NgieqhpcBtUZ-Q-1
X-Mimecast-MFC-AGG-ID: jFU6B8r8NgieqhpcBtUZ-Q_1760520471
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154F41800245;
	Wed, 15 Oct 2025 09:27:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47DA618003FC;
	Wed, 15 Oct 2025 09:27:40 +0000 (UTC)
Date: Wed, 15 Oct 2025 17:27:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai3@huawei.com>,
	tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
Message-ID: <aO9pB8DEDFYcvbz7@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
 <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
 <aO78EFfuT_o5Gcng@fedora>
 <4b8aab6f-f341-49af-9ccb-d592e1a40fe5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b8aab6f-f341-49af-9ccb-d592e1a40fe5@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Oct 15, 2025 at 10:46:51AM +0530, Nilay Shroff wrote:
> 
> 
> On 10/15/25 7:12 AM, Ming Lei wrote:
> > On Tue, Oct 14, 2025 at 07:14:16PM +0800, Yu Kuai wrote:
> >> Hi,
> >>
> >> 在 2025/10/14 18:58, Nilay Shroff 写道:
> >>>
> >>> On 10/14/25 7:51 AM, Yu Kuai wrote:
> >>>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
> >>>> rq_qos_add() requires queue to be freezed. This can deadlock because
> >>>>
> >>>> creating new entries can trigger fs reclaim.
> >>>>
> >>>> Fix this problem by delaying creating rq-qos debugfs entries until
> >>>> it's initialization is complete.
> >>>>
> >>>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
> >>>>    delaying after wbt_init();
> >>>> - For other policies, they can only be initialized by blkg configuration,
> >>>>    fix it by delaying to blkg_conf_end();
> >>>>
> >>>> Noted this set is cooked on the top of my other thread:
> >>>> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
> >>>>
> >>>> And the deadlock can be reporduced with above thead, by running blktests
> >>>> throtl/001 with wbt enabled by default. While the deadlock is really a
> >>>> long term problem.
> >>>>
> >>> While freezing the queue we also mark GFP_NOIO scope, so doesn't that
> >>> help avoid fs-reclaim? Or maybe if you can share the lockdep splat
> >>> encountered running throtl/001?
> >>
> >> Yes, we can avoid fs-reclaim if queue is freezing, however,
> >> because debugfs is a generic file system, and we can't avoid fs reclaim from
> >> all context. There is still
> >>
> >> Following is the log with above set and wbt enabled by default, the set acquire
> >> lock order by:
> >>
> >> freeze queue -> elevator lock -> rq_qos_mutex -> blkcg_mutex
> >>
> >> However, fs-reclaim from other context cause the deadlock report.
> >>
> >>
> >> [   45.632372][  T531] ======================================================
> >> [   45.633734][  T531] WARNING: possible circular locking dependency detected
> >> [   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
> >> [   45.636220][  T531] ------------------------------------------------------
> >> [   45.637587][  T531] check/531 is trying to acquire lock:
> >> [   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
> >> conf_start+0x116/0x190
> >> [   45.640416][  T531]
> >> [   45.640416][  T531] but task is already holding lock:
> >> [   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
> >> _conf_start+0x108/0x190
> >> [   45.643322][  T531]
> >> [   45.643322][  T531] which lock already depends on the new lock.
> >> [   45.643322][  T531]
> >> [   45.644862][  T531]
> >> [   45.644862][  T531] the existing dependency chain (in reverse order) is:
> >> [   45.646046][  T531]
> >> [   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
> >> [   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
> >> [   45.647716][  T531]        blkg_conf_start+0x108/0x190
> >> [   45.648395][  T531]        tg_set_limit+0x74/0x300
> >> [   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
> >> [   45.649813][  T531]        vfs_write+0x29e/0x550
> >> [   45.650413][  T531]        ksys_write+0x74/0xf0
> >> [   45.651032][  T531]        do_syscall_64+0xbb/0x380
> >> [   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Not sure why elevator lock is grabbed in throttle code, which looks a elevator lock
> > misuse, what does the elevator try to protect here?
> > 
> > The comment log doesn't explain the usage too:
> > 
> Lets go back to the history:
> The ->elevator_lock was first added in the wbt code path under this commit 
> 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock"). It was
> introduced to protect the wbt latency and state updates which could be 
> simultaneously accessed from elevator switch path and from sysfs write method
> (queue_wb_lat_store()) as well as from cgroup (ioc_qos_write()).
> 
> Later above change caused a lockdep splat and then we updated the code 
> to fix locking order between ->freeze_lock, ->elevator_lock and ->rq_qos_mutex
> and that was implemented in this commit 9730763f4756 ("block: correct locking
> order for protecting blk-wbt parameters"). With this change we set the 
> locking order as follows: 
> ->freeze_lock ->elevator_lock ->rq_qos_mutex
> 
> Then later on under this commit 78c271344b6f ("block: move wbt_enable_default()
> out of queue freezing from sched ->exit()") we moved the wbt latency/stat
> update code out of the ->freeze_lock and ->elevator_lock from elevator switch
> path. So essentially with this commit now in theory we don't need to acquire
> ->elevator_lock while updating wbt latency/stat values. In fact, we also removed
> ->elevator_lock  from queue_wb_lat_store() in this commit but I think we missed
> to remove ->elevator_lock from cgroup (ioc_qos_write()). 

Nice looking back!

I will cook one patch to remove it from ioc_qos_write().

> 
> > 
> > I think it is still order issue between queue freeze and q->rq_qos_mutex
> > first, which need to be solved first.
> > 
> So yes we should first target to get rid off the use of ->elevator_lock
> from ioc_qos_write(). Later we can decide on locking order between
> ->freeze_lock, ->rq_qos_mutex and ->debugfs_mutex. 

Yu Kuai is working on ordering queue freeze and ->rq_qos_mutex.


Thanks,
Ming


