Return-Path: <cgroups+bounces-6833-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D62FA4F5F9
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 05:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5881188C5A6
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 04:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1E1A23B7;
	Wed,  5 Mar 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u4Sk5z5T"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428EB19CC2E;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147989; cv=none; b=L9iMVIZ08XyIodZ6rQFgjff5Yt/Xq/yMmRSp1mPimGJSjIkqSEKfQ6Naot4UxK/k3K1lhjMpp6yl6Zhsw7t9Srf5CP8esCgYhp2ARo6d7BQh6kax6BEHp5Gt1DQIbi0lUpfdAQnqafU/A9NA0KB0Y6dG++exSIg1kuOvDcXe6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147989; c=relaxed/simple;
	bh=5UXRL54BFARNyIExd957ZiQGbmJZmiFrgr7K+zCJvRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OtIa9iSypeod78YR6HGf70Ie83WD7FCouf7mljgBxSYsK3yHr19gUAz1p8qEKtIYXECrL/fB6lZb5Kr43Rh2AKqVU7zCQBmV+twmluNPrgGBE4BoA7QlO94WfJ2+/lfiwVKIb2rRWU0ei8dRahjz7vrZYzC9VVbKDBWrUdwJcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u4Sk5z5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E1A8C4CEE2;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741147988;
	bh=5UXRL54BFARNyIExd957ZiQGbmJZmiFrgr7K+zCJvRQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=u4Sk5z5Tvo1rTX66Bt3jX/gM1l67V+G3tTXqeLGZnxK671s2GpNj+HMQemd/vrZm0
	 wDJHZpf2Rx8KRo1JgFqxKDASo8k9mt0iKojjcjUlxXwPswLLIYgK+h0mcJroeJAHEi
	 ljlTgXr2ocZ3Ppjoqf+TuMKIXvGmAddUNXGPA2SReOuuGl6LlsPTUOlovkyjXVJf/O
	 xfzzH5RflCBh7opDD+FEivawhCCvO89WLyOqgKTExCdQLEJA+MU6f8z+o9lWBE9JDX
	 Bk99diqSeVRS6eAax8iUFGYFqS8rNrbw7hN0fwQsSENsRskVSLLVJ9Vcjcsjbm0Tdx
	 /XCZQl5R/1PwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CEC19F32;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Subject: [PATCH 0/2] cgroup, docs: Clarify interaction of RT processes with
 cgroup v2 cpu controller
Date: Wed, 05 Mar 2025 13:12:42 +0900
Message-Id: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADrPx2cC/x3MQQqDQAxA0atI1gZsilZ6leIiZKINyIxkrBRk7
 u7g8i3+PyGrm2Z4Nye4HpYtxYpH24B8OS6KFqqBOuo7ogF9R44BZfuhpLh7Wld1DElw5JFZ+hf
 NT4Xab66z/e/3ZyrlAtNmlBlrAAAA
X-Change-ID: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1499;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=5UXRL54BFARNyIExd957ZiQGbmJZmiFrgr7K+zCJvRQ=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGNKPnw+6+bcjp3D9rkCn1feVrZ4o9OzxMqu4f6zss+Mfs
 19xBz23dJSyMIhxMciKKbK8k1l34aCVZdPX4wzfYOawMoEMYeDiFICJzPnJ8IeT757aNhEu/W8p
 zaGFfgpXFft4k6PfWN7cXqTxv/3Qt2eMDDcUKxsPXbumLzLHV/aM8Jqgpm2y28y37Tm3LGLq95W
 6nfwA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

Currently, CONFIG_RT_GROUP_SCHED is practically unusable. If enabled,
the cpu controller can be enabled only when all the realtime processes are in
the root cgroup. This has been clarified by Waiman Long in commit
20d4628 (cgroup, docs: Clarify limitation of RT processes with cgroup v2
cpu controller): https://lore.kernel.org/lkml/20240320142302.1790171-1-longman@redhat.com/

But this limitation does not affect any of the other controllers:
irrespective of CONFIG_RT_GROUP_SCHED, the other controllers can be used
for the resource control of realtime processes. This is made more
explicit in the first patch.

Even when CONFIG_RT_GROUP_SCHED is disabled, the runtime of realtime
processes is accounted for by cpu.pressure, and the usage_usec, user_usec,
and system_usec fields of cpu.stat, and cpu.uclamp.{min, max} affect
realtime processes as well. This is documented in the second patch.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Shashank Balaji (2):
      cgroup, docs: Be explicit about independence of RT_GROUP_SCHED and non-cpu controllers
      cgroup, docs: Document interaction of RT processes with cpu controller

 Documentation/admin-guide/cgroup-v2.rst | 41 ++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 14 deletions(-)
---
base-commit: 9b381a28f44a49b92b03bb3982728f9cb67ee225
change-id: 20250226-rt-and-cpu-controller-doc-8a8aac572f3e

Best regards,
-- 
Shashank Balaji <shashank.mahadasyam@sony.com>



