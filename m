Return-Path: <cgroups+bounces-17642-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkOnLNtpUGoHygIAu9opvQ
	(envelope-from <cgroups+bounces-17642-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38465737081
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FOw3hfY3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17642-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17642-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60D4B3027951
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5B367F48;
	Fri, 10 Jul 2026 03:29:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE9367B73
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654198; cv=none; b=F8nB/uo+SZE0E3T1VpsiiZ9ZCTGfJMuyAm+r98dnLusdjeuYzwy8vqLhOYEBLPqR0mM8Ee/BNcaJfL0URLzEi8TaFgWzjL0p9ItrseI298JfLSb5tv8ko3K/0K2TiyKj6lHGl6gI56s39+tCHsH8P7Yk6dBbpwvyO1VIQYBtTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654198; c=relaxed/simple;
	bh=MNtb2Qrr3nNt+ub4rjVucp13CHEPWughXQYJLAqNpy4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a2HAQ44ba/ynskx+08HJY2HfFVOqM0/Y8EyA1Xn8ItGWlxiqJGML0sOPtbOp5g+BhgbtP4WrDqlKTCYblyxzCr/SdxwkwOqKAW3Z9YVTVoKUkh2HNgaEq64fIN1ymjC7QYU/3xljgg2rj86loAdMBhmKZ0juhqfO7Y8LcLAnfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOw3hfY3; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c7c61b5292so7034635ad.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654197; x=1784258997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cx1US55ZcQE2IXAHU74DmTXGa2F7H+sEKzQcFe01wfY=;
        b=FOw3hfY3Oj5i9E3RdC0nhn5AdEWFb5cLVgRgArGb4bb6kp/M6RdpixAkzx0OUPJDS/
         OCzD2dxGCeiV1VB4CXInwLgPPekz+xhtXDl4y2+YmSa5pu0nmL8y3IIK72XOV5kZDmln
         Utgz1Mii77S2ODs5veYjNP1vVJpupanprFN5EE7ZUg4o85bOuNpcpiMghscP5Ijsz71E
         rXtG6SZTWDTNwYG77d3fQGou5JIQZ8OqqhKiRxQ/0WaXggRpIzvnSYDPbftCBkkPlogi
         9Utiz4nYmMvhnv8wEbcHsy3/cBDSIf/YTUzVFSx/EMMjTv//mq/relr7ibH0sRUlLyJa
         bZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654197; x=1784258997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cx1US55ZcQE2IXAHU74DmTXGa2F7H+sEKzQcFe01wfY=;
        b=a8HAJnn5PoGwpvQFGkNyLSnKrpr6ZxGoweQzvogbUupGzVPMj9gW4xlOD+K5zHDCai
         8KaPftjCRG6qVNw5hrY441cQ/CSH9YaI+U1OAnzNHBS462Zehbqp6s9E1XW3hsy0eZMW
         4qAgjOp07i7Z9gJFRLgFYrlduW0bUrCSk6xqgspNhj7+7u0kZILr2B7ruu40xqB28le8
         g45Lj2TJc26cSiFWk5VopmNTIyKXcUkhQCt8TpppqYbWFM0+TtBtLdc1tUuKADktzXy5
         3VAo7GQnSGzok4mtAGpM2xG8LlOuKamn9kdvxr0BHnMDez39GePVYPszs7t35ja7TOLj
         x2Rg==
X-Forwarded-Encrypted: i=1; AHgh+Rqu9USreXO0Sh61yUkUeirZklvrHLDTpnGqcw9msQBX92/b9Fv6ltUKXCeFIu/RB7St4AKy7V3D@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmeFhvSk0VbMG515PD/vgBSonViUckf9lhJp6MxsWiZY1+6qw
	voUrg1BHO29i7WFpLNMiKrQV/6Ewx3GkOuxpxyiDJOElyv7yv+7r2tYs
X-Gm-Gg: AfdE7cl0kwSHW0RW3ImQrRyBvn7PuShGyiukN7hcbZsbTMDr58PdrUiQJ7o5b1fkLc5
	ljWv1bENbaLvzgkV9l9xOtLqKMttQ1fj9xaagpSxnJvwBc4ApH17Pxsb4SPYkQml0DjxWBwI+fl
	ptHp+bX5yaQBkydzetI75a2XaL9nj6G+eC4sVrpBUAVWd+FkcxVFoJC05fk+IHnY6VdRzRc4My7
	3Y05zi+/IWxVTZvH8Z+mLW440yrJ6xGZ3pgcYqRdQQtiu5hVQbxCUsU8w0VyWNrXNGXkYqCcMVI
	NDzMSLswTwBfB3Kx13uTCw7CgQRn2VLhLQkM4Fy6bZhPbZlSPFxUS2yyO4dwwyVhrDZE79Y1ZTO
	rdgloOfcrBAQHVc9ClGAGou3yzrr0uzr5wVm5d+Gnmt03ejxU5TBxvM5fSmkd78nSMS2IboSPzu
	UJEZ0uTi2eaqw=
X-Received: by 2002:a17:903:244e:b0:2ca:d91d:d3a7 with SMTP id d9443c01a7336-2ccea2a5de9mr109420575ad.10.1783654196716;
        Thu, 09 Jul 2026 20:29:56 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:56 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:21 +0800
Subject: [PATCH v4 10/11] docs: cgroup-v2: document kernel-noise isolation
 via isolated partitions
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-10-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17642-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38465737081
X-Spam: Yes

Document that creating a cpuset isolated partition updates the
kernel-noise housekeeping masks (HK_TYPE_KERNEL_NOISE and
HK_TYPE_MANAGED_IRQ) in addition to the sched-domain mask, and
that destroying it restores the boot configuration.

No boot-time kernel parameters such as nohz_full= or rcu_nocbs=
are required; writing "isolated" to cpuset.cpus.partition is the
only mechanism needed.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed995..eaafe6d88c0e5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2721,6 +2721,23 @@ Cpuset Interface Files
 	kernel boot command line option.  If those CPUs are to be put
 	into a partition, they have to be used in an isolated partition.
 
+	When an isolated partition is created or destroyed, the kernel
+	automatically drives runtime updates of the housekeeping masks
+	for kernel-noise types (nohz_full, RCU NOCB, managed IRQ
+	interrupts).  This extends isolation beyond scheduler domains:
+	the tick is stopped on isolated CPUs, RCU callbacks are
+	offloaded to housekeeping cores, and managed interrupts are
+	migrated away.  No boot-time kernel parameters such as
+	``nohz_full=`` or ``rcu_nocbs=`` are required; writing
+	``isolated`` to ``cpuset.cpus.partition`` is the only mechanism
+	needed.  No additional cgroupfs files are required.
+
+	CPUs with hotplug disabled (typically the boot CPU, CPU 0, on
+	x86-64) cannot be cycled offline for kernel-noise isolation.
+	The kernel emits a one-time warning and keeps those CPUs in
+	the tick and RCU-NOCB housekeeping set, even when they appear
+	in an isolated partition.
+
 
 Device controller
 -----------------

-- 
2.43.0


