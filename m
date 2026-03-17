Return-Path: <cgroups+bounces-14839-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD8jCVwxuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14839-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:47:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D50A42A8361
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC54301BDF3
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09D375ABC;
	Tue, 17 Mar 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAXxdJth"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49E35E94E;
	Tue, 17 Mar 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=pITqLtcH0vgFzpDvDwXdAsl2KVGnbo1y3p7ejnTCCpcQKRZbXAXZ5KbOIaUIOKB25/GiVlqN/gRvVxZf2zifCkM6xjcqEDH3T2ejcZjS1R/lpZXxhhcl1u/u8hVAIdnLgvyYzfyB1T7kso/sbcLvBKkF8nukXgbLA2uKOeqDhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=T27qzyYKG+E+ydXlU0Bgzv3ItERcVEWJQYTBrn4Bt90=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fPF7vBlhKVZBvtmR4MRbPTrYZjdjXlKrMY3tIJcdaVreVmS4nwKD1ogwrk8BkqmRAyZZll67ODdz5jQSBRihVbrbY5SAYCKxPdwXorAadJx9K5zs0PMYkwnuA9hZKWt4ti6o+8wq16+2vLCFeNm7p2E844fYtbzmbedp0/7ygU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HAXxdJth; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mdpH7IA9Zx1EXuFvTkkIpM3Kmg8UyMcBxa7Jp5moBW0=; b=HAXxdJthVVUwMkMB68l4lpUB/a
	N4ynQzE2vAY9TY9TUsH5HAegffHP9xL3ui6oDIXpSVOIgGecK4yfxnCjQ4j6l9G6RieT6FXJsZUtH
	3j19ALUoGpOSGEY85C8yJvIu7heRW/4XF6+6ttk9zjILvzpMn1ZuQLMaca0KJC13561ZWkbK2plEq
	GHAfCEo5IBdeoGtiPMuByvoKy5F3ZT5FVgFWLMCyrZ/DvpQrZVif2yqV5TzJhrautIWisZqoPp2GH
	2wsBo1oQQ/999ZKymRwPf+ErDQAUzVCe/TXQSStg5/0S2kbHH/heEdycn3g1NoF/CwRMDEEbWqzPM
	RqNU42mg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000002YWr-0uWy;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1D2DA30325A; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104342.586950604@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 2/8] sched/fair: Add cgroup_mode switch
References: <20260317095113.387450089@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14839-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:email,infradead.org:mid]
X-Rspamd-Queue-Id: D50A42A8361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since calc_group_shares() has issues with 'many' CPUs, specifically the
computed shares value gets to be roughly 1/nr_cpus, prepare to add a few
alternative methods.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |    1 
 2 files changed, 73 insertions(+)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -587,6 +587,74 @@ static void debugfs_fair_server_init(voi
 	}
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+int cgroup_mode = 0;
+
+static const char *cgroup_mode_str[] = {
+	"smp",
+};
+
+static int sched_cgroup_mode(const char *str)
+{
+	for (int i = 0; i < ARRAY_SIZE(cgroup_mode_str); i++) {
+		if (!strcmp(str, cgroup_mode_str[i]))
+			return i;
+	}
+	return -EINVAL;
+}
+
+static ssize_t sched_cgroup_write(struct file *filp, const char __user *ubuf,
+				   size_t cnt, loff_t *ppos)
+{
+	char buf[16];
+	int mode;
+
+	if (cnt > 15)
+		cnt = 15;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_cgroup_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	cgroup_mode = mode;
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_cgroup_show(struct seq_file *m, void *v)
+{
+	for (int i = 0; i < ARRAY_SIZE(cgroup_mode_str); i++) {
+		if (cgroup_mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, cgroup_mode_str[i]);
+		if (cgroup_mode == i)
+			seq_puts(m, ")");
+
+		seq_puts(m, " ");
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int sched_cgroup_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_cgroup_show, NULL);
+}
+
+static const struct file_operations sched_cgroup_fops = {
+	.open		= sched_cgroup_open,
+	.write		= sched_cgroup_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -624,6 +692,10 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	debugfs_create_file("cgroup_mode", 0444, debugfs_sched, NULL, &sched_cgroup_fops);
+#endif
+
 	debugfs_fair_server_init();
 #ifdef CONFIG_SCHED_CLASS_EXT
 	debugfs_ext_server_init();
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -565,6 +565,7 @@ static inline struct task_group *css_tg(
 extern int tg_nop(struct task_group *tg, void *data);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+extern int cgroup_mode;
 extern void free_fair_sched_group(struct task_group *tg);
 extern int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent);
 extern void online_fair_sched_group(struct task_group *tg);



