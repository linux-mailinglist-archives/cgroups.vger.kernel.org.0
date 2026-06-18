Return-Path: <cgroups+bounces-17067-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZSd7GmdiM2oHAAYAu9opvQ
	(envelope-from <cgroups+bounces-17067-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372069D402
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CZqe4DdH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17067-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17067-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A89943049479
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A65326939;
	Thu, 18 Jun 2026 03:12:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820A833E34B
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752362; cv=none; b=X7YcsqUUYJs2qxP93rMpT4vXiHmZVxFIQzHk4H9yYmj0J5Fa7dNJNRZz9lsRK5NPdGyJ744PucAdnaCip+FCDieCMawxM8wNxjH7ZQn8mdWd8ssBc15VmyFFNy8pokP9kMm7KGPvazgBrRJ/Vgj97k+fEWcf+L/DY7ozvE/KdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752362; c=relaxed/simple;
	bh=SZSfvX12VlEuwZl+6hAVKIfqxpPnB1VqKOp94X4ryo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PABc0P9BIxRD+NelpEjC83XVkA1kAXl61gIxkWGE602ekYW4rEKm8FkG9xX5mnIb0X7Q7q8+dX5MgK329Hao7MzbM/iVmF+lWbGM/Me9ulCGmG9BF2UzuxUuWl4aFVhUoOy4LuLUQi41K+FRUnnI06RMZ6RSqp2/DQm3dju32ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZqe4DdH; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf125989f2so2930375ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752361; x=1782357161; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3I6IX1xUYJMTfIXEi0w2UhaS8cMsiIG3uPORXy/Kqg=;
        b=CZqe4DdHuvA83HXuWHxNF+zbSnA/5STgQ7D8CWrVBB6gmc4KskyUW59tKbRVl1V3vC
         iEnxeIbNe3Xk0TsPZiLIVbK3M1WDMzKTjnTvV9gA2Y5bT1L1ZRtvGxWDT2KP1sVCWjaO
         DN04QcsZ6c6SDbsjZakOm/AD3yccCOyNCXMMd6c1EsiqTocuIJ9wUGoy5B6H/OgIey5M
         G6vWB6sE3qPynStWyu7ckXbk8zpmAUQ7G1rwosSEp8tUxgEfCqd83FBTwaIBr2xpeNe7
         kXFDpdpf+DCO9kP2Wb9HfyfFet0xxaYu/Aj2ft5pOLvWHGzAaqcqE8i/AruzjUBA22wT
         CLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752361; x=1782357161;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v3I6IX1xUYJMTfIXEi0w2UhaS8cMsiIG3uPORXy/Kqg=;
        b=Eo4zHNMVb+QuvQoyW8cxv2j5euTE+2CDZhGDTkS1OVmRpLWOs/ZDbqO1GVUW335L+R
         eTRpTiqk24FeMjEApEeAXtAVU7ms0wCoI8Y5MYXrG6zQoSnBANaqG3HRVwZadIfNEPMy
         qrhCfWsGKdHJJ5/jFWcObo9Cw9C/Aq+kOp/zgu2KTl1JnuMyzXz3Nx0W0HBMWfj/mzI7
         NhWqCJVtp5ZzX3yui6k+spq/Ub2MGXzm46bFzFJ0RFrpHTFrF3jwujzkLYv3NbC/uLxf
         SZ4TUeIG0fCENopPM+R4QnULpaEzPwCjALMLlNLYUmIPypFdHocAo+B+Wm00dJTa4M9L
         bYJA==
X-Forwarded-Encrypted: i=1; AFNElJ9mWLKcSSgfRAMOSJE3hTlHkM11QHrkwbocA5yT7QTLIJLtv9rx9JHtc688/1/lbwJi1CnoPR1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WftcN9H3sLqakSL+4TEPl8uSH3Q1hrmxEjIcaHAotqgaOd+l
	D7pzb000bFxaPoon9cpjGoKcfSnU6u/bxx/hqjJ8KukbQ/KMX1icXpvt
X-Gm-Gg: AfdE7clnbB+jYptdk1O2+3Lh1c1Q4FRfKqrJto2HIreSdnt0e6IxJ6hwPJ2O3m7HL1Y
	79kBGvfhf/NA61ZPOmt7Ys/HcmEpkGC49fD3WSj4yhWOdYGEHWUgvpdEY3MQfz5KZpIcYNPOJXM
	EKXk/pmIWy5Amps4wIlgSRr9eNg1Td3fQEWmWMM/jZWNIhVYLfQMdXQQVI2Z1N4l9lwxghMc4yv
	hKtg1shyb23NKJ7kk1L5oXRRwVFv1d4I+x6l7bFkuJT2NJ/9SfsBfxKshI4WpfH4q9ySTO36q+l
	mmBjPbFnSeD+9y1vIEDw8HzOihhUrV9eN+DgRoWh0+0gFD6KNCalI8ivKQKz+PNoJiPrHa0kNDf
	Dktq6SeF609pBG9RbrRXoMDYXAxfqh2G7MwTqX+7UL3QR/jg0O+LiBVVtzpUVYZG3duZnJ1b4ME
	3MkMSYyGp4sUQ=
X-Received: by 2002:a17:902:ea07:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c6bbf9dfa0mr65761055ad.4.1781752360871;
        Wed, 17 Jun 2026 20:12:40 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:40 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:23 +0800
Subject: [PATCH v3 12/13] docs: cgroup-v2: Document kernel-noise isolation
 via isolated partitions
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-12-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17067-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4372069D402

Document that cpuset.cpus.partition=isolated now drives runtime updates
of the housekeeping masks for kernel-noise types: nohz_full (tick
suppression), RCU NOCB offloading, and managed IRQ migration.  No
additional cgroupfs files are required; the partition update path
automatically triggers explicit housekeeping callbacks for all affected
subsystems.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 Documentation/admin-guide/cgroup-v2.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed995..7c3b048e75cb5 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2721,6 +2721,14 @@ Cpuset Interface Files
 	kernel boot command line option.  If those CPUs are to be put
 	into a partition, they have to be used in an isolated partition.
 
+	When an isolated partition is created or destroyed, the kernel
+	automatically drives runtime updates of the housekeeping masks
+	for kernel-noise types (nohz_full, RCU NOCB, managed IRQ
+	interrupts).  This extends isolation beyond scheduler domains:
+	the tick is stopped on isolated CPUs, RCU callbacks are
+	offloaded to housekeeping cores, and managed interrupts are
+	migrated away.  No additional cgroupfs files are required.
+
 
 Device controller
 -----------------

-- 
2.43.0


