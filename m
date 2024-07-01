Return-Path: <cgroups+bounces-3475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A195C91EB90
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 01:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FE6282637
	for <lists+cgroups@lfdr.de>; Mon,  1 Jul 2024 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAC172BDB;
	Mon,  1 Jul 2024 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LkRlqxtb"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665C502A9;
	Mon,  1 Jul 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877784; cv=none; b=FbyKWhfay6V4Mhf18HXGpIcL3Af5tCDS1XMwGDNr4HAwKgXF8PtXMisn6njvsSuqEEClewxjEut0aTzEA93pfFsJ46JvtrA1CKtCPYSt10YoSnECW4QsgOuXt9DDswskNgOAtBWTSN7fi4UDLVrRUarDFNP6HdenOTgf2b3hgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877784; c=relaxed/simple;
	bh=8MNobYcS3M11m270gQEQ/d7cseauXHIOlPsDi1L/Co0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEIsJZAnYRgumyirTqeGwmhcWQHdK1BikbEQPuI1Aj3YMBdGtPsj/yZCXpm7b7KUIfU3drPgI3thhHEY3aMs9222QG2DElCrnF7Fk3a+eutPxDjlpayrB3ID+U90h22CErvWdGqlqzTA96CgIZvifTgFTtLhGHnNhCbUe6ceKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LkRlqxtb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=C9hPq27IUlrZo7/Uc/eSJ/ts9B8NQnWRiLfyrurlNYo=; b=LkRlqxtbe0fIKGRtCDBW8zKRJg
	JmEdI8bv11WHWYhnu9l/D1LXniD2KNQlDOroVq5ucG69PioaAjRIjym094VemZ0qbpdSJkFxgjxEU
	7dWfm7SUlTJPNasqSdm92nEUfeNLuLOYu0bpnHgcZFiDfArx8MpNF2nsHVoi69XjWgvQFu3GqqVs3
	rG4HSBUvOje3f2divUkKBaeYQ3ixOJHol0YA/CGipIVmS2IAeHNY7KoZM0GeM+9BB8RrTB54gDK8e
	TmSXTCOX9EcUkx4GnpUNsph0fMzNKW9aaDPLtypp75yp/0eQkUpVXn4HTcevLiio4ThAXTkJkKyWO
	+jXs95NA==;
Received: from [50.53.4.147] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOQmA-000000057IR-1KLU;
	Mon, 01 Jul 2024 23:49:40 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	cgroups@vger.kernel.org,
	Vipin Sharma <vipinsh@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] cgroup_misc: add kernel-doc comments for enum misc_res_type
Date: Mon,  1 Jul 2024 16:49:37 -0700
Message-ID: <20240701234937.8234-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fully document enum misc_res_type with kernel-doc comments to prevent
kernel-doc warnings:

misc_cgroup.h:12: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Types of misc cgroup entries supported by the host.
misc_cgroup.h:12: warning: missing initial short description on line:
 * Types of misc cgroup entries supported by the host.

Fixes: a72232eabdfc ("cgroup: Add misc cgroup controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: cgroups@vger.kernel.org
---
Cc: Vipin Sharma <vipinsh@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>

 include/linux/misc_cgroup.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -- a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -9,15 +9,16 @@
 #define _MISC_CGROUP_H_
 
 /**
- * Types of misc cgroup entries supported by the host.
+ * enum misc_res_type - Types of misc cgroup entries supported by the host.
  */
 enum misc_res_type {
 #ifdef CONFIG_KVM_AMD_SEV
-	/* AMD SEV ASIDs resource */
+	/** @MISC_CG_RES_SEV: AMD SEV ASIDs resource */
 	MISC_CG_RES_SEV,
-	/* AMD SEV-ES ASIDs resource */
+	/** @MISC_CG_RES_SEV_ES: AMD SEV-ES ASIDs resource */
 	MISC_CG_RES_SEV_ES,
 #endif
+	/** @MISC_CG_RES_TYPES: count of enum misc_res_type constants */
 	MISC_CG_RES_TYPES
 };
 

