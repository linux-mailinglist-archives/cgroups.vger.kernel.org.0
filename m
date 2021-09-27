Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F955418DD7
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 04:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhI0DAO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Sep 2021 23:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232498AbhI0DAO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Sep 2021 23:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632711516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=zWF2nczzI4+QyZS6NYi2Qx1q/41F/KSIJItUkmUbpvE=;
        b=E27mXsk1+5TWy4NBatZFfp0TRfmnFK9myxQuYUAVgUpnGBMm6KXXisRJ4br5BZj8xLBgE3
        FJiGGnCtcHYIEjsgrskPXR2fPGoOZUnJwwRSBtzZGmQFUlSHeqUXckaJ5UdQjJ78tONikJ
        0S9KKaLOJEmKSop4mU3P02d/gDW1gv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-6MDp9_YaPemGY6qZ7YMhSg-1; Sun, 26 Sep 2021 22:58:35 -0400
X-MC-Unique: 6MDp9_YaPemGY6qZ7YMhSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7290B5074C;
        Mon, 27 Sep 2021 02:58:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1A35DF2F;
        Mon, 27 Sep 2021 02:58:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/debug: Fix lockdep splat with "%pK" format specifier
Date:   Sun, 26 Sep 2021 22:58:07 -0400
Message-Id: <20210927025807.26918-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that the following lockdep splat happened when the control
files of the debug controller are being read.

[ 1732.553607] =====================================================
[ 1732.560413] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[ 1732.567801] 4.18.0-345.el8.x86_64+debug #1 Not tainted
[ 1732.573536] -----------------------------------------------------
[ 1732.580344] read_all/7798 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[ 1732.587729] ffffffffa8844630 (&selinux_ss.policy_rwlock){.+.?}-{2:2}, at: security_compute_av+0x6c/0xfe0
[ 1732.598335]
               and this task is already holding:
[ 1732.604848] ffffffffa5d9c878 (css_set_lock){..-.}-{2:2}, at: current_css_set_read+0x84/0x540
[ 1732.614283] which would create a new lock dependency:
[ 1732.619922]  (css_set_lock){..-.}-{2:2} -> (&selinux_ss.policy_rwlock){.+.?}-{2:2}
[ 1732.628383]
               but this new dependency connects a SOFTIRQ-irq-safe lock:
[ 1732.637221]  (css_set_lock){..-.}-{2:2}
[ 1732.637226]
               ... which became SOFTIRQ-irq-safe at:
[ 1732.648416]   lock_acquire+0x1b1/0x890
[ 1732.652607]   _raw_spin_lock_irqsave+0x4c/0x8c
[ 1732.657573]   cgroup_free+0x74/0x140
[ 1732.661573]   __put_task_struct+0xb4/0x2e0
[ 1732.666151]   rcu_do_batch+0x3d4/0xba0
[ 1732.670338]   rcu_core+0x5ab/0x8e0
[ 1732.674138]   __do_softirq+0x1cb/0xa4f
[ 1732.678325]   run_ksoftirqd+0x3a/0x70
[ 1732.682419]   smpboot_thread_fn+0x30f/0x770
[ 1732.687094]   kthread+0x344/0x410
[ 1732.690797]   ret_from_fork+0x3a/0x50
[ 1732.694885]
               to a SOFTIRQ-irq-unsafe lock:
[ 1732.701007]  (&selinux_ss.policy_rwlock){.+.?}-{2:2}
[ 1732.701011]
               ... which became SOFTIRQ-irq-unsafe at:
[ 1732.713641] ...
[ 1732.713647]   lock_acquire+0x1b1/0x890
[ 1732.719784]   _raw_read_lock+0x3c/0x90
[ 1732.723970]   security_compute_av+0x6c/0xfe0
[ 1732.728739]   avc_compute_av+0xd3/0x620
[ 1732.733021]   avc_has_perm+0x330/0x4b0
[ 1732.737201]   security_task_alloc+0x8d/0x140
[ 1732.741971]   copy_process+0x1d6d/0x6410
[ 1732.746353]   _do_fork+0x107/0xbc0
[ 1732.750152]   kernel_thread+0x25/0x30
[ 1732.754243]   rest_init+0x26/0x200
[ 1732.758045]   start_kernel+0x77c/0x7ba
[ 1732.762236]   secondary_startup_64_no_verify+0xc2/0xcb
[ 1732.767971]
               other info that might help us debug this:

