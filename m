Return-Path: <cgroups+bounces-10756-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28955BDC038
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28843E3505
	for <lists+cgroups@lfdr.de>; Wed, 15 Oct 2025 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5300D2FABF9;
	Wed, 15 Oct 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UELuM5tl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4FE2868B2
	for <cgroups@vger.kernel.org>; Wed, 15 Oct 2025 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492585; cv=none; b=NmStJwVbw9SKp24Lsk7oFMPrETEv4HgWUSVfGsCkkorVoIBKdreVLd5BVvfecapyG7c52aqdcj0+9z/tD1TW4AAYZ060pRiu1fD9vsq6fMwVf7FJQ19wrTDiPgAOPGPxonLSQ5Q/6ztiyGzh1aGVKNYRW/sF3M4PdkDkfPUkgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492585; c=relaxed/simple;
	bh=tBXK6fGWeHXi5aXqSeF7tZ0jsUnK/jtkq1Vngbc+nVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJHyCEYihftsM7mLMEWM+X1xFfor5Nn3KQ3iwuRGuOMO+4zYBsM7ATlOl8bIdqSW50QSyUTz7EqHf/WuqayTMWZyK2u+ZYg/Jw4ok7WOXEgxhNzm00YxMTNeZcYx6qchhFM/FkxAPoou8Kb0uZKGGcIN8KbWKfhVp9FkTx+vluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UELuM5tl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760492581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eEQrY4re1h6qdVirHmmH/RKJ0TU8/Alpc97VBSqBIg=;
	b=UELuM5tl4jY2t0pD+3idZpRItojVliyFjV1zuCSCEXPiAWhZDH4bIGsoe4thHEYc2r4+Ld
	b/0iKP6ikxDaHEqE/lhpKDOz/zYsLfygRAI34dfFWfJzTmZWwCVjlyGOvO8fDjGNDhH7Ae
	PbftfmCqm2CESEtxRZ86FXN2GAbu5FY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-CXnLwrmwPZWt5uI_XH2HlA-1; Tue,
 14 Oct 2025 21:42:57 -0400
X-MC-Unique: CXnLwrmwPZWt5uI_XH2HlA-1
X-Mimecast-MFC-AGG-ID: CXnLwrmwPZWt5uI_XH2HlA_1760492576
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2222E1800451;
	Wed, 15 Oct 2025 01:42:55 +0000 (UTC)
Received: from fedora (unknown [10.72.120.29])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8688A19560B4;
	Wed, 15 Oct 2025 01:42:45 +0000 (UTC)
Date: Wed, 15 Oct 2025 09:42:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <hailan@yukuai.org.cn>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai3@huawei.com>,
	tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
Message-ID: <aO78EFfuT_o5Gcng@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
 <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 14, 2025 at 07:14:16PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 18:58, Nilay Shroff 写道:
> > 
> > On 10/14/25 7:51 AM, Yu Kuai wrote:
> > > Currently rq-qos debugfs entries is created from rq_qos_add(), while
> > > rq_qos_add() requires queue to be freezed. This can deadlock because
> > > 
> > > creating new entries can trigger fs reclaim.
> > > 
> > > Fix this problem by delaying creating rq-qos debugfs entries until
> > > it's initialization is complete.
> > > 
> > > - For wbt, it can be initialized by default of by blk-sysfs, fix it by
> > >    delaying after wbt_init();
> > > - For other policies, they can only be initialized by blkg configuration,
> > >    fix it by delaying to blkg_conf_end();
> > > 
> > > Noted this set is cooked on the top of my other thread:
> > > https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
> > > 
> > > And the deadlock can be reporduced with above thead, by running blktests
> > > throtl/001 with wbt enabled by default. While the deadlock is really a
> > > long term problem.
> > > 
> > While freezing the queue we also mark GFP_NOIO scope, so doesn't that
> > help avoid fs-reclaim? Or maybe if you can share the lockdep splat
> > encountered running throtl/001?
> 
> Yes, we can avoid fs-reclaim if queue is freezing, however,
> because debugfs is a generic file system, and we can't avoid fs reclaim from
> all context. There is still
> 
> Following is the log with above set and wbt enabled by default, the set acquire
> lock order by:
> 
> freeze queue -> elevator lock -> rq_qos_mutex -> blkcg_mutex
> 
> However, fs-reclaim from other context cause the deadlock report.
> 
> 
> [   45.632372][  T531] ======================================================
> [   45.633734][  T531] WARNING: possible circular locking dependency detected
> [   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
> [   45.636220][  T531] ------------------------------------------------------
> [   45.637587][  T531] check/531 is trying to acquire lock:
> [   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
> conf_start+0x116/0x190
> [   45.640416][  T531]
> [   45.640416][  T531] but task is already holding lock:
> [   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
> _conf_start+0x108/0x190
> [   45.643322][  T531]
> [   45.643322][  T531] which lock already depends on the new lock.
> [   45.643322][  T531]
> [   45.644862][  T531]
> [   45.644862][  T531] the existing dependency chain (in reverse order) is:
> [   45.646046][  T531]
> [   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
> [   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
> [   45.647716][  T531]        blkg_conf_start+0x108/0x190
> [   45.648395][  T531]        tg_set_limit+0x74/0x300
> [   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
> [   45.649813][  T531]        vfs_write+0x29e/0x550
> [   45.650413][  T531]        ksys_write+0x74/0xf0
> [   45.651032][  T531]        do_syscall_64+0xbb/0x380
> [   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f

Not sure why elevator lock is grabbed in throttle code, which looks a elevator lock
misuse, what does the elevator try to protect here?

The comment log doesn't explain the usage too:

```
  /*
   * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
   * acquires q->elevator_lock, and ensures the correct locking order
   * between q->elevator_lock and q->rq_qos_mutex.
   *
   * This function returns negative error on failure. On success it returns
   * memflags which must be saved and later passed to blkg_conf_exit_frozen
   * for restoring the memalloc scope.
   */
```

I think it is still order issue between queue freeze and q->rq_qos_mutex
first, which need to be solved first.


Thanks, 
Ming


