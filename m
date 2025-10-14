Return-Path: <cgroups+bounces-10744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80581BDADED
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6796D4F2149
	for <lists+cgroups@lfdr.de>; Tue, 14 Oct 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323A3074BE;
	Tue, 14 Oct 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZMy1RhxA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D79307AC8;
	Tue, 14 Oct 2025 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760464684; cv=none; b=Z54w9nWWwrbo6LKoAw7z9afpAexhqUNVgq+X0rSHcYyxVfQeXCS5HR30tBGVEzZBXHElISDf2A5LA7g2eVU237qXkRFN8aWHematHHdIGen96Jim5YLtistTu4YOGseq+gud3CMZ6GFaNMITBn9mDXPbXxN+fjCSuhOl1JT8Wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760464684; c=relaxed/simple;
	bh=GeasJ1k8goW5lf5YOrSR9SoZPMr2dV8i4vuFwQTf6kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRp3pfmL00+FYDFUswi1983cgsCROMGcNRBm87sLZTzevo/7MIJ7SN7LgpkkNHQnc/qnL4Z/ocmDs6bJMPlNfTuZsi1kpGie4+I63cQhkxPKlTLnPSBhRfCtX/PfHvcRgMb5UBWiZwwyqwYO6gPcirTIjYzexLux+dJYqG+gvRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZMy1RhxA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFPXTt002742;
	Tue, 14 Oct 2025 17:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dNH21r
	EZx6JOTlipPd6T46YbAmkSlhH4ntfrh3pAkOU=; b=ZMy1RhxAXE86AquNrSv0Op
	djSZvwddSV/1Zw0jGuB0b+zO+DpX38WT3bOmDG0mi43V4SQBUGkUhKyQrJ8A/E+H
	X+LqUyClkFfphVEdL6tRhr3Mn5vvwQlilsIpra471b2X5623fKO3KZa+SIQxgnXP
	7WTSAAS/D3hrZ5Efx+yL0WfNhtQGG5oqtYgjhGZwrO7secN75fIO4Ri6wOCdZXgb
	KeRdM54xqiQ/3GY0XgaSaXTw1sfJR0mCzdh7jMIOf05O/bHYOG7wo6Gvr1Zol92F
	IqE8TWkTgQPaodBPgTX8J6BrNCHhc8HJbq2EAtXP1zIvaBppAkII6JHjBhZpNf8g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpftc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 17:57:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEbg2L003626;
	Tue, 14 Oct 2025 17:57:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxvdqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 17:57:36 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EHvZna24248978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 17:57:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AFD258062;
	Tue, 14 Oct 2025 17:57:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07C2158059;
	Tue, 14 Oct 2025 17:57:31 +0000 (GMT)
Received: from [9.61.43.11] (unknown [9.61.43.11])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 17:57:30 +0000 (GMT)
Message-ID: <7de6c29f-9058-41ca-af95-f3aaf67a64d3@linux.ibm.com>
Date: Tue, 14 Oct 2025 23:27:29 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] blk-rq-qos: fix possible deadlock
To: Yu Kuai <hailan@yukuai.org.cn>, Yu Kuai <yukuai3@huawei.com>,
        ming.lei@redhat.com, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <d4fe218b-9fc5-4466-ac56-0d4c5a8ccd96@linux.ibm.com>
 <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e5e7ac3f-2063-473a-aafb-4d8d43e5576e@yukuai.org.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfXxdfnsoQCoYM4
 aagdqXSWe9ndl3HWZNnn5ICNRDVFAJlU/NaFjc0dr87WOPEB7ibvadSxXdmm2U3ZJL12aqeEtS2
 dPReH7QlYoRUKe4zvfLx4oBQl0YmCTWu0TfbNH7c3tE4GWPZ7NJx9LVLung9CjJrtsfk8mzDjH4
 va8DqoxyKZn5UBF9AhyF5x0I/rf87sMgHihZBHn61JeYEjRKutYLfki/MvXnIledbQKIYTogGHE
 2RYNMuk0ibp1bjD2dMT2b2NAlsjBCVVkA5wr35XYt5IyuuZpQymxy3ckzXRQnejZ/FLasBhOo/n
 7l+bFwxykftBOn46iPHKSQ/4L6tol8szTv9zipqBHgjhO9SGi4aul6BjQr3D809wieg62JtXzc+
 fdSUezsQrFF7VgvfwpgELXtAPhu4Ow==
