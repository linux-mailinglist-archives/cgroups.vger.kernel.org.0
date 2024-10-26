Return-Path: <cgroups+bounces-5272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CA9B13EE
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4C31F22AFB
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 00:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93E8BE7;
	Sat, 26 Oct 2024 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW41Ue9L"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA838217F39
	for <cgroups@vger.kernel.org>; Sat, 26 Oct 2024 00:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903718; cv=none; b=m/B/j6nQfrAE/KuIu4gTBZJTRy/LtOO9b8qs73lFe63GhDuaEE32p1qRAiMKQDc6M58KjQF9ML9D170EHM9VwyOuGfRzUzmW+rvujs9bshHIkD/HG727ILo7IUc3n0coo1EjR34dtPLrdb0QbRMp6J5+IAluGDm2vti49ZEUqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903718; c=relaxed/simple;
	bh=NEwIpwr+R4AKMRrduc/psT3XDNjrthixZZ+mHZhAIns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkxgOrKNW+HoBAXGFMVByYF7kDMbTzMKn7+OTdJN3wYef0ht4mN+nTmi5f1AO+FazDZCQNnRhxkhGTv3ps9eesRSNaZfIHGkp4bqy/UgaWGvs7yI7Y9S3Nkz+eKRNNS6r5yrha4H2flAIlTq3ZKCzWVA7CMxf5vVJo2CRJANb9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cW41Ue9L; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso1890051a91.0
        for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 17:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729903716; x=1730508516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fA7WcO3E5pEDm+0LOtfHSLJ9cdNF7fPH0isXm9fWCU=;
        b=cW41Ue9LuXuJ0QZ7LdcGV13qyyTm+4TI19az+wykZQgeTcqomL9CNMT0UyBncTAqau
         h9NgtzgaoOV/0ttV6WC7vobhqZ0zdKGUUn6ci0PQksvjr52d5gtnkpdQZVFYrb/aGrZI
         9HUQY8HHEHlaCqHn+H6Zt10qQZ7yLQqocADJRev25hn98gHdRlzkh8ZLz06bxao1k/vj
         qjCbRgbF/FswSKyVylH200WG/zbqbNnx0NVF7l2zInWmyAJFLNIX2v8sRA71Ee16xtBY
         yuPjadbHmHPc1r/Xyj8xcFIxYd6a29AXQCVaPr90F4zlTp1IIVmW7M3PwHaAGN1ZVHl4
         nxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729903716; x=1730508516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fA7WcO3E5pEDm+0LOtfHSLJ9cdNF7fPH0isXm9fWCU=;
        b=ADYG5NfcnUEcMMKql9jdL95k6shD+WhurHBfJbk0Fho4rgo+t0jvIX8zvlkBbIRYOA
         7N+1S+nYYfQmDDmNvfD9SrKv2+e/KE2ysobE5sFyqjR30I/eh9kStwCeKMPrg+M1zuog
         neG9DmplmLD66UPI7Q0y4U8KWN+yXzreW4bGBDsVJtajDWkBNn7cKh/0tAUtS00ZtLGU
         OOTjffvaISNNxbyoJX9pGr6xvP7/hCCiTUwmKD+JcEBzx4Kp7YazRTiOhsau6hS5cDX0
         /mrGaZyRB5RuQoR9kD2hizXUgiOizuK56N9/jheP1qa0PmzGMg7yclQ9RjzEtQtkG2pL
         YXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKWNesFEivUuMelarUGm7q2lxNUr9sTKHYggWJNzykJTEei4LFV5i8utY2jZqSFYLKPD9s0GE5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8F0nmbxhgTA//fjw5uQLyVYq6R/o8YhHhsTLVob/xfyybNFfz
	yhO/wQtNBUnevw9FWstlWo9KV6VLwhmk59bcOXwBEIhILi00PaP+
X-Google-Smtp-Source: AGHT+IG8s6V1enHwWFRipM3OcTqSi0KNhyZtfDNk2LRJn8DilFz1SDop76Gqj2Wixr8/K7JkamzbeQ==
X-Received: by 2002:a17:90b:5201:b0:2e7:6e84:a854 with SMTP id 98e67ed59e1d1-2e8f0f53e17mr1650825a91.1.1729903716025;
        Fri, 25 Oct 2024 17:48:36 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ad66sm4249738a91.4.2024.10.25.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 17:48:35 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 1/2 v2] memcg: add memcg flush tracepoint event
Date: Fri, 25 Oct 2024 17:48:25 -0700
Message-ID: <20241026004826.55351-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241026004826.55351-1-inwardvessel@gmail.com>
References: <20241026004826.55351-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a tracepoint event that contains the memcg pointer and information
on whether the flush was forced, skipped, and the number of stats updated.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

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
 
-- 
2.47.0


