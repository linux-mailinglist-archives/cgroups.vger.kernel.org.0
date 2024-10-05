Return-Path: <cgroups+bounces-5039-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D86991AF5
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA6B283E56
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332AD1714B2;
	Sat,  5 Oct 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCYkOdwE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CF170828;
	Sat,  5 Oct 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165006; cv=none; b=b2M+eeFt7/4RWQe7/g4ldTKGTzpTSvmTsMEXSbC6hgIAEwM7+XDNsC+da4QNK7RwOBnQ5FLfpJPZm9iH6atC/T/Mbd8qqNTleif6pUvsLQ5pGDVTMjftAEPU32AffTrQOJlXVQm9uG8kTLNOgry6P+VrCnIePODEmPYeIpkqrzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165006; c=relaxed/simple;
	bh=FIuweSrtG+mcEyXr9hjv2sE4Z6ooLACWb0fLKdJTkfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZjH1kbY0Dh//guDBPci3dP+Iv1tY/IaxHsS/CL5FST9mp/edBw9IXXS2L10tKLQWv9wU3Zoi/8Iy5HKf1GHmPKHfRsAusPBKTSvDGdKLjIfjFkBJHyQ47V0i2K0LNLFlNX0q6ptw5bk1h4ND7/3WWuuqCQzFGb3NWYiXnynoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCYkOdwE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-207115e3056so29609755ad.2;
        Sat, 05 Oct 2024 14:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165004; x=1728769804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy+fzQoGdpErgau5hKCbmSyfAtB1CVjWDNKSp3x5/6M=;
        b=QCYkOdwEuBffkxGl39lEZRXDyJKpad18cUGT0t4/I+Yi2atLYPROek2+E1n2/pYt7l
         DCkSMsER6Dxs4JL5gzJGEJzBwKvPMeUOaIaM5UpiD06YD6vIOJTtk/24mlqCDFs0X0Dy
         jIxtpZIcH/GiyNwJF95BJWdWROz1Oswfvkf6u2G5+M6YA1S9SVJAkDyGrDfazz9UFPdF
         r4f9tBwOArOuGg52tnbQn86BgDhW1m3l9zF4Zv0nzsODD81R981TQd9Nw2dfFq5PkavH
         ptmX1qbG7pDOHK1XWyzrQNPi6BIY0eK2ozWj9yDtIT36mOzAJtMvbrhjjUVCpVoAy8UH
         dZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165004; x=1728769804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy+fzQoGdpErgau5hKCbmSyfAtB1CVjWDNKSp3x5/6M=;
        b=TkMx50lZOV1rszUQpR7y6gb6iZ3PjF2wpK96EjjYHpbXu2ZhwjZ4F1v+j66mEK5ROG
         arF9rWTS13F0YcyPRbr+7GJylIgxFqBr0LvDgbg1RoQU1s8ezspZrtbPmafMKbYC+rHe
         7vHcoDzPKdMX/y9H/9ueu/YwCNEfnmi8vjENWHaSJoV4+UgSgkwS48/th7Zjrm0jGJ4v
         43/UPV5UGOF45f+w1iwCSN2jkHzA4xqBMo32GVWTPTqlMOo178ZXjyenEGJMRzDQaXtB
         vsL9jgTUdR06424N88nrTMm8BTqbArEbqr7xB7EL3wFOxSuIo0H+5khtCmuO2nQXklSL
         T8hA==
X-Forwarded-Encrypted: i=1; AJvYcCVmbKWL3Ku3mmGyw9miscPv1prO8F1HLy+PF4ocv7BlyteJcCUPNGZoIFSsIfPBZTuyY8YoVTdv@vger.kernel.org, AJvYcCVuRSQm7Ap265ZDkkMous9qSN2F5bTU0BXEXsy/cNC56wk9ue052McLe8xFhOs5NM2Aki6sapC7B7eXp1m4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2IfKqXyDeE07I+w3afZSEz5Tvst6YhB63rMnI+ND8WJaHPTqf
	ct4kkFHT0HQdPxIRfTAI6ro2ZjGzt6H25ID04bRFFKZZhjwF8FSb
X-Google-Smtp-Source: AGHT+IFjm3s5QoZ8Wvo6+zkWC9E/2NcwqZAvehzgcrJPMMFjq0tbvkUUMfyWoM/7lRqDJxBRu/yxcA==
X-Received: by 2002:a17:903:41ce:b0:20b:b39d:9735 with SMTP id d9443c01a7336-20bff1b044cmr95796015ad.54.1728165003852;
        Sat, 05 Oct 2024 14:50:03 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:50:03 -0700 (PDT)
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
Subject: [PATCH 2/5] lib/union_find: Change uf_union() return type to bool
Date: Sun,  6 Oct 2024 05:49:35 +0800
Message-Id: <20241005214938.2147393-3-visitorckw@gmail.com>
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

Modify the uf_union() function to return a bool indicating whether a
merge occurred. If the two nodes belong to the same set, the function
returns false, indicating no merge took place. Otherwise, it completes
the merge and returns true. This change allows the caller to easily
determine the number of distinct groups by tracking successful merges,
enhancing the usability of the Union-Find implementation.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/union_find.h | 2 +-
 lib/union_find.c           | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/union_find.h b/include/linux/union_find.h
index cfd49263c138..45c1a6fc6574 100644
--- a/include/linux/union_find.h
+++ b/include/linux/union_find.h
@@ -36,6 +36,6 @@ static inline void uf_node_init(struct uf_node *node)
 struct uf_node *uf_find(struct uf_node *node);
 
 /* Merge two intersecting nodes */
-void uf_union(struct uf_node *node1, struct uf_node *node2);
+bool uf_union(struct uf_node *node1, struct uf_node *node2);
 
 #endif /* __LINUX_UNION_FIND_H */
diff --git a/lib/union_find.c b/lib/union_find.c
index c9fd30b8059c..a20678da0220 100644
--- a/lib/union_find.c
+++ b/lib/union_find.c
@@ -31,14 +31,16 @@ EXPORT_SYMBOL(uf_find);
  *
  * This function merges the sets containing node1 and node2, by comparing
  * the ranks to keep the tree balanced.
+ *
+ * Returns true if the sets were merged, false if they were already in the same set.
  */
-void uf_union(struct uf_node *node1, struct uf_node *node2)
+bool uf_union(struct uf_node *node1, struct uf_node *node2)
 {
 	struct uf_node *root1 = uf_find(node1);
 	struct uf_node *root2 = uf_find(node2);
 
 	if (root1 == root2)
-		return;
+		return false;
 
 	if (root1->rank < root2->rank) {
 		root1->parent = root2;
@@ -48,5 +50,7 @@ void uf_union(struct uf_node *node1, struct uf_node *node2)
 		root2->parent = root1;
 		root1->rank++;
 	}
+
+	return true;
 }
 EXPORT_SYMBOL(uf_union);
-- 
2.34.1