X-Proofpoint-ORIG-GUID: hJIHf5vsHoUWbdcm379-SdDUzo1-GAOj
X-Proofpoint-GUID: hJIHf5vsHoUWbdcm379-SdDUzo1-GAOj
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ee8f10 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=H31F4hS0uZKSM2tskcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005



On 10/14/25 4:44 PM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 18:58, Nilay Shroff 写道:
>>
>> On 10/14/25 7:51 AM, Yu Kuai wrote:
>>> Currently rq-qos debugfs entries is created from rq_qos_add(), while
>>> rq_qos_add() requires queue to be freezed. This can deadlock because
>>>
>>> creating new entries can trigger fs reclaim.
>>>
>>> Fix this problem by delaying creating rq-qos debugfs entries until
>>> it's initialization is complete.
>>>
>>> - For wbt, it can be initialized by default of by blk-sysfs, fix it by
>>>    delaying after wbt_init();
>>> - For other policies, they can only be initialized by blkg configuration,
>>>    fix it by delaying to blkg_conf_end();
>>>
>>> Noted this set is cooked on the top of my other thread:
>>> https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel.org/
>>>
>>> And the deadlock can be reporduced with above thead, by running blktests
>>> throtl/001 with wbt enabled by default. While the deadlock is really a
>>> long term problem.
>>>
>> While freezing the queue we also mark GFP_NOIO scope, so doesn't that
>> help avoid fs-reclaim? Or maybe if you can share the lockdep splat
>> encountered running throtl/001?
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
> [   45.632372][  T531] ======================================================
> [   45.633734][  T531] WARNING: possible circular locking dependency detected
> [   45.635062][  T531] 6.17.0-gfd4a560a0864-dirty #30 Not tainted
> [   45.636220][  T531] ------------------------------------------------------
> [   45.637587][  T531] check/531 is trying to acquire lock:
> [   45.638626][  T531] ffff9473884382b0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_
> conf_start+0x116/0x190
> [   45.640416][  T531]
> [   45.640416][  T531] but task is already holding lock:
> [   45.641828][  T531] ffff9473884385d8 (&q->elevator_lock){+.+.}-{4:4}, at: blkg
> _conf_start+0x108/0x190
> [   45.643322][  T531]
> [   45.643322][  T531] which lock already depends on the new lock.
> [   45.643322][  T531]
> [   45.644862][  T531]
> [   45.644862][  T531] the existing dependency chain (in reverse order) is:
> [   45.646046][  T531]
> [   45.646046][  T531] -> #5 (&q->elevator_lock){+.+.}-{4:4}:
> [   45.647052][  T531]        __mutex_lock+0xd3/0x8d0
> [   45.647716][  T531]        blkg_conf_start+0x108/0x190
> [   45.648395][  T531]        tg_set_limit+0x74/0x300
> [   45.649046][  T531]        kernfs_fop_write_iter+0x14a/0x210
> [   45.649813][  T531]        vfs_write+0x29e/0x550
> [   45.650413][  T531]        ksys_write+0x74/0xf0
> [   45.651032][  T531]        do_syscall_64+0xbb/0x380
> [   45.651730][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   45.652533][  T531]
> [   45.652533][  T531] -> #4 (&q->q_usage_counter(io)#3){++++}-{0:0}:
> [   45.653297][  T531]        blk_alloc_queue+0x30b/0x350
> [   45.653807][  T531]        blk_mq_alloc_queue+0x5d/0xd0
> [   45.654300][  T531]        __blk_mq_alloc_disk+0x13/0x60
> [   45.654810][  T531]        null_add_dev+0x2f8/0x660 [null_blk]
> [   45.655374][  T531] nullb_device_power_store+0x88/0x130 [null_blk]
> [   45.656009][  T531]        configfs_write_iter+0xcb/0x130 [configfs]
> [   45.656614][  T531]        vfs_write+0x29e/0x550
> [   45.657045][  T531]        ksys_write+0x74/0xf0
> [   45.657497][  T531]        do_syscall_64+0xbb/0x380
> [   45.657958][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   45.658595][  T531]
> [   45.658595][  T531] -> #3 (fs_reclaim){+.+.}-{0:0}:
> [   45.659266][  T531]        fs_reclaim_acquire+0xa4/0xe0
> [   45.659783][  T531] kmem_cache_alloc_lru_noprof+0x3b/0x2a0
> [   45.660369][  T531]        alloc_inode+0x1a/0x60
> [   45.660873][  T531]        new_inode+0xd/0x90
> [   45.661291][  T531]        debugfs_create_dir+0x38/0x160
> [   45.661806][  T531]        component_debug_init+0x12/0x20
> [   45.662316][  T531]        do_one_initcall+0x68/0x2b0
> [   45.662807][  T531]        kernel_init_freeable+0x238/0x290
> [   45.663241][  T531]        kernel_init+0x15/0x130
> [   45.663659][  T531]        ret_from_fork+0x182/0x1d0
> [   45.664054][  T531]        ret_from_fork_asm+0x1a/0x30
> [   45.664601][  T531]
> [   45.664601][  T531] -> #2 (&sb->s_type->i_mutex_key#2){+.+.15:25:59 [194/1936]
> [   45.665274][  T531]        down_write+0x3a/0xb0
> [   45.665669][  T531]        simple_start_creating+0x51/0x110
> [   45.666097][  T531]        debugfs_start_creating+0x68/0xd0
> [   45.666561][  T531]        debugfs_create_dir+0x10/0x160
> [   45.666970][  T531]        blk_register_queue+0x8b/0x1e0
> [   45.667386][  T531]        __add_disk+0x253/0x3f0
> [   45.667804][  T531]        add_disk_fwnode+0x71/0x180
> [   45.668205][  T531]        virtblk_probe+0x9c2/0xb50
> [   45.668603][  T531]        virtio_dev_probe+0x223/0x380
> [   45.669004][  T531]        really_probe+0xc2/0x260
> [   45.669369][  T531]        __driver_probe_device+0x6e/0x100
> [   45.669856][  T531]        driver_probe_device+0x1a/0xd0
> [   45.670263][  T531]        __driver_attach+0x93/0x1a0
> [   45.670672][  T531]        bus_for_each_dev+0x87/0xe0
> [   45.671063][  T531]        bus_add_driver+0xe0/0x1d0
> [   45.671469][  T531]        driver_register+0x70/0xe0
> [   45.671856][  T531]        virtio_blk_init+0x53/0x80
> [   45.672258][  T531]        do_one_initcall+0x68/0x2b0
> [   45.672661][  T531]        kernel_init_freeable+0x238/0x290
> [   45.673097][  T531]        kernel_init+0x15/0x130
> [   45.673510][  T531]        ret_from_fork+0x182/0x1d0
> [   45.673907][  T531]        ret_from_fork_asm+0x1a/0x30
> [   45.674319][  T531]
> [   45.674319][  T531] -> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
> [   45.674929][  T531]        __mutex_lock+0xd3/0x8d0
> [   45.675315][  T531]        rq_qos_add+0xe0/0x130
> [   45.675717][  T531]        wbt_init+0x183/0x210
> [   45.676062][  T531]        blk_register_queue+0xdf/0x1e0
> [   45.676490][  T531]        __add_disk+0x253/0x3f0
> [   45.676844][  T531]        add_disk_fwnode+0x71/0x180
> [   45.677247][  T531]        virtblk_probe+0x9c2/0xb50
> [   45.677648][  T531]        virtio_dev_probe+0x223/0x380
> [   45.678044][  T531]        really_probe+0xc2/0x260
> [   45.678411][  T531]        __driver_probe_device+0x6e/0x100
> [   45.678875][  T531]        driver_probe_device+0x1a/0xd0
> [   45.679282][  T531]        __driver_attach+0x93/0x1a0
> [   45.679678][  T531]        bus_for_each_dev+0x87/0xe0
> [   45.680053][  T531]        bus_add_driver+0xe0/0x1d0
> [   45.680458][  T531]        driver_register+0x70/0xe0
> [   45.680823][  T531]        virtio_blk_init+0x53/0x80
> [   45.681208][  T531]        do_one_initcall+0x68/0x2b0
> [   45.681611][  T531]        kernel_init_freeable+0x238/0x290
> [   45.682027][  T531]        kernel_init+0x15/0x130
> [   45.682392][  T531]        ret_from_fork+0x182/0x1d0
> [   45.682829][  T531]        ret_from_fork_asm+0x1a/0x30
> [   45.683240][  T531]
> [   45.683240][  T531] -> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
> [   45.683867][  T531]        __lock_acquire+0x103d/0x1650
> [   45.684411][  T531]        lock_acquire+0xbc/0x2c0
> [   45.684798][  T531]        __mutex_lock+0xd3/0x8d0
> [   45.685172][  T531]        blkg_conf_start+0x116/0x190
> [   45.685623][  T531]        tg_set_limit+0x74/0x300
> [   45.685986][  T531]        kernfs_fop_write_iter+0x14a/0x210
> [   45.686405][  T531]        vfs_write+0x29e/0x550
> [   45.686771][  T531]        ksys_write+0x74/0xf0
> [   45.687112][  T531]        do_syscall_64+0xbb/0x380
> [   45.687514][  T531] entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   45.687983][  T531]
> [   45.687983][  T531] other info that might help us debug this:
> [   45.687983][  T531]
> [   45.688760][  T531] Chain exists of:
> [   45.688760][  T531]   &q->rq_qos_mutex --> &q->q_usage_counter(io)#3 --> &q->e
> levator_lock
> [   45.688760][  T531]
> [   45.689817][  T531]  Possible unsafe locking scenario:
> [   45.689817][  T531]
> [   45.690359][  T531]        CPU0                    CPU1
> [   45.690764][  T531]        ----                    ----
> [   45.691172][  T531]   lock(&q->elevator_lock);
> [   45.691544][  T531] lock(&q->q_usage_counter(io
> )#3);
> [   45.692108][  T531] lock(&q->elevator_lock);
> [   45.692659][  T531]   lock(&q->rq_qos_mutex);
> [   45.692994][  T531]
> [   45.692994][  T531]  *** DEADLOCK ***
> 

From the above trace, I see that thread #1 (virtblk device) is
unable to acquire &q->debugfs_mutex and it's pending on thread #2
(another virtblk device) because thread #2 has already acquired
the same &q->debugfs_mutex. And this sequence of events appears
to be a false-positive. The reasoning is as follows:

Each virtio block device (e.g., virtblk0, virtblk1, etc.) has its own
struct request_queue, and therefore its own instance of q->debugfs_mutex.
These mutexes are distinct objects at different memory addresses. Hence,
thread #1 cannot physically block on thread #2’s q->debugfs_mutex, since
the mutex wait queue is per-lock address.

However, lockdep does not track individual mutex addresses. Instead, it
operates at the level of lock classes, identified by a lock class key. 
Because all q->debugfs_mutex instances share the same lock class key,
lockdep treats them as equivalent and reports a potential circular
dependency across devices, even though such dependency cannot actually
occur at runtime. So IMO, to eliminate this false-positive warning, we
should assign a separate lockdep class/key for each queue’s q->debugfs_mutex.
This will ensure lockdep distinguishes mutex instances belonging to
different queues.

Thanks,
--Nilay


