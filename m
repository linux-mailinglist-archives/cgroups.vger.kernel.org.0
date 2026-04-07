Return-Path: <cgroups+bounces-15178-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I4cJ+9Y1GkrtQcAu9opvQ
	(envelope-from <cgroups+bounces-15178-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 03:07:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C83A894F
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 03:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 916A230071D6
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825D1C8603;
	Tue,  7 Apr 2026 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rt0rhBdV"
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D471A9FB0;
	Tue,  7 Apr 2026 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524073; cv=none; b=f+z+UgOhm5MmGgn58XC8MJFAZd4Tn44lPzGuSkGYO91oavhT9DjcxHpT4NPCW8M2Luon4i1zdj5f2KTQc+SBQsuEolnZx4w6Zklm5Qa7GrIVjzCHgUF8sKPwtd7hKWcdtnsvO4Q6H/aJ/Ypmo19rUme+IQx8vDzWyvPOBsfctPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524073; c=relaxed/simple;
	bh=mfAgd54s/h1ICwrQqLGafvBK66JUCbAVdoH2zv42efQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vBC6KAO+Q/JoI20SHYub0L5CUvpGc1GFhipOiYMUAiPyd+RFhxTNTMNIjCwUkyx0Tc1uPHV8n8J6fnkvKGb6HMTWTddhRejUJqgghipDcWkJv29uCes3OcaFljioCSOOqQep29bRHg0sQIFpxJSk/8qKDh0+z4pwTfAzaqSra8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rt0rhBdV; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775524072; x=1807060072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=co6wh8FdcwJFRSY1XyBB43ALGdvZ6Z0Vl5vtqguZSls=;
  b=Rt0rhBdVF6fehU3YWkccSqOJWLAy9UEsKwPS+0lgxRlsnvGzthjrETwQ
   JpkxB5mshwybM/U5Q8XuOsJSXbbDH4yK9mucG9qYEKDzAcbaKe9F9e9vq
   tVxcJgsLkaiB0t1cBpSQkcTnXKgXh0zuN07BkTSZTBfR3sWh4v2MJhGDp
   ugzTCGZv3V/P6WaKMiMpX7ILxrt+vb2KePdQ58OvmVnQXefqhOV9NrjUw
   AN5fqBfMuZJ/6k36H4M6upvBl/rS/qz/M9rpDhc6podEGG59JvadV04KW
   kiXALjjNw9wJd5oXNPC41xdpEO43HeK57hdWdz669MISYBcGUmFhYWPUf
   A==;
X-CSE-ConnectionGUID: tjOOPnVaSo+Bkz85Dbc1gg==
X-CSE-MsgGUID: W3GVGG+9SM28omMKa4GH8Q==
X-IronPort-AV: E=Sophos;i="6.23,164,1770595200"; 
   d="scan'208";a="16482096"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 01:07:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:18836]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.195:2525] with esmtp (Farcaster)
 id d439e589-ddbd-46ae-bf14-06f8af17c3d4; Tue, 7 Apr 2026 01:07:49 +0000 (UTC)
X-Farcaster-Flow-ID: d439e589-ddbd-46ae-bf14-06f8af17c3d4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 01:07:49 +0000
Received: from 6c7e67b75e78.amazon.com (10.187.171.24) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 01:07:49 +0000
From: Willy Barro Raffel <willybar@amazon.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Willy Barro Raffel
	<willybar@amazon.com>
CC: Justinien Bouron <jbouron@amazon.com>, Gunnar Kudrjavets
	<gunnarku@amazon.com>
Subject: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Date: Mon, 6 Apr 2026 18:06:43 -0700
Message-ID: <20260407010642.3249-2-willybar@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15178-lists,cgroups=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[willybar@amazon.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B5C83A894F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Expose per-CPU subtree_bstat via a new cgroupfs file cpu.stat.percpu.
Each line shows one CPU cumulative stats in io.stat-style key=value
format:

  cpu0 usage_usec=123 user_usec=45 system_usec=78 nice_usec=0
  cpu1 usage_usec=456 user_usec=123 system_usec=333 nice_usec=0

This completes the interface left as a TODO in commit 7716f383a583
("Merge tag 'cgroup-for-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
which added per-CPU subtree_bstat but only exposed it via BPF/drgn.

Signed-off-by: Willy Barro Raffel <willybar@amazon.com>
Reviewed-by: Justinien Bouron <jbouron@amazon.com>
Reviewed-by: Gunnar Kudrjavets <gunnarku@amazon.com>
---
 kernel/cgroup/cgroup-internal.h |  1 +
 kernel/cgroup/cgroup.c          | 10 +++++++++
 kernel/cgroup/rstat.c           | 36 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 3bfe37693d68..28aff03975f2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -277,6 +277,7 @@ int css_rstat_init(struct cgroup_subsys_state *css);
 void css_rstat_exit(struct cgroup_subsys_state *css);
 int ss_rstat_init(struct cgroup_subsys *ss);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
+void cgroup_base_stat_cputime_show_percpu(struct seq_file *seq);
 
 /*
  * namespace.c
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be1d71dda317..652fae15d7c5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3968,6 +3968,12 @@ static int cpu_local_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+
+static int cpu_percpu_stat_show(struct seq_file *seq, void *v)
+{
+	cgroup_base_stat_cputime_show_percpu(seq);
+	return 0;
+}
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
@@ -5499,6 +5505,10 @@ static struct cftype cgroup_base_files[] = {
 		.name = "cpu.stat.local",
 		.seq_show = cpu_local_stat_show,
 	},
+	{
+		.name = "cpu.stat.percpu",
+		.seq_show = cpu_percpu_stat_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 150e5871e66f..f1aaed87180c 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -743,6 +743,42 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &bstat);
 }
 
+
+void cgroup_base_stat_cputime_show_percpu(struct seq_file *seq)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	int cpu;
+
+	css_rstat_flush(&cgrp->self);
+
+	for_each_possible_cpu(cpu) {
+		struct cgroup_rstat_base_cpu *rstatbc;
+		struct cgroup_base_stat bstat;
+		unsigned int seq_cnt;
+
+		/* Reacquire for each CPU to avoid disabling IRQs too long */
+		__css_rstat_lock(&cgrp->self, cpu);
+		rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
+		do {
+			seq_cnt = __u64_stats_fetch_begin(&rstatbc->bsync);
+			bstat = rstatbc->subtree_bstat;
+		} while (__u64_stats_fetch_retry(&rstatbc->bsync, seq_cnt));
+		__css_rstat_unlock(&cgrp->self, cpu);
+
+		do_div(bstat.cputime.sum_exec_runtime, NSEC_PER_USEC);
+		do_div(bstat.cputime.utime, NSEC_PER_USEC);
+		do_div(bstat.cputime.stime, NSEC_PER_USEC);
+		do_div(bstat.ntime, NSEC_PER_USEC);
+
+		seq_printf(seq, "cpu%d usage_usec=%llu user_usec=%llu system_usec=%llu nice_usec=%llu\n",
+			   cpu,
+			   bstat.cputime.sum_exec_runtime,
+			   bstat.cputime.utime,
+			   bstat.cputime.stime,
+			   bstat.ntime);
+	}
+}
+
 /* Add bpf kfuncs for css_rstat_updated() and css_rstat_flush() */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
 BTF_ID_FLAGS(func, css_rstat_updated)
-- 
2.50.1 (Apple Git-155)


