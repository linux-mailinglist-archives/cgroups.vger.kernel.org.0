Return-Path: <cgroups+bounces-6030-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5011AA00287
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 02:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2423A3B66
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2025 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86037187848;
	Fri,  3 Jan 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOxF2oTt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46243232
	for <cgroups@vger.kernel.org>; Fri,  3 Jan 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735869041; cv=none; b=FJhkeU3qIOm8dDsdhj5+mYf2iIl1uHbprAn+AN0+mjFFR8DLYTB3hL8e/R2sZugjpr7faLRqJA/tZXyqLbqv6wPr7uW8dCfMTEHIwLTfYXc9IPOLfG1tAwIVvnUJDhdp9SiIQFkm5If7kbtP/jJ8Hj42gT3EiwNpPERI7uGiwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735869041; c=relaxed/simple;
	bh=rnN3mFL8ZrDpyVrDtSl3MQE2KldHX9mBK/9aAC5f8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dy+IHI55uDNoCuFDztWXJ6CM/pBB1A+0PI48fp4G6xlSEqkd2M8B6v0tQEmg4ffVP+6J7arxtSV+yQvEr2opr0Rep57+FCHcsSUVRtw4HlqidmvbWTQwpXgbXvyHPcYGQiX+BJmpRxA2xkwELw4hyEPh0DBpK0haTAJ2uh+cBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOxF2oTt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166651f752so189386085ad.3
        for <cgroups@vger.kernel.org>; Thu, 02 Jan 2025 17:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735869039; x=1736473839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov79tpw4GuAmAWp+brDBEww96U26TW/4D2kYy+uPe/w=;
        b=UOxF2oTtL+MaqLEyKEB/U+RfGL59P/ttviiRh+NdM4TDCA1vdzyjhbLrIdhz2mkl8N
         Pd32a0PNTD/FJyg8tpBEggG7W2goLNVi+CnVzI5qjr7RE7u2e1PHzOxzJa9SraCZJe2G
         2RNyJtjN+OrMDwt031aY0dEkIghPtqVUsNvVahGIZFook0VHqP5wXaGiwD3xVca0oZiI
         /FyFQlb9Ge8VvKD1wguAjWAaPmEGjCgH/rmy5QP0vD0cP0Kx7Yq58RU/M7K0SYhsoKx8
         7O/1cUEcFYcBZYx2x9N1RvZA2/2j35AMkEEZKcqsnkFDFnuHiVK/4zb08ghRpSjyUZZq
         G8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735869039; x=1736473839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov79tpw4GuAmAWp+brDBEww96U26TW/4D2kYy+uPe/w=;
        b=nWQq7TnhtqLFRlxFUt/E4pqhqaYRK541pbhZVRe5F9UdJQwFfZxEfRuuku1gQ9BJl3
         dX/9OV2BC78vWPzhNhdnddkKbkC3v9rXHuZjE1MoXSezz8cvi+RmQ/4q7HBVkBX8TKre
         S+/bG8Tk6ZUCUB+1SAFj3+KQ6WZOLK9gZJf9NDGncMU0Dqa4pD2QVMfUNAuUZ9Ax7PRP
         jFH5R9I0BFJKq1+dOhqUwdyzfA13aV1vEA+1eHOCB5B65hXcNyvRibKQ6f6GY2OJ0s4+
         e9OP2FvgQ8R7tiVhLlsMcDDYv65Z6h2wwqE4V++bNlJUvncM83woea4HizE/BlO0mkNX
         0cHw==
X-Forwarded-Encrypted: i=1; AJvYcCXK824mkfyj4qrAB+gqwDSdONwTejL1638WiidmyJ+REZKEgAxqCrm5EGKWMXSnWRic3Linydn9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5UsWHiSES79CKpXY13iTVRX6mgS7y4H9n7ydWCVjSeS9KWEO
	xv0XCaxIKQrzqkjWchpbG5F480YxOrKyw8h0hPVODurcnOjcZ/t7
X-Gm-Gg: ASbGnctQ0HDoYbuHB4B2+JXpUJhN+YlLhlp4xRYZuY8niQy+7vXoVynmFe5Cv6Xi44D
	Mi3OpfSuO246NARMrglNTRh0Eo9abihTe0CVPcP9FZUYMZLbP2sZOVAmwf+4hwe19Ce4VGlDBxW
	y4h2Xc9NZJX1BCQDPbDfWBTcIwtVQPAoyS1rNbe66UoxFGB3zMwj6ozVHccfxLoliAgBGIRjcy0
	6A3zxPOGSB/TQXnZ+Eb28bqHdpYJkcwN62m4Fg4p3zyu9CVsm6vpXpBcqi0RenyJ2bC4/bo19bG
	vP198VIxoM98ECeAFQ==
X-Google-Smtp-Source: AGHT+IHLu3wo59GI10fAuqab6yxqPVBVuB+WZNMyKnuCfl4ZNRDH7NjVsB8okoZW+Ytc6M8DT1bsCQ==
X-Received: by 2002:a17:903:2449:b0:215:3a42:dc17 with SMTP id d9443c01a7336-219e6e8bbabmr593714305ad.7.1735869039266;
        Thu, 02 Jan 2025 17:50:39 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm228851505ad.283.2025.01.02.17.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 17:50:38 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH 6/9 v2] cgroup: isolate base stat flush
Date: Thu,  2 Jan 2025 17:50:17 -0800
Message-ID: <20250103015020.78547-7-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103015020.78547-1-inwardvessel@gmail.com>
References: <20250103015020.78547-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the base stat flushing from the generic css flushing routine. Provide a
direct way to flush the base stats and make use of it when the cpu stats are
read.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 958bdccf0359..92a46b960be1 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -320,6 +320,14 @@ static inline void __cgroup_rstat_unlock(struct cgroup_subsys_state *css,
 	spin_unlock_irq(lock);
 }
 
+static void cgroup_rstat_base_flush_locked(struct cgroup *cgrp)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cgroup_base_stat_flush(cgrp, cpu);
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 	__releases(&css->ss->rstat_lock) __acquires(&css->ss->rstat_lock)
@@ -341,7 +349,6 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css_iter;
 
-			cgroup_base_stat_flush(pos->cgroup, cpu);
 			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
 
 			rcu_read_lock();
@@ -408,7 +415,7 @@ static void cgroup_rstat_base_flush_hold(struct cgroup_subsys_state *css)
 {
 	might_sleep();
 	__cgroup_rstat_lock(css, &cgroup_rstat_base_lock, -1);
-	cgroup_rstat_flush_locked(css);
+	cgroup_rstat_base_flush_locked(css->cgroup);
 }
 
 /**
-- 
2.47.1


