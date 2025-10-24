Return-Path: <cgroups+bounces-11068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E6C045B1
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 06:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1227719A8198
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 04:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDF145A1F;
	Fri, 24 Oct 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m1NpszDE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394BD219E8;
	Fri, 24 Oct 2025 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761281714; cv=none; b=bBnGVLj2FpQFGhhKbWZMtsDq8iHUxpOjxWNLmmytGTw46ZpAi0W9d9lQLTBEh0OI1I+PMgDz7twzHAl1LdDtUqM1gG00SB8Lc5knfmYj1ONvF1dh0CGXXUv/8VzCTcPwThr+bDdMkRqSZZ3lz2AP98eNHPMTbVx54ju+CLOkOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761281714; c=relaxed/simple;
	bh=WMF6ZIsJSyf5vJSfn2XOaIDmGN6b1FeuEaWtCaRDLZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Flox83F0GkQnwD16fTsjtsyQ8BZzfD5JS56lt2Jxm8rZFCOOyvOqlOTkB7llP9SeSzDp3pO+B+PnBJCCCDE+jvAS0Me2NVbHsz2iIDST8O5Aa+EJ18aHqJAGWJAf3Ak9hp9H3vkqM8tw3/x2g6JIVTpGnfRQ7/XXArGmXYvk3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m1NpszDE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NL7doF030921;
	Fri, 24 Oct 2025 04:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w2YFGQ
	yHwYe3oADbRW2mOBrBSRkS/itX+Ac7I8oGgEs=; b=m1NpszDEp+ISWP0P4DVvnU
	F/Zot1pgl1BSb/IjUFCdzGXbiL0pBD6jTUUiHbWujcAjHBznJt563yWgMDbSv5Fq
	DTwB3P/GhI1DCvUi2EsHivaqM2m6sY5OfybuB/0EG1E8MzUazigBYadS6iG4G4ux
	cMYpz4X20wTTQJe8DE9iKFjzXI3DSA2P2MemZ7lVMo5XSjzzovEd9WUevT+31vMs
	U7N6mg6QJS1w8cq6qSVXSg3UdGih+Y9o+dkOPq5GzLzoQ/l9kYF++b3ekg5ULCpb
	4eJKRBwxPIBjKUOnPutPxXyZmusUH7VEs69GveJo8dpvkFfKjQcBsvsXmeaE+4dQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fnmkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:54:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OQaq014663;
	Fri, 24 Oct 2025 04:54:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7shnc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 04:54:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59O4spVI25821824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 04:54:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 054675805A;
	Fri, 24 Oct 2025 04:54:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0D358051;
	Fri, 24 Oct 2025 04:54:44 +0000 (GMT)
Received: from [9.61.79.238] (unknown [9.61.79.238])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 04:54:43 +0000 (GMT)
Message-ID: <5b403c7c-67f5-4f42-a463-96aa4a7e6af8@linux.ibm.com>
Date: Fri, 24 Oct 2025 10:24:42 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] Possible circular locking dependency on 6.18-rc2 in
 blkg_conf_open_bdev_frozen+0x80/0xa0
To: David Wei <dw@davidwei.uk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
        lkp@intel.com, oliver.sang@intel.com
References: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <63c97224-0e9a-4dd8-8706-38c10a1506e9@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fb069c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=fUZpyD7Rg2de-DjPzZ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ETyIbunyvyZXEi55mumT6uYrCz8fKm9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5YABRNmiWT1W
 f6c5Y37jiIoVMF8QIsXQei/QlR7Q6bm3CCvSRwi7CyjcQwGqrItVaYtKOFEujonfFEguJ4OXloy
 nJq8H5wZQYN/GFcIwTq8UG5hT30LoHgoHSW3zIEx3TNTjtO0CMPX5fOackJZFs+oaFnErotilGM
 n5IWAZ5Zj9xYM2KO8F6PJdvOXoNBjKzoQqmMnV2zQ6TNY/i8BIqOjSpmmQa/nc/sJndplAdmqiV
 FvvN9xyALk/NUJSM3AYdCiTEYKQCgdkSLGn6bVXmjkVISwNQhYwXzIFUqaWmTNxrrDqcxlF0Pal
 eKr3xg1xnz7e3PrU3HJ6w+GZ27crebIMXGMLef4ptxX9azAWQFncIKXNFQkCAg4p7BLrLcixvMl
 n52bKFMjwib6cKjZ/EW4y0jUUgkevw==