[ 1732.776898]  Possible interrupt unsafe locking scenario:

[ 1732.784469]        CPU0                    CPU1
[ 1732.789517]        ----                    ----
[ 1732.794565]   lock(&selinux_ss.policy_rwlock);
[ 1732.799528]                                local_irq_disable();
[ 1732.806137]                                lock(css_set_lock);
[ 1732.812648]                                lock(&selinux_ss.policy_rwlock);
[ 1732.820413]   <Interrupt>
[ 1732.823335]     lock(css_set_lock);
[ 1732.827222]
                *** DEADLOCK ***

[ 1732.833831] 6 locks held by read_all/7798:
[ 1732.838393]  #0: ffff88811b46daf0 (&p->lock){+.+.}-{3:3}, at: seq_read+0x6b/0x1020
[ 1732.846857]  #1: ffff888132826490 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x49/0x170
[ 1732.856192]  #2: ffffffffa5d9c950 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0x14a/0x430
[ 1732.866105]  #3: ffffffffa5d9c878 (css_set_lock){..-.}-{2:2}, at: current_css_set_read+0x84/0x540
[ 1732.876020]  #4: ffffffffa5c819a0 (rcu_read_lock){....}-{1:2}, at: current_css_set_read+0x78/0x540
[ 1732.886032]  #5: ffffffffa5c819a0 (rcu_read_lock){....}-{1:2}, at: has_ns_capability_noaudit+0x5/0x1c0
[ 1732.896435]
               the dependencies between SOFTIRQ-irq-safe lock and the holding lock:
[ 1732.906361] -> (css_set_lock){..-.}-{2:2} {
[ 1732.911037]    IN-SOFTIRQ-W at:
[ 1732.914548]                     lock_acquire+0x1b1/0x890
[ 1732.920482]                     _raw_spin_lock_irqsave+0x4c/0x8c
[ 1732.927190]                     cgroup_free+0x74/0x140
[ 1732.932929]                     __put_task_struct+0xb4/0x2e0
[ 1732.939250]                     rcu_do_batch+0x3d4/0xba0
[ 1732.945184]                     rcu_core+0x5ab/0x8e0
[ 1732.950727]                     __do_softirq+0x1cb/0xa4f
[ 1732.956660]                     run_ksoftirqd+0x3a/0x70
[ 1732.962495]                     smpboot_thread_fn+0x30f/0x770
[ 1732.968912]                     kthread+0x344/0x410
[ 1732.974359]                     ret_from_fork+0x3a/0x50
[ 1732.980191]    INITIAL USE at:
[ 1732.983605]                    lock_acquire+0x1b1/0x890
[ 1732.989439]                    _raw_spin_lock_irq+0x46/0x90
[ 1732.995663]                    cgroup_setup_root+0x49d/0x920
[ 1733.001984]                    cgroup_init+0x20e/0xbb7
[ 1733.007721]                    start_kernel+0x754/0x7ba
[ 1733.013555]                    secondary_startup_64_no_verify+0xc2/0xcb
[ 1733.020939]  }
[ 1733.022803]  ... key      at: [<ffffffffa5d9c878>] css_set_lock+0x18/0x80
[ 1733.030382]  ... acquired at:
[ 1733.033696]    __lock_acquire+0x21d1/0x2c60
[ 1733.038369]    lock_acquire+0x1b1/0x890
[ 1733.042651]    _raw_read_lock+0x3c/0x90
[ 1733.046934]    security_compute_av+0x6c/0xfe0
[ 1733.051798]    avc_compute_av+0xd3/0x620
[ 1733.056170]    avc_has_perm_noaudit+0x2eb/0x490
[ 1733.061230]    cred_has_capability+0x139/0x260
[ 1733.066193]    security_capable+0x58/0x90
[ 1733.070670]    has_ns_capability_noaudit+0xc7/0x1c0
[ 1733.076120]    restricted_pointer+0x18a/0x410
[ 1733.080984]    pointer+0x1de/0x700
[ 1733.084783]    vsnprintf+0x7bd/0x1250
[ 1733.088873]    seq_vprintf+0xbd/0x1a0
[ 1733.092963]    seq_printf+0x9b/0xd0
[ 1733.096859]    current_css_set_read+0x179/0x540
[ 1733.101918]    seq_read+0x408/0x1020
[ 1733.105916]    vfs_read+0xff/0x300
[ 1733.109715]    ksys_read+0xb8/0x170
[ 1733.113614]    do_syscall_64+0xa5/0x430
[ 1733.117899]    entry_SYSCALL_64_after_hwframe+0x6a/0xdf

