Return-Path: <cgroups+bounces-6001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5147B9FB82E
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92FB1646CA
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721B71805A;
	Tue, 24 Dec 2024 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8S2iBjK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF3A95E
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002865; cv=none; b=Lw5D8PWOR09OFgzhOLDLQWN7hsPi+q0Zs/Jp4bVgPx4huzRx7ZpHW+Rj3uoKi8fdINqvZFkN8oFNkBBT23kMrBJVMwj7M+FCCLXCwOkKO4v5sqxLJ29woeU9vMjodlz6hz5tZVVu0LpS4Wa1x/PiPygl+snVvwwQWBBJyJ1IJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002865; c=relaxed/simple;
	bh=rnN3mFL8ZrDpyVrDtSl3MQE2KldHX9mBK/9aAC5f8WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKv0lWC6P6DYJmN9G6o6CfX9RlLWSKlmYf52a+jrTkURK+xmChjZzvG0w++mOigPT9QoK8jbCMebl2hxzfl/G31sc0COXroai5nrKZzSVEbprdcR/l4NEcv1Fz1cyFwY77G+j/maL2T0Ltx1PsPAaAACHyiSvHjPdDQtXivxO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8S2iBjK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21631789fcdso39058365ad.1
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002863; x=1735607663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ov79tpw4GuAmAWp+brDBEww96U26TW/4D2kYy+uPe/w=;
        b=B8S2iBjKUDbeNaha1dAlMXADP1Y5hljrQA/nZHsQLK0Txr4hl0BuatwEiFE3CZtLE8
         RtgQZ1/4EpQIvIJYVH4YERiGahl8h/FfDTEfTEDCYy6dNiJi10sZ2R9dNFZ+vI//kbIO
         V0PA8VS23a7lF0ycsD9t9p1vxdxq8pHgp4K4EG3z5BXeXOSH9TwXxrNadkSyLfpR25VI
         UAk032GOGNdJG6UzNVasYlEV8OQMGFCet4Nl6z3UMJjBEpTj8jKo8xrI+8IvxwoTuplm
         /UMPFPdNv1J5obiULEurzzAXQIkL6a/cqS89IAtbDIEPX+QpwbPD2lENMHIzm+I71EoV
         o4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002863; x=1735607663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ov79tpw4GuAmAWp+brDBEww96U26TW/4D2kYy+uPe/w=;
        b=Q4zasHg3ceWYTC+9hDpPlcIcw8ipGkrlvyDy2Fizer4TSO+esEYadtmxkVvpS8qUX/
         aeOsaKwzRUJtT72nGZOp4HLkgtM5GEHV4TA0NdVNnFSCWWJWBS7nZks403EV0iIrPbxP
         /zHtHXs+qTHoUFyzk4F11ypalINhhUOKVsuM7UJlldk8MZ+6RSGr4vzWiKLuQyMlHmHd
         UZoTfkEh0UMwafIQqWPtUa9QLAkKzc/QnRpOzdRNQQ7670+D80dhuhKMcQuJj+MlpK75
         WaSq7iuQC2E3iM/Kj0YANf2jBMPR0Fd0Olfa7TSfdNTRLUToRE0GfC4z31KemWzkkKiO
         JlVg==
X-Forwarded-Encrypted: i=1; AJvYcCX5kxe+yjiAd3g5CiX94T/kw1DIDiDOafsxlidwi0OgXeCfcHedyXN7x9v2sc/w9tlqqV/Qc4lT@vger.kernel.org
X-Gm-Message-State: AOJu0YxazMmGWbDWSm6UpblXE1hVUsf4deqZmr4rG0HMc3jsFtZTfcWo
	zl0UqmMpmZCcFPK8ZwjEUBMpP8wOHVrEYTe6WGEro1zHdXd7jrbE
X-Gm-Gg: ASbGncsohkNXKphzceoAbQHe+MbHCONxz9rJ94pA1lmoeSRVievkAhOQUr+ZWeDnBF9
	jpmYPuTqlKHCpIsLmJp8q9diJox2/7EM5Bm55/cj272wxHHE855q3U8BIXYTph5I4tVwHbawef9
	XX28bnoRZOdCWtYmbOAN/mY2y34jkoBlm4eAufzlDyRzrK8v/a/ulFQl/CPEe/8VWZDj30KizQ3
	BpUgHgBoAATPF2yGk2kSmg0MQ95Rps7ovKvUsZ6+smv45bwv22l9GCIEYe571ZkooNJVqZDBXtF
	T7dkKg7axB7RHckMYQ==
X-Google-Smtp-Source: AGHT+IEY86iGVikNx6UUKQVMCZN+fQ5IPsxtPbnuy3ffrZykI3u8eUI1nnnwBtZavbsacJHzUOJQqg==
X-Received: by 2002:a17:90b:5251:b0:2f2:a90e:74ef with SMTP id 98e67ed59e1d1-2f44353f0b2mr28673142a91.1.1735002861637;
        Mon, 23 Dec 2024 17:14:21 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:21 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 6/9 RFC] cgroup: isolate base stat flush
Date: Mon, 23 Dec 2024 17:13:59 -0800
Message-ID: <20241224011402.134009-7-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241224011402.134009-1-inwardvessel@gmail.com>
References: <20241224011402.134009-1-inwardvessel@gmail.com>
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


