Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43A1BECA
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEMUpH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 16:45:07 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:54524 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbfEMUpH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 16:45:07 -0400
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x4DKZVt5006013;
        Mon, 13 May 2019 21:45:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=jan2016.eng; bh=g37pczUbKrwfb2PG60E8lMD0YH4JQSGXnhy605XKbRk=;
 b=UNFwA76FMzEnslJNqaYd6xF6+Ad6pIsR/tOmkUPsKfO4lLh67a73JyfyNF1GcsOK2FlJ
 qWl3lfr4enLMFPbzufBP2Yo7z33AI11ha7ooX0CzP7laR0eCca49fXum+zPklSIHA9IT
 7H5B5ZZlE0kRrzMr1ow6mz9Tx4v1pdcY7kzrGtjqgLpsZlspcyunLgNuVTmyD4xR8xkr
 pvqOe2Zi7ljA2mQ31HIBjkxz/lpZkcOsYambxAWINtkZ1PVdkYMz7KzT6k0Raswh7k0Z
 PAr7+I9fAQ8VCE1XkEgBKcNTDGj2Ctd46CUQpVREBXW6xjsYTniU8MyYpw/sbeaN6wQ9 Xw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 2sdrsx8uw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 May 2019 21:44:59 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x4DKWsA3032233;
        Mon, 13 May 2019 16:44:58 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2sdsqv8t7u-1;
        Mon, 13 May 2019 16:44:58 -0400
Received: from bos-lpxjs (bos-lpxjs.kendall.corp.akamai.com [172.29.171.194])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 40D9D1FC6D;
        Mon, 13 May 2019 20:44:58 +0000 (GMT)
Received: from dbanerje by bos-lpxjs with local (Exim 4.86_2)
        (envelope-from <dbanerje@akamai.com>)
        id 1hQHof-0001ak-KX; Mon, 13 May 2019 16:44:57 -0400
From:   Debabrata Banerjee <dbanerje@akamai.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     dbanerje@akamai.com
Subject: [PATCH] mem_cgroup: event_list_lock requires irqsave lock
Date:   Mon, 13 May 2019 16:44:32 -0400
Message-Id: <20190513204432.6063-1-dbanerje@akamai.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905130138
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905130138
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Lockdep reports of potential deadlock in memcg_event_wake():

