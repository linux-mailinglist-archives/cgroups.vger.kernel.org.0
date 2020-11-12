Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3D2B0B28
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 18:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgKLRTx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 12:19:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:51736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKLRTx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Nov 2020 12:19:53 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHAHnB098144;
        Thu, 12 Nov 2020 17:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=hnDD1OaQV3/V8O1ynyyI2YtOMS2gUFD+PHh5569AHdU=;
 b=c+g4DiulHXt6cLuxrGOTiFnhu599gnVJ4zGqJorgNZUGZ7m9DLJ7IsR9FKMpoUUELtR8
 12009ufC3nTNZLL/laGPiJb3UsbMPyEWfN6ay9ZMd6vHkCg3+EeNaM+nNvUJoT2yRZ41
 3PyI7WaA0T7m4oAzhh+udcf0MXU5a42Gr0VXoRBO448N3sHijXqMKZqfjV365J0ImnGU
 idLGR5gXurtX/b09ALrF12VkACh4KxCliGVp2qTZpeoxtbls5NqNcIben7ZZxhzLu1V4
 8QAoX3ns6RSoofmOnQ2tgE61VPSBUGZQUaoDU0aXM7toqsW88/ZirIOizcr60rTOPxKV RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhm6jf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 17:19:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACHBRkl142898;
        Thu, 12 Nov 2020 17:17:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34rt56ct7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 17:17:25 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ACHHKMa016619;
        Thu, 12 Nov 2020 17:17:20 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 09:17:19 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Prateek Sood <prsood@codeaurora.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v2] cpuset: fix race between hotplug work and later CPU offline
Date:   Thu, 12 Nov 2020 12:17:11 -0500
Message-Id: <20201112171711.639541-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120101
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

One of our machines keeled over trying to rebuild the scheduler domains.
Mainline produces the same splat:

  BUG: unable to handle page fault for address: 0000607f820054db
  CPU: 2 PID: 149 Comm: kworker/1:1 Not tainted 5.10.0-rc1-master+ #6
  Workqueue: events cpuset_hotplug_workfn
  RIP: build_sched_domains
  Call Trace:
   partition_sched_domains_locked
   rebuild_sched_domains_locked
   cpuset_hotplug_workfn

It happens with cgroup2 and exclusive cpusets only.  This reproducer
triggers it on an 8-cpu vm and works most effectively with no
preexisting child cgroups:

  cd $UNIFIED_ROOT
  mkdir cg1
  echo 4-7 > cg1/cpuset.cpus
  echo root > cg1/cpuset.cpus.partition

  # with smt/control reading 'on',
  echo off > /sys/devices/system/cpu/smt/control

RIP maps to

  sd->shared = *per_cpu_ptr(sdd->sds, sd_id);

from sd_init().  sd_id is calculated earlier in the same function:

  cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
  sd_id = cpumask_first(sched_domain_span(sd));

tl->mask(cpu), which reads cpu_sibling_map on x86, returns an empty mask
and so cpumask_first() returns >= nr_cpu_ids, which leads to the bogus
value from per_cpu_ptr() above.

The problem is a race between cpuset_hotplug_workfn() and a later
offline of CPU N.  cpuset_hotplug_workfn() updates the effective masks
when N is still online, the offline clears N from cpu_sibling_map, and
then the worker uses the stale effective masks that still have N to
generate the scheduling domains, leading the worker to read
N's empty cpu_sibling_map in sd_init().

rebuild_sched_domains_locked() prevented the race during the cgroup2
cpuset series up until the Fixes commit changed its check.  Make the
check more robust so that it can detect an offline CPU in any exclusive
cpuset's effective mask, not just the top one.

Fixes: 0ccea8feb980 ("cpuset: Make generate_sched_domains() work with partition")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prateek Sood <prsood@codeaurora.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---

v2:
 - Made the comment more descriptive (Peter)

 kernel/cgroup/cpuset.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57b5b5d0a5fd..53c70c470a38 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -983,25 +983,48 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  */
 static void rebuild_sched_domains_locked(void)
 {
+	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
+	struct cpuset *cs;
 	int ndoms;
 
 	lockdep_assert_cpus_held();
 	percpu_rwsem_assert_held(&cpuset_rwsem);
 
 	/*
-	 * We have raced with CPU hotplug. Don't do anything to avoid
+	 * If we have raced with CPU hotplug, return early to avoid
 	 * passing doms with offlined cpu to partition_sched_domains().
-	 * Anyways, hotplug work item will rebuild sched domains.
+	 * Anyways, cpuset_hotplug_workfn() will rebuild sched domains.
+	 *
+	 * With no CPUs in any subpartitions, top_cpuset's effective CPUs
+	 * should be the same as the active CPUs, so checking only top_cpuset
+	 * is enough to detect racing CPU offlines.
 	 */
 	if (!top_cpuset.nr_subparts_cpus &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
-	if (top_cpuset.nr_subparts_cpus &&
-	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		return;
+	/*
+	 * With subpartition CPUs, however, the effective CPUs of a partition
+	 * root should be only a subset of the active CPUs.  Since a CPU in any
+	 * partition root could be offlined, all must be checked.
+	 */
+	if (top_cpuset.nr_subparts_cpus) {
+		rcu_read_lock();
+		cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
+			if (!is_partition_root(cs)) {
+				pos_css = css_rightmost_descendant(pos_css);
+				continue;
+			}
+			if (!cpumask_subset(cs->effective_cpus,
+					    cpu_active_mask)) {
+				rcu_read_unlock();
+				return;
+			}
+		}
+		rcu_read_unlock();
+	}
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);

base-commit: 3d5e28bff7ad55aea081c1af516cc1c94a5eca7d
-- 
2.29.2