[ 1733.125392]
               the dependencies between the lock to be acquired
[ 1733.125394]  and SOFTIRQ-irq-unsafe lock:
[ 1733.137843] -> (&selinux_ss.policy_rwlock){.+.?}-{2:2} {
[ 1733.143779]    HARDIRQ-ON-R at:
[ 1733.147289]                     lock_acquire+0x1b1/0x890
[ 1733.153223]                     _raw_read_lock+0x3c/0x90
[ 1733.159156]                     security_compute_av+0x6c/0xfe0
[ 1733.165670]                     avc_compute_av+0xd3/0x620
[ 1733.171699]                     avc_has_perm+0x330/0x4b0
[ 1733.177632]                     security_task_alloc+0x8d/0x140
[ 1733.184148]                     copy_process+0x1d6d/0x6410
[ 1733.190274]                     _do_fork+0x107/0xbc0
[ 1733.195820]                     kernel_thread+0x25/0x30
[ 1733.201654]                     rest_init+0x26/0x200
[ 1733.207198]                     start_kernel+0x77c/0x7ba
[ 1733.213131]                     secondary_startup_64_no_verify+0xc2/0xcb
[ 1733.220613]    IN-SOFTIRQ-R at:
[ 1733.224123]                     lock_acquire+0x1b1/0x890
[ 1733.230057]                     _raw_read_lock+0x3c/0x90
[ 1733.235991]                     security_netlbl_sid_to_secattr+0xc3/0x330
[ 1733.243572]                     selinux_netlbl_inet_conn_request+0xf4/0x210
[ 1733.251348]                     selinux_inet_conn_request+0x1ad/0x270
[ 1733.258539]                     security_inet_conn_request+0x4f/0x90
[ 1733.265635]                     tcp_v6_route_req+0x2db/0x510
[ 1733.271958]                     tcp_conn_request+0xb06/0x2e40
[ 1733.278375]                     tcp_rcv_state_process+0x9d2/0x4971
[ 1733.285278]                     tcp_v6_do_rcv+0x6f5/0x1220
[ 1733.291403]                     tcp_v6_rcv+0x2c9d/0x3290
[ 1733.297337]                     ip6_protocol_deliver_rcu+0x27b/0x1560
[ 1733.304530]                     ip6_input_finish+0x6c/0x110
[ 1733.310753]                     ip6_input+0xd5/0x310
[ 1733.316298]                     ipv6_rcv+0x11c6/0x2400
[ 1733.322038]                     __netif_receive_skb_core+0x194a/0x3330
[ 1733.329328]                     process_backlog+0x21e/0x6b0
[ 1733.335551]                     __napi_poll+0x9f/0x520
[ 1733.341288]                     net_rx_action+0x36e/0x980
[ 1733.347317]                     __do_softirq+0x1cb/0xa4f
[ 1733.353250]                     do_softirq_own_stack+0x2a/0x40
[ 1733.359763]                     do_softirq.part.9+0x9b/0xb0
[ 1733.365988]                     __local_bh_enable_ip+0xef/0x110
[ 1733.372599]                     ip6_finish_output2+0x984/0x2340
[ 1733.379207]                     ip6_output+0x205/0x730
[ 1733.384940]                     ip6_xmit+0xc3c/0x1f60
[ 1733.390579]                     inet6_csk_xmit+0x2d0/0x4d3
[ 1733.396703]                     __tcp_transmit_skb+0x1704/0x38e0
[ 1733.403408]                     tcp_connect+0x28c5/0x3c80
[ 1733.409433]                     tcp_v6_connect+0x15ff/0x1f40
[ 1733.415752]                     __inet_stream_connect+0x64a/0xbf0
[ 1733.422554]                     inet_stream_connect+0x53/0xa0
[ 1733.428972]                     __sys_connect+0xfe/0x130
[ 1733.434900]                     __x64_sys_connect+0x6f/0xb0
[ 1733.441120]                     do_syscall_64+0xa5/0x430
[ 1733.447049]                     entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[ 1733.454529]    SOFTIRQ-ON-R at:
[ 1733.458034]                     lock_acquire+0x1b1/0x890
[ 1733.463962]                     _raw_read_lock+0x3c/0x90
[ 1733.469890]                     security_compute_av+0x6c/0xfe0
[ 1733.476401]                     avc_compute_av+0xd3/0x620
[ 1733.482425]                     avc_has_perm+0x330/0x4b0
[ 1733.488353]                     security_task_alloc+0x8d/0x140
[ 1733.494865]                     copy_process+0x1d6d/0x6410
[ 1733.500987]                     _do_fork+0x107/0xbc0
[ 1733.506527]                     kernel_thread+0x25/0x30
[ 1733.512358]                     rest_init+0x26/0x200
[ 1733.517898]                     start_kernel+0x77c/0x7ba
[ 1733.523826]                     secondary_startup_64_no_verify+0xc2/0xcb
[ 1733.531305]    INITIAL READ USE at:
[ 1733.535199]                         lock_acquire+0x1b1/0x890
[ 1733.541516]                         _raw_read_lock+0x3c/0x90
[ 1733.547833]                         security_compute_av+0x6c/0xfe0
[ 1733.554731]                         avc_compute_av+0xd3/0x620
[ 1733.561144]                         avc_has_perm+0x330/0x4b0
[ 1733.567461]                         security_task_alloc+0x8d/0x140
[ 1733.574360]                         copy_process+0x1d6d/0x6410
[ 1733.580863]                         _do_fork+0x107/0xbc0
[ 1733.586784]                         kernel_thread+0x25/0x30
[ 1733.593003]                         rest_init+0x26/0x200
[ 1733.598931]                         start_kernel+0x77c/0x7ba
[ 1733.605247]                         secondary_startup_64_no_verify+0xc2/0xcb
[ 1733.613113]  }
[ 1733.614971]  ... key      at: [<ffffffffa8844380>] __key.89897+0x0/0x40
[ 1733.622354]  ... acquired at:
[ 1733.625664]    __lock_acquire+0x21d1/0x2c60
[ 1733.630333]    lock_acquire+0x1b1/0x890
[ 1733.634613]    _raw_read_lock+0x3c/0x90
[ 1733.638894]    security_compute_av+0x6c/0xfe0
[ 1733.643756]    avc_compute_av+0xd3/0x620
[ 1733.648133]    avc_has_perm_noaudit+0x2eb/0x490
[ 1733.653190]    cred_has_capability+0x139/0x260
[ 1733.658139]    security_capable+0x58/0x90
[ 1733.662614]    has_ns_capability_noaudit+0xc7/0x1c0
[ 1733.668059]    restricted_pointer+0x18a/0x410
[ 1733.672911]    pointer+0x1de/0x700
[ 1733.676706]    vsnprintf+0x7bd/0x1250
[ 1733.680792]    seq_vprintf+0xbd/0x1a0
[ 1733.684878]    seq_printf+0x9b/0xd0
[ 1733.688771]    current_css_set_read+0x179/0x540
[ 1733.693828]    seq_read+0x408/0x1020
[ 1733.697817]    vfs_read+0xff/0x300
[ 1733.701612]    ksys_read+0xb8/0x170
[ 1733.705504]    do_syscall_64+0xa5/0x430
[ 1733.709785]    entry_SYSCALL_64_after_hwframe+0x6a/0xdf

