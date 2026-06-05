Return-Path: <cgroups+bounces-16658-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NHH4N2DFImrwdQEAu9opvQ
	(envelope-from <cgroups+bounces-16658-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B966484C2
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:47:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=vQzhqwkT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16658-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16658-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B0CB3046421
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFBD3C1F36;
	Fri,  5 Jun 2026 12:43:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B838F654;
	Fri,  5 Jun 2026 12:43:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663417; cv=none; b=Qr861JOwxRGfBBC4DGeia+PQhQoTeeNPYQq9XB1qSFxIFhz6xgORoss+A/YoUo3dPKuuyxAAeDnVKScBDEw6BYmTTXQXUG1/glkbKONr2DhwWVgbav10oOI2e/rQ57PYHw3i7igFe5cYNp1lQPk1Y1f81fCcWAzFmTLGrnRQ0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663417; c=relaxed/simple;
	bh=ESn+jy1pu/UCj/USFRLlenpiPmXSDjwbSckkIfRJE50=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QL7RNfl2Shg9nPKI+fsiKV83IC0YjdeTfy21BjaxRSATu2qMz8fRivxhsCmJpnkDOpdzLLhaP7o3/g9Poo0BQc9KPmTZNY5wDzVc0yGyCrWPZwB5qOS/AV4uXvUTPevdrwQJCQ0poeNFno4QHXooOl9zqBdLhTgt2VcNXl/sDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vQzhqwkT; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=FvXbdK8gbx0YRdwnPl5AOZZaCXWHI0fEhG+nZSugnvU=; b=vQzhqwkTOdFuzD2Sb3CPz0e+2V
	RZraMv6wn6QMoL44dQzv2L9VyhKx/1JiKdROcfLKe/XJ8kXjrpAoinCuWhe6JrCLjDl4Ez2TLgvh5
	Hz3M6rkTiam+3eEOqeX/pteq/T7BYfDo59rJRj1daQk+tVseqEBh62mfJ59qVUvQ4hPvCM4A/O9ko
	CY1Buh7/r4hbWU4EQ76kXfv73aqzbhH55ypOsJE/E/SbU61+wUIvbtVhcT635DoDuWZtamrtNGKmO
	3BSWKPzPTvn0lNQktwAT3LlnmZUf1a7y/dxSXyeXArJSqug8sCIzsuhTSmGAPQZ6VM8oonFMQix5g
	49IHoNsg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVTtH-00000007val-3swD;
	Fri, 05 Jun 2026 12:43:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 24265300642; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605124051.338602724@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:14 +0200
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
Subject: [PATCH v3 1/7] sched/fair: Add cgroup_mode switch
References: <20260605105513.354837583@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16658-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:dkim,infradead.org:from_mime,infradead.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57B966484C2


The effective task weight (W_t') for a task in cgroup g on CPU n is given by:

                                 W_t
	W_t' = W_g * F_g_n * ----------
                             \Sum W_t_n

Where W_g is the group's weight (cpu.weight), F_g_n is the fraction of the
group weight for CPU n and W_t/W is the relative weight of this task against
all other tasks in the same group on the same CPU.

Furthermore, this makes:

                \Sum W_t_n
	F_g_n = ----------
	         \Sum W_t

The fraction of weight inside the group of CPU n against the whole group.

The problem is with F_g_n, the primary goal of this fraction is to make sure
that the relative weight of tasks, when distributed over CPUs is maintained.
For example, consider 4 (equal weight) tasks and 2 CPUs with a 1:3
distribution, then if F_g_n would simply be 1 (no weight re-distribution) the
effective relative weights (W_t') of the tasks in our group would be:

	CPU0	CPU1
        W_g     W_g/3
	        W_g/3
		W_g/3

IOW, the lucky task on CPU0 would get an equal amount of weight as all 3 tasks
on CPU1 combined. However, with the weight redistribution, this becomes:

	CPU0	CPU1
        W_g/4   W_g/4
	        W_g/4
		W_g/4

All tasks are equal weight (as intended). However, as is already evident from
this example, the more CPUs you add, the smaller F_g_n becomes, which creates a
disparity against tasks not in our group.

Specifically:

	avg(F_g_n) ~ 1/N

This leads to a weight mismatch in the hierarchy. IOW tasks cannot compete
fairly across hierarchy levels.

*Notably*, what is meant by avg(F_g_n) being proportional to 1/N is that when
there are at least N runnable tasks, the average of this fraction tends to 1/N.

For a hierarchy of depth d, this gets even worse, since that gets terms on the
order of:

	avg(F_g_n)^d ~ 1/(N^d)

Given fixed point arithmetic, this also leads to numerical trouble.

However, the meaning of "cpu.weight" is simple and intiutive: the total weight
of the cgroup. But as explored above, there is deception in this simplicity.

Prepare to add a few alternative methods for distributing weight.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -633,6 +633,76 @@ static void debugfs_fair_server_init(voi
 	}
 }
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static int cgroup_mode = 0;
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
+	if (copy_from_user(buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+	mode = sched_cgroup_mode(strstrip(buf));
+	if (mode < 0)
+		return mode;
+
+	WRITE_ONCE(cgroup_mode, mode);
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static int sched_cgroup_show(struct seq_file *m, void *v)
+{
+	int mode = READ_ONCE(cgroup_mode);
+
+	for (int i = 0; i < ARRAY_SIZE(cgroup_mode_str); i++) {
+		if (mode == i)
+			seq_puts(m, "(");
+		seq_puts(m, cgroup_mode_str[i]);
+		if (mode == i)
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
 	struct dentry __maybe_unused *numa, *llc;
@@ -686,6 +756,10 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	debugfs_create_file("cgroup_mode", 0644, debugfs_sched, NULL, &sched_cgroup_fops);
+#endif
+
 	debugfs_fair_server_init();
 #ifdef CONFIG_SCHED_CLASS_EXT
 	debugfs_ext_server_init();



