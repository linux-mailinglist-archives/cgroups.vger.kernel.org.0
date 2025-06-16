Return-Path: <cgroups+bounces-8533-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703FEADA706
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 06:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE94D188EA87
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 04:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C578188734;
	Mon, 16 Jun 2025 04:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSeIzJgu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1346B5;
	Mon, 16 Jun 2025 04:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750046642; cv=none; b=P3I4NvrUjzmbophP5ehhHA2hXaJhIjWc3sA3Xx4rcHXg6N7iesa6zjgeBiER8wfOl3dJ93Ps6/s1lMtQ1oAR0qfRhBnkgYhLh2UFAoaQZWZCd4jkqCTnksLvsGFpy/Cph6RDgHFqJNIIWMhOMbPJSzKMZH/X2sIYhaonQ5zQ7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750046642; c=relaxed/simple;
	bh=yDzp1HXMtne8DF19p6akhYxebQV8My0v2pNpbGDe7DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uu6IPVvYnIRIaFhdNWolHd1QY1OpGG1TIXZCvGx+IrdLKSrxHc5QClfgij8sjQKzbWC8jhyPPaYahG6n28sGPbQFkuDVly13FhgCotn5Zs7fksPBtk8HAQRkT7fgYrgQ3yrlRNE40xsay0cFpim6+5z7Fy+wajDyspkfEJFuXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSeIzJgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21278C4CEEA;
	Mon, 16 Jun 2025 04:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750046641;
	bh=yDzp1HXMtne8DF19p6akhYxebQV8My0v2pNpbGDe7DQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bSeIzJgu6jzY4Cv6vyOqZ3mwBMw5YbDtb2K73cSvFLj1NS45YrgepgVZ9xYxSkhxb
	 PBhhca9dYT3DucO+oiMAz/1YLLM1IYrZ+nWF9iiBiXBNY/k9hedenuUuoE8PYa3fSc
	 LbboorWoyS+MgkCebsDY28x/QVCYWtI3baDZrumT3A7zwwl9/SQhXbjSuEGafP7wYa
	 fvb9YIWtsfFxzihajNe2Qmv7HlKlwcmlSBcZS7IcP7MlmLYtxHDK+viY7sQiiY23+I
	 jwXRnll7VpL5uHrEr08YqM7TnyBeS+Pkn8kV9kgCN2RDqvamqamVicYcuGRQMwvAu2
	 ytrtm4g/CIGPQ==
Message-ID: <9d3aee10-9eb3-4f2d-bb9a-1721c05ec3aa@kernel.org>
Date: Mon, 16 Jun 2025 13:03:59 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/5] blk-mq-sched: support request batch
 dispatching for sq elevator
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com,
 yukuai3@huawei.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250614092528.2352680-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/14/25 18:25, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Before this patch, each dispatch context will hold a global lock to
> dispatch one request at a time, which introduce intense lock competition:
> 
> lock
> ops.dispatch_request
> unlock
> 
> Hence support dispatch a batch of requests while holding the lock to
> reduce lock contention.
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
> Test result(elevator is deadline): iops
> |                 | null_blk | scsi hdd |
> | --------------- | -------- | -------- |
> | before this set | 263k     | 24       |
> | after this set  | 475k     | 272      |

For the HDD, these numbers are very low, and I do not understand how you can get
any improvement from reducing lock contention, since contention should not be an
issue with this kind of performance. What HW did you use for testing ? Was this
a VM ?

I tested this null_blk setup and your fio command on a bare-metal 16-cores Xeon
machine. For the scsi disk, I used a 26TB SATA HDD connected to an AHCI port).
With this setup, results are like this:

|                 | null_blk | hdd (write) | hdd (read) |
| --------------- | -------- | ----------- | ---------- |
| before this set | 613k     | 1088        | 211        |
| after this set  | 940k     | 1093        | 212        |

So not surprisingly, there is no improvement for the SATA HDD because of the low
max IOPS these devices can achieve: lock contention is not really an issue when
you are dealing with a slow device. And a SAS HDD will be the same. Gains may
likely be more significant with a fast SAS/FC RAID array but I do not have
access to that.

But the improvement for a fast device like null_blk is indeed excellent (+53%).

With LOCKDEP & KASAN disabled, the results are like this:

|                 | null_blk | hdd (write) | hdd (read) |
| --------------- | -------- | ----------- | ---------- |
| before this set | 625k     | 1092        | 213        |
| after this set  | 984k     | 1095        | 215        |

No real changes for the HDD, as expected, and the improvement for null_blk is
still good.

So maybe drop the RFC tag on these patches and repost after cleaning things up ?


-- 
Damien Le Moal
Western Digital Research

