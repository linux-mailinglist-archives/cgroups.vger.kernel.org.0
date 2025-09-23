Return-Path: <cgroups+bounces-10403-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280BB97306
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159CE188C1E4
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB02FFDF3;
	Tue, 23 Sep 2025 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CgGHHz5M"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE302DC776;
	Tue, 23 Sep 2025 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651936; cv=none; b=F3qDoz7FoE6VKwo5clt++Mz/ZtCA5EjWd1m09PzL1OawN2Hk6ZlUB4SOYJ37u2lKyciQI8aayIYR6Q0P1pl/6G43ikvaP+41QAbBxNFRrv32ZtAoU/a8o9Nnk0xX6iNYdbHeHVQyn1HSfqtCt0+NZINeJ/9UNE2vNNxa7n56uPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651936; c=relaxed/simple;
	bh=TpAW6kkXpu5Y6IQiVeAsSltQP0y5RASLYh+47Kv0+UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A64yccVU+pIk2+CFsu8ItmqbNbP4vEBvaleUqe9jELbOQhFc1HVqTmvdKOYqSN2+OP3lEbJ0qLVxjBcwN97ogoHwqzOHUnztDSnezFU1Wzu6FR7N+kaPjJQjKMMZRhXI8vbv/5oNDlub4/KepZnpcuBhsb0F2vgwxWHqzI91Ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CgGHHz5M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NEoe0o018428;
	Tue, 23 Sep 2025 18:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s32gH4
	+w9tvSgn0R5MtNvQgiNiAST2ZCnXq3H8wnIe0=; b=CgGHHz5MA0o5ijjkvHpBaj
	1CCCU60puWPY0mMb0sSoAinXB9jkBW9Z1eebdK4gk2xxQtJryLKWcutnRvuwe+wR
	wAJMNJdKz6w+AM9MYTHjLwPF//eiyCSSMEBoKbunnDVeJfv1kxWdF2OJ9+s/wGwk
	eYDIKqc6RvM9dLG9lO6sPHPgQ/KXP7K2xxuz5EYVAdtyyHSPm2auUnHBlk1wP20E
	2VBYqPWpSV23ZRwejPZQY/nikVYLEIuebzdn8VRb23ZFqwVfOoRxIpaMzaCB/vrc
	aEdUwuQqkwRIFVwsPJNFDsfQaiHCIv5Lmka7iNIcK8LvpXp6G6VxwfnnLOynBE2A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyjde6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:25:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NHWFKe030345;
	Tue, 23 Sep 2025 18:25:04 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a14kwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 18:25:04 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NIOrqZ30409176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 18:24:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFDEA5805D;
	Tue, 23 Sep 2025 18:25:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9929658052;
	Tue, 23 Sep 2025 18:24:59 +0000 (GMT)
Received: from [9.43.49.218] (unknown [9.43.49.218])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 18:24:59 +0000 (GMT)
Message-ID: <581e87e4-d237-40d3-9152-4c45fd371280@linux.ibm.com>
Date: Tue, 23 Sep 2025 23:54:54 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 2/2] blk-cgroup: fix possible deadlock
 while configuring policy
To: Yu Kuai <yukuai1@huaweicloud.com>, tj@kernel.org, josef@toxicpanda.com,
        axboe@kernel.dk
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
        yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com>
 <20250923075520.3746244-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250923075520.3746244-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d2e601 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=z4OmbuzoYE4chs2ZX-UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0z8m3oYX4oRncUw_seDKofjKPWcr39Ao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX29L1vuL/c94j
 CDIf4UxESf/ydUaLiZdB8ggUI61IgN0Cm8d05pyYg27Tlg2fhQc/P4UHgxizIluVKDXZvKR98kL
 RnsdYpl2Z0n5s8XVT9jBQ/YmCD5Az9fpCBZrGX2Pd9kp1uO1hdyzDfKHJ5bALp1e9sdUD8mGXBw
 bvSKn/3jp8sb25CG+/nxUbRQDTqyJHm1dR/VduzB7ohnhV0f4tfHZqZQIw5GMGyF7J7vk6YVhBY
 J9hufSqvjoft6z8bL7oRjtAFrfMWXisgkZX39cEVbJjeYmZvOeOTJXwq5Qta7br1iXP/co+BMGh
 uA62kwgHXgv62HTSxBE2tCKtrDxSWwcjYVACITInjq2V2astghWtJfHL/3kFkkn2o6Oo9YIuCMx
 0PfK/yzq
