Return-Path: <cgroups+bounces-7134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6ECA67569
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 14:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4A37A3BCD
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 13:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F318720D502;
	Tue, 18 Mar 2025 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLKkxFWT"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3662017A311;
	Tue, 18 Mar 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305426; cv=none; b=YpPATCPFqbcdTu4zPXooW5wzwoqMHp5AgUFzH+7OzYcIy1dK5qm/JpnPBxhxfW3DAycaFzEa+r+ImEl1AMT9UgK90b5iTHYbt9cHvkfzHp05MweeHd9JIq4KXcLAcSctQCroWYbUd8A3aHZVqvO27I+QD5pLjRz2Sj/16v2bqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305426; c=relaxed/simple;
	bh=uFshjnch6COON/lIdXmtI3HvzIF/PxLTSiVUaUs2klA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHhf89bAfh2yM4IZsmc7uPlO0cmXsYpzbMNqFlRTVnREzv9MPIWUQ1BG9VtJmHRMs0NQg5WdxsZpmhwCeQlJKtjTTtWrYi9L2rWsmkgPUJ05rqC7ApCP9jHgPWFlGuEhb83IhBdb7lJ9l6gxC1rnHccxzOU5swdZWLSo6zzcx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLKkxFWT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICSHk8030912;
	Tue, 18 Mar 2025 13:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T+XfCi
	ogmjfy2Rk9LOyW7fR4o+KUQUGMxOm6P0obNJw=; b=RLKkxFWTtrbPrXKT1/hWK3
	Q+Lsc4EM9hxZTSv92SLXpsgNTLJcxX1r+pSlozckLneIt7LAOfTwlX1bRL8zGJoZ
	R7TtEWh2yfv0n+L+CtXsrsV1uqI4mcLLuFrDVj3XUiP80AX0r5VXc2J4SmjTQIyK
	9jChVDksbEwHdr5TKFbCCyU7UGl830pN8C8FS2FKhWtrJKkTwUuE6Vho5oVl2AP0
	+uJVqdfWgJ1eLZSkD2yP8PC58ZN5Wb0sk1yfhH6qNO0gekfUBueCkBr846LR2H/y
	3qlLrisS/9H+nBJk58dQnW1H9itZhUEx/fNCkff5VAgst6v/bGBtjZbr3PVbQ3DA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45f8v7gcs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 13:43:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ICgner005819;
	Tue, 18 Mar 2025 13:43:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk2bqb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 13:43:28 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52IDhR9l27919090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 13:43:27 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6733B58065;
	Tue, 18 Mar 2025 13:43:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C565804B;
	Tue, 18 Mar 2025 13:43:22 +0000 (GMT)
Received: from [9.171.73.51] (unknown [9.171.73.51])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 13:43:22 +0000 (GMT)
Message-ID: <95c6356c-da6d-4f66-8782-ada1f56315c2@linux.ibm.com>
Date: Tue, 18 Mar 2025 19:13:20 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
References: <202503171650.cc082b66-lkp@intel.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <202503171650.cc082b66-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xWM--ITegE4REgDi0zmHdWDw2CibOQF5
X-Proofpoint-ORIG-GUID: xWM--ITegE4REgDi0zmHdWDw2CibOQF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_06,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180100



