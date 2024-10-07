Return-Path: <cgroups+bounces-5047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB50993123
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B91F231D8
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D391D95BC;
	Mon,  7 Oct 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQzccLln"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9BE1D9593;
	Mon,  7 Oct 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314933; cv=none; b=orYVmXD45K0BMz/3bJyfk1wWGuPlTGxiJxcwHt5nYjp3x0Eht/3TEfB10G0mUOYpsd4zVrQRY+qVUh9ezXRq7Qk3j1w7KBTrNvWCDoEPm8Li4ftobK7Jz1CKbWvVHBPuCZv4Mn3ezTjSWmuE5cTMZTyKLhBQv4ArTSmoy5v9nOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314933; c=relaxed/simple;
	bh=pmII0JW/KQDCNY1pEAAKxAI6HvOubKGy6U2Nj7h8+N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5vhA+L0KUWsvAmgmh95BSkyC8QQbXCNJngadg/jYkRG79nKsge34k1XcOAAbN1GO34JpNQCmWcikCHGMAdLewp7mH9QAnSPvhe0QCmuW2oYFvisRFeKwpZeq9ZUNerxpiyP+uCfm/xvSu3K9n1Orpf1zh2NNG9C07QM59sJ6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQzccLln; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710da656c0bso1758157a34.0;
        Mon, 07 Oct 2024 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314931; x=1728919731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClTLohECAof//FoFt3H1m3SEt+JHyEO+9qrUd3WdsjQ=;
        b=GQzccLlnVaxzJmPTwic39lv/wcYy5GIM/eURy82EAoKi0Q65Gu/YMzi8TTu5IityF0
         L9o+krmbWUWneNnNwWi6YCN8z3rifRuup43ae4c0I0WMRsQkcGV6zalBK2rMHl8qkKHE
         1CXUk3arVWM1GrFG58am8zKduO92mWE/fjZh4nSKTgXTojCG2m2Jbov0n1nG/YZmW4/h
         Wq3Ivgif9QfmWSd7QsQASdOChDYp+xsFTuld4qSupUq4nEgOo2BCmxszTlCKX3tN93uv
         njnJtO/9x19xMi9DIM2Bl4ryWpZzE3zCeKwjVVqPpGr8Jmz4MQM9+FoqfYTPVahs5/o9
         JxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314931; x=1728919731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClTLohECAof//FoFt3H1m3SEt+JHyEO+9qrUd3WdsjQ=;
        b=No/qbNAuQucrpfubG0wn5uUpiiSDOCt7f0z/JXYGqic3bAq+HFWxwidqXn6gGVy9Ap
         7BDWVDQojQbAbk3f+thcTZe+ik1q7EAzpxKsMC1O9pThL9z44FYbj9LCG/jMAn9nFOSK
         G/lFeQ7SGVF7BRv5nw042FrFnrNNzMQY+fJRgyELhIx1MjeiIyV1+m44eDUQHpglju4+
         kF3myEZ528rY+ezCadYxEFr63uEyp7YRyfwJ4aBLcut+5rX7MbIygc+L5k9gXEmSMWYZ
         EqkcTpEdWlGZOMEHE7MM++4v+OGPlnFSvYJkMaksWlzt+OZr9PjTINFIcp4vw5Yj/5U9
         YlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEb53QSnIyyy0OVjZuZDmzSCeqkXPEuf1uaET8A2DL7APxJxjo0gsmhYKZMqEPQqZS+ViGXuHarZrCgUSA@vger.kernel.org, AJvYcCXIANHU+a2+VCR59MkPjXt7fAzntMyr9TN2wIX2a14FL/YnazdWJsgmq+BToD2AA4oh/8d+14Gw@vger.kernel.org
X-Gm-Message-State: AOJu0YzPll/LlrdYKmntkbk9L3jwgmxBDHJzUuOG4mla/WqY7y83H8XU
	wV9kiCEdNtT6i6Eott6fbzb6YLfw2gTV6DYg2k8nG8QTT4TNCpJn
X-Google-Smtp-Source: AGHT+IGPFkSciSx6WIIbL+g3mcSC01w5WNqKfZ6UyyRwmbJxKmqft2jt9SQbyco8ycn9HnFWeYmqlA==
X-Received: by 2002:a05:6830:a91:b0:712:4021:b043 with SMTP id 46e09a7af769-7154e97c082mr8285195a34.23.1728314930976;
        Mon, 07 Oct 2024 08:28:50 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:28:50 -0700 (PDT)
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
Subject: [PATCH v2 2/6] lib/union_find: Change uf_union() return type to bool
Date: Mon,  7 Oct 2024 23:28:29 +0800
Message-Id: <20241007152833.2282199-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007152833.2282199-1-visitorckw@gmail.com>
References: <20241007152833.2282199-1-visitorckw@gmail.com>
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
enhancing the usability of the union-find implementation.

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


