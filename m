Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF75AC8E1
	for <lists+cgroups@lfdr.de>; Mon,  5 Sep 2022 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiIECru (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 22:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIECrt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 22:47:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5D2559C;
        Sun,  4 Sep 2022 19:47:44 -0700 (PDT)
X-UUID: b5f5a10eed7d4697826513eff8415680-20220905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:Date:CC:To:From:Subject:Message-ID; bh=SPZom6e4m2DwhVGUgCYsOooFFaI6jPFzv+CbKS3SeiE=;
        b=FuOO+lR0kcjnnoOqg8R88BKGO4Ch702JrZNpT41Il53R5YqzmMyAr+YfTxwu49cWoHTsXdWSha8PM4HgtI9iKHm/3TzfysGIaTdyIwc2QGcWgD4ProghQqFVzEa8veZyYmDxGfDF9FjvAWp4XyHeBk503uTP8eNa8ZOsDzOY+CA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:ea4544cb-fa61-4382-80fd-f08e63aec98d,OB:10,
        LOB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:ea4544cb-fa61-4382-80fd-f08e63aec98d,OB:10,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:db8e2621-1c20-48a5-82a0-25f9c331906d,C
        OID:d1b7296c41ce,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: b5f5a10eed7d4697826513eff8415680-20220905
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jing-ting.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1858471057; Mon, 05 Sep 2022 10:47:37 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 5 Sep 2022 10:47:36 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 5 Sep 2022 10:47:36 +0800
Message-ID: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
Subject: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
From:   Jing-Ting Wu <jing-ting.wu@mediatek.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>
CC:     <wsd_upstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Jonathan.JMChen@mediatek.com>,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Vincent Donnefort" <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        <cgroups@vger.kernel.org>, <lixiong.liu@mediatek.com>,
        <wenju.xu@mediatek.com>
Date:   Mon, 5 Sep 2022 10:47:36 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

We meet the HANG_DETECT happened in T SW version with kernel-5.15.
Many tasks have been blocked for a long time.


Root cause:
migration_cpu_stop() is not complete due to is_migration_disabled(p) is
true, complete is false and complete_all() never get executed.
It let other task wait the rwsem.

Detail:
system_server waiting for cgroup_threadgroup_rwsem.
OomAdjuster is holding the cgroup_threadgroup_rwsem and waiting for
cpuset_rwsem.
cpuset_hotplug_workfn is holding the cpuset_rwsem and waiting for
affine_move_task() complete.
affine_move_task() waiting for migration_cpu_stop() complete.

The backtrace of system_server:
__switch_to
__schedule
schedule
percpu_rwsem_wait
__percpu_down_read
cgroup_css_set_fork => wait for cgroup_threadgroup_rwsem
cgroup_can_fork
copy_process
kernel_clone

The backtrace of OomAdjuster:
__switch_to
__schedule
schedule
percpu_rwsem_wait
percpu_down_write
cpuset_can_attach => wait for cpuset_rwsem
cgroup_migrate_execute
cgroup_attach_task
__cgroup1_procs_write => hold cgroup_threadgroup_rwsem
cgroup1_procs_write
cgroup_file_write
kernfs_fop_write_iter
vfs_write
ksys_write

The backtrace of cpuset_hotplug_workfn:
__switch_to
__schedule
schedule
schedule_timeout
wait_for_common
affine_move_task => wait for complete
__set_cpus_allowed_ptr_locked
update_tasks_cpumask
cpuset_hotplug_update_tasks => hold cpuset_rwsem
cpuset_hotplug_workfn
process_one_work
worker_thread
kthread


In affine_move_task() will call migration_cpu_stop() and wait for it
complete.
In normal case, if migration_cpu_stop() complete it will inform
everyone that he is done.
But there is an exception case that will not notify.
If is_migration_disabled(p) is true and complete will always is false,
then complete_all() never get executed.

static int migration_cpu_stop(void *data)
{
...
    bool complete = false;
...

    if (task_rq(p) == rq) {
        if (is_migration_disabled(p))
              goto out; => is_migration_disabled(p) = true,
                           so complete = false.
            ...
        }
...

out:
...
    if (complete) => complete = false,
                     so complete_all() never get executed.
        complete_all(&pending->done);

        return 0;
}


Review the code, we found that there are many places can change
is_migration_disabled() value.
(such as: __rt_spin_lock(), rt_read_lock(), rt_write_lock(), ...)

Do you have any suggestion for this issue?
Thank you.




Best regards,
Jing-Ting Wu


