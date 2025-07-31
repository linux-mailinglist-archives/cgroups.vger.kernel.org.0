Return-Path: <cgroups+bounces-8956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A06EB16D52
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 10:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C241174524
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16321A435;
	Thu, 31 Jul 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E932SuCC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9551EE7A1
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949910; cv=none; b=uKt6iWWoBf4yokqMXre2Jr2GK2LIHcoyDzqnmHdZHV+MDRCFEFQoubK+i9HBY3XQu9khKiNsBfMBcp2QpGvn9IHze2hdyvB+q6Lr1E47GKtdoik46N57gHZQ0H2rE0WCCmKc7vkiJfnOkUlOuOVMtzzqWw+qdMB7dmDNaYjRDno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949910; c=relaxed/simple;
	bh=TpJnwz5jWr5OonsdFvsUU4fF/z2r+LxLaUCEUMSlxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAj3QfOTk5PpuH6YAml0KUhEyIJe68kLNFEUgiXUUjILQCo0lGMHUjMD1hlikUhDu9mVmwtJL5mqLXziVQ5QWsZyEtI/8tMBiO+TiBXjs+G8A51LNPvAeAkwPVfza0PomNsChtRGbg+M/UGNI8LGdwJAnyCEqryWMf0EkxxDNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E932SuCC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753949907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6katTsCF1LMthpbb9w2c3s1PekN7Dr6xyf8vleDZvrI=;
	b=E932SuCCK+IU4ecIKm5IHnnZ+XfU34yfS0ksXQppog26+fHtV1AG52oqiBwO9KPydI2QkX
	xsAWBMDIv27B0t5d8oVaD8JdOIa6nB5RrNCN81tiULa7uIn56IypOsp+qJTwV/gAI8Q1+v
	zFSdBg4kA1iEUs88AJJ+6UozZ1XxwWQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-LnhF8j-xNvSP2Ytu6eNHZA-1; Thu,
 31 Jul 2025 04:18:23 -0400
X-MC-Unique: LnhF8j-xNvSP2Ytu6eNHZA-1
X-Mimecast-MFC-AGG-ID: LnhF8j-xNvSP2Ytu6eNHZA_1753949901
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41B4B195609E;
	Thu, 31 Jul 2025 08:18:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B215418003FC;
	Thu, 31 Jul 2025 08:18:11 +0000 (UTC)
Date: Thu, 31 Jul 2025 16:18:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: dlemoal@kernel.org, hare@suse.de, jack@suse.cz, tj@kernel.org,
	josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH v2 0/5] blk-mq-sched: support request batch dispatching
 for sq elevator
Message-ID: <aIsmvj_lxLA6ZaWe@fedora>
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jul 30, 2025 at 04:22:02PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Changes from v1:
>  - the ioc changes are send separately;
>  - change the patch 1-3 order as suggested by Damien;
> 
> Currently, both mq-deadline and bfq have global spin lock that will be
> grabbed inside elevator methods like dispatch_request, insert_requests,
> and bio_merge. And the global lock is the main reason mq-deadline and
> bfq can't scale very well.
> 
> For dispatch_request method, current behavior is dispatching one request at
> a time. In the case of multiple dispatching contexts, This behavior, on the
> one hand, introduce intense lock contention:
> 
> t1:                     t2:                     t3:
> lock                    lock                    lock
> // grab lock
> ops.dispatch_request
> unlock
>                         // grab lock
>                         ops.dispatch_request
>                         unlock
>                                                 // grab lock
>                                                 ops.dispatch_request
>                                                 unlock
> 
> on the other hand, messing up the requests dispatching order:
> t1:
> 
> lock
> rq1 = ops.dispatch_request
> unlock
>                         t2:
>                         lock
>                         rq2 = ops.dispatch_request
>                         unlock
> 
> lock
> rq3 = ops.dispatch_request
> unlock
> 
>                         lock
>                         rq4 = ops.dispatch_request
>                         unlock
> 
> //rq1,rq3 issue to disk
>                         // rq2, rq4 issue to disk
> 
> In this case, the elevator dispatch order is rq 1-2-3-4, however,
> such order in disk is rq 1-3-2-4, the order for rq2 and rq3 is inversed.
> 
> While dispatching request, blk_mq_get_disatpch_budget() and
> blk_mq_get_driver_tag() must be called, and they are not ready to be
> called inside elevator methods, hence introduce a new method like
> dispatch_requests is not possible.
> 
> In conclusion, this set factor the global lock out of dispatch_request
> method, and support request batch dispatch by calling the methods
> multiple time while holding the lock.
> 
> nullblk setup:
> modprobe null_blk nr_devices=0 &&
>     udevadm settle &&
>     cd /sys/kernel/config/nullb &&
>     mkdir nullb0 &&
>     cd nullb0 &&
>     echo 0 > completion_nsec &&
>     echo 512 > blocksize &&
>     echo 0 > home_node &&
>     echo 0 > irqmode &&
>     echo 128 > submit_queues &&
>     echo 1024 > hw_queue_depth &&
>     echo 1024 > size &&
>     echo 0 > memory_backed &&
>     echo 2 > queue_mode &&
>     echo 1 > power ||
>     exit $?
> 
> Test script:
> fio -filename=/dev/$disk -name=test -rw=randwrite -bs=4k -iodepth=32 \
>   -numjobs=16 --iodepth_batch_submit=8 --iodepth_batch_complete=8 \
>   -direct=1 -ioengine=io_uring -group_reporting -time_based -runtime=30
> 
> Test result: iops
> 
> |                 | deadline | bfq      |
> | --------------- | -------- | -------- |
> | before this set | 263k     | 124k     |
> | after this set  | 475k     | 292k     |

batch dispatch may hurt io merge performance which is important for
elevator, so please provide test data on real HDD. & SSD., instead of
null_blk only, and it can be perfect if merge sensitive workload
is evaluated.



Thanks,
Ming


