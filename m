Return-Path: <cgroups+bounces-15751-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL+gIpvGAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15751-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A66450D563
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 858063014272
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F83A0EB3;
	Mon, 11 May 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gBY4cj+a"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2837B027;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501244; cv=none; b=PC1+uHjURijoQNir9l1V8mkidgUAXk7XB4ZfrQejcaw2QIINSQQOQT9DdDd1ZxZ8UZigraBFqbvC+5XffMz36QtbSlLCpRgwEXB8pJ/xNvxOK/ZH+U8tsuc5/pox+8FlbfsCysJ30ExKD5yh55NwxgXGKMx++2kBTzjSTSwkFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501244; c=relaxed/simple;
	bh=k+pTtIaHnkTkTKHeFxbxviXAACzwjbCoERO6tUUG+L4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BwWsdaa1q8ipBpFpYdLCBEHM9zc/LnPABQVV0JtjP6aQ+Hgi7uNA69CqVNbyu3ItXBgNfNr5g7zC3IO+mFTnnneZkB4kNYu0BsfnWANK2+KqQxTHI815bcDAZZlmVDWU7ijLcon/F9I5qkKNyY5Q2hsXQoOk+IGjxeFDSFcJ808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gBY4cj+a; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MfDnJaDuHfmTlNlHQofhOK4P8wdrC5bwkWlHclTuFTk=; b=gBY4cj+ak1BsL/7h5Ll8ILYeyr
	LQ+5eLAL94kuEJGQR8z7kueUciFt3VwRvPVBw6tKdlCa27U1O0KuYgthD2kqPWf3dGXlVM62MEW3d
	+alW+Np1TRPkSd7SSAQFOazSgTGqOah7RWvUyWkL8LwcEkLbqkGDq52JN7mnyzpA7hd+NTES5oPI2
	QkmJSFzxuEJRzj/PiQeMRsVKiizI+wsbkgGrhsNAQpqZcz2jWZxAjFjfhVbpDMXXmQQzV8CQ5xaC5
	Oep7vldSjmb+h+oRCh6x5p3wGFoIm5JVY07Bm+N9hF+OCMY6uC9xKId0RVn5/sR6vB5DA9+c6mkRU
	UmCDD5hA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPZ-0000000BZMR-1yZd;
	Mon, 11 May 2026 12:07:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 1702B302F8E; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.281160085@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:07 +0200
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
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v2 03/10] sched/debug: Collapse subsequent CONFIG_SCHED_CLASS_EXT sections
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 3A66450D563
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15751-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   92 ++++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 48 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -446,6 +446,8 @@ static const struct file_operations fair
 	.release	= single_release,
 };
 
+static struct dentry *debugfs_sched;
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 static ssize_t
 sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
@@ -478,75 +480,92 @@ static const struct file_operations ext_
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
@@ -569,29 +588,6 @@ static void debugfs_fair_server_init(voi
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



