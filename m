Return-Path: <cgroups+bounces-2561-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4178A8184
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 12:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B42DE1F21A1E
	for <lists+cgroups@lfdr.de>; Wed, 17 Apr 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B628513C8E9;
	Wed, 17 Apr 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYg+1aNQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC513BC21;
	Wed, 17 Apr 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351590; cv=none; b=EtFyqhLPiVjNTAY78wFP7IG52gitYJeU8YyeDZOoIzr0fwVX0Fz2q3pYbcD0+np/jTkqJr0y4mbCBLLwR7OrLAKfTh/GzRQQg+H1DNpjxQylp/c6kRBYUOMDUMxV1C7IPxcNo94u1JZU/Qa09OhzRu44tYQh7wYRRB3mvuRsHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351590; c=relaxed/simple;
	bh=eWLI0pVTmy02PTwoV4UoOrO5hmZkHWORU7qvV72JPzk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8swe2KBob7CHTOhq8bm6o1OEYlF/Mq7PP0X0mq+wKf96NrV1lT75tuFUg7QYozPc2967R7zInPiczW1817glsRYbHLXZSJXPnckFWApEfAcs86qP3JmEwK4JWHlYl1AAI0LW7+VR5sJB2jxVnJlPYKmnIOw1liOhQVlDTGLz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYg+1aNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2710CC072AA;
	Wed, 17 Apr 2024 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713351590;
	bh=eWLI0pVTmy02PTwoV4UoOrO5hmZkHWORU7qvV72JPzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tYg+1aNQmWOMMDJaF2NefSk6jyMUWzngPZTw42kl3nQfXSXY7fJ7GZ02wY3KJ4RvK
	 DuEB40MePebRMrKJhF4OiLDAGFlSCMmMmFb/rl9P8lcZnopo7ZhGhSfs5zhWncOlT8
	 Y1FXYdAcZfzYNphsKy9xXXDpABNQ9IofObzLOj7VpdsPRIrza5oN0rIDKqBLHA3yl4
	 7o+pnDxim88itC2rwmaVHI2KS8l8ljlyrbvTq38Z0wiTr1Dj+qocz4Rxgb06mkiBdT
	 U3Lsa/8KK+X8KnadTxoZUwUBq/TqEtTkRtekr1RjnKhYA7AhaBwidG10g4QHeGDBhJ
	 6cMo2f5u/iZ3A==
Subject: [PATCH] cgroup/rstat: desc member cgrp in cgroup_rstat_flush_release
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: cgroups@vger.kernel.org
Cc: tj@kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 oe-kbuild-all@lists.linux.dev
Date: Wed, 17 Apr 2024 12:59:46 +0200
Message-ID: <171335156850.3932572.581386697098608458.stgit@firesoul>
In-Reply-To: <202404170821.HwZGISTY-lkp@intel.com>
References: <202404170821.HwZGISTY-lkp@intel.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Recent change to cgroup_rstat_flush_release added a
parameter cgrp, which is used by tracepoint to correlate
with other tracepoints that also have this cgrp.

The kernel test robot detected kernel doc was missing
a description of this member.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404170821.HwZGISTY-lkp@intel.com/
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 kernel/cgroup/rstat.c |    1 +
 1 file changed, 1 insertion(+)

TJ feel free to squash this into other patch

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 8c71af67b197..4aebf43882e2 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -384,6 +384,7 @@ int cgroup_rstat_flush_hold(struct cgroup *cgrp)
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
+ * @cgrp: cgroup used by tracepoint
  */
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)



