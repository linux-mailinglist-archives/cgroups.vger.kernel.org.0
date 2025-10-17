Return-Path: <cgroups+bounces-10837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0C5BE6E2B
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 09:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44ED91A63822
	for <lists+cgroups@lfdr.de>; Fri, 17 Oct 2025 07:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0981A310631;
	Fri, 17 Oct 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaFL/h9y"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25024166D;
	Fri, 17 Oct 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684865; cv=none; b=Qf0wV+PTuoOdVCGB9uNKOeQ2QHk7McLaaz5cQ4HXO9wJwZx/5k7m4oq3DQyFokzrfDhSflZ2VHpWZe3xJ+0AHSSWJD9llNFZUMuz9dn2nf1doauCfNgO1Gtf4peS/zukYzl6Fxx/uVbLGr8ScrA7jiz45YpHjTzOGnIBu+EojbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684865; c=relaxed/simple;
	bh=ldWk1lERh8XNGYXG6/Ucw/1RSMUP9zi8+wTgs/lOzTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1ja3fjDMQxq6ipfmtC4H/o4K3/dPxzMB7V5Z5TPz+tn5SYvaOQr0uFD5kGPQ7/BL2bxWKBcvE9QoLRO5c7U5gJ1HBfqaJdjmzJQ9zpr6L0wDK44wMB6Gs9NYgurNJq8E4OFYqjs0ueSgJo+RLzwEUKRiP6U6t/GF3lmhu7ojRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZaFL/h9y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+CSKeW83p2OdWvIZT7Y6au3SnhUitU5ATNyD1/Meewc=; b=ZaFL/h9yfsxC21mA+/fpSfVM/S
	/qGvGjLQ1yVGC6dU8j9PrNIY4QsTqu0YiaO+yjNHY3yXriS5OQEvmRFV4sVljdTehsPNATQSVAZXe
	drMEfyHHXqVw0F5xKOXCNoOdFxLq48fpArJyAvjBZy6Q9BWrV5+YdOtrdCAnN2MpCeDhm/a5ZclDJ
	RDtAwh74oxH85qvge1kQfRO9vfQYwsSuFG9kaO4uhWTZxOd1mgefWqOzvMtYyUNrnWuTWotjbB9Jb
	fPQUTheDK2096G+tnMBqBsPVV+BR56Z5sYq1r0GoLyKsXIHN9YWcquje2I1hjesYXpQRoIj7/lZhr
	zEOWpjhQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9eYx-00000006vrO-38Qm;
	Fri, 17 Oct 2025 07:07:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Zhiming Hu <zhiming.hu@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [PATCH] cgroup/misc: fix misc_res_type kernel-doc warning
Date: Fri, 17 Oct 2025 00:07:42 -0700
Message-ID: <20251017070743.1638456-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Format the kernel-doc for SCALE_HW_CALIB_INVALID correctly to
avoid a kernel-doc warning:

Warning: include/linux/misc_cgroup.h:26 Enum value
 'MISC_CG_RES_TDX' not described in enum 'misc_res_type'

Fixes: 7c035bea9407 ("KVM: TDX: Register TDX host key IDs to cgroup misc controller")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Zhiming Hu <zhiming.hu@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
---
 include/linux/misc_cgroup.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251016.orig/include/linux/misc_cgroup.h
+++ linux-next-20251016/include/linux/misc_cgroup.h
@@ -19,7 +19,7 @@ enum misc_res_type {
 	MISC_CG_RES_SEV_ES,
 #endif
 #ifdef CONFIG_INTEL_TDX_HOST
-	/* Intel TDX HKIDs resource */
+	/** @MISC_CG_RES_TDX: Intel TDX HKIDs resource */
 	MISC_CG_RES_TDX,
 #endif
 	/** @MISC_CG_RES_TYPES: count of enum misc_res_type constants */

