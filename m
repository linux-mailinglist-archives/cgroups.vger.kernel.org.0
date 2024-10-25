Return-Path: <cgroups+bounces-5244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EC89AF62C
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 02:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AFA1F22AD7
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2024 00:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C08B641;
	Fri, 25 Oct 2024 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWitif6r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BDF22B669
	for <cgroups@vger.kernel.org>; Fri, 25 Oct 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815969; cv=none; b=suFFyLrsKzefJXMoDneA8SYGkfxYM/GE/jshf+GueWacLHy75GQAdJJiDSHsH7oX7ziNUTA/IUCHohC87KsnjQcKXN5r8ZaRGSBl0SEZaqLusamPTV6TmQ3CJcv1Vc5pGCwtOd3nR7CYlMCK//pb3eXCsNCwIQsRkh2D26JNmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815969; c=relaxed/simple;
	bh=Sca/4A3S9yh4oWKBAhxTYhJuY7vQE0PD5e5pOweMHd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKdZBvevjXZrpYehUGBHCpyMLw9X4YsHdu/aulG5F9Teh9vZyKTJhNOjS0PTC1lRAqNcCPNQo3lczyWf3nGBwRuF73r7QSei3Mc7hi1G4AuD5N754+0kmMp31Ht2HjY2yKgi0xtT6ElDMsDHZ2ujQaJxXNe/ydwk1ujSU7m0HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWitif6r; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e49ef3b2bso1063895b3a.2
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 17:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729815967; x=1730420767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IeBx+IbfCPsZzGBrrw0brhnGHzVrpkG5SByugERHPp0=;
        b=KWitif6rb8xC+RVGoLkVChMWrpGQ60hhBzDGYXJSQfh8AOI6g4uCxfQ4O6XrQw959K
         9IEx38txEn2Co0RAbOCPlN98XeE61wcxib3uksp742qOHFPBOYDgOrNcSj/YLjKlIPfw
         M5foAbD9RJVeP4CQEQtc4O8H570M013c19OnfHUtEI/9kGOJeFVPj1Frs1islcA/J7D9
         IKYz2Na2FtJhwYAmiVbrAEzHxuijCoHwqbwDORyCFvVTA6iOspwK+9hq0HEgKltYpa+j
         LqB2BfKzzOJdFTUOCJnVaUY6S2Xayt/xmlFtlNAnnRuOSrdVGgGbkoFYSgU91GijX5eb
         wmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729815967; x=1730420767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeBx+IbfCPsZzGBrrw0brhnGHzVrpkG5SByugERHPp0=;
        b=HfdcEx2omm/oJHsI8v0xeSIpHPikYEIXNKfNgQCQ1tyVSPQme5TnmpeS0dlq8VwABv
         ypsEX+YuwVYW4Mln9bKGXqAUd0ahygpRhAzEGhVQ8dLmlJwIA8AAv6ELbfPmrVSwXNZr
         EwAz8AfL/Tt9AppckBT74oWjm2YDn+mfntfgtegHTgzXuK8WeO2YS10wniGM2lQnUmia
         sP2/TuS0aDLSp3Ge1W7doEsDs25sYwAUghyhGHRZYPIv9974bEoXfzHojP0SjXvQ6pqq
         HYPHGdzI7CMdK9vlPoiDoK9ClKXDrVlCPHbXdxaxnOv9wE3la/WtrCFg85YYy+F2mAGG
         x+lg==
X-Forwarded-Encrypted: i=1; AJvYcCWtnkflDZHAB7EFVDt6/fi95XFtBeYDN6HLkql2a/OjQu3tzR2Cj9sQunEgYgBR9XHhBJgDwKts@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMRDiFxCZlJmKwnKq/3hhAJRP2Qoz/pNGIZUasjDh2Wf/QMd7
	ZeEths8O55b/rplMSJ2w5qXA5H7VBkx1rq2U0tqk1lrb1gnaxvv1
X-Google-Smtp-Source: AGHT+IFIiZZgA8TzhxiZ3F2VrQysWarw5zg/4+RqEpp72bYL8zTqxgSi7bgWMwkFE54ASqr6EpiuOw==
X-Received: by 2002:a05:6a00:390a:b0:71e:75c0:2545 with SMTP id d2e1a72fcca58-72030ba31e4mr10445343b3a.25.1729815967198;
        Thu, 24 Oct 2024 17:26:07 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b707sm21572b3a.128.2024.10.24.17.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 17:26:06 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 2/2] memcg: use memcg flush tracepoint
Date: Thu, 24 Oct 2024 17:25:11 -0700
Message-ID: <20241025002511.129899-3-inwardvessel@gmail.com>
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

Make use of the flush tracepoint within memcontrol.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18c3f513d766..f816737228fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -613,8 +613,11 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
-	if (memcg_vmstats_needs_flush(memcg->vmstats))
+	if (memcg_vmstats_needs_flush(memcg->vmstats)) {
+		trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_READER);
 		do_flush_stats(memcg);
+	} else
+		trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_READER_SKIP);
 }
 
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
@@ -630,6 +633,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
+	trace_memcg_flush_stats(root_mem_cgroup, TRACE_MEMCG_FLUSH_PERIODIC);
 	do_flush_stats(root_mem_cgroup);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
@@ -5285,6 +5289,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 		 * mem_cgroup_flush_stats() ignores small changes. Use
 		 * do_flush_stats() directly to get accurate stats for charging.
 		 */
+		trace_memcg_flush_stats(memcg, TRACE_MEMCG_FLUSH_ZSWAP);
 		do_flush_stats(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
-- 
2.47.0


