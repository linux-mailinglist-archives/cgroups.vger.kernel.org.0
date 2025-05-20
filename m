Return-Path: <cgroups+bounces-8271-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313CABDB88
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A4D1BA806A
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 14:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5D4248868;
	Tue, 20 May 2025 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMtZZJZy"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ECA2475CD;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750114; cv=none; b=m61bbRHotu9WNavp2Fkql6XP/aTcLLU9lynGAyU2o2yYErcdqwu/zBLKdNpQNulz98ZOvic0IXbG1nbX6XO7rqxOcHDYJMPGWjMum/+gYs+NIFIPCHSBlgIFyjc4YpLT91rTPLeHtVn0cWRsvGBPlnUXCRsyJog+WlkM2kS8tZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750114; c=relaxed/simple;
	bh=ttAbpSM1hXQuNR/OMOYp8x1yy4Ma9fGMFXn0HWuoelg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O5PIZlLKH+VhQKSkD4ZgE47IYduU2r/4xvs/aL8SE4ZI3A2Kes8xDloxq8smT1pBomrX2L0orPdmgtgoIAyNtTA7lzfMcTs882uqGU5HcmvCxWnh+gJcpxdrckvwd8Zel9K2BRoa+54KGmRDmaarb+Dvi/eXwwRfQ9ZARhyb1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMtZZJZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A84CC4CEF1;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747750113;
	bh=ttAbpSM1hXQuNR/OMOYp8x1yy4Ma9fGMFXn0HWuoelg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dMtZZJZyHdgW2RKC+xdk3FBoCiDoQdmAjq+EUAaBKQx3v58faXyCucAcDRauheXl/
	 2kRjuabrUdWtUKouTQ9OIDdcqe46q5XtesFoUrDfB7ymTTB4vhOfjy3264oDOWq3Mq
	 /UoKwpaEySrwnztJW47el/uvK97P8/oep/hJby1spoy62dhEVe6XHOhLEgLZtOywxM
	 YWCF4b+AHnh5BkxU3rR5yn3owOEPZ9i2lFhzQECRQv2cOL3pr5dttrXPlqbStp1ynM
	 42nH/0X67TeqgMAU+dC+0JMXs7g1oskePFEmbJab00+HoxhKyNmnqvU/vmL1x3+ETO
	 i449+VP1kWkXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADAEC3ABDD;
	Tue, 20 May 2025 14:08:33 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Subject: [PATCH v2 0/3] cgroup, docs: cpu controller interaction with
 various scheduling policies
Date: Tue, 20 May 2025 23:07:44 +0900
Message-Id: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALGMLGgC/32NQQ6CMBBFr0Jm7ZhSLBBX3MOwqO1UmmBLpkgkh
 Ltbce/yveS/v0Ei9pTgWmzAtPjkY8ggTwWYQYcHobeZQQqphJQ18ow6WDTTC00MM8dxJEYbDba
 61dqoRrqKIO8nJuffR/vWZx58miOvx9VSfu2vWgn1p7qUKLC517p2yrlLZbsUw3o28Qn9vu8f9
 QYiscEAAAA=
X-Change-ID: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=ttAbpSM1hXQuNR/OMOYp8x1yy4Ma9fGMFXn0HWuoelg=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGDJ0eu6rPGPd+v97b+NxtpuqO+YKrd8TpLhUpG5b7ux9q
 7z751WrdpSyMIhxMciKKbK8k1l34aCVZdPX4wzfYOawMoEMYeDiFICJ5HExMqyZ1Pbk+N95RTsT
 DEIN9jPeWCzKvvKf1I+16bM9ZnFF1T5m+O8+48/RVZemsCus8Jw/v38in/T1NUtZU65t/LR1SWH
 KlvncAA==
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

The cgroup v2 cpu controller interface files interact with processes
differently based on their scheduling policy and the underlying
scheduler used (fair-class vs. BPF scheduler). This patchset
documents these differences.

This is related to the previous patchset titled "cgroup, docs: Clarify
interaction of RT processes with cgroup v2 cpu controller"
(https://lore.kernel.org/all/20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com/),
which focused solely on RT processes. The current patchset incorporates
the previous feedback and expands on the scope of scheduling policies.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Shashank Balaji (3):
      cgroup, docs: be specific about bandwidth control of rt processes
      sched_ext, docs: add label
      cgroup, docs: cpu controller interaction with various scheduling policies

 Documentation/admin-guide/cgroup-v2.rst | 100 ++++++++++++++++++++++++--------
 Documentation/scheduler/sched-ext.rst   |   2 +
 2 files changed, 78 insertions(+), 24 deletions(-)
---
base-commit: 036ee8a17bd046d7a350de0aae152307a061cc46
change-id: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>



