Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAE492ECE
	for <lists+cgroups@lfdr.de>; Tue, 18 Jan 2022 20:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiART5X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 18 Jan 2022 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbiART5W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 18 Jan 2022 14:57:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EFAC061574
        for <cgroups@vger.kernel.org>; Tue, 18 Jan 2022 11:57:22 -0800 (PST)
Date:   Tue, 18 Jan 2022 20:57:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642535839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekB+1/vJxKtPMPKgiG7Ixi8Eki0Fc2E/bH0E5cSRR1U=;
        b=fHbWgepw/aDQjBLvnCI80P8N8EsYANtaojRx+/2VtR2gTR96Znt6hFYewAfcs4Cgi60vhg
        OAKzIpQyKV22TsLsIYGs+OtmNWqM6tFcgBNpBZ1xZoREsQhx9zo1thIl71HhSu97f0Sn2D
        30C4qXVtet1nPP2RmbxVLJmrk8bc9qXqe92BxzP3qhexJisiADg8HX0JtMy4QQ5hTVych7
        hV2qt/+L1CANDPUWnDb76dbxNEyhcneBAe7MmNoma6GdFuOmwHGwn00sseFz+refXsyBnz
        yWtege5K79p81K9pBAyGfwY0MZ5R3ffsaioyn8nif07fUHPYDuTaIjI82FX3yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642535839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekB+1/vJxKtPMPKgiG7Ixi8Eki0Fc2E/bH0E5cSRR1U=;
        b=JSgnI20eM18xM0ejtTlxLGa5wEIFBRjVgZdESG86vOupEzU6H4EPwN/ilnrRzKM04mVLQo
        3sFvJfzJRcZJdvAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-mm@kvack.org, longman@redhat.com,
        mhocko@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        vdavydov.dev@gmail.com
Subject: Re: [PATCH] mm/memcg: Do not check v1 event counter when not needed
Message-ID: <YecbnYDuBXgAjPs1@linutronix.de>
References: <YeE9zyUokSY9L2ZI@linutronix.de>
 <20220118182600.15007-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220118182600.15007-1-mkoutny@suse.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-01-18 19:26:00 [+0100], Michal Koutn=C3=BD wrote:
> I think it would make sense inserting the patch into your series and
> subsequently reject enabling on PREEMPT_RT -- provided this patch makes s=
ense
> to others too -- the justification is rather functionality splitting for
> this PREEMPT_RT effort.

Interesting. So while looking at this today I came up with the patch at
the bottom. The other things I had looked way uglier and then since
nobody probably will use it=E2=80=A6
Let me know how you want it to be integrated.

------>8------

=46rom: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 18 Jan 2022 17:28:07 +0100
Subject: [PATCH] mm/memcg: Disable threshold event handlers on PREEMPT_RT
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

During the integration of PREEMPT_RT support, the code flow around
memcg_check_events() resulted in `twisted code'. Moving the code around
and avoiding then would then lead to an additional local-irq-save
section within memcg_check_events(). While looking better, it adds a
local-irq-save section to code flow which is usually within an
local-irq-save block.

The threshold event handler is a deprecated memcg v1 feature. Instead of
trying to get it to work under PREEMPT_RT just disable it. There should
have not been any users on PREEMPT_RT. From that perspective makes it
even less sense to get it to work under PREEMPT_RT while having zero
users.

Make memory.soft_limit_in_bytes and cgroup.event_control return
-EOPNOTSUPP on PREEMPT_RT. Make memcg_check_events() empty on PREEMPT_RT
since it won't do anything. Document that the two knobs are disabled on
PREEMPT_RT.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 ++
 mm/memcontrol.c                                | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation=
/admin-guide/cgroup-v1/memory.rst
index faac50149a222..2cc502a75ef64 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -64,6 +64,7 @@ Brief summary of control files.
 				     threads
  cgroup.procs			     show list of processes
  cgroup.event_control		     an interface for event_fd()
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.usage_in_bytes		     show current usage for memory
 				     (See 5.5 for details)
  memory.memsw.usage_in_bytes	     show current usage for memory+Swap
@@ -75,6 +76,7 @@ Brief summary of control files.
  memory.max_usage_in_bytes	     show max memory usage recorded
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't=
 be
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ed5f2a0879d3..3c4f7a0fd0039 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -821,6 +821,7 @@ static void mem_cgroup_charge_statistics(struct mem_cgr=
oup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
@@ -864,6 +865,9 @@ static void memcg_check_events(struct mem_cgroup *memcg=
, int nid)
 			mem_cgroup_update_tree(memcg, nid);
 	}
 }
+#else
+static void memcg_check_events(struct mem_cgroup *memcg, int nid) { }
+#endif
=20
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
@@ -3751,8 +3755,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_f=
ile *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
+#ifndef CONFIG_PREEMPT_RT
 		memcg->soft_limit =3D nr_pages;
 		ret =3D 0;
+#else
+		ret =3D -EOPNOTSUPP;
+#endif
 		break;
 	}
 	return ret ?: nbytes;
@@ -4717,6 +4725,7 @@ static void memcg_event_ptable_queue_proc(struct file=
 *file,
 static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 					 char *buf, size_t nbytes, loff_t off)
 {
+#ifndef CONFIG_PREEMPT_RT
 	struct cgroup_subsys_state *css =3D of_css(of);
 	struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
 	struct mem_cgroup_event *event;
@@ -4843,6 +4852,9 @@ static ssize_t memcg_write_event_control(struct kernf=
s_open_file *of,
 	kfree(event);
=20
 	return ret;
+#else
+	return -EOPNOTSUPP;
+#endif
 }
=20
 static struct cftype mem_cgroup_legacy_files[] =3D {
--=20
2.34.1

