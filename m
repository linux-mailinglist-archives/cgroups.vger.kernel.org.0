Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B629F3FD
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 19:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgJ2STv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 14:19:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42114 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgJ2STu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 14:19:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TI8vi6003566;
        Thu, 29 Oct 2020 18:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=iNGPvF8/9u1VENKAf/0lRqv0Owyx1NTKc6e+z/kqLZA=;
 b=FtG7u9GqPU2aakXwrqs8SJex4rCTkubxZN4XBElCVj0iDfgxsIpuX28WNYosE5sBYI03
 F5te5oA65g5Y3+Fgm9x/JxjgxIvp+k5eE+vHF66RkQhSk6d5cMiBex+4ndrDng1rXz9y
 pwoUiQdHEFMk+QdAgBvoD0f8tvTTNcKWuE39TBcKsTkctglpMw3GBxebwtN+b307TsfC
 9VWICPuoeZ4JVTk0ympcDbJ9WbCvyCPnMqReVVdHRCb2jlSonbog4aROtxZwiDLs8HWm
 +9VqwvDO7O6gaE7w9UZuAKk7pWtAHOXpDy8nK2ZpTLltn4ZEw5pXe+mFCM4EE7moGrwS Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm4bxt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 18:18:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TIAVoE072256;
        Thu, 29 Oct 2020 18:18:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1thkga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 18:18:53 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TIIo9C008219;
        Thu, 29 Oct 2020 18:18:50 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 11:18:50 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Prateek Sood <prsood@codeaurora.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH] cpuset: fix race between hotplug work and later CPU offline
Date:   Thu, 29 Oct 2020 14:18:45 -0400
Message-Id: <20201029181845.415517-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9789 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290127
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

I think the right thing to do long-term is make the hotplug work
synchronous, fixing the lockdep splats of past attempts, and then take
these checks out of rebuild_sched_domains_locked, but this fixes the
immediate issue and is small enough for stable.  Open to suggestions.

Prateek, are you planning on picking up your patches again?

 kernel/cgroup/cpuset.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57b5b5d0a5fd..ac3124010b2a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -983,8 +983,10 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  */
 static void rebuild_sched_domains_locked(void)
 {
+	struct cgroup_subsys_state *pos_css;
 	struct sched_domain_attr *attr;
 	cpumask_var_t *doms;
+	struct cpuset *cs;
 	int ndoms;
 
 	lockdep_assert_cpus_held();
@@ -999,9 +1001,21 @@ static void rebuild_sched_domains_locked(void)
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
 		return;
 
-	if (top_cpuset.nr_subparts_cpus &&
-	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		return;
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

base-commit: 23859ae44402f4d935b9ee548135dd1e65e2cbf4
-- 
2.29.0

