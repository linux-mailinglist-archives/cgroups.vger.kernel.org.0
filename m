Return-Path: <cgroups+bounces-2872-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358058C4970
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29E5286700
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2024 22:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A53886AEE;
	Mon, 13 May 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyEFS17e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5684A3B;
	Mon, 13 May 2024 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637720; cv=none; b=n3rvseBjgTh685gpIj3CqlVPYEvPK2nz5/SecQLUbe9kDZJdnzbhYxPdxY8JvnxFiIQ8GNP3WaOqbA5n6lE66/fBjvi3itxnuluil8YDUetpAhyIlnteiRYOoqvMFhfqe64/6siDcKS/UTsG2tY4R7vxmSfE0sbyNlBpu4KRods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637720; c=relaxed/simple;
	bh=PmUZF5vuqc5KffzerVNSVTNAR1dfIS9Fx2N+w9iYCaM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUAjnB/ug3tBB3ahDZClznGlxDMwnrL6TzB30PH4drsI0Di/OBg55IqVmttsurYUJjbwkAz9/NmB0vOQ5pyxbvDfid2UQp9nbF7qs4pFxwsz+aa7Bv6FMWgaFoQnfF9RXpDywfsEzognY+/1xstWXSquf5wil4TlAMssx6V/y5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyEFS17e; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61bee45d035so50586447b3.1;
        Mon, 13 May 2024 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715637718; x=1716242518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFQwRbO5Y/SwpSfXYkkqhhf8QwJBkym56pFBFXHGIfQ=;
        b=eyEFS17emt3Wi2+bz8GkzUXy7r5tP9qhA5WroV9b1Zc2Y5LQ+9Lf2Erg8nm+Y6GGoo
         6Q6weLcOyHnZGzIqniaRNz5wjOt8AsNVBYjDbvEjylvgU+dHkj0SQjzW40v8FCr2TGf3
         x/lArl0hWLX0g5rEojoOb3d7nyRf7yAIFgr6HaqyCBpfPMly7/+qYGCq806lCMqjtA6K
         l3iaMT0l33paGjhu8GQCAvaC7SXTEqoObTRojcYWpUi7wrQVi2mUD/5BTwv1oK4AfxSc
         t1HLWoKZqv8mHufGjexITCw2b4rPlzAzgSDMg57nX9LKgAMKlyDi5TbeceqL3zTquKpN
         CNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715637718; x=1716242518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFQwRbO5Y/SwpSfXYkkqhhf8QwJBkym56pFBFXHGIfQ=;
        b=EFeeHQH/GAOrTE4CH2AjBMwT83Kzb0UQrawPxCjBE9IW1qocSz7Oov80Obo7QngzUR
         6miLGZNQAXrN/wgFG5fO72Ud7Dgv4A3M4DDjqbkM5FEiyY9RZJpmBeGoUFqloqg2xR5z
         mZDFhEUDpT4bqNfEY7ikBTak2vMMsryh8uVzwc4R2clbwllhLdHYLo/bU44QKw7p6PEx
         GaQEaeaozvzE4MbGp8XpLjyAMxVQ4ewELnJnwR7WrhcgAn+Z186FpZP7fHVuIHJeHpdQ
         Y7J+BHthKwd5WAbqq1GCHRlgPlgh7vhIi6XCa4kp9Iz5NJeC32jLP10JGon9Gm5S28lv
         yNJA==
X-Forwarded-Encrypted: i=1; AJvYcCWwjt5jEYmTc7x741QJkSRHix8OiTKELE7qBRf4btJc4i3DlJQFv8pzNYQodFZNfU3Qp0l2uTY2GlH+DsAsp/PUePHXQp/QkA==
X-Gm-Message-State: AOJu0YyBGzKEZvQmwjvXtNOBn1wEN0pnf9KFM00X8+yqUsHwMsX/5kdU
	n73EayZUYZ4dYnxzpngbxTT+7P6pZZJtIBAcG5aeDp5nR1UrdC5uFNlQNA==
X-Google-Smtp-Source: AGHT+IHW3OxOtQkdaQaZZslj683tDCnOFiWmEsyE6KF4ZUH/We4b8SQs6HP6c5dzkG/SQEHfdjO+rQ==
X-Received: by 2002:a05:690c:15:b0:61b:1a4f:158b with SMTP id 00721157ae682-622affc65c2mr113804967b3.6.1715637717837;
        Mon, 13 May 2024 15:01:57 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e233fc3sm23098497b3.8.2024.05.13.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:01:57 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Imran Khan <imran.f.khan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Leonardo Bras <leobras@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 5/6] cgroup/cpuset: optimize cpuset_mems_allowed_intersects()
Date: Mon, 13 May 2024 15:01:45 -0700
Message-Id: <20240513220146.1461457-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513220146.1461457-1-yury.norov@gmail.com>
References: <20240513220146.1461457-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the function is called with tsk1 == tsk2, we know for sure that their
mems_allowed nodes do intersect, and so we can return immediately instead
of checking the nodes content.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/cgroup/cpuset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4237c8748715..47ed206d4890 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -5010,6 +5010,9 @@ EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
 int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
 				   const struct task_struct *tsk2)
 {
+	if (tsk1 == tsk2)
+		return 1;
+
 	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
 }
 
-- 
2.40.1