[  850.145324] =====================================================
[  850.151458] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[  850.158108] 4.19.29-4.19.0-debug-99d9c44b25c08f51 #1 Tainted: G           O
[  850.165540] -----------------------------------------------------
[  850.171669] gh_PhantomThr00/8426 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  850.178924] 00000000cf6f8a05 (&(&memcg->event_list_lock)->rlock){+.+.}, at: memcg_event_wake+0x58/0x210
[  850.188360]
[  850.188360] and this task is already holding:
[  850.194226] 00000000bc034eb9 (&ctx->wqh#2){..-.}, at: __wake_up_common_lock+0xa3/0x100
[  850.202183] which would create a new lock dependency:
[  850.207279]  (&ctx->wqh#2){..-.} -> (&(&memcg->event_list_lock)->rlock){+.+.}
[  850.214454]
[  850.214454] but this new dependency connects a SOFTIRQ-irq-safe lock:
[  850.222403]  (&ctx->wqh#2){..-.}
[  850.222405]
[  850.222405] ... which became SOFTIRQ-irq-safe at:
[  850.231894]   _raw_spin_lock_irqsave+0x48/0x80
[  850.236385]   eventfd_signal+0x1f/0xc0
[  850.240169]   aio_complete+0x51b/0xd40
[  850.243959]   dio_complete+0x2e3/0x880
[  850.247970]   blk_update_request+0x197/0xb50
[  850.252277]   scsi_end_request+0x77/0x870
[  850.256325]   scsi_io_completion+0x211/0x14e0
[  850.260720]   blk_done_softirq+0x212/0x310
[  850.264863]   __do_softirq+0x22e/0x868
[  850.268657]   irq_exit+0x150/0x170
[  850.272098]   do_IRQ+0x87/0x1a0
[  850.275277]   ret_from_intr+0x0/0x22
[  850.278893]   orc_find+0x9a/0x340
[  850.282246]   unwind_next_frame+0x1fd/0x1850
[  850.286554]   __save_stack_trace+0x73/0xd0
[  850.290690]   kasan_kmalloc+0xda/0x170
[  850.294474]   kmem_cache_alloc+0x14e/0x340
[  850.298609]   create_object+0x81/0x8e0
[  850.302396]   kmem_cache_alloc+0x2c8/0x340
[  850.306529]   __blockdev_direct_IO+0x36c/0xae51
[  850.311121]   ext4_direct_IO+0xecd/0x1690 [ext4]
[  850.315779]   generic_file_read_iter+0x1de/0x15b0
[  850.320516]   aio_read+0x2a7/0x360
[  850.323957]   io_submit_one+0x5a6/0x1710
[  850.327917]   __se_sys_io_submit+0x115/0x340
[  850.332226]   do_syscall_64+0x9b/0x400
[  850.336014]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.341187]
[  850.341187] to a SOFTIRQ-irq-unsafe lock:
[  850.346714]  (&(&memcg->event_list_lock)->rlock){+.+.}
[  850.346717]
[  850.346717] ... which became SOFTIRQ-irq-unsafe at:
[  850.358283] ...
[  850.358286]   _raw_spin_lock+0x30/0x70
[  850.363867]   memcg_write_event_control+0x982/0xe60
[  850.368782]   cgroup_file_write+0x260/0x640
[  850.373002]   kernfs_fop_write+0x278/0x400
[  850.377136]   __vfs_write+0xd5/0x5b0
[  850.380748]   vfs_write+0x15d/0x460
[  850.384275]   ksys_write+0xb1/0x170
[  850.387803]   do_syscall_64+0x9b/0x400
[  850.391591]   entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.396762]
[  850.396762] other info that might help us debug this:
[  850.396762]
[  850.404798]  Possible interrupt unsafe locking scenario:
[  850.404798]
[  850.411626]        CPU0                    CPU1
[  850.416195]        ----                    ----
[  850.420760]   lock(&(&memcg->event_list_lock)->rlock);
[  850.426343]                                local_irq_disable();
[  850.432297]                                lock(&ctx->wqh#2);
[  850.438087]                                lock(&(&memcg->event_list_lock)->rlock);
[  850.445781]   <Interrupt>
[  850.448442]     lock(&ctx->wqh#2);
[  850.451884]
[  850.451884]  *** DEADLOCK ***
[  850.451884]
[  850.457847] 1 lock held by gh_PhantomThr00/8426:
[  850.462499]  #0: 00000000bc034eb9 (&ctx->wqh#2){..-.}, at: __wake_up_common_lock+0xa3/0x100
[  850.470889]
[  850.470889] the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
[  850.479801] -> (&ctx->wqh#2){..-.} ops: 2456971 {
[  850.484546]    IN-SOFTIRQ-W at:
[  850.487731]                     _raw_spin_lock_irqsave+0x48/0x80
[  850.493779]                     eventfd_signal+0x1f/0xc0
[  850.499134]                     aio_complete+0x51b/0xd40
[  850.504481]                     dio_complete+0x2e3/0x880
[  850.509828]                     blk_update_request+0x197/0xb50
[  850.515696]                     scsi_end_request+0x77/0x870
[  850.521312]                     scsi_io_completion+0x211/0x14e0
[  850.527265]                     blk_done_softirq+0x212/0x310
[  850.532959]                     __do_softirq+0x22e/0x868
[  850.538307]                     irq_exit+0x150/0x170
[  850.543307]                     do_IRQ+0x87/0x1a0
[  850.548046]                     ret_from_intr+0x0/0x22
[  850.553224]                     orc_find+0x9a/0x340
[  850.558136]                     unwind_next_frame+0x1fd/0x1850
[  850.564002]                     __save_stack_trace+0x73/0xd0
[  850.569700]                     kasan_kmalloc+0xda/0x170
[  850.575054]                     kmem_cache_alloc+0x14e/0x340
[  850.580747]                     create_object+0x81/0x8e0
[  850.586103]                     kmem_cache_alloc+0x2c8/0x340
[  850.591797]                     __blockdev_direct_IO+0x36c/0xae51
[  850.597944]                     ext4_direct_IO+0xecd/0x1690 [ext4]
[  850.604162]                     generic_file_read_iter+0x1de/0x15b0
[  850.610474]                     aio_read+0x2a7/0x360
[  850.615472]                     io_submit_one+0x5a6/0x1710
[  850.620992]                     __se_sys_io_submit+0x115/0x340
[  850.626862]                     do_syscall_64+0x9b/0x400
[  850.632206]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.638943]    INITIAL USE at:
[  850.642037]                    _raw_spin_lock_irqsave+0x48/0x80
[  850.647989]                    add_wait_queue+0x49/0x150
[  850.653338]                    ep_ptable_queue_proc+0x296/0x380
[  850.659290]                    eventfd_poll+0x6f/0x100
[  850.664464]                    ep_item_poll.isra.1+0xf9/0x320
[  850.670246]                    __se_sys_epoll_ctl+0x12e0/0x3030
[  850.676200]                    do_syscall_64+0x9b/0x400
[  850.681469]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.688115]  }
[  850.689825]  ... key      at: [<ffffffffbf2ac7e0>] __key.41123+0x0/0x40
[  850.696479]  ... acquired at:
[  850.699494]    _raw_spin_lock+0x30/0x70
[  850.703378]    memcg_event_wake+0x58/0x210
[  850.707512]    __wake_up_common+0x183/0x550
[  850.711733]    __wake_up_common_lock+0xbe/0x100
[  850.716299]    eventfd_release+0x47/0x70
[  850.720261]    __fput+0x256/0x7e0
[  850.723614]    task_work_run+0xfe/0x170
[  850.727489]    do_exit+0x993/0x2b60
[  850.731014]    do_group_exit+0xee/0x2b0
[  850.734889]    get_signal+0x31f/0x18c0
[  850.738674]    do_signal+0x9b/0x16d0
[  850.742289]    exit_to_usermode_loop+0x146/0x1a0
[  850.746942]    do_syscall_64+0x317/0x400
[  850.750903]    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.756164]
[  850.757706]
[  850.757706] the dependencies between the lock to be acquired
[  850.757707]  and SOFTIRQ-irq-unsafe lock:
[  850.768925] -> (&(&memcg->event_list_lock)->rlock){+.+.} ops: 4 {
[  850.775058]    HARDIRQ-ON-W at:
[  850.778238]                     _raw_spin_lock+0x30/0x70
[  850.783585]                     memcg_write_event_control+0x982/0xe60
[  850.790069]                     cgroup_file_write+0x260/0x640
[  850.795851]                     kernfs_fop_write+0x278/0x400
[  850.801552]                     __vfs_write+0xd5/0x5b0
[  850.807417]                     vfs_write+0x15d/0x460
[  850.812505]                     ksys_write+0xb1/0x170
[  850.817593]                     do_syscall_64+0x9b/0x400
[  850.822941]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.829675]    SOFTIRQ-ON-W at:
[  850.832856]                     _raw_spin_lock+0x30/0x70
[  850.838203]                     memcg_write_event_control+0x982/0xe60
[  850.844676]                     cgroup_file_write+0x260/0x640
[  850.850457]                     kernfs_fop_write+0x278/0x400
[  850.856152]                     __vfs_write+0xd5/0x5b0
[  850.861333]                     vfs_write+0x15d/0x460
[  850.866420]                     ksys_write+0xb1/0x170
[  850.871507]                     do_syscall_64+0x9b/0x400
[  850.876856]                     entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.883595]    INITIAL USE at:
[  850.886692]                    _raw_spin_lock+0x30/0x70
[  850.891953]                    memcg_write_event_control+0x982/0xe60
[  850.898347]                    cgroup_file_write+0x260/0x640
[  850.904042]                    kernfs_fop_write+0x278/0x400
[  850.909649]                    __vfs_write+0xd5/0x5b0
[  850.914736]                    vfs_write+0x15d/0x460
[  850.919737]                    ksys_write+0xb1/0x170
[  850.924738]                    do_syscall_64+0x9b/0x400
[  850.929998]                    entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  850.936643]  }
[  850.938356]  ... key      at: [<ffffffffbf2a6680>] __key.75511+0x0/0x40
[  850.945007]  ... acquired at:
[  850.948014]    _raw_spin_lock+0x30/0x70
[  850.951891]    memcg_event_wake+0x58/0x210
[  850.956025]    __wake_up_common+0x183/0x550
[  850.960243]    __wake_up_common_lock+0xbe/0x100
[  850.964811]    eventfd_release+0x47/0x70
[  850.968771]    __fput+0x256/0x7e0
[  850.972126]    task_work_run+0xfe/0x170
[  850.975999]    do_exit+0x993/0x2b60
[  850.979528]    do_group_exit+0xee/0x2b0
[  850.983402]    get_signal+0x31f/0x18c0
[  850.987189]    do_signal+0x9b/0x16d0
[  850.990802]    exit_to_usermode_loop+0x146/0x1a0
[  850.995456]    do_syscall_64+0x317/0x400
[  850.999425]    entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>
---
 mm/memcontrol.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 81a0d3914ec9..3faaa6934335 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4016,7 +4016,9 @@ static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
 		 * side will require wqh->lock via remove_wait_queue(),
 		 * which we hold.
 		 */
