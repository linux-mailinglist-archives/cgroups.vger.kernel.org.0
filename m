Return-Path: <cgroups+bounces-5304-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257C9B4039
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 03:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9C01F233F9
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 02:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E95192590;
	Tue, 29 Oct 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqJo+EfC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7119067A
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167879; cv=none; b=aaLBBK2AClzm1X9Vm92l5kQG6Ej0L/uasY48BLfwxtZQ9wWbDGVBFh0MnbGH+81HH5xhSLfjFNWS/cqHEkFdiV0227ewF6dt/bA38jvIfhwUdazhew74Tpceu9CPy1vndzN5hSKFzQ0tgUsB6dl0PddVp3c2uxzP2fo5YAOCtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167879; c=relaxed/simple;
	bh=DTrNoUTO8FRbRtrZCOFPUyYK7GoePz4+EprNEIq13s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W89mkWA0thwQ2rgWPRvVetkUot3PglYAweSfOksRQv/1C/Q33RkT6nOtGTn+KPEoKVr6FNqiggH5ou+eNUPQA0db3ssXwPgo+ImzQkpCmoCk63v9BJtiexIE9iGpch37naN8gmD/yp4tUhhqbkgTCsX8wZwhUfJ4wOpVdlyvk5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqJo+EfC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so3975199b3a.1
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730167877; x=1730772677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62ijouUXGdPsDpTOyUYsa0hTBBZ19BQGZ0b2Cjo/M5w=;
        b=WqJo+EfC7EWe/P9wN8jDvgB9oK7CWPVy5CX2EP6Xk29kZh7C98NhtzsbKzIAXAgvDF
         JrpxsG9LsnxwWrSbziMYk6bSyUGWnoxsMfvm7awCMq4NPqS2XgFOJqkQgXof/YXFqYOD
         4XaKVAr4X1ZQE9PiYOafngqJHoozwGf+inQbjr1HwSpqF4AOKWxm6rR9zvgFaLdTfOrs
         4sXjT6VFyub2Hx5qG16X0zq9fGg2NOT4WIdtpx3d0Lk1cew3aEsCar47caFNjFg/cdWC
         gFwEiRIqDsUyFNN66jKaxpx1etVRo14fwT1Q95teO8A2ld2oxbk+fvXg3CobRq4vUnkV
         jaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730167877; x=1730772677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62ijouUXGdPsDpTOyUYsa0hTBBZ19BQGZ0b2Cjo/M5w=;
        b=v/yaeU3oWd0WmskpmyuKpzBLSyshHiH9AciuL96uVZIsvR1Jvs2gOZQTLgGYq0ESRh
         VXmxYGfUJDGdwRiQizzXvK0oZTiYCG5Fxz8sauUKLul2oaSuoei4Hwbez/GbAUnZHjn1
         8I0KehFp/Zsk1mVxK+H9isnJcXLyVxUv62+nS9qDIN2nBGVkCE284Lop4k9kyY9FvYDO
         eKYWP7pcDeBrvgMDv/0JAuA5EQ0nEnIjRm/7HyDYmPZ9L7vdt6sCvgkFwU1BmHFI6sgu
         5dnoDzwmuNJ4PhRp6ZFeJWEhSih+zlAn980sbPYXtWTIJnLV62RW+u4HRNs3LGPY55C8
         +78A==
X-Forwarded-Encrypted: i=1; AJvYcCVEkoLWeXOwAVjOWxcMSSNis3wRAqF7+6/ffnA6+8QHPDnHIpT8qRJtWnjylCJSzS0dFkETftt+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JJYf6e20gouin394pB1tsGNTP7iSd9uPBQKTqgQ9bATWZVaY
	vSnqHcvayeyjGusWWbw6BTgqamyWo/7P33hmab3GrcRv41dnBqrD0l9F5GvY
X-Google-Smtp-Source: AGHT+IGCLf5U4+sFsqYb2ermCrY/7iLSB5IEVW+42bLnZfp2+/qnyRqlJW8VvMH+sXRXZ71UqhS2cA==
X-Received: by 2002:a05:6a00:3929:b0:71e:2a0:b0d0 with SMTP id d2e1a72fcca58-72062fd4b4bmr15741361b3a.13.1730167877101;
        Mon, 28 Oct 2024 19:11:17 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0df99sm6500884b3a.118.2024.10.28.19.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 19:11:16 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 2/2 v3] memcg: add flush tracepoint
Date: Mon, 28 Oct 2024 19:11:06 -0700
Message-ID: <20241029021106.25587-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029021106.25587-1-inwardvessel@gmail.com>
References: <20241029021106.25587-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracepoint gives visibility on how often the flushing of memcg stats
occurs and contains info on whether it was forced, skipped, and the value of
stats updated. It can help with understanding how readers are affected by
having to perform the flush, and the effectiveness of the flush by inspecting
the number of stats updated. Paired with the recently added tracepoints for
tracing rstat updates, it can also help show correlation where stats exceed
thresholds frequently.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
 mm/memcontrol.c              |  7 ++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
index 8667e57816d2..dfe2f51019b4 100644
--- a/include/trace/events/memcg.h
+++ b/include/trace/events/memcg.h
@@ -74,6 +74,31 @@ DEFINE_EVENT(memcg_rstat_events, count_memcg_events,
 	TP_ARGS(memcg, item, val)
 );
 
+TRACE_EVENT(memcg_flush_stats,
+
+	TP_PROTO(struct mem_cgroup *memcg, s64 stats_updates,
+		bool force, bool needs_flush),
+
+	TP_ARGS(memcg, stats_updates, force, needs_flush),
+
+	TP_STRUCT__entry(
+		__field(u64, id)
+		__field(s64, stats_updates)
+		__field(bool, force)
+		__field(bool, needs_flush)
+	),
+
+	TP_fast_assign(
+		__entry->id = cgroup_id(memcg->css.cgroup);
+		__entry->stats_updates = stats_updates;
+		__entry->force = force;
+		__entry->needs_flush = needs_flush;
+	),
+
+	TP_printk("memcg_id=%llu stats_updates=%lld force=%d needs_flush=%d",
+		__entry->id, __entry->stats_updates,
+		__entry->force, __entry->needs_flush)
+);
 
 #endif /* _TRACE_MEMCG_H */
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 59f6f247fc13..c3d6163aaa1c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -590,7 +590,12 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
 {
-	if (!force && !memcg_vmstats_needs_flush(memcg->vmstats))
+	bool needs_flush = memcg_vmstats_needs_flush(memcg->vmstats);
+
+	trace_memcg_flush_stats(memcg, atomic64_read(&memcg->vmstats->stats_updates),
+		force, needs_flush);
+
+	if (!force && !needs_flush)
 		return;
 
 	if (mem_cgroup_is_root(memcg))
-- 
2.47.0


