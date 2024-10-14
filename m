Return-Path: <cgroups+bounces-5113-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9199C7F0
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 13:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04031F24577
	for <lists+cgroups@lfdr.de>; Mon, 14 Oct 2024 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746073446;
	Mon, 14 Oct 2024 11:00:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDE19E80F;
	Mon, 14 Oct 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903607; cv=none; b=X9F3EUYb0kKHcs0u/qJDspogBXQlI7vs1BbXya8uB+N8m8ttRKM7k/D62FDVrDiswJ2eqktZroxvZkNfY9qBrSOGoaDfpYwX/4A7rtXJTc0m2+JVwMPexsoTuzt6N2Dsvj9uX/23KgQzs3uTLDHgzAp0ejTefamQpWtvSteP8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903607; c=relaxed/simple;
	bh=Nh/G0+6BTckWH7pcNTg6397vWGRxhr6r4hIyNOpdmIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnHMV1YNlCKm5zA0BwmxRhGXplbe3+4ivE7cNFn1co2354YqC5fsIh+gxp/ad1gvvgR6fhZ18qn0CtdKCUEtcIilJWrSl2RxZo5XXENor1Bhnk4gmRAs+PFM2UMwnRiSU2HnGF9OxKRXkA18kQd2e4CQj1dra0tQ+jdG3xVXnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD141684;
	Mon, 14 Oct 2024 04:00:35 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94D563F51B;
	Mon, 14 Oct 2024 04:00:02 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Tejun Heo <tj@kernel.org>,
	Will Deacon <will@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 12/57] cgroup: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:19 +0100
Message-ID: <20241014105912.3207374-12-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Wrap global variables that are initialized with PAGE_SIZE derived values
using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
deferred for boot-time page size builds.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 kernel/cgroup/cgroup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a4..1e9c96210821d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4176,16 +4176,16 @@ static int cgroup_seqfile_show(struct seq_file *m, void *arg)
 	return 0;
 }
 
-static struct kernfs_ops cgroup_kf_single_ops = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(struct kernfs_ops, cgroup_kf_single_ops, {
 	.atomic_write_len	= PAGE_SIZE,
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
 	.write			= cgroup_file_write,
 	.poll			= cgroup_file_poll,
 	.seq_show		= cgroup_seqfile_show,
-};
+});
 
-static struct kernfs_ops cgroup_kf_ops = {
+static DEFINE_GLOBAL_PAGE_SIZE_VAR(struct kernfs_ops, cgroup_kf_ops, {
 	.atomic_write_len	= PAGE_SIZE,
 	.open			= cgroup_file_open,
 	.release		= cgroup_file_release,
@@ -4195,7 +4195,7 @@ static struct kernfs_ops cgroup_kf_ops = {
 	.seq_next		= cgroup_seqfile_next,
 	.seq_stop		= cgroup_seqfile_stop,
 	.seq_show		= cgroup_seqfile_show,
-};
+});
 
 static void cgroup_file_notify_timer(struct timer_list *timer)
 {
-- 
2.43.0


