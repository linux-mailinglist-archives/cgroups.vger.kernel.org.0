Return-Path: <cgroups+bounces-6486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E6A2F127
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6251661DB
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB52417C2;
	Mon, 10 Feb 2025 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cPI3/4kP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111223DEAA
	for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200384; cv=none; b=goHuyjyABmQbL8jFq/d+pLF95PiAYOaUneJFxI65mtqO6M9Qnh9dCqSs310aZwp36aJY6zVO/ubA2xeG7Xa3J7zVXM8awpGD7ye16MzFAeCUgWiK+QhsGjJbZWWZX2oXDjcDTo1iXHfrxWpMqnuzQS2Y11mBDMYDEImJGpYd0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200384; c=relaxed/simple;
	bh=iqeMyg2aM7rOxUpDWS/hr/9N/tXvFYSx8aHXmJaW8IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/SswWBhC3Px6Npna4C9U/JW8tt9gPTPB9yxS3HErnWy8YPmAcRKeNTFMbvX6Ylvhdxy8+gdfTZ+0hXrZpOV+vMU4vuC3Yy2S1VjIRBjNskxqhvtwgboPY6tL3sw4SSYrE44Eb/9ro4fs/fVW1wggTBvZnO3M/bc7xX8VZUh3B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cPI3/4kP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7ca64da5dso138241466b.0
        for <cgroups@vger.kernel.org>; Mon, 10 Feb 2025 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739200380; x=1739805180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7MdvLo2eJNuv+SAzqGScNlKUwpiF8b6hAU2gKf+PuM=;
        b=cPI3/4kPGhCpWqSc5MwGXkQo+kYmiF7kcNbax9523QDkCcMDarEkuOEOptJq7pyOWH
         OuK/KsbIyUndWq5qzuO5wg+cJ/bqFZmEEahUNQi2VCaDLlCly1dKpq4P8uOGeb8K/D26
         INJhc2UiNtVcV8YcYyFbXL30GKHCnk5rK2vzEdHg4JFFN2zP2xIv8aAA6e/kj/fdQFbv
         mv4M6iVCgKh671IMXB9dJOEJJ5Xy+h8r5rLuVciwfJD1Ht9gRKw6Udv/46tZVew8FqaE
         fzV8X6fvYN5Keyp7xqiXTsujUpLYuLKQPXw8ADnTdJbD+sNX9euD9uWsZyZLltq97GxZ
         QB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200380; x=1739805180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7MdvLo2eJNuv+SAzqGScNlKUwpiF8b6hAU2gKf+PuM=;
        b=CNozQEedPN3ijHk3lOakA3nWIbyj9neOTTUiU3lm5M1Krj0eiVjMiwne3hsEPRY6/x
         DbmAah7anaHVduQb08ZtThHgpPMKy0ViCbJlOwN2+TP2iPyHQQfMVSo6/0vn6RXmE/Sj
         sd2PB7laC4l0dJwW1LHYfSv9CVHvIWV6DI03v7SCl5Wb9p7IKj77RySgrlB0FXQOlpxB
         cFB29FDUENK/tDnLdjl6CVpfwKTC1jPC1nYOrkXLDOSxXIOoKYxRLvT6Xt6OkEr7vANE
         98x9+jGaU4+7srSMNOWmwJSNF8TE5vsyODBpke1A/P9KXfmUG+KT2fC7PNgbaRcuGc6l
         3zXA==
X-Gm-Message-State: AOJu0YyBCtOkjIk+ejlbA9RMm1IlK24FTy+N8arntKAhc9Cnl3qhZl7i
	usZQzRiS+Ci3iqZRoyRaTC6K+2buCLKRKAMm7eUKyOjBoCi/LGi0ZDnE3EBDUv85qpVt9cHkUbY
	V
X-Gm-Gg: ASbGncvuK7GO+4JRxYOCdBSivLnBd3PSNINaC0hG4DMC/63F5tQFZdqijKBMt+f867T
	+W11QBTixJO/sPMHUICkL+G25xDFjbCHfbmaIK3XoOWv7nAbGvNsyXnKxG9EUzjDZvCwGUyxzjw
	/+d6qDOjOMdJJQjORSOPknSbGJK4Nz6uAOyENO/HWeALdEBA7ERjwOzjRWf5MR+G/sjqhYF/Uea
	lD9v3on5MrZ2Vol0wjyyr9ficsuEkUhrN+RaMAAMMfqS9odKb8mjxiAyMVpOAs6MijLLBPQGdXU
	G0JrQd8xKl6D4YwI4Q==
X-Google-Smtp-Source: AGHT+IGk13SlYbxa8hsziKdtSAXkNvItrd13FwoaDhO6Dj5aOXPATenE3duFftBrONekaMv0xj1FKQ==
X-Received: by 2002:a17:907:d26:b0:ab7:d34a:8f83 with SMTP id a640c23a62f3a-ab7d34a94a4mr151220666b.17.1739200380472;
        Mon, 10 Feb 2025 07:13:00 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339e82sm895192866b.143.2025.02.10.07.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:13:00 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [PATCH 9/9] sched: Add annotations to RT_GROUP_SCHED fields
Date: Mon, 10 Feb 2025 16:12:39 +0100
Message-ID: <20250210151239.50055-10-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210151239.50055-1-mkoutny@suse.com>
References: <20250210151239.50055-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update comments to ease RT throttling understanding.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/sched.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4548048dbcb8f..51feefef65c66 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -819,17 +819,17 @@ struct rt_rq {
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	int			rt_throttled;
-	u64			rt_time;
-	u64			rt_runtime;
+	u64			rt_time; /* consumed RT time, goes up in update_curr_rt */
+	u64			rt_runtime; /* allotted RT time, "slice" from rt_bandwidth, RT sharing/balancing */
 	/* Nests inside the rq lock: */
 	raw_spinlock_t		rt_runtime_lock;
 
 	unsigned int		rt_nr_boosted;
 
-	struct rq		*rq;
+	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	struct task_group	*tg;
+	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
 #endif
 };
 
-- 
2.48.1


