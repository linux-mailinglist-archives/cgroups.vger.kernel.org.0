Return-Path: <cgroups+bounces-6863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E402DA54D1D
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501F11895161
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54818BB9C;
	Thu,  6 Mar 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8A7GNpN"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85D188724
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270279; cv=none; b=l2C9UYJ9wbt0TQPNsy5R3Vf4nRFYP7Q1TB3aQrCikCh8M+R0GD3tjNjC/qtl6Ye4+6b3cH1TEO6SE7qXFmCB91hZjEf1ukii/DniBlpzorlYAuunoCJwR1XyeYDzAT8+OE2uwBu8O06ZXfqefJyS3S3R/4DOjFaPRYcNCZnuh1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270279; c=relaxed/simple;
	bh=4bDzmWrpSp48TdjMHbBbRLXbqjOIhNsg93No87cP2Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOfAIDbBcLQ33a+NspgvzJdq/teUXuu9AmxYXr/afcQ936/nxBW4Z2sy5qBPWbmz2+wy8DW6UHi2A71BmpZFknpGyxAopkxHDDackwIrDqFvjDsi//LcoDri+paUAkozydSta80evkOTY2P62KN9HPvxrxCN8r9KwNNGVBJct1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8A7GNpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7Wvt9bCpxa9m5FhJrFhPuBa/FfAz6U7Ug8gygH663s=;
	b=R8A7GNpN6CxwH6LXmSBT3+2VneQhvcoyFsDbpy881BZatqvQgOkDye6ZskJCxwPfpm6dyF
	SV0uIpQgo37c15kz9KKfrXNP8nbDlXXh/I7ZhOigZ418zGNYjMKswxUrkxWgtiudp38Mbv
	aQoDbaib1ECuSlqAvsxp9cb3wcHTTnc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-kqeon8vAOjy1WChnXJ2yag-1; Thu, 06 Mar 2025 09:11:14 -0500
X-MC-Unique: kqeon8vAOjy1WChnXJ2yag-1
X-Mimecast-MFC-AGG-ID: kqeon8vAOjy1WChnXJ2yag_1741270274
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3cd389c67so131748885a.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 06:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270274; x=1741875074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7Wvt9bCpxa9m5FhJrFhPuBa/FfAz6U7Ug8gygH663s=;
        b=OH2QT30jxNchLHAzT9DoJKcRIVN1CRKhyVF7Ju4MaBBm+03E517Ye7cHWE3gTrcHke
         3P9eXkJddNYKE60zbYY64q3B5CaxNUS3c84a+LUO2QegXw0q1++Y1vmNA4vo74QwvJwW
         v9SRrp4rYOVl8OEzAiX30bGD+0Bm0zZ9+A24sQb4MeQ/eujeWQNU9i9lYCYgtRW1FFF0
         IwOCoPGhb0Ax3ojOvlvUxqrJK1oyQULmnYk1xyvttXP7Er6VQFp1Yzu374BEjEx2M0q4
         0p608WwjaCpArQEglX3uhqWaBl/YrbkgPgW5kFBY/GtWc/NM2KixhLGrbEphe+hf0PD9
         Zkkw==
X-Forwarded-Encrypted: i=1; AJvYcCUJlWX7b9tZUIH95awbe902h5bus0eFu1buocwDmgyEQUOiP/wZAQqkw0KdI2Mge18k64FM9XVC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wzCxiIcqIKmI4X5gTNXu8WW+vONoqCIQRLZq/h0tpLBkRRHc
	xSujbSy5Eq+y0+a8y3WAVI4gYmdzjSnc/WCdcI/+pMNSxfIC3FSiNcz8izv++5PWnXWrp2A0MQI
	5h7SDtVJOttQ+umir3JtA+aHVRozm52oXEhMyzindwIg0CVC1zrX/QzQ=
X-Gm-Gg: ASbGncvO/sQGD+0oV8TW8qr4/IhLFpUb/1o/ywZG2jZS12RVU1LYZ1FEfihvExHKQ7N
	AhM2jJmCWSpNLCk1qpQEEC+By4cE5BdnBP+ba7+9GpN8oofyNhIaF5vlI7N9zTow9n+r/Xz/uqd
	zCjtUvibwAFD4o2AlqFNVivLmYOdL703zXlkR8UFY4fpvB0IG5sbTqUUbN0hOYqEpu30pDH+yBx
	ft6HevgE312RvtGnhUilDJbyQ07lq0cmwgvHzp4cq8l0V5CWoJjdrYOnbsu3T7he5AYKEQ2oILS
	Y7O7UrT8PKfG/47b5tfdVSGafnNAuk6a8o4r+jjIKeaKlbK1KyXm8K66NAsWqLPh+f8AIbQqBXb
	hyNUR
X-Received: by 2002:a05:620a:270e:b0:7c3:d282:d2e6 with SMTP id af79cd13be357-7c3d8e6f751mr1067265285a.29.1741270274110;
        Thu, 06 Mar 2025 06:11:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGavNGLBZnGI8W2c5FsjQ9kPKpnQpHBXP0YguyX+7DGXw75Fqnh1vbSyiUv74NnxEk0kp8WQ==
X-Received: by 2002:a05:620a:270e:b0:7c3:d282:d2e6 with SMTP id af79cd13be357-7c3d8e6f751mr1067260585a.29.1741270273836;
        Thu, 06 Mar 2025 06:11:13 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:11:12 -0800 (PST)
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
	Jon Hunter <jonathanh@nvidia.com>,
	Waiman Long <llong@redhat.com>
Subject: [PATCH v2 7/8] sched/topology: Stop exposing partition_sched_domains_locked
Date: Thu,  6 Mar 2025 14:10:15 +0000
Message-ID: <20250306141016.268313-8-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The are no callers of partition_sched_domains_locked() outside
topology.c.

Stop exposing such function.

Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched/topology.h | 10 ----------
 kernel/sched/topology.c        |  2 +-
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 1622232bd08b..96e69bfc3c8a 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -168,10 +168,6 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 
 extern void dl_rebuild_rd_accounting(void);
 
-extern void partition_sched_domains_locked(int ndoms_new,
-					   cpumask_var_t doms_new[],
-					   struct sched_domain_attr *dattr_new);
-
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -212,12 +208,6 @@ extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
-static inline void
-partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
-			       struct sched_domain_attr *dattr_new)
-{
-}
-
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index df2d94a57e84..95bde793651c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2688,7 +2688,7 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  *
  * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
-- 
2.48.1


