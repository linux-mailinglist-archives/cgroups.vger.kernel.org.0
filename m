Return-Path: <cgroups+bounces-5042-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECE991AFF
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA091C217CD
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9D17799F;
	Sat,  5 Oct 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGE/D3xP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2B176FB8;
	Sat,  5 Oct 2024 21:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165016; cv=none; b=K3SoAFJ59HjddyPTRujUW//eFNtBaTk+u3eZkJuAAiOfrN3gx7nai3riuKOPSYH5bBpS33zrSC5dkNC86sgzpLffTBnZpXdNnO9eSka8gm2FE6lu3509hJSPa+YoyZnTqYU4dEuVUAStGMI/meuovQQMH3+PMAJ3vVW3plenbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165016; c=relaxed/simple;
	bh=i/BhTFLd48HomWyz8xZC68ePjxoABU2y+lp5CSpHwuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZUykJ/FdD0RIgIZ5Sh0wODsoSuX/7sWr2o/6U5CQLwHmw3ob7iArel+s14n5eDPIA1oY0ZHtVRn85YW991rGY0nXdoQlxodY1UEMu1QHTrDjJWui+vR+/Wois7ItKxMsqkxYwa1cTUrUf64st4caenJEZ7Gf6KokHF22lnNinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGE/D3xP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7259be6fso36227355ad.0;
        Sat, 05 Oct 2024 14:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165014; x=1728769814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeXtZC/fnaI3e4fw3nt3kTvuPSe90+rJIZz1Zw6u5CM=;
        b=RGE/D3xPCa/5c0YdF4XgcpwPXqGJl3XAg+5V+GTGbKABwPs+vRYXO5SwncbUJn+Yec
         dqhNjavRE/gRzabgOfuSD6FmrIw/naoKQPHm+d8exfHBlYi/X4ukH+lT8+6v65P4uClx
         G8lyW2/7K1QfQi/2vLpRkEb29+xH1y35CMQcdPObgKG0KoWWbX7ltemparYyZ8W+595H
         Dw6j7cEy8uZimLtsqZbSUPoQvM7g89DAvmp0K5zsLFXzFJATEyUHupD8+VsjDFby+8D9
         7U/Xp25IJ9W6ESh2MBmk9IEgVeTXlGkRiDisxr49wWWSGYJiZNXOQlw+bjt0flwlzQXO
         DCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165014; x=1728769814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeXtZC/fnaI3e4fw3nt3kTvuPSe90+rJIZz1Zw6u5CM=;
        b=BDQvXXgX/m/7QCXeivWeXtO8ZeAgPv9CX2i6G2Ptxkmqtpd1vFs3/bzpdzboibQQ9C
         3aYuP0d2T0nwWBAIcWzctAa/Tsan1ltSBO+k5l/G4pfElS15ZXbqroruaEWGYPajQXg3
         Ui5qsCjMOTBudD5SjN8hTj7tVzLd5gF4Cr0bj/7ZrIbz8pwxI6k/ot/07RlbBC5CkuRk
         d6FS4T4dlrpcKtcjRfBr26GA/UCrvmTEMhdJMVMz8KIXjFsWp0ThJ/3fPNYV06zTq20N
         9EGqGljJdtjseIjE9WARaHCHuAi6wEs0u6rWlAFishDAiQ/6+WNVJgWIeZGd3JpWjVIc
         rvrA==
X-Forwarded-Encrypted: i=1; AJvYcCV6RDcJqoYrrnAg1LoeYTVSL9kApX6SSqq2+f3lQ1zWeg9EecJU49uCIj2II9vkY0QSuRouVpeFKo3TjC7F@vger.kernel.org, AJvYcCVTLe7g0Ou7zDWoMDsiowR97CHSSDM8KhB/cEwBaM/1wR39DwB+Rfw2TFNb0UoRrNwTh4exhSIN@vger.kernel.org
X-Gm-Message-State: AOJu0YwHIBjZsBK4aA9Ps9nXlQZ+Oz+dFjSsT10GYygpd1x38uiz9CoF
	x1nR99r33WkYfqhCR9FehVK/D8h4I75YcOsbo6FptmjKXa0L1omJ2uYD/w==
X-Google-Smtp-Source: AGHT+IGJUD/oCRSpFBXNVaQbMpQpROalL480XnaY1oZ2gclVXGNcQnL7cRD4PLhtmkqn1wNPhgTXNg==
X-Received: by 2002:a17:902:e74c:b0:206:9a3f:15e5 with SMTP id d9443c01a7336-20bfe043018mr105109485ad.32.1728165014380;
        Sat, 05 Oct 2024 14:50:14 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:50:13 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 5/5] cgroup/cpuset: Optimize total domain count using updated uf_union()
Date: Sun,  6 Oct 2024 05:49:38 +0800
Message-Id: <20241005214938.2147393-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241005214938.2147393-1-visitorckw@gmail.com>
References: <20241005214938.2147393-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the efficiency of calculating the total number of scheduling
domains by using the updated uf_union function, which now returns a
boolean to indicate if a merge occurred. Previously, an additional loop
was needed to count root nodes for distinct groups. With this change,
each successful merge reduces the domain count (ndoms) directly,
eliminating the need for the final loop and enhancing performance.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Tested with test_cpuset_prs.sh

 kernel/cgroup/cpuset.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a4dd285cdf39..5e9301550d43 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -817,6 +817,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	if (root_load_balance && (csn == 1))
 		goto single_root_domain;
 
+	ndoms = csn;
+
 	for (i = 0; i < csn; i++)
 		uf_node_init(&csa[i]->node);
 
@@ -829,17 +831,11 @@ static int generate_sched_domains(cpumask_var_t **domains,
 				 * partition root cpusets.
 				 */
 				WARN_ON_ONCE(cgrpv2);
-				uf_union(&csa[i]->node, &csa[j]->node);
+				ndoms -= uf_union(&csa[i]->node, &csa[j]->node);
 			}
 		}
 	}
 
-	/* Count the total number of domains */
-	for (i = 0; i < csn; i++) {
-		if (uf_find(&csa[i]->node) == &csa[i]->node)
-			ndoms++;
-	}
-
 	/*
 	 * Now we know how many domains to create.
 	 * Convert <csn, csa> to <ndoms, doms> and populate cpu masks.
-- 
2.34.1


