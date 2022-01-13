Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1048DA9D
	for <lists+cgroups@lfdr.de>; Thu, 13 Jan 2022 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiAMPVt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 10:21:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236051AbiAMPVt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 10:21:49 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DDxCX6020615
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : date : message-id : mime-version : content-type; s=pp1;
 bh=fGFrytyVy7HxnTpbshDJL+mFDEVGJdPEpMtb2EDB7eg=;
 b=UMAzSe0SqhalBQW+Q81fug8rJQFTzH1KUVChTwPceerH7qzv0rpCFUyneQmkSn/3M72G
 L1zvH/8Q1VT+m7crlnFJrqMzL9iEGZ+o8HaFzkM8eeZhCpxIUt36C95R4e85I6D+BRfd
 6aIuDkgF29reKxah7f+uRuTbmY1QQYbfA7V1tkQPoh0BRcNXd8AKwcaEwSLgitfG372c
 78CFAUiNeSqvjsR2nK3qdO6AP3kjrIHm3ccV0Y0rA7Sfui2o5M7LWKNza/59XzU0+ihO
 94c0VPfwicmipw6DaXKr3PDb/tamVTqPtllEemdGV3MgVZyNKbXs19+qkwoBNyU6Uqmz 0g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3djnesstgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:21:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DFCRQd016242
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:47 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3df1vjp4rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DFKjcf45220152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F09FAA405F
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C25C0A4040
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:44 +0000 (GMT)
Received: from localhost (unknown [9.171.39.7])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <cgroups@vger.kernel.org>; Thu, 13 Jan 2022 15:20:44 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     cgroups@vger.kernel.org
Subject: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
In-Reply-To: 
Date:   Thu, 13 Jan 2022 16:20:44 +0100
Message-ID: <87mtjzslv7.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kc5km-7PXNKfQVYLi_YowzWxOdbrGEr2
X-Proofpoint-ORIG-GUID: Kc5km-7PXNKfQVYLi_YowzWxOdbrGEr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_07,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=4 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=4 phishscore=0 mlxlogscore=142 lowpriorityscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 mlxscore=4 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130093
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi,

our daily CI linux-next test reported the following finding on s390x arch:

	 LOCKDEP_CIRCULAR (suite: ltp, case: mtest06 (mmap1))
		 WARNING: possible circular locking dependency detected
		 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1 Not tainted
		 ------------------------------------------------------
		 mmap1/202299 is trying to acquire lock:
		 00000001892c0188 (css_set_lock){..-.}-{2:2}, at: obj_cgroup_release+0x4a/0xe0
		 but task is already holding lock:
		 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
		 which lock already depends on the new lock.
		 the existing dependency chain (in reverse order) is:
		 -> #1 (&sighand->siglock){-.-.}-{2:2}:
			__lock_acquire+0x604/0xbd8
			lock_acquire.part.0+0xe2/0x238
			lock_acquire+0xb0/0x200
			_raw_spin_lock_irqsave+0x6a/0xd8
			__lock_task_sighand+0x90/0x190
			cgroup_freeze_task+0x2e/0x90
			cgroup_migrate_execute+0x11c/0x608
			cgroup_update_dfl_csses+0x246/0x270
			cgroup_subtree_control_write+0x238/0x518
			kernfs_fop_write_iter+0x13e/0x1e0
			new_sync_write+0x100/0x190
			vfs_write+0x22c/0x2d8
			ksys_write+0x6c/0xf8
			__do_syscall+0x1da/0x208
			system_call+0x82/0xb0
		 -> #0 (css_set_lock){..-.}-{2:2}:
			check_prev_add+0xe0/0xed8
			validate_chain+0x736/0xb20
			__lock_acquire+0x604/0xbd8
			lock_acquire.part.0+0xe2/0x238
			lock_acquire+0xb0/0x200
			_raw_spin_lock_irqsave+0x6a/0xd8
			obj_cgroup_release+0x4a/0xe0
			percpu_ref_put_many.constprop.0+0x150/0x168
			drain_obj_stock+0x94/0xe8
			refill_obj_stock+0x94/0x278
			obj_cgroup_charge+0x164/0x1d8
			kmem_cache_alloc+0xac/0x528
			__sigqueue_alloc+0x150/0x308
			__send_signal+0x260/0x550
			send_signal+0x7e/0x348
			force_sig_info_to_task+0x104/0x180
			force_sig_fault+0x48/0x58
			__do_pgm_check+0x120/0x1f0
			pgm_check_handler+0x11e/0x180
		 other info that might help us debug this:
		  Possible unsafe locking scenario:
			CPU0                    CPU1
			----                    ----
		   lock(&sighand->siglock);
						lock(css_set_lock);
						lock(&sighand->siglock);
		   lock(css_set_lock);
		  *** DEADLOCK ***
		 2 locks held by mmap1/202299:
		  #0: 00000000ca3b3818 (&sighand->siglock){-.-.}-{2:2}, at: force_sig_info_to_task+0x38/0x180
		  #1: 00000001892ad560 (rcu_read_lock){....}-{1:2}, at: percpu_ref_put_many.constprop.0+0x0/0x168
		 stack backtrace:
		 CPU: 15 PID: 202299 Comm: mmap1 Not tainted 5.17.0-20220113.rc0.git0.f2211f194038.300.fc35.s390x+debug #1
		 Hardware name: IBM 3906 M04 704 (LPAR)
		 Call Trace:
		  [<00000001888aacfe>] dump_stack_lvl+0x76/0x98 
		  [<0000000187c6d7be>] check_noncircular+0x136/0x158 
		  [<0000000187c6e888>] check_prev_add+0xe0/0xed8 
		  [<0000000187c6fdb6>] validate_chain+0x736/0xb20 
		  [<0000000187c71e54>] __lock_acquire+0x604/0xbd8 
		  [<0000000187c7301a>] lock_acquire.part.0+0xe2/0x238 
		  [<0000000187c73220>] lock_acquire+0xb0/0x200 
		  [<00000001888bf9aa>] _raw_spin_lock_irqsave+0x6a/0xd8 
		  [<0000000187ef6862>] obj_cgroup_release+0x4a/0xe0 
		  [<0000000187ef6498>] percpu_ref_put_many.constprop.0+0x150/0x168 
		  [<0000000187ef9674>] drain_obj_stock+0x94/0xe8 
		  [<0000000187efa464>] refill_obj_stock+0x94/0x278 
		  [<0000000187eff55c>] obj_cgroup_charge+0x164/0x1d8 
		  [<0000000187ed8aa4>] kmem_cache_alloc+0xac/0x528 
		  [<0000000187bf2eb8>] __sigqueue_alloc+0x150/0x308 
		  [<0000000187bf4210>] __send_signal+0x260/0x550 
		  [<0000000187bf5f06>] send_signal+0x7e/0x348 
		  [<0000000187bf7274>] force_sig_info_to_task+0x104/0x180 
		  [<0000000187bf7758>] force_sig_fault+0x48/0x58 
		  [<00000001888ae160>] __do_pgm_check+0x120/0x1f0 
		  [<00000001888c0cde>] pgm_check_handler+0x11e/0x180 
		 INFO: lockdep is turned off.


Regards
Alex