-		spin_lock(&memcg->event_list_lock);
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&memcg->event_list_lock, irqflags);
 		if (!list_empty(&event->list)) {
 			list_del_init(&event->list);
 			/*
@@ -4025,7 +4027,7 @@ static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
 			 */
 			schedule_work(&event->remove);
 		}
-		spin_unlock(&memcg->event_list_lock);
+		spin_unlock_irqrestore(&memcg->event_list_lock, irqflags);
 	}
 
 	return 0;
@@ -4062,6 +4064,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 	const char *name;
 	char *endp;
 	int ret;
+	unsigned long flags;
 
 	buf = strstrip(buf);
 
@@ -4157,9 +4160,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	vfs_poll(efile.file, &event->pt);
 
-	spin_lock(&memcg->event_list_lock);
+	spin_lock_irqsave(&memcg->event_list_lock, flags);
 	list_add(&event->list, &memcg->event_list);
-	spin_unlock(&memcg->event_list_lock);
+	spin_unlock_irqrestore(&memcg->event_list_lock, flags);
 
 	fdput(cfile);
 	fdput(efile);
@@ -4578,18 +4581,19 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup_event *event, *tmp;
+	unsigned long flags;
 
 	/*
 	 * Unregister events and notify userspace.
 	 * Notify userspace about cgroup removing only after rmdir of cgroup
 	 * directory to avoid race between userspace and kernelspace.
 	 */
-	spin_lock(&memcg->event_list_lock);
+	spin_lock_irqsave(&memcg->event_list_lock, flags);
 	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
 		list_del_init(&event->list);
 		schedule_work(&event->remove);
 	}
-	spin_unlock(&memcg->event_list_lock);
+	spin_unlock_irqrestore(&memcg->event_list_lock, flags);
 
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
-- 
2.21.0

