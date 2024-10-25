Return-Path: <cgroups+bounces-5243-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B159AF62A
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 02:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772461C216B8
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2182AD2C;
	Fri, 25 Oct 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoBRc1Bq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941B522A
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815968; cv=none; b=XYegQLZjg8BGILac72e5ogYLQN6DN/YJVXfXcalNIqC4GXEd4rp9nqyyTzQT2R5s2ZZDabpmxaSVC0zjYLgPQtAz/Lw9ATntQu/9KoFKhmegCVilFcdafIdwrUo2FxayIA3HJlKaKP+QgoUJ6rxFL0tfDrDIpuJ/LSAcQqFHaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815968; c=relaxed/simple;
	bh=J7B8O1vKvIW3HUYq4MgnPAupAs7ej7MXjcJ794kXt78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0hT3qaYlXwNfbk/mkpYOzVSbjvinuK4TChXTpKwSTMU2MFp5WMEavfo5xh2vstCvm/HdrdZ3wzgc4D+/Cc5E8NMxK513Lkb5dBR8LDRHWdNzKSG3sR1ymJgZWbp6BdSf4IBgQDxJ1V+vEN75V4M1E/RjVHXdPtIehN/lf2uxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoBRc1Bq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e93d551a3so1074185b3a.1
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729815966; x=1730420766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eleAA8GQoILopeSGwt8qD2sFnpMPZ+qYQRQD58BJFx4=;
        b=OoBRc1BqU8YMD5V/V5CbNr0/EsdAOaRFBJqAZVNFMFOO+cXQPPEt150gYbqI1J3CDX
         wYu+7mUdAPualMxYtFzbdJNHJixoUhLwmGoSd259S0H8lERs9GDO0M9O1Fqbw7YPbj5S
         3EFk/jOF7E8wm/XEeypGNC2FFJZqlzIlPGDvw41iyfJ6cWJXBdSBvDrvroCvgAsl/OiP
         4IlOKiyO1hhiXNikBgvVqbyVtY7KpUS0VRgEY9KupB99+0oK3zNrdAxp2ph6NUt9eu2J
         G1gL+Z2Zj1ztPR4rlAerMPdcJw6vgHWPmJFkOaaln63VJc2R06IGrRFaLOzhPxYLH3ul
         2UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815966; x=1730420766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eleAA8GQoILopeSGwt8qD2sFnpMPZ+qYQRQD58BJFx4=;
        b=lKRb6XjJqXz4il4mtnT8xLniCYhYoSVGdDRApkfzlPd8uaY4S725slRUT8OcHeczY7
         xEv1zJihk+ChSUoe91ERsCbiv1xgTjF4+rRqIkTvHQ8ZTN4Zz8CJvkU2mRYOuR+teFJZ
         fuT5V7d41SQguEY9NsWmb/YWqxysAhJnd2rLzlKmQZx1+avagjZOdWG8Zj2E2FgZCu7y
         aU/sXhB2cTymNN4RXRiUVFQuc5Hec/JS1vsl3VT2zU0R8/nnvRK8yPmdITKgfCZgzFhe
         9lCNB/80BVrN5piMkd+hCLuWk2M0PH2mVcx8TqDyLK8jzN+75B/1DTr2VbCnk8Ww1i71
         pe7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpYRVH4QYd9ZBP4a9kI2n7MCgm6SDv55Dc/0j2+yUR+2XBDDwp9EQpfY6lb1/J6h7IKPE7uogk@vger.kernel.org
X-Gm-Message-State: AOJu0YwFoRtto1TAgTTtqkDj6WtVr7Mv9u5aRzgjn1e9LpOPFNC/MRDL
	2SjadMaRYRgcsyejgOPnW7C4LpEenH/iXTTb0YlzuEIZ/FHnPgRG
X-Google-Smtp-Source: AGHT+IFku3793G7NqJ6klFI9OVEwE0ZbQKW5RkBJ07ubX56OXMplVCNsWge2Qq5pPtxU4sCKi2RQfw==
X-Received: by 2002:a05:6a00:2ea3:b0:71e:e3:608 with SMTP id d2e1a72fcca58-72030cd4786mr10469056b3a.26.1729815965865;
        Thu, 24 Oct 2024 17:26:05 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b707sm21572b3a.128.2024.10.24.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:26:05 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 1/2] memcg: add memcg flush tracepoint event
Date: Thu, 24 Oct 2024 17:25:10 -0700
Message-ID: <20241025002511.129899-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025002511.129899-1-inwardvessel@gmail.com>
References: <20241025002511.129899-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a tracepoint event that contains the memcg pointer and an enum value
representing the reason associated with the flush.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/trace/events/memcg.h | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
index 8667e57816d2..9cccf0f13d4f 100644
--- a/include/trace/events/memcg.h
+++ b/include/trace/events/memcg.h
@@ -8,6 +8,43 @@
 #include <linux/memcontrol.h>
 #include <linux/tracepoint.h>
 
+#define MEMCG_FLUSH_REASONS \
+	EM(TRACE_MEMCG_FLUSH_READER, "reader") \
+	EM(TRACE_MEMCG_FLUSH_READER_SKIP, "reader skip") \
+	EM(TRACE_MEMCG_FLUSH_PERIODIC, "periodic") \
+	EMe(TRACE_MEMCG_FLUSH_ZSWAP, "zswap")
+
+#ifndef __MEMCG_DECLARE_TRACE_ENUMS_ONLY_ONCE
+#define __MEMCG_DECLARE_TRACE_ENUMS_ONLY_ONCE
+
+/* Redefine macros to help declare enum */
+#undef EM
+#undef EMe
+#define EM(a, b)	a,
+#define EMe(a, b)	a
+
+enum memcg_flush_reason {
+	MEMCG_FLUSH_REASONS
+};
+
+#endif /* __MEMCG_DECLARE_TRACE_ENUMS_ONLY_ONCE */
+
+/* Redefine macros to export the enums to userspace */
+#undef EM
+#undef EMe
+#define EM(a, b)	TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)	TRACE_DEFINE_ENUM(a)
+
+MEMCG_FLUSH_REASONS;
+
+/*
+ * Redefine macros to map the enums to the strings that will
+ * be printed in the output
+ */
+#undef EM
+#undef EMe
+#define EM(a, b)	{ a, b },
+#define EMe(a, b)	{ a, b }
 
 DECLARE_EVENT_CLASS(memcg_rstat_stats,
 
@@ -74,6 +111,25 @@ DEFINE_EVENT(memcg_rstat_events, count_memcg_events,
 	TP_ARGS(memcg, item, val)
 );
 
+TRACE_EVENT(memcg_flush_stats,
+
+	TP_PROTO(struct mem_cgroup *memcg, enum memcg_flush_reason reason),
+
+	TP_ARGS(memcg, reason),
+
+	TP_STRUCT__entry(
+		__field(u64, id)
+		__field(enum memcg_flush_reason, reason)
+	),
+
+	TP_fast_assign(
+		__entry->id = cgroup_id(memcg->css.cgroup);
+		__entry->reason = reason;
+	),
+
+	TP_printk("memcg_id=%llu reason=%s",
+		  __entry->id, __print_symbolic(__entry->reason, MEMCG_FLUSH_REASONS))
+);
 
 #endif /* _TRACE_MEMCG_H */
 
-- 
2.47.0