[ 1733.717274]
               stack backtrace:
[ 1733.722140] CPU: 4 PID: 7798 Comm: read_all Kdump: loaded Not tainted 4.18.0-345.el8.x86_64+debug #1
[ 1733.732333] Hardware name: Dell Inc. PowerEdge R720/0X6FFV, BIOS 2.1.2 09/19/2013
[ 1733.740686] Call Trace:
[ 1733.743423]  dump_stack+0x8e/0xd0
[ 1733.747124]  check_irq_usage.cold.57+0x566/0x7b6
[ 1733.805114]  check_prevs_add+0x409/0x21d0
[ 1733.835277]  __lock_acquire+0x21d1/0x2c60
[ 1733.839761]  lock_acquire+0x1b1/0x890
[ 1733.865825]  _raw_read_lock+0x3c/0x90
[ 1733.874779]  security_compute_av+0x6c/0xfe0
[ 1733.888306]  avc_compute_av+0xd3/0x620
[ 1733.892494]  avc_has_perm_noaudit+0x2eb/0x490
[ 1733.907384]  cred_has_capability+0x139/0x260
[ 1733.926460]  security_capable+0x58/0x90
[ 1733.930743]  has_ns_capability_noaudit+0xc7/0x1c0
[ 1733.935997]  restricted_pointer+0x18a/0x410
[ 1733.950203]  pointer+0x1de/0x700
[ 1733.966360]  vsnprintf+0x7bd/0x1250
[ 1733.979006]  seq_vprintf+0xbd/0x1a0
[ 1733.982901]  seq_printf+0x9b/0xd0
[ 1733.990790]  current_css_set_read+0x179/0x540
[ 1733.995657]  seq_read+0x408/0x1020
[ 1733.999461]  vfs_read+0xff/0x300
[ 1734.003065]  ksys_read+0xb8/0x170
[ 1734.021070]  do_syscall_64+0xa5/0x430
[ 1734.025159]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf

