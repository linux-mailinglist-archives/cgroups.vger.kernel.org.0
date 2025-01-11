Return-Path: <cgroups+bounces-6094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7CA0A13C
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 07:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2811A188BD77
	for <lists+cgroups@lfdr.de>; Sat, 11 Jan 2025 06:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FE158DD9;
	Sat, 11 Jan 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1L4WuGr"
X-Original-To: cgroups@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD3129A78;
	Sat, 11 Jan 2025 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736576871; cv=none; b=GTwWWZkzjuUkdHf9blYdFBP9ytGvCO0LwxsE3I/Y1HNKsyJ9sqFVCcz5fD4BeP3SUW7Lw/N/uRg4GiSg8MyL6Mie31p/xn+smIRXTSXN1rJLlJ22jp0NB/FF+mSpnZUPzed3+Du/fsmhMlu4kPH3q4Wbq9yJCa1g4PTjHvg7JQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736576871; c=relaxed/simple;
	bh=IDaSdxfnGf33O2S0Hn/FzGCL18pD52R97dWPXndg4VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ROly4NMfmma3EqZenF3zaln7a0YV3obJw8Tf/Ze+xS1Km43hS6XuSThnsJBefhwpRgjpUy9sgZUFqDpeE8YgzIYjisi7tup2t5ZV4tNS7dvCX7zUI3PO18j0GEh3fL80hPOKGPX64A/poPoBFwIAx7gi3q8hSGzsf7jzFl1p7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k1L4WuGr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WUxWwFKdoN3GrCnuGXQZYa95akxNZD4zoFS0jYRWjg4=; b=k1L4WuGrIhLjJthjzCoZx1aQLR
	rzeLVT2zLjJnAmw0aUTYgqo3v55QbE8qvnD5b04ijmVB9aSHrEd6BFfoNS/RiLFUCxJ7YoyPzduka
	/LvBNMz5+jigA1XO0EqvOfF37z5nm3/a3YN2LsAWDbBkLhMl/7G/tLz/dj98eEM7atMfdnZbgbYeF
	uXynpEIzn9UcXHc3gRldDYS3lxIkP42vFESDtisEpZ3nl5sBlQTmH1XQTK56cAQ25uVwOMxRfiD2p
	VcDEX9nPbg0I8w1snGHm6hbIB047jErbYuTfKfiDsm4wh2wYYu5vHGtiZnSOWWkzNoSYOvhNP8JKN
	XPhtjMSw==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWUyL-00000000H3O-2MMa;
	Sat, 11 Jan 2025 06:27:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-block@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org
Subject: [PATCH] blk-cgroup: rwstat: fix kernel-doc warnings in header file
Date: Fri, 10 Jan 2025 22:27:48 -0800
Message-ID: <20250111062748.910442-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the function parameters to eliminate kernel-doc warnings:

blk-cgroup-rwstat.h:63: warning: Function parameter or struct member 'opf' not described in 'blkg_rwstat_add'
blk-cgroup-rwstat.h:63: warning: Excess function parameter 'op' description in 'blkg_rwstat_add'
blk-cgroup-rwstat.h:91: warning: Function parameter or struct member 'result' not described in 'blkg_rwstat_read'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: cgroups@vger.kernel.org
---
 block/blk-cgroup-rwstat.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20250108.orig/block/blk-cgroup-rwstat.h
+++ linux-next-20250108/block/blk-cgroup-rwstat.h
@@ -52,7 +52,7 @@ void blkg_rwstat_recursive_sum(struct bl
 /**
  * blkg_rwstat_add - add a value to a blkg_rwstat
  * @rwstat: target blkg_rwstat
- * @op: REQ_OP and flags
+ * @opf: REQ_OP and flags
  * @val: value to add
  *
  * Add @val to @rwstat.  The counters are chosen according to @rw.  The
@@ -83,8 +83,9 @@ static inline void blkg_rwstat_add(struc
 /**
  * blkg_rwstat_read - read the current values of a blkg_rwstat
  * @rwstat: blkg_rwstat to read
+ * @result: where to put the current values
  *
- * Read the current snapshot of @rwstat and return it in the aux counts.
+ * Read the current snapshot of @rwstat and return it in the @result counts.
  */
 static inline void blkg_rwstat_read(struct blkg_rwstat *rwstat,
 		struct blkg_rwstat_sample *result)

