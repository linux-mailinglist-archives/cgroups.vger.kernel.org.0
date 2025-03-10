Return-Path: <cgroups+bounces-6946-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAC0A59BFF
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C349D7A5664
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 17:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610C236428;
	Mon, 10 Mar 2025 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aTQijJvh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C40234966
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626310; cv=none; b=mmtYPhTRJswb8lZQYH9HGLnXkBJPLa8cxjMqgJI5hyht/WBqSCH+4M3SmfgMvwF53QK6LsiTSTTRfPQ12D5sac9BkBYncAStTMZMXASo57tetlOjpqnwiCkLY+oQPq1pSYm3WXthyfUCwNPwXBrpXwxRg/GVy4ctO8VtbZlzic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626310; c=relaxed/simple;
	bh=xvZO/eWJHr5v18qgFAuJ2zD9tV9+05a3hSDFW/3DL08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzdvOsRA0Sq7bssvEJ2VMH/1lXdrQh9NyYQxiJUzi6FgcNQg8xTTN7PRav82xHYIF4BQjjbKuNVGQmFKUryiWDJbOyVxyodJ/YQ4Wb+Dy82XbWmE2HtXHk5EKvhp82+AsydsjgJqXAPSdqap/jvJlXLICVnhKjSiwzhxGPP4Ueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aTQijJvh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914a5def6bso805854f8f.1
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626307; x=1742231107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+gLWqx/04LxUxfH1eW7PRrvfpM9WFH49x2PLPFue8=;
        b=aTQijJvhrMGi064tHm2mJ/mAf/+ejnSHFBKt7Q3f+ko+o+YdG4B4iMXYFrwDu8tKzZ
         h8r84SCEpDpVjRFMAbnV7QRLoNzqIuuC0+lC5r9P0t70IY6SuYereQFbqjB+ndeb5msH
         lcIyi1JpbU7LaJzi7UlhRRqKGq88jsKZeDhI17EsAiQ9/PkwbLcdU38JsDb2tev2aLIU
         uBpMDFVhn/YeAk7ObXuIRhsZq3LMHvELCaNLAVb1hs1MmCV3zGzn89p6W0E0Yd7GZ5y9
         ClHdne5q+xpCIpK6vVOtw+B6yNrElq4JJxXaUbY8sK1q8TdNb57CECLOJDGhJ7OG5hk3
         Y9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626307; x=1742231107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT+gLWqx/04LxUxfH1eW7PRrvfpM9WFH49x2PLPFue8=;
        b=u6OWu+t7RWAYdSb0GqEXRBcXsuM8lgUsiYQVB4GCkYzXGI0CTejJf0qrp6GLBllaPr
         XXlOfSFYD7Tpz8EEbM+U2a3oFjEidK5IxEu7t1rI7B6F57YV2Z9usS6qweVQUpXRcGFN
         /mL7Th49XLFRH3EbvcL1cq0KbcwQQTijcJbNk9iBiGPi4WZomqgVfKoDBRNgrf+CO/yv
         O6+a/v+wBOWKrns+EJCg/ZguxGsCHc14lMRWG8IV5IsFiGmn7yK779qL9I7NhpFKafWJ
         SC3e4F+iNA9RTYU282UqubPhfmVy2Qj7XDFOOL09dkU69I7fp7ZLU7BXQECuPOlB1znj
         80gw==
X-Forwarded-Encrypted: i=1; AJvYcCVfy5J8kKHt/k3zCoDcMxJ2xFGFkoPekZ9l/fWRbgO2C0AnbtH9kl6q2YZsw5OmOBzZG8FNT2uo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmv9AIs2pm36E+SanLjDmy1iittdAg1rOesWwoJDJPXCNIXE3i
	b9E96L/AyWCBNVa9GDvrxm8pt+xx29BL2FA7HQoQANmzTdqmGJOOBbcloo58FP0=
X-Gm-Gg: ASbGnctKzcfxV5Di6UfYhOlJzfSbqcubr/hgts7LMOslvcVPdG7ancpb8a0nulxBq3X
	VanzFhp9ztSmymz9kU3t1ZfZlUQIY2seWT6KDlh3saoBHVeYEzbtdwGw0x+LDUjSSdQ9xex2HhY
	UQod0wr4vKoJYv4AFi7rOsqO4BtQYFlhjjHE62B/4KKUFI0GokM5gLW0zW2Ki6+El2MOOMt6QWB
	E8+KylReon4EVTNXCYPqmmeL16nVdeegt4zI9a41vnFwMLLFGBF42A9GATvayNlI/I/siWHMyor
	K2xh37745foi9MvqPsYuYIFBLQQj0w8bydPNsQ/uPu7UP7s=
X-Google-Smtp-Source: AGHT+IEVpdllDp8ezqPm81pST1MhCpXpU9dAvAoZOtgMqwTmUvPRTqKqLJeuqRXUT4ASXwEhDtWGYA==
X-Received: by 2002:a5d:64aa:0:b0:390:e853:85bd with SMTP id ffacd0b85a97d-39132db1108mr10862381f8f.48.1741626306652;
        Mon, 10 Mar 2025 10:05:06 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:06 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 10/10] sched: Add deprecation warning for users of RT_GROUP_SCHED
Date: Mon, 10 Mar 2025 18:04:42 +0100
Message-ID: <20250310170442.504716-11-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4b2d9ec0c1f23..6866355046d21 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9748,6 +9748,7 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 static int cpu_rt_runtime_write(struct cgroup_subsys_state *css,
 				struct cftype *cft, s64 val)
 {
+	pr_warn_once("RT_GROUP throttling is deprecated, use global sched_rt_runtime_us and deadline tasks.\n");
 	return sched_group_set_rt_runtime(css_tg(css), val);
 }
 
-- 
2.48.1


