Return-Path: <cgroups+bounces-6802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29FA4D6BE
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E063E3AAE25
	for <lists+cgroups@lfdr.de>; Tue,  4 Mar 2025 08:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A421FBEB9;
	Tue,  4 Mar 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQBTHhjQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1C1F3B8B
	for <cgroups@vger.kernel.org>; Tue,  4 Mar 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077679; cv=none; b=NYJAfqPDLfNNQJUJXa7wew5R4HWPlDIjcxs8sxGTsm9cYOvgH+Yfg1fSg0XljzJaxR0caiETPyP97fuyaKol4hvkdZSA/HY6+4IzuYqtHtG0pqKhCWEA366f4937BYIhIbH7CQiUJY4DvLscJyOlqJB5JuwALeZCFwCppeVPJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077679; c=relaxed/simple;
	bh=xcnCm892YVWrZWbMShd7y4D6hSOZDUxmmffjBmaQwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsNVP+IRHge0HpyGq1b4ef8WOObOAC7rvNx6dX1XOgteYcUQwR5fJNkNDlswKm5g28zkmYshanI6Pd01+EM1f249G7yTLDlXRBmb65RcAWOwB9ah3IqVyOasaT+RHWMI+EztZVc6adak6yr7txfIaav5bb5oTxLtCBqMSAcvkus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQBTHhjQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
	b=cQBTHhjQfCVoCBDPv+RqzpiT2uyvL+u+9pxPqiwLcvMzkIpRLF/FHvODkswoqxISsGuS/y
	cXMNNgqbPqA0ofD13yGGNwKEyum5dXI9q5tprWtsilqlp/50+mmGDtpu/G+PPRLGLGvwe8
	1gL61EBk3ljZci/W9F6dpry4+zD4Y9o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-CshCXE4NOImEt9-BCtMczA-1; Tue, 04 Mar 2025 03:41:15 -0500
X-MC-Unique: CshCXE4NOImEt9-BCtMczA-1
X-Mimecast-MFC-AGG-ID: CshCXE4NOImEt9-BCtMczA_1741077675
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c3b7f1227cso207716285a.0
        for <cgroups@vger.kernel.org>; Tue, 04 Mar 2025 00:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077672; x=1741682472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
        b=XxxI9rxAZuQdTIh4Zuy++CIPym7D/5vpbxFTKXeU0ATsRiBlaAYmM+AUulBVa1V2oj
         dWGodiRwJg0lXJpM0eoLzCoJ2Q3l94ZljrD9so39X/vbTxS8QHfXm2Q6+BB6Zjm866TZ
         hHaPuoUraIdJgNInPuQCVmbYGR1YApanfXbrMV2dQKGCvYZlfvXfKIWcPVQ+Cw/NsD//
         JmST9jcZy/eHc5bOorsTOhLnhPBeX4HESmrPTDVdT2MVbmPEeeBFXpHOaiVrTeYX+TWG
         C9eQBBC4YDHBtkuy/s2ZcFH1tiYnd2i2oWBhI7XBPyFfYo1DfhbZLMtpwCTlH/azKLeV
         bKbg==
X-Forwarded-Encrypted: i=1; AJvYcCWaKCBua21QmNgApLwCUwEyfCUgPTKLWT3smoQ1qbzQA8BiDkqgdcdkCwoA+yNXhvqOJzx0da+i@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5OxPcr8a9N49jwIOtcHjBtDLD/fuxtoglTPoCGObHgA9l6NY
	nshOwjJFOX1ahBOIbsce+8n+kceMjDteanoQT2UKIzF5ROtwol3cc2UrdQNTXOYjLasz/MfLK+2
	Ii+eNn0ZDXH0QQzqhpDP77755HJZUKH0sqwjZ4yCU3CjNLL7XkQe1WydsuSNYIncVrXJx
X-Gm-Gg: ASbGnctRfr7ZjEnnezr4jsSdHsfVMOfk11zG+gZfCWIARIGZTC4Ohf0/JIXYl3h7m8H
	BsIL+aUhUe+l0BZMbBJTtq2l2HZIPwRcUv5D0iIt8X/hzG15Ys7E6FHUu1lBhPkj0cirMqL+hAz
	20refC45yKmXwoKAuuTkttVFaqtsVrfcxx12lfHf5+qnIYlDAEZVVVM+AV3Xy+ZjsNowdel0K3a
	0Y+E6XlSi0z2Sk5eZiqUoIFPNlgOnY7b8CBpyRn3wTyWpXlX2vYaZMqOJqPZoq0nmvxctYvHtPF
	vZl5mMZByQLaPmakWp9RAVKfHRw8rES/DyN1PmmysfomkoUcDneafFRMbRh98LGHG/BJjRaSqaH
	ClIJ0
X-Received: by 2002:a05:620a:46a3:b0:7c2:49ef:1f77 with SMTP id af79cd13be357-7c39c4a0181mr2593146585a.1.1741077671999;
        Tue, 04 Mar 2025 00:41:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG79q9XffEJNpdX763jIx+W9EQRrB41TjQwa3qn+cmvJTNbdOuOPZAWMQ1iApXQL2A4RS0MQ==
X-Received: by 2002:a05:620a:46a3:b0:7c2:49ef:1f77 with SMTP id af79cd13be357-7c39c4a0181mr2593144285a.1.1741077671659;
        Tue, 04 Mar 2025 00:41:11 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:08 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/5] sched/deadline: Ignore special tasks when rebuilding domains
Date: Tue,  4 Mar 2025 08:40:41 +0000
Message-ID: <20250304084045.62554-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..ab565a151355 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