The lockdep splat is caused by the fact that the debug controller use the
"%pK" format specifier to print out address of cset's with css_set_lock
held. Under some circumstances, the use of "%pK" format specifier may
acquire the selinux_ss.policy_rwlock.

To avoid this possible deadlock scenario, we have to abandon the use of
the "%pK" format specifier and just use "%p" to always hash the cset
addresses. The actual cset addresses aren't that important as long as
they are unique for matching purpose.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/debug.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..fbf7bdbae1a2 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -52,7 +52,7 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 	rcu_read_lock();
 	cset = task_css_set(current);
 	refcnt = refcount_read(&cset->refcount);
-	seq_printf(seq, "css_set %pK %d", cset, refcnt);
+	seq_printf(seq, "css_set %p %d", cset, refcnt);
 	if (refcnt > cset->nr_tasks)
 		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
 	seq_puts(seq, "\n");
@@ -129,10 +129,10 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 		 * Print out the proc_cset and threaded_cset relationship
 		 * and highlight difference between refcount and task_count.
 		 */
-		seq_printf(seq, "css_set %pK", cset);
+		seq_printf(seq, "css_set %p", cset);
 		if (rcu_dereference_protected(cset->dom_cset, 1) != cset) {
 			threaded_csets++;
-			seq_printf(seq, "=>%pK", cset->dom_cset);
+			seq_printf(seq, "=>%p", cset->dom_cset);
 		}
 		if (!list_empty(&cset->threaded_csets)) {
 			struct css_set *tcset;
@@ -141,7 +141,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 			list_for_each_entry(tcset, &cset->threaded_csets,
 					    threaded_csets_node) {
 				seq_puts(seq, idx ? "," : "<=");
-				seq_printf(seq, "%pK", tcset);
+				seq_printf(seq, "%p", tcset);
 				idx++;
 			}
 		} else {
-- 
2.18.1

