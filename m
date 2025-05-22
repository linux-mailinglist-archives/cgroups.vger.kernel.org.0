Return-Path: <cgroups+bounces-8303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5425AC0248
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 04:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB501BC374A
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBF840C03;
	Thu, 22 May 2025 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="g1FtZDTQ"
X-Original-To: cgroups@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B92610D;
	Thu, 22 May 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879721; cv=none; b=JerMdV1w95iPTkHigEapjUR10gflL15pREbYjp5w6/J3jkb78abb4HcGQ5h6zq6UVmNVcKF1O06+HVEt7mcX84BiogT2pbjVSstVO+MdHSYF7e1XTzADvqJCxrU6TfPPVTm1tfYGpXRnSKxZeyJz7+PS6RPKzQ/D5txpLwfvReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879721; c=relaxed/simple;
	bh=/2xv4T5GnAsCDJLXVz2LJBcpTe9h0DDljTwugSSUNK0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i+Co8ddMlyptNPwGrCu0y9H4Aiiak6rCK2FgIFykUfCl3AzEsfZUj+8TpBEwsEuHk9+BTbohIlxtrf1vgLoPup2qJAJzCa6sJIVbpCnUfdEYUgM5+0fyHES0TpW0+yBRbQzHJU5Sbw4304bT508IOUgWgJl309/Bl+hZpIZJzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=g1FtZDTQ; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1747879719; x=1779415719;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=CM0gkP0omB3y7XaEysVhdhhpKRTQjedl49eUwjMubMo=;
  b=g1FtZDTQFUqllWcj/c32q9pCWeHvwiTANk6PgGLeb5P+ZlVSUNQvizey
   rAprzTqv+vnJ8lqT3A8uHLCKiU73w5JRejiywsBAkQyzgENB5cmRx8ZMB
   O7LB7M7XLI9JXS85QrlkivQ7K06w2Wx0mY4Vm7hNaJ+2QAUJYhBc78GS5
   0jxLgzBjnOapfXnAXdb1qHSXR+XXh3U+/uPr2CwEHYxEfZx4wlH0rgZWA
   nfk2rLKuzcyGRpWRvp+FydN3id6eE9esh3sgadxMF2akei9MYJNq8xyWd
   ZYIUd5LENS+KHPbhnldo10un1PCvHSFmLWDGiEv54cYL3OX0S/WsNCn/R
   Q==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 11:08:37 +0900
X-IronPort-AV: E=Sophos;i="6.15,304,1739804400"; 
   d="scan'208";a="562451313"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2025 11:08:37 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH v3 0/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Date: Thu, 22 May 2025 11:08:11 +0900
Message-Id: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuHLmgC/33NTQ6CMBCG4auQrh1TphaIK+5hXJT+SBNsSYuNh
 HB3Cy50xfL9knlmIVEHqyO5FgsJOtlovcvBTgWRvXAPDVblJkiRU8QKwgTCKZDjC6R3U/DDoAM
 oL6ERjRCS12iYJvl+DNrY927f7rl7Gycf5v1VKrf1qzLKD9RUAoW6q0RluDEXptro3XyW/kk2N
 OEP4kiPINwgKjBbZVdT9get6/oBmC6nEAoBAAA=
X-Change-ID: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=/2xv4T5GnAsCDJLXVz2LJBcpTe9h0DDljTwugSSUNK0=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDL02pWlfgVO+1v8TuLHVbPngc5PrC/LPeXjlTtYwr2tb
 u4t3u7dHaUsDGJcDLJiiizvZNZdOGhl2fT1OMM3mDmsTCBDGLg4BWAiJVMYGY5wc5gorXy6bXak
 dLF1x52p3dsST/iv+cQeOM0+l93L+TJQxW2zhWdXuLF5PXizZtts72ndN9YHBrrnWTDaunkFLhH
 mAQA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A

The cgroup v2 cpu controller interface files interact with processes
differently based on their scheduling policy and the underlying
scheduler used (fair-class vs. BPF scheduler). This patchset
documents these differences.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Changes in v3:
- Refer to sched-ext.rst for fair-class vs. BPF scheduler instead of repeating
the details in cgroup-v2.rst
- Link to v2: https://lore.kernel.org/r/20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com

Changes in v2:
- Expanded scope from only RT processes to all scheduling policies
- Link to v1: https://lore.kernel.org/all/20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com/

---
Shashank Balaji (3):
      cgroup, docs: convert space indentation to tab indentation
      sched_ext, docs: convert mentions of "CFS" to "fair-class scheduler"
      cgroup, docs: cpu controller's interaction with various scheduling policies

 Documentation/admin-guide/cgroup-v2.rst | 77 ++++++++++++++++++++++++---------
 Documentation/scheduler/sched-ext.rst   |  8 ++--
 2 files changed, 60 insertions(+), 25 deletions(-)
---
base-commit: 036ee8a17bd046d7a350de0aae152307a061cc46
change-id: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>