X-Proofpoint-ORIG-GUID: 0z8m3oYX4oRncUw_seDKofjKPWcr39Ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015



On 9/23/25 1:25 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Following deadlock can be triggered easily by lockdep:
> 
> WARNING: possible circular locking dependency detected
> 6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
> ------------------------------------------------------
> check/1334 is trying to acquire lock:
> ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x53/0x180
> 
> but task is already holding lock:
> ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gendisk+0xba/0x110
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
>        blk_queue_enter+0x40b/0x470
>        blkg_conf_prep+0x7b/0x3c0
>        tg_set_limit+0x10a/0x3e0
>        cgroup_file_write+0xc6/0x420
>        kernfs_fop_write_iter+0x189/0x280
>        vfs_write+0x256/0x490
>        ksys_write+0x83/0x190
>        __x64_sys_write+0x21/0x30
>        x64_sys_call+0x4608/0x4630
>        do_syscall_64+0xdb/0x6b0
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> -> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
>        __mutex_lock+0xd8/0xf50
>        mutex_lock_nested+0x2b/0x40
>        wbt_init+0x17e/0x280
>        wbt_enable_default+0xe9/0x140
>        blk_register_queue+0x1da/0x2e0
>        __add_disk+0x38c/0x5d0
>        add_disk_fwnode+0x89/0x250
>        device_add_disk+0x18/0x30
>        virtblk_probe+0x13a3/0x1800
>        virtio_dev_probe+0x389/0x610
>        really_probe+0x136/0x620
>        __driver_probe_device+0xb3/0x230
>        driver_probe_device+0x2f/0xe0
>        __driver_attach+0x158/0x250
>        bus_for_each_dev+0xa9/0x130
>        driver_attach+0x26/0x40
>        bus_add_driver+0x178/0x3d0
>        driver_register+0x7d/0x1c0
>        __register_virtio_driver+0x2c/0x60
>        virtio_blk_init+0x6f/0xe0
>        do_one_initcall+0x94/0x540
>        kernel_init_freeable+0x56a/0x7b0
>        kernel_init+0x2b/0x270
>        ret_from_fork+0x268/0x4c0
>        ret_from_fork_asm+0x1a/0x30
> 
> -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
>        __lock_acquire+0x1835/0x2940
>        lock_acquire+0xf9/0x450
>        __mutex_lock+0xd8/0xf50
>        mutex_lock_nested+0x2b/0x40
>        blk_unregister_queue+0x53/0x180
>        __del_gendisk+0x226/0x690
>        del_gendisk+0xba/0x110
>        sd_remove+0x49/0xb0 [sd_mod]
>        device_remove+0x87/0xb0
>        device_release_driver_internal+0x11e/0x230
>        device_release_driver+0x1a/0x30
>        bus_remove_device+0x14d/0x220
>        device_del+0x1e1/0x5a0
>        __scsi_remove_device+0x1ff/0x2f0
>        scsi_remove_device+0x37/0x60
>        sdev_store_delete+0x77/0x100
>        dev_attr_store+0x1f/0x40
>        sysfs_kf_write+0x65/0x90
>        kernfs_fop_write_iter+0x189/0x280
>        vfs_write+0x256/0x490
>        ksys_write+0x83/0x190
>        __x64_sys_write+0x21/0x30
>        x64_sys_call+0x4608/0x4630
>        do_syscall_64+0xdb/0x6b0
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&q->q_usage_counter(queue)#3);
>                                lock(&q->rq_qos_mutex);
>                                lock(&q->q_usage_counter(queue)#3);
>   lock(&q->sysfs_lock);
> 
> Root cause is that queue_usage_counter is grabbed with rq_qos_mutex
> held in blkg_conf_prep(), while queue should be freezed before
> rq_qos_mutex from other context.
> 
> The blk_queue_enter() from blkg_conf_prep() is used to protect against
> policy deactivation, which is already protected with blkcg_mutex, hence
> convert blk_queue_enter() to blkcg_mutex to fix this problem. Meanwhile,
> consider that blkcg_mutex is held after queue is freezed from policy
> deactivation, also convert blkg_alloc() to use GFP_NOIO.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>