On 3/17/25 7:10 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> 
> commit: f35c9ef2ba17842de59176b29df32999803bd9fa ("[PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock")
> url: https://github.com/intel-lab-lkp/linux/commits/Nilay-Shroff/block-acquire-q-limits_lock-while-reading-sysfs-attributes/20250304-182738
> base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
> patch link: https://lore.kernel.org/all/20250304102551.2533767-7-nilay@linux.ibm.com/
> patch subject: [PATCHv6 6/7] block: protect wbt_lat_usec using q->elevator_lock
> 
> in testcase: fio-basic
> version: fio-x86_64-3.38-1_20250308
> with following parameters:
> 
> 	runtime: 300s
> 	disk: 1HDD
> 	fs: btrfs
> 	nr_task: 100%
> 	test_size: 128G
> 	rw: randwrite
> 	bs: 4M
> 	ioengine: posixaio
> 	cpufreq_governor: performance
> 
> 
> 
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com
> 
> 
> [  991.017071][  T472] INFO: task umount:12320 blocked for more than 491 seconds.
> [  991.024314][  T472]       Tainted: G        W          6.14.0-rc5-00192-gf35c9ef2ba17 #1
> [  991.032414][  T472] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  991.040948][  T472] task:umount          state:D stack:0     pid:12320 tgid:12320 ppid:12317  task_flags:0x400100 flags:0x00004002
> [  991.052695][  T472] Call Trace:
> [  991.055849][  T472]  <TASK>
> [ 991.058658][ T472] __schedule (kernel/sched/core.c:5378 kernel/sched/core.c:6765) 
> [ 991.062856][ T472] schedule (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/linux/thread_info.h:192 include/linux/thread_info.h:208 include/linux/sched.h:2149 kernel/sched/core.c:6844 kernel/sched/core.c:6857) 
> [ 991.066706][ T472] wb_wait_for_completion (fs/fs-writeback.c:216 fs/fs-writeback.c:213) 
> [ 991.071773][ T472] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
> [ 991.077702][ T472] __writeback_inodes_sb_nr (fs/fs-writeback.c:2736) 
> [ 991.082936][ T472] sync_filesystem (fs/sync.c:55 fs/sync.c:30) 
> [ 991.087390][ T472] generic_shutdown_super (fs/super.c:622) 
> [ 991.092538][ T472] kill_anon_super (fs/super.c:434 fs/super.c:1238) 
> [ 991.096991][ T472] btrfs_kill_super (fs/btrfs/super.c:2101) btrfs 
> [ 991.102280][ T472] deactivate_locked_super (fs/super.c:473) 
> [ 991.107678][ T472] cleanup_mnt (fs/namespace.c:281 fs/namespace.c:1414) 
> [ 991.112082][ T472] task_work_run (kernel/task_work.c:227 (discriminator 1)) 
> [ 991.116534][ T472] syscall_exit_to_user_mode (include/linux/resume_user_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kernel/entry/common.c:207 kernel/entry/common.c:218) 
> [ 991.122197][ T472] do_syscall_64 (arch/x86/entry/common.c:102) 
> [ 991.126731][ T472] ? do_syscall_64 (arch/x86/entry/common.c:102) 
> [ 991.131430][ T472] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcontrol.c:857) 
> [ 991.136738][ T472] ? handle_mm_fault (arch/x86/include/asm/irqflags.h:154 include/linux/memcontrol.h:970 include/linux/memcontrol.h:993 include/linux/memcontrol.h:1000 mm/memory.c:6077 mm/memory.c:6238) 
> [ 991.141606][ T472] ? do_user_addr_fault (include/linux/mm.h:743 arch/x86/mm/fault.c:1339) 
> [ 991.146823][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> [ 991.151517][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> [ 991.156203][ T472] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1538) 
> [ 991.160881][ T472] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [  991.166777][  T472] RIP: 0033:0x7f415ea2aa77
> [  991.171197][  T472] RSP: 002b:00007ffe0db2fd98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [  991.179611][  T472] RAX: 0000000000000000 RBX: 000055cc64b55048 RCX: 00007f415ea2aa77
> [  991.187586][  T472] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055cc64b55160
> [  991.195555][  T472] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
> [  991.203514][  T472] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f415eb65264
> [  991.211476][  T472] R13: 000055cc64b55160 R14: 0000000000000000 R15: 000055cc64b54f30
> [  991.219431][  T472]  </TASK>
> [ 1008.358661][T12320] BTRFS info (device sda1): last unmount of filesystem 8b972718-96ad-4a66-b549-8be29321e91a
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250317/202503171650.cc082b66-lkp@intel.com
> 
I attempted to reproduce the above issue multiple times using the provided 
reproducer but was unable to do so. However, during further investigation, 
I discovered a  lockdep warning related to a circular buffer. The patch in
question introduces q->elevator_lock to protect writes to the sysfs attribute
wbt_lat_usec and the cgroup attribute io.cost.qos. However, write to these
attributes also acquire q->rq_qos_mutex, which may lead to a potential lock
ordering issue reported by lockdep. Unfortunately, blktest doesn't have any
testcase testing writes to these attributes. I think we should have one and
so will submit a blktest. 

The lockdep warning reports an incorrect locking order between q->elevator_lock
and q->rq_qos_mutex, which might cause the observed symptom reported. Notably, 
I saw that the LKP test case did not have lockdep enabled, which may have 
allowed this issue to manifest much earlier rather than being detected later 
while unmounting the file system.

Anyways, we have to fix the circular locking dependency between q->elevator_lock 
and q->rq_qos_mutex. I will prepare a patch to address this and submit it upstream, 
tagging you in the commit.

On another, if you're able to recreate this issue then whenever this issue manifests
would you please help run the below command and collect dmesg output:
# echo w > /proc/sysrq-trigger

Thanks,
--Nilay


