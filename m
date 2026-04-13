Return-Path: <cgroups+bounces-15263-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NlDBj+g3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15263-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:50:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EE3E8862
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06BF33039B35
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CD739DBC4;
	Mon, 13 Apr 2026 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlaFdogi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896439C003
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066324; cv=none; b=VOQRepnOypqUPNTkd5JCCqbL8LAoJN44p8eY5X41BlgqbDgu4ThMwT7oL0W1DzxXWSqevm1BU1Je4rt1/ppGNvoXf0CVKoDLOyTfztU0p7bZuUBCYb1bwtNIVitJJg904x4A88y8bBt5Dbw7zetE1Kb77iQgkma04YYhRbHtMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066324; c=relaxed/simple;
	bh=11ce8bUKvUSdcebzsjZtiRLgXFylySnevizU5TDAFts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGsqLub7L/MZI5n8T942ernGFtdxD561uhusdnGjop3OBpzbpo5twSw9nGDlI5p2KaVilsKhxd+3c/GvnlLVuFZvUGtS7Hh+gCDs3rvW2YTQWAHji0dqQSEslqno/XYZkQLDzzJlJTN9eB5U9TFc4kjIDGHrcnn6ZaaQ8h1Bk4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlaFdogi; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c45281a06so1611476c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066322; x=1776671122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNYrrMihyJ/UopuSP8NsPFIh0brjDU9y6jBpikXxsOI=;
        b=rlaFdogizaH8E48QTvwAewMKrEOKvjVGk8NUiMvPfxXtudCAn6AJJck1u1sPsjApvw
         V+jykR2eah19Ul04Ggv5O/draHnzso2rriDuTYkLDG69k2TUR5AV1Okwx63H/SEcQT2L
         o/VzvNMyv85GFv4tCobyFzT9S3zFYCjCVqsKNoaufkPQtko+tYf//rrd9BCFCSuG+FK+
         AkhYscxlwAjBzJA22sYZ5r/rxj/rwKw3zptSsQ/VFOLgVdpFWutMjHkQ+VBDXz8p2/Dv
         EoMHOmZOnDj/LNg+fv5UlS4Uhq7el9M/AggMd+8SQFoRSNoia/I7j/qH9kMjuUGwQ1qo
         imOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066322; x=1776671122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNYrrMihyJ/UopuSP8NsPFIh0brjDU9y6jBpikXxsOI=;
        b=FtSQgsx4gi1X/z73gH4SpKH/QeJ9rKwLWlRc3x8PY8CXav4CI45jGJ8Pc/Jj5kUDA0
         0YtKBPlsC2nK4ySwdWVy9aYkdltWc+ZEkY8x/MiL0Jlpqmgu61Xl5IZ1avVwFOTiG5iX
         ahmXxod0H9OGTh083NCfeA2DN1hvYiBxe1m5N7cjG6CqBK5a2x3ou5SU855Ocb6QkAkV
         +PuXHT40AU8Tm6VWw1rMbjd6+vK5oUN71AVaziqv1za+zsHjlmMJIoc5rpNp/b6kAmCF
         2Pa1tHWKaklRlym10/uxm78pc9t7DskOW01mx9ZhFWlfC88HhN9s3juJnMX9AVKYsDaH
         08Zg==
X-Forwarded-Encrypted: i=1; AFNElJ9N+aXs4Kfeb0XMjCOhsBegBOX/zDsanFojTYGvnq2rNS/uCRFHeFWJ5rBjl8DciIysdGdmdqRA@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZJNpbVc+FZjufO93kSG0hUHDHl89JlWnv95B9YrSFcLLXv5f
	vegrNHFBR1cb8qobrQxvRX+eBuMgMYQ0Dl7176TzL5VWFOj172HkpFg5
X-Gm-Gg: AeBDievzdUXRY7NxJXCp7axq0L50KTW/sWngbUVtj9ql56oIhh/f2nWzUXOhGq3SqmT
	+PGNO2vNAlJKKPUTkC8cffReCh2YAgblFktfYQ6wfgvRSYvyZ3PpDbuiEaIAGkMIX3NGLQFDAo9
	QamyrRLoIbwx1BF68VMEfHy60ei+QyL4nEyVqcAOCovKdk6KwUJptroqn+1jaHztxTqzCw0kmRY
	HczqMzmJm7yBHaEXwuWnFzZ+r1vVHJFVdHSEx3YuMnpiFDffo1kWdS185JJJfpmyBgx5/pqSbam
	PXGn3Ao8ZxegPKBbvMcHGu4Vv8T+Kul+HrNz1Chr7C0NdZ8Ks5NmVKDPaALwa3UDBQiHGbdH18s
	Z5GnLIqA5BrzVFxYr3xfYkZhQVNUv5uXoNiJX0964HNxGAvmn4SJQYYMb1UaBloxZVkaX2Um35K
	vvFgr6rUub/wSS7Zee
X-Received: by 2002:a05:7022:69a2:b0:12c:8b9:7208 with SMTP id a92af1059eb24-12c34eeb95cmr7021315c88.26.1776066322024;
        Mon, 13 Apr 2026 00:45:22 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:45:21 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:17 +0800
Subject: [PATCH v2 11/12] Documentation: cgroup-v2: Document dynamic
 housekeeping (DHM)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-11-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-15263-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A6EE3E8862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the admin-guide for cgroup-v2 to explicitly document the newly introduced
cpuset.housekeeping.cpus and cpuset.housekeeping.smt_aware files.

The documentation explains the use of the DHM framework for reconfiguring
kernel subsystem isolation masks natively through the root cpuset without
incurring system reboots, and describes the functional restrictions of
SMT grouping safety constraints.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 91beaa6798ce0..deb644b88509f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2592,6 +2592,30 @@ Cpuset Interface Files
 	isolated partitions. It will be empty if no isolated partition
 	is created.
 
+  cpuset.housekeeping.cpus
+	A read-write multiple values file that exists only on the root cgroup.
+
+	This file is part of the Dynamic Housekeeping Management (DHM)
+	framework. It allows dynamic reconfiguration of the global
+	kernel housekeeping CPU mask without a system reboot.
+
+	By writing a mask of CPUs (e.g. "0-3,8"), DHM will update all internal
+	housekeeping subsystem masks (scheduler domains, RCU NOCB, tick offload,
+	timers, unbound workqueues, and managed IRQs) in real time.
+
+	The new mask must have at least one online CPU. The value stays constant
+	until changed or affected by CPU hot-unplug.
+
+  cpuset.housekeeping.smt_aware
+	A read-write single value file that exists only on the root cgroup.
+	It accepts "0" or "1". The default value is "0" (false).
+
+	This file enables the SMT-aware pipeline logic for DHM. When enabled (1),
+	any update to "cpuset.housekeeping.cpus" is strictly validated to ensure
+	Hardware Threads (SMT siblings) are kept together. If an SMT sibling pair
+	is split across the housekeeping boundary, the mask update is rejected
+	with an error to avoid severe cache and pipeline contention penalties.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup

-- 
2.43.0


