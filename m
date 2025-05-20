Return-Path: <cgroups+bounces-8273-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32487ABDC08
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9974E0DDC
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B0248873;
	Tue, 20 May 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlXkWcXM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA58F2475E3;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750114; cv=none; b=PiV7dTc6qPeuuYTWGG6QiUoQm3SqnvQJGWlq4E8MJSoXoqpUD+LjyONHkR9u+DLx/VbPMFEpByfjuVIJ4KA9rVxiGtfOOpscHEfdAd/Cadlt03ySuCsFvRiGxlllwJ9Ypi1Z5zgIfjxefpuK1xC/6eVhE9DntLbtkiNn5fSWec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750114; c=relaxed/simple;
	bh=+VIZI0thf+/H5abY0c5Mvtc6jv5kMqAoJ4uZft755Eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGPvMxCkaoGe5tYhzqyIQFj+pYSo3VUACdmOumREpGzkQGWbPJnYjHexguejTdCMAcR+ZcjEk2fb6Labi2GIgVDCfRI/YbKLl2KAkgNW1/cFYTYl97joAuOR1AdJrs4LquYU3M3NO5owf9j0YeUFuGy98v5+d+Rnx+RH55esONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlXkWcXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A97B8C4CEEA;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750113;
	bh=+VIZI0thf+/H5abY0c5Mvtc6jv5kMqAoJ4uZft755Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OlXkWcXMskGq4RZJqDGaZBNai+ftFCMooxjzQOkWmwiNpNW1Odniq+/fGoT7vq8Lz
	 5fXY4CtT5phi32yZ3xZG6M7ncfv+CUxHV6fi4iLphDkfmjdzvy/PhUHvClGE8XwX+d
	 U/eWQ7m5z9T4dF1q2RCgS4L+Vp/d7qsv7utx+DaoqV51K/ANqrBi6C19UubAPY71K+
	 3kIm7jPrniZX1bVFhEj3oPqHiSQJs5d1Lf6SS6FF/fqmxElHG7qjvNScjF3WRDg4ik
	 69M5eFMUQtXM80+GympQicDDPcEZJtFWNe8cIqD04/pPu1qIWWVSf8QepuZRWNOvTV
	 s0aHBfIlORhcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B310C3DA6D;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Date: Tue, 20 May 2025 23:07:45 +0900
Subject: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=0fu39uClw6bO5Fx9qm8IAuu7HAJELLYW1+XN2jpeVRc=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJ0eu4ryTSGmj/9K5m283rhgp2TvHbPr+kp3S/tf6D7j
 nncxO08HaUsDGJcDLJiiizvZNZdOGhl2fT1OMM3mDmsTCBDGLg4BWAinN6MDBOnHXDfpefzryzv
 5t+ZQYxia9t3/2g32+9gO6vhuX3oyURGhl8vA09LbbSKufD17pmXV5czV30MUbOen2am4vw6rUl
 rJSMA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

From: Shashank Balaji <shashank.mahadasyam@sony.com>

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7f6f8c9070be89c4975dbfa79077e..3b3685736fe9b12e96a273248dfb4a8c62a4b698 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequency which should always be
 provided by a CPU, as well as the maximum desired frequency, which should not
 be exceeded by a CPU.
 
-WARNING: cgroup2 cpu controller doesn't yet fully support the control of
+WARNING: cgroup2 cpu controller doesn't yet support the (bandwidth) control of
 realtime processes. For a kernel built with the CONFIG_RT_GROUP_SCHED option
 enabled for group scheduling of realtime processes, the cpu controller can only
 be enabled when all RT processes are in the root cgroup. Be aware that system

-- 
2.43.0



