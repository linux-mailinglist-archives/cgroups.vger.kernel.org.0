Return-Path: <cgroups+bounces-14841-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JUJMnIxuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14841-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 866152A83AB
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CA543058331
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D52379990;
	Tue, 17 Mar 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kwai421O"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAB367F28;
	Tue, 17 Mar 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=O9yHOVFptG7qeh1nQWdRNy4r7tfcNutwBegFN/ZndZXAWRT/sR03ye+mf1Hk7n5pTOsck5eOsQQziwazb9v7Rql6CP+vn42I8ybo3w4tX6GhGKO5JxG/36QjGWYbrhbCS9Z/4cubckijVSonzBpZ6YZYmfABBsOdZpp/8Z8nPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=RMQtBLhBRrnECy14R/UPmUDg8ctH2OwIAZ8x50M/5Zc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QRrMbv+N5h/un8thUj8/3Fsi8sYYKI7OkEyEhi2bOMhxRw0AO/VcY6wlccVv3/KS8YKntNqxkhfQY0NzFUbja0MYzdF/L84jAZwdXKqXaLR0Rf1F5LEXfP7UDBer8defhZRFLdcBa3Bjow9kLpBvDnBwiI84IkDyReWf4HMYp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kwai421O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=DHfVDiTvL7Puoc1oBq/QUXOiKwIW1u/4kXnBI0NvDWE=; b=Kwai421OCN2DDVqJxiYqjWzJ48
	PUDWWCBRMrTCjBj3f3dQnK218yXjiPNLkF1V52YPRUnJRKYixGqSoEXaYzkFBB5k1q6Wb+rc3petw
	+GqqOex8fNta1Y7qpnTY/WH9YiVXXfuoKmnJnifDDVRajqQmd8zODOYdcwzqdSEW5EXTYPsQkJb2M
	dktYFx7X0JqJuXSERsO2XUCd3+/ddfl95i6iYBLwLFFdongMRF4Lsc10GaekvkDiecjxbJEhFWKax
	Tr55DDqVTpXImP2T5MWQvMjFVvsb/9Ny7/vio3MxBpCCwgg+HEYBKqICSR5h3lGOltI9srNQdEY+B
	oFUX69gw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000002YWp-0uWV;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1736330324D; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104342.467728645@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:14 +0100
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
Subject: [RFC][PATCH 1/8] sched/debug: Collapse subsequent CONFIG_SCHED_CLASS_EXT sections
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14841-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 866152A83AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   92 ++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -445,6 +445,8 @@ static const struct file_operations fair
 	.release	= single_release,
 };
 
+static struct dentry *debugfs_sched;
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 static ssize_t
 sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
@@ -477,75 +479,92 @@ static const struct file_operations ext_
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif /* CONFIG_SCHED_CLASS_EXT */
 
 static ssize_t
-sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
-			       size_t cnt, loff_t *ppos)
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 
 	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
-					&rq->fair_server);
+					&rq->ext_server);
 }
 
-static int sched_fair_server_period_show(struct seq_file *m, void *v)
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu = (unsigned long) m->private;
 	struct rq *rq = cpu_rq(cpu);
 
-	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
 }
 
-static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
 }
 
-static const struct file_operations fair_server_period_fops = {
-	.open		= sched_fair_server_period_open,
-	.write		= sched_fair_server_period_write,
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
 
-#ifdef CONFIG_SCHED_CLASS_EXT
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 static ssize_t
-sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
-			      size_t cnt, loff_t *ppos)
+sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
 
 	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
-					&rq->ext_server);
+					&rq->fair_server);
 }
 
-static int sched_ext_server_period_show(struct seq_file *m, void *v)
+static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu = (unsigned long) m->private;
 	struct rq *rq = cpu_rq(cpu);
 
-	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
-static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
 {
-	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+	return single_open(filp, sched_fair_server_period_show, inode->i_private);
 }
 
-static const struct file_operations ext_server_period_fops = {
-	.open		= sched_ext_server_period_open,
-	.write		= sched_ext_server_period_write,
+static const struct file_operations fair_server_period_fops = {
+	.open		= sched_fair_server_period_open,
+	.write		= sched_fair_server_period_write,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-#endif /* CONFIG_SCHED_CLASS_EXT */
-
-static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
 {
@@ -568,29 +587,6 @@ static void debugfs_fair_server_init(voi
 	}
 }
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-static void debugfs_ext_server_init(void)
-{
-	struct dentry *d_ext;
-	unsigned long cpu;
-
-	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
-	if (!d_ext)
-		return;
-
-	for_each_possible_cpu(cpu) {
-		struct dentry *d_cpu;
-		char buf[32];
-
-		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
-		d_cpu = debugfs_create_dir(buf, d_ext);
-
-		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
-		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
-	}
-}
-#endif /* CONFIG_SCHED_CLASS_EXT */
-
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;



