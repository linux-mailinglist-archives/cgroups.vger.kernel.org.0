Return-Path: <cgroups+bounces-8305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5ABAC0250
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8DA3B9E3B
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739214830F;
	Thu, 22 May 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="ZuY0X4q/"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB6126BFF;
	Thu, 22 May 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879725; cv=none; b=CLBrIn8I3Tv/380oKIjguUgCkBkiSuqiQrMjK60dAP11uB0ANKUES7aqGIBCvDPd2uNSXcbLVA2eR8BTG1+nUCQG/YQ0f8Xjv2ej0L8G2CNV7FwOTBETRkuhN2VdCmoivDLFemS2upZlkVZpbyVihQ5TOFBfk2qqHQ3NEWYpIM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879725; c=relaxed/simple;
	bh=G22jshGU7C2aVZ8VKgfdgmdlNKbB41JU/ZUJNKMIxpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FY2SCWBZl3gyxGqz3e7QEbO+rboBpIfoGDdGOsDO0nljHTXMbVAaXiPoROQAPYI9OrNlIj5GChk7s+Va1fawhTVHcaW2dpwVFTVqL9QBnFb6NZ2SK4OPWYe+Z7MFtTO7sX9aBOkNhxjqU7Nf7ZU3FUpw3WhQFGzW6noiVPgobUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=ZuY0X4q/; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747879723; x=1779415723;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=IriCGEyxogMDnCjn4gvwdcT8fXmdiv5bTxbWQrLz6dA=;
  b=ZuY0X4q/E7tJfBLQnfWZZfG5maaZF9ipCynegnLoQjVaLxNjEJPDt6MT
   vOepMT9o+0ykKMabIPDTNFGvkwnyz59JZjRxeG2b3iY53pWDp2lkdZ59W
   wdRH4RXEExI+12dI7vtD7DhFnvIRrkFzjXriNXQJ1Gp+bIa+NJ6OsxHOU
   BIn31+clE5vbGdt7J56LEifHtamQiwVROvgriQcjq0+IowczJ+GInDULI
   8bYBu1kebksA3+9hH22ch+cZQdtMHDWpe7t5oC7sU+llRo5yXQX+Atb5O
   4OOaAxbR+RT0yPRxydU6zOxfHvpc9YbSMuGezYsHXzewAFIqCwzuCb2j0
   g==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:08:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; 
   d="scan'208";a="562451315"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2025 11:08:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Date: Thu, 22 May 2025 11:08:13 +0900
Subject: [PATCH v3 2/3] sched_ext, docs: convert mentions of "CFS" to
 "fair-class scheduler"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-rt-and-cpu-controller-doc-v3-2-483fc9cca591@sony.com>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1965;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=G22jshGU7C2aVZ8VKgfdgmdlNKbB41JU/ZUJNKMIxpo=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDL02pUZIpi983ZXKkskf6zOORl4/5q1Xcw2X+aegty4i
 DONy/93lLIwiHExyIopsryTWXfhoJVl09fjDN9g5rAygQ3h4hSAiRifZmQ4fCN5Xfw598dP3dh+
 zDjy4ekxEwO9m/1/E9d5zHnt/qdsNSNDq6HvxB9dwmn/0joqHpw9UhhgybB25x42f8fvPPWHytr
 5AA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

Mentions of CFS are stale since the fair-class scheduler is implemented using
EEVDF. So, convert such mentions to "fair-class scheduler" to stay
algorithm-name agnostic.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/scheduler/sched-ext.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0b2654e2164b8e6139db19fc8b68e6c5c289503d..ceca6f8966eeeb5f029a9ae41c039d67c1db7be8 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -47,8 +47,8 @@ options should be enabled to use sched_ext:
 sched_ext is used only when the BPF scheduler is loaded and running.
 
 If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
-treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
-loaded.
+treated as ``SCHED_NORMAL`` and scheduled by the fair-class scheduler until the
+BPF scheduler is loaded.
 
 When the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is not set
 in ``ops->flags``, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE``, and
@@ -57,11 +57,11 @@ in ``ops->flags``, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE``, and
 However, when the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is
 set in ``ops->flags``, only tasks with the ``SCHED_EXT`` policy are scheduled
 by sched_ext, while tasks with ``SCHED_NORMAL``, ``SCHED_BATCH`` and
-``SCHED_IDLE`` policies are scheduled by CFS.
+``SCHED_IDLE`` policies are scheduled by the fair-class scheduler.
 
 Terminating the sched_ext scheduler program, triggering `SysRq-S`, or
 detection of any internal error including stalled runnable tasks aborts the
-BPF scheduler and reverts all tasks back to CFS.
+BPF scheduler and reverts all tasks back to the fair-class scheduler.
 
 .. code-block:: none
 

-- 
2.43.0


