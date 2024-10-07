Return-Path: <cgroups+bounces-5049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55658993129
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869BD1C202C9
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8F1DA634;
	Mon,  7 Oct 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGmugt15"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE611DA60F;
	Mon,  7 Oct 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314940; cv=none; b=Q3wmg0IuY7ScTmU+AqtDQPDphO/jnBV3zPpjKL5OmxKSFbRD0Pe8zEyievct/VfqV5/NbE4BBamn1bumvZQc/SdJR7U7AQrUIayY1po7Y1vTKL38jbbkSCYNYNJUtQLOO8HzTixhffVsO/JISv1atLnrMS7+mhQIwo5/98Edztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314940; c=relaxed/simple;
	bh=gTjP83WTuybGiDFLufp9WtByb/SPoKCyFhxnlBLVOQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9Vewq775u/Svd3o79J+lgG71NZXmPb2U6nCptgJ+rI20qv1vI2S7ZfFQXk/sO5dGzJAp+BLHDW0tgyUdfjK9uJC8/uEeRZh6ALCDBY2whu9V85h03fWiP+133ZG2LGGCNXD6cEIWgXetzL36JNfrHkPsqvck6fxL7NNqYxZ6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGmugt15; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df4620966so1925759b3a.0;
        Mon, 07 Oct 2024 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314938; x=1728919738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcMNpzO9xVZEqN5WJI+Z0rS/5IVpbeChfW9TRj+rYMw=;
        b=dGmugt15sbULWFc8yTf0ifaVHlKchG0WDSzhxJvgl/NuvMB7H3MSPNQFXChIwkNHUn
         YxFrPVqu8zyFmIdu6iAnPbrPSKPJdBlZtcyY/r0hePHeQMPHQ/lQWG8j7r0wpZSfWIvi
         b9ESOWTzFegbCNmP7r0dFfizBIPKeY2QK/xRr3ALbcpy1bazVegjllu6sb36Wi/IOJtl
         Z1MH67Y3LSI2I1NYR8pSuC60Azt/ML82AYV9CNDMCtsfEpiHsKtIcfEOTINL4gkHhjLS
         Nh22gSwG3GyZ1cXzXM46NH6KId1pWl8yJgJnZMsjYUSNme2TgQ1fK8tQ6d4zXDu2l4PI
         jXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314938; x=1728919738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcMNpzO9xVZEqN5WJI+Z0rS/5IVpbeChfW9TRj+rYMw=;
        b=qDHfOhubGWcNq2ApmAdHn2FXRvc3qQwOVZF/n9q6Ln5Qx3SbtBxmy7+Lh+BnOoY+ef
         FqMhZep9kZyIXUTdjqW7HPtsABI7GndV1Ipp/wFB639A1jquF8egd3r72/vjsFvIBOjO
         8q5Bt2p4moxjQfnZmIh0UANU55UZ+3/+m145+yLaNzHyfn7/CKlBL/QNEr1+yWS2YuSO
         0dLgcxbhZcoagne1BSw/YHIRJu7G4HXetl90bvpXt062mxTzREgY9upmULahKUZCey/D
         k80gT/UArlH9LWnTbnQs/o3Kzv1mDMTcvV8COVkSeEYiKGZHmG5BU1LgJ+v9djyJZiue
         1ImQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZsmcg+tMrcTJuDiC4FuJ+EUTuMw2Peduox8TewxmDertmEX8t7vXFh+Jed/wRoidgkqcokz/slY29pGoI@vger.kernel.org, AJvYcCXKeSnCT4OYrkOvXXnr1V/YUYKMtksaVdeHrIi4IXXlNZ1+XQU4WT+w+/FyNf3LszLlCzdP6D2J@vger.kernel.org
X-Gm-Message-State: AOJu0YzFBoqjD39R6J5iA2dvw9VNhOnpfxTi9v/dp8i8EkmR8rsGLjCG
	A+mY/UaVED9SsQW4GwWKNdJPI3/rlww4mHJfOekxYFKGzEeYyMn9
X-Google-Smtp-Source: AGHT+IFwU/p1ltG4BTXRfs8ffnBeYCy9p4lErF47u4sf4jnfTruMYwUh6Tohx6NLVKOYBv/8bI7xng==
X-Received: by 2002:a05:6a20:1d98:b0:1d2:eb9d:9973 with SMTP id adf61e73a8af0-1d6dfabb82amr17414312637.39.1728314937823;
        Mon, 07 Oct 2024 08:28:57 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:28:57 -0700 (PDT)
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
Subject: [PATCH v2 4/6] lib/union_find: Optimize uf_find() with enhanced path compression
Date: Mon,  7 Oct 2024 23:28:31 +0800
Message-Id: <20241007152833.2282199-5-visitorckw@gmail.com>
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

Optimize the uf_find() function to enhance its efficiency by
implementing a more effective path compression strategy. The original
implementation only updated the parent pointer of the current node to
its grandparent, resulting in a relatively shallow tree.

In the updated version, once the root of the node is identified, all
nodes along the search path are updated to directly point to the root.
This change minimizes the height of the tree and improves the
efficiency for subsequent find operations, providing better performance
for the union-find data structure.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Tested with the KUnit tests introduced in the previous patch.

 lib/union_find.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/lib/union_find.c b/lib/union_find.c
index a20678da0220..d2b79065cbc8 100644
--- a/lib/union_find.c
+++ b/lib/union_find.c
@@ -13,14 +13,19 @@
  */
 struct uf_node *uf_find(struct uf_node *node)
 {
+	struct uf_node *root = node;
 	struct uf_node *parent;
 
-	while (node->parent != node) {
+	while (root->parent != root)
+		root = root->parent;
+
+	while (node->parent != root) {
 		parent = node->parent;
-		node->parent = parent->parent;
+		node->parent = root;
 		node = parent;
 	}
-	return node;
+
+	return root;
 }
 EXPORT_SYMBOL(uf_find);
 
-- 
2.34.1