X-Proofpoint-ORIG-GUID: ETyIbunyvyZXEi55mumT6uYrCz8fKm9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022



On 10/24/25 2:42 AM, David Wei wrote:
> Hi folks, hit this with lockdep on 6.18-rc2:
> 
> [   36.862405] ======================================================
> [   36.862406] WARNING: possible circular locking dependency detected
> [   36.862408] 6.18.0-rc2-gdbafbca31432-dirty #97 Tainted: G S          E
> [   36.862409] ------------------------------------------------------
> [   36.862410] fb-cgroups-setu/1420 is trying to acquire lock:
> [   36.862411] ffff8884035502a8 (&q->rq_qos_mutex){+.+.}-{4:4}, at: blkg_conf_open_bdev_frozen+0x80/0xa0
> [   36.943164]
>                but task is already holding lock:
> [   36.954824] ffff8884035500a8 (&q->q_usage_counter(io)#2){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0xe/0x20
> [   36.975183]
>                which lock already depends on the new lock.
> [   36.991541]
>                the existing dependency chain (in reverse order) is:
> [   37.006502]
>                -> #4 (&q->q_usage_counter(io)#2){++++}-{0:0}:
> [   37.020429]        blk_alloc_queue+0x345/0x380
> [   37.029315]        blk_mq_alloc_queue+0x51/0xb0
> [   37.038376]        __blk_mq_alloc_disk+0x14/0x60
> [   37.047612]        nvme_alloc_ns+0xa7/0xbc0
> [   37.055976]        nvme_scan_ns+0x25a/0x320
> [   37.064339]        async_run_entry_fn+0x28/0x110
> [   37.073576]        process_one_work+0x1e1/0x570
> [   37.082634]        worker_thread+0x184/0x330
> [   37.091170]        kthread+0xe6/0x1e0
> [   37.098489]        ret_from_fork+0x20b/0x260
> [   37.107026]        ret_from_fork_asm+0x11/0x20
> [   37.115912]
>                -> #3 (fs_reclaim){+.+.}-{0:0}:
> [   37.127232]        fs_reclaim_acquire+0x91/0xd0
> [   37.136293]        kmem_cache_alloc_lru_noprof+0x49/0x760
> [   37.147090]        __d_alloc+0x30/0x2a0
> [   37.154759]        d_alloc_parallel+0x4c/0x760
> [   37.163644]        __lookup_slow+0xc3/0x180
> [   37.172008]        simple_start_creating+0x57/0xc0
> [   37.181590]        debugfs_start_creating.part.0+0x4d/0xe0
> [   37.192561]        debugfs_create_dir+0x3e/0x1f0
> [   37.201795]        regulator_init+0x24/0x100
> [   37.210335]        do_one_initcall+0x46/0x250
> [   37.219043]        kernel_init_freeable+0x22c/0x430
> [   37.228799]        kernel_init+0x16/0x1b0
> [   37.236814]        ret_from_fork+0x20b/0x260
> [   37.245351]        ret_from_fork_asm+0x11/0x20
> [   37.254235]
>                -> #2 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
> [   37.268336]        down_write+0x25/0xa0
> [   37.276003]        simple_start_creating+0x29/0xc0
> [   37.285582]        debugfs_start_creating.part.0+0x4d/0xe0
> [   37.296552]        debugfs_create_dir+0x3e/0x1f0
> [   37.305782]        blk_register_queue+0x98/0x1c0
> [   37.315014]        __add_disk+0x21e/0x3b0
> [   37.323030]        add_disk_fwnode+0x75/0x160
> [   37.331738]        nvme_alloc_ns+0x395/0xbc0
> [   37.340275]        nvme_scan_ns+0x25a/0x320
> [   37.348638]        async_run_entry_fn+0x28/0x110
> [   37.357870]        process_one_work+0x1e1/0x570
> [   37.366929]        worker_thread+0x184/0x330
> [   37.375461]        kthread+0xe6/0x1e0
> [   37.382779]        ret_from_fork+0x20b/0x260
> [   37.391315]        ret_from_fork_asm+0x11/0x20
> [   37.400200]
>                -> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
> [   37.412736]        __mutex_lock+0x83/0x1070
> [   37.421100]        rq_qos_add+0xde/0x130
> [   37.428942]        wbt_init+0x160/0x200
> [   37.436612]        blk_register_queue+0xe9/0x1c0
> [   37.445843]        __add_disk+0x21e/0x3b0
> [   37.453859]        add_disk_fwnode+0x75/0x160
> [   37.462568]        nvme_alloc_ns+0x395/0xbc0
> [   37.471105]        nvme_scan_ns+0x25a/0x320
> [   37.479469]        async_run_entry_fn+0x28/0x110
> [   37.488702]        process_one_work+0x1e1/0x570
> [   37.497761]        worker_thread+0x184/0x330
> [   37.506296]        kthread+0xe6/0x1e0
> [   37.513618]        ret_from_fork+0x20b/0x260
> [   37.522154]        ret_from_fork_asm+0x11/0x20
> [   37.531038]
>                -> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
> [   37.543399]        __lock_acquire+0x15fc/0x2730
> [   37.552460]        lock_acquire+0xb5/0x2a0
> [   37.560647]        __mutex_lock+0x83/0x1070
> [   37.569010]        blkg_conf_open_bdev_frozen+0x80/0xa0
> [   37.579457]        ioc_qos_write+0x35/0x4a0
> [   37.587820]        kernfs_fop_write_iter+0x15c/0x240
> [   37.597750]        vfs_write+0x31f/0x4c0
> [   37.605590]        ksys_write+0x58/0xd0
> [   37.613257]        do_syscall_64+0x6f/0x1120
> [   37.621790]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   37.632932]
>                other info that might help us debug this:
> [   37.648935] Chain exists of:
>                  &q->rq_qos_mutex --> fs_reclaim --> &q->q_usage_counter(io)#2
> [   37.671552]  Possible unsafe locking scenario:
> [   37.683385]        CPU0                    CPU1
> [   37.692438]        ----                    ----
> [   37.701489]   lock(&q->q_usage_counter(io)#2);
> [   37.710374]                                lock(fs_reclaim);
> [   37.721691]                                lock(&q->q_usage_counter(io)#2);
> [   37.735615]   lock(&q->rq_qos_mutex);
> [   37.742934]

Well this appears to be false-positive and its signature is similar to the one
reported here[1] earlier. The difference here's that we have two different NVMe
block devices being added concurrently (as can be seen in thread #1 and #2) where
device #1 pends on device #2's q->debugfs_mutex but in reality those two mutexes
are distinct as each queue has its own ->debugfs_mutex. 

In the earlier report, the same locking sequence was observed with virtio-blk devices
which similarly triggered a spurious circular dependency warning.

IMO, we need to make lockdep learn about this differences by assigning separate
lockdep key/class for each queue's q->debugfs_mutex to avoid this false positive.
As this is another report with the same false-positive lockdep splat, I think we
should address this. 

Any other thoughts or suggestions from others on the list?

[1]https://lore.kernel.org/all/7de6c29f-9058-41ca-af95-f3aaf67a64d3@linux.ibm.com/

Thanks,
--Nilay

