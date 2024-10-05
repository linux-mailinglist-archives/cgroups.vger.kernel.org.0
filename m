Return-Path: <cgroups+bounces-5041-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D1E991AFD
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A761E2813C2
	for <lists+cgroups@lfdr.de>; Sat,  5 Oct 2024 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDB16F0EC;
	Sat,  5 Oct 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkr43FEr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA4175D34;
	Sat,  5 Oct 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165012; cv=none; b=rMaLk0zFGQgt0o9CBjdEkBz2Pkqqb5TXZ/SA8fk6VS5B9VLuxTTzew2BOVWsaI2L1UY6JIa9CFjcoKc3X3zkyM8NtDUTiMROXY86x9AEN2xhga9g3npxQOn+Lpfcv7f4WDdWrAHqMVc4n6+R/xwSpFgD0LkJxrtFDU6ACwa1uvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165012; c=relaxed/simple;
	bh=aAgtS/55DGRhNRVzeHNfrp0NQH4YCxQhxRW5I5lgpBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gd65VtgL8WJlteL6AFqn8SslYkh5GVucbNDZpZfQBglLhf+PijL+GZfCYFcKygEsutCNPGh8QtEPsjf1xMjlXDbhHWXL5370VdhBHCZfxIQChXlbgAih2uRW74PClrqX0vc45KoHqyeYW5iSEUlQy0kS9uxJumof4UNHm5GrJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkr43FEr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b01da232aso25805585ad.1;
        Sat, 05 Oct 2024 14:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728165010; x=1728769810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/RDd3OgykNkc6odsd6hV7b7AYM8gkhtHwhum24D1j4=;
        b=lkr43FEraOaIYxSa8sPkuKRx1sKNpaJdKf/NR3IE/kN7w5eNphm1zpDrZid1YiD3mU
         WFACPLvcf+yUaSdMtyGs2p0SGHeehaMcJ0KCtK8vDtnM4f40invhgDDlqgRhDDlhxdCK
         G6NyYKauEGJm7khluSvBpD2R7arpi77kvyjwJLNFhU50OmuIji71A8ZvwtgE8ToVKM5x
         699/rRn0++dlGAkNjkGOanLzxsDNg5FJYS/nsbgKIsmOfmaEQN8M2zqUbZuBDd+avPts
         ZSpunJ7le1OXzwmH+b+g2VKIC254PEd5DHC0vZ5HXa09bEs3mbzXxs22iNLZjpNAfX9g
         rgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728165010; x=1728769810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/RDd3OgykNkc6odsd6hV7b7AYM8gkhtHwhum24D1j4=;
        b=CXvzu19kl7GDkhoym+TreED3/bR7UJjT7ecTc8zDFAJx0MCk5cYSKbUS6EiFHiD2tw
         4osR07JSAYehsgRXY1oUSgqUgGR2lfckOseLJa2X1U+zOZXpxN4Qrpw7YsluBS7LY3Ty
         IqPqUeK3DW9+hjTCCZx41dND9jNwyEo29mb8hMPI270l457aQds0DkSrq0TJxWSX0XtR
         WGzCO+AouEuf/Y1ukWDsFC9ruZPhfq2tCppBTViLhwcqO37R2L+tXE3gHggD7wCcF7wK
         l/zOa3EahhhSioPei0uPGziiieOWLxFXd8T+shQW6q+UN4VoKGWAe5zneGXK1xMCwmau
         /4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl+nmWE0rHnqSsTI62plgsul6KdfqiJiSU8TFspT2nReDOscCt3zr5RjPmRPU9eQ3un4QdfCtoM58SOyY5@vger.kernel.org, AJvYcCXzH39y0n3Y8isAzhTGF358XPpaRgW8sag0y6TY38r9/lqzDKEuQ64yW61ua4NVBD6r1CwPndBA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vqvkQQZS5zyfn5f1mZLCvGPwXL65Yf5A1X099FUV/O5pLoqt
	K+T9+OBgew1zqi6AhQcHxQ4AqDiaNCrC9o4r2zMmMNtTDw57igcb
X-Google-Smtp-Source: AGHT+IHkN85dFaHZp7eUqo5HXHSdqmnGE12VAhz/SoR3WLlRAERNoJSPWeMi/AYuB1cCyrPrjJZMaQ==
X-Received: by 2002:a17:903:1c9:b0:20b:5ef8:10a6 with SMTP id d9443c01a7336-20bff391262mr103385635ad.8.1728165010287;
        Sat, 05 Oct 2024 14:50:10 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13931055sm17165135ad.139.2024.10.05.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:50:09 -0700 (PDT)
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
Subject: [PATCH 4/5] lib/union_find: Optimize uf_find() with enhanced path compression
Date: Sun,  6 Oct 2024 05:49:37 +0800
Message-Id: <20241005214938.2147393-5-visitorckw@gmail.com>
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

Optimize the uf_find() function to enhance its efficiency by
implementing a more effective path compression strategy. The original
implementation only updated the parent pointer of the current node to
its grandparent, resulting in a relatively shallow tree.

In the updated version, once the root of the node is identified, all
nodes along the search path are updated to directly point to the root.
This change minimizes the height of the tree and improves the
efficiency for subsequent find operations, providing better performance
for the Union-Find data structure.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Note: Tested with the KUnit tests introduced in the previous patch.

 lib/union_find.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/union_find.c b/lib/union_find.c
index a20678da0220..7c553fa622c8 100644
--- a/lib/union_find.c
+++ b/lib/union_find.c
@@ -13,14 +13,19 @@
  */
 struct uf_node *uf_find(struct uf_node *node)
 {
+	struct uf_node *root = node;
 	struct uf_node *parent;
 
+	while (root->parent != root)
+		root = root->parent;
+
 	while (node->parent != node) {
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


