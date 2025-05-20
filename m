Return-Path: <cgroups+bounces-8272-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA9ABDBE6
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940FD4E0D71
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36624886C;
	Tue, 20 May 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP8FvKS+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52B2475D0;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750114; cv=none; b=WI6NM2fmgdcWVkeSdpkK2n3a/dHIKTrp1mA1sFQETunzgq60CqTrcER/cHP0GBlEPFYdK6M2LnDfigzWF9OAKxuugEDh6+DhL3F65KgV5sw2GnFAFH7nTj6gtXKzJtib71wN2CnHtdEJdOB+XO8FzCvV4uMjUZN5AljepDiQhYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750114; c=relaxed/simple;
	bh=3J3O5QjrYLY5D5jr1IbXc+c/3h2+JJ2Uhf1/X72Y0+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jpeaj7PnwEbEzZy4AjCq7KnTuOAhZHlzN7qEGifX5GNMqTKFi0S69aLOU+ixg3qwFfIkfNBpdo61LwiFH8+1BMNRfKvyVh97MpxNiZzIhNHnIYSUZmTVwSskbrndAByav/pOQQrhXkPKfmpm4WZoKiDcbuh+18N3shf6ADU4jH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP8FvKS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B97A9C4CEF4;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750113;
	bh=3J3O5QjrYLY5D5jr1IbXc+c/3h2+JJ2Uhf1/X72Y0+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IP8FvKS+mrAmKbQ6QlQGIPS3Yn+9+mqAJaf34s5U5stlExtCtCm0C1uObySKxiLJ+
	 7yzAi+NMs55DveFoawZrRc/qQEkzPNg9BRQstyyWTbOzkrbN6GueOCBZyMSBHHdNmd
	 +NEvQt68YBdS89qneYLS2F59AJBA9TTff8buL/jTUo3IPjZ3ZIrEuB1XAL/IsSgt5o
	 xv7hopjfuyf2d3aJye48Zgsv+sElQ//NVEz0Z92mIg89wGz0zW3p1+PyGX1wHifROi
	 M1DW0UYIYnY8VffwLe6RoFyd4tpD87PFA1+s1F0kIsg5mjoy2vb1YOpXKwpdQ3/wPk
	 v3v7sfx3u24Kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB249C54E65;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Date: Tue, 20 May 2025 23:07:46 +0900
Subject: [PATCH v2 2/3] sched_ext, docs: add label
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-rt-and-cpu-controller-doc-v2-2-70a2b6a1b703@sony.com>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
In-Reply-To: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=569;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=kROQYcJm32GQjz2uQCl7dr3UvhZuMbRBEjFkLwGn5dM=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJ0eh6cSQ15na2Z2aq2wPxdy4IszUQDS7UO660769+xt
 a9STZHqKGVhEONikBVTZHkns+7CQSvLpq/HGb7BzGFlAhnCwMUpABMRZ2JkmHmDVdTcTzTp18kZ
 aamflOzYdjknNk975CL9w2OBgmepIMP/MCGB/BvvCjY2tpypXf31yxetby8jF7169pnvmWOi7Oo
 cRgA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

From: Shashank Balaji <shashank.mahadasyam@sony.com>

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/scheduler/sched-ext.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0b2654e2164b8e6139db19fc8b68e6c5c289503d..03f9e63a7b2aa10567366ff3e1a0cfc05b43e05a 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -1,3 +1,5 @@
+.. _sched-ext:
+
 ==========================
 Extensible Scheduler Class
 ==========================

-- 
2.43.0



