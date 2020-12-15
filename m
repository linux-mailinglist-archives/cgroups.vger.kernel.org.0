Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004662DA826
	for <lists+cgroups@lfdr.de>; Tue, 15 Dec 2020 07:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgLOGho (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Dec 2020 01:37:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9612 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLOGho (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Dec 2020 01:37:44 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cw7nc2Z8yz15fYx;
        Tue, 15 Dec 2020 14:36:20 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 15 Dec 2020 14:36:48 +0800
From:   chenzhou <chenzhou10@huawei.com>
Subject: [QUESTION] Dying cgroups in subsystem cpu, pids and named hierarchy
 systemd
To:     Tejun Heo <tj@kernel.org>, <lizefan@huawei.com>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>
Message-ID: <35659595-5a3f-e0e4-1f61-15af6f1367e3@huawei.com>
Date:   Tue, 15 Dec 2020 14:36:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

When i do some tests with kernel-4.19.x，i found some dying cgroups.

There are dying cgroup in subsystem cpu/cpuacct, memory, pids and named hierarchy systemd.

The root cause of dying cgroups in memory subsystem is that some charged pages aren't gone.

I don't figure out why there are dying cgroup in cpu, pids and named hierarchy systemd.

I used to turn on/off Delegate and do operation "systemctl daemon-reload" in the machine,

but now can't reproduce it.

Is this normal and what may cause this or any suggestions about this?


The details about the machine with problem is as below:
# mount -t cgroup
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,pids)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,memory)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,blkio)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,devices)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,perf_event)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,rdma)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,freezer)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,net_cls,net_prio)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,cpuset)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,seclabel,hugetlb)
memory on /cgroup/memory type cgroup (rw,relatime,seclabel,memory)
cpu,cpuacct on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,relatime,seclabel,cpu,cpuacct)

# cat /proc/cgroups
#subsys_name    hierarchy    num_cgroups    enabled
cpuset    12    109    1
cpu    10    110    1
cpuacct    10    110    1
blkio    4    109    1
memory    3    2571    1
devices    5    109    1
freezer    9    109    1
net_cls    11    1    1
perf_event    6    1    1
net_prio    11    1    1
hugetlb    13    1    1
pids    2    480    1
...

# crash vmlinux /proc/kcore
crash> list cgroup_roots
ffff000081272558
...

list -H ffff000081272558 -s cgroup_root.subsys_mask,hierarchy_id,cgrp.nr_dying_descendants -l cgroup_root.root_list
ffff8007ff67c6f8        // cpu,cpuacct
  subsys_mask = 6
  hierarchy_id = 10
  cgrp.nr_dying_descendants = 1,
...
ffff8007ff6726f8        // memory
  subsys_mask = 16
  hierarchy_id = 3
  cgrp.nr_dying_descendants = 2036,
ffff800fb579c6f8        // pids
  subsys_mask = 2048
  hierarchy_id = 2
  cgrp.nr_dying_descendants = 1,
ffff800fb57986f8        // named systemd
  subsys_mask = 0
  hierarchy_id = 1
  cgrp.nr_dying_descendants = 1,
...


For the cpu subsystem, the dying cgroup is /sys/fs/cgroup/cpu/user.slice:

crash> p root_task_group.css.cgroup
$4 = (struct cgroup *) 0xffff8007ff67c010
crash> cgroup_subsys_state ffff8007ff67c010 -ox
struct cgroup_subsys_state {
  [ffff8007ff67c010] struct cgroup *cgroup;
  [ffff8007ff67c018] struct cgroup_subsys *ss;
  [ffff8007ff67c020] struct percpu_ref refcnt;
  [ffff8007ff67c058] struct list_head sibling;
  [ffff8007ff67c068] struct list_head children;
  [ffff8007ff67c078] struct list_head rstat_css_node;
  [ffff8007ff67c088] int id;
  [ffff8007ff67c08c] unsigned int flags;
  [ffff8007ff67c090] u64 serial_nr;
  [ffff8007ff67c098] atomic_t online_cnt;
  [ffff8007ff67c0a0] struct work_struct destroy_work;
  [ffff8007ff67c0e0] struct rcu_work destroy_rwork;
  [ffff8007ff67c138] struct cgroup_subsys_state *parent;
}
SIZE: 0x130
crash> list -H ffff8007ff67c068 -s cgroup_subsys_state.cgroup -l cgroup_subsys_state.sibling
ffff800faff65848
  cgroup = 0xffff800faff65800
ffff800fa18b1048
  cgroup = 0xffff800fa18b1000
ffff800fa22c0848
  cgroup = 0xffff800fa22c0800
ffff800fa940e048
  cgroup = 0xffff800fa940e000
crash>
crash> cgroup.self.refcnt,flags,kn 0xffff800fa18b1000 -x
  self.refcnt = {
    count = {
      counter = 0x3
    },
    percpu_count_ptr = 0xfffefdf041334c83,
    release = 0xffff0000801c1ea0 <css_release>,
    confirm_switch = 0x0,
    force_atomic = 0x0,
    rcu = {
      next = 0xffff80083365da30,
      func = 0xffff0000804fb748 <percpu_ref_switch_to_atomic_rcu>
    }
  },
  flags = 0x0
  kn = 0xffff800bbdb1b110
crash>
crash> kernfs_node.name 0xffff800bbdb1b110
  name = 0xffff800fa54d9c00 "user.slice"


Thanks,

Chen Zhou

