Return-Path: <cgroups+bounces-6003-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8399FB830
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCBF1646BE
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2AC8FE;
	Tue, 24 Dec 2024 01:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbbGetKj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08027C2F2
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002867; cv=none; b=aIhNK3qDDr+76cSEVrSbrHyKefB2M3O/2LwrjYQmZlSHfg5IwW2tIamgnj5TvoMElxRq8hhz0mKDxO55Sc5cW1Lx9FuEFuqDnw0tf1UU4ZdgMjE6ZARmXJpUgwCRyu1ibrEtqnGOuGyZwYteF5QJEbERh5cOpw1Ag1Tv8KzzBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002867; c=relaxed/simple;
	bh=E/baAJMBti0GI30IMJI/idyMjj/Pxi0JFqUU0zDaUn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzHru8ixXdgFxY2CUsXelbUGO49M+GLtnSkzpCueD1ur8KyM4/U+FHDuAH+gZ6msTAq050eGhpy5a2Rr3oFS00O0iDpA4Xy0RrOHX//Ft/TPS913thpTYGM8xMV6QUSdAOi2fmv9YrKtbVibO7p5zPtGbz5G3RWuVAKnexm4nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbbGetKj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216395e151bso32442015ad.0
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002865; x=1735607665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm9yai/osEcIq2t3vZy97c5K46GB7iT4Bhg8cC3aZ6k=;
        b=nbbGetKjmIvyasQXjaf5aMe35KMACibDn6SwlXPN3Rrz3pjr1bw3X2C1acYjEsCFQ7
         f7FW91P/SxjBBCqS1gnSCHyPRY9O/ckqYGXz5PglyXiX/kCKDv9H8lta7oxyORCvj89x
         1/aGn2F03btAO0nJ459j1yJULOlsnbJzUJoRa6aX8y7JNe9wwF5ny3P0LJiu+XdzJiFV
         eCAtNneJlO8Ki+il0ZhVqefV0EAYuMjyorny8Zp00G6Lemv9ILqjAyoXX6iOiJw6pIgz
         pEHHobIvna2uiw+xIWnbxUaY7JNxh2NSlgJIWBi58bpDQYMXhzvFcs5pxAYFNgRzlhJb
         hvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002865; x=1735607665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm9yai/osEcIq2t3vZy97c5K46GB7iT4Bhg8cC3aZ6k=;
        b=NlYb4hKAKmYtLi3hsrwIqvHaRmidOCKqAIgsow71Wkk+5AaV6ZdKpxZLJ6rAjUyj+t
         1I8763AcL+ccqen+5L2CQpdCwjeF6NhYtcerh9p+Y0phnmRRJq8oozBBysfZIx0xGRdW
         IbtbbL6nmwSs9FJ00pe7v8IBZWkhSbN6IDJ7HRxNTE0It0Lu6M+knqVkfrEIT98lODBL
         /40GrHzbBu/WhAFvCWXlgTc8BQkRGrjHYqjeHSuV4+D3LAa7Lr4CMzDtQjCoSkHF4Zzz
         B+iWoGFDyXMn7XsG6tObpv1WsC0ptXFxE0znGoHRdnjO7AXTbCQzvyEMJGUt0AarZ2Kn
         mGbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVob1IKH38el9ciGueINAqJMzcU+kgV4hC44X0sVhciL47NNr9wj4soij1U4dOR3wDoNIrNJC2I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9sAjB0f7nhOXgHEqmdPMuh/BNCBSQ3cm5FThX+FvhGjWUbEk+
	ZZvQfWY1GaxhGGfqkPd2kUg394I/gC7jLyVmYvfPe/2+TsCpO2FnlPQVuw==
X-Gm-Gg: ASbGnctLTlCiALJkuOVMGUwbAMk03SALub2+WXCj/T3+2PmUua4Ydmj02v56RqdXgMj
	BegSITbpJR4sfGRnCL7yVK9XunWQkvCBXbA4BdWfeJPF37a0FQc1+HR7H3CR017Y45KIo1ZOmnh
	0AzE9SRklI9/02CzU3mUejJbrB3wrs7RliaUnwk71zvOIZmQu5sZtvPa9t+4oh21RWSGrwv4Tpz
	7PK3Wpub/C3AEHUdBZy7NuojAsMJioX1srZ+Baxahk5UkvhQ75wLQmd/zNR6cezwP+DX45L4pCY
	29fxc9sIXguScHKcfg==
X-Google-Smtp-Source: AGHT+IEqRtFE3SjYN8vE3ZEp1iTgfgoCrR6J9QQ+lxWuXPA4f3+IfoIE2/oejmcZygYdV0QTvV6Ahw==
X-Received: by 2002:a17:902:f646:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-219e6ca6c61mr244012185ad.2.1735002865450;
        Mon, 23 Dec 2024 17:14:25 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:24 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 9/9 RFC] cgroup: avoid allocating rstat when flush func not present
Date: Mon, 23 Dec 2024 17:14:02 -0800
Message-ID: <20241224011402.134009-10-inwardvessel@gmail.com>
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

If a given subsystem is not the base type and does not have a flush
func, do not allocate.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/rstat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 03effaaf09a4..4feefa37fa46 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -423,6 +423,9 @@ int cgroup_rstat_init(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
+	if (css->ss && !css->ss->css_rstat_flush)
+		return 0;
+
 	/* the root cgrp css has rstat_cpu preallocated */
 	if (!css->rstat_cpu) {
 		css->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
@@ -445,6 +448,9 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 {
 	int cpu;
 
+	if (css->ss && !css->ss->css_rstat_flush)
+		return;
+
 	cgroup_rstat_flush(css);
 
 	/* sanity check */
-- 
2.47.1


