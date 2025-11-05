Return-Path: <cgroups+bounces-11618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72134C37DCE
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9DE4F1B54
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA534D930;
	Wed,  5 Nov 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjCYtsp3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1534B663;
	Wed,  5 Nov 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376707; cv=none; b=BPDXey+ktroqYaPT1cXMp4m43tbKLbleq1Oy7KJMfd/84Odbkvj2jpgeL/gZ390LAZ577M51sIL7KZdQSsR69ETMeQH1KGT2pB5P4pd0dDGRTXOSivDk+7OuqtOrlt5wirOLPLLwhIgHYxy25AaAijXGGTxwZrEhL+BmfWLvrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376707; c=relaxed/simple;
	bh=27i30BHoqn/BGY6ARghdzM2ne1ZlXRlOL17r9Y9xQIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZJqcAOdD9yQVXhuvNTuLFJo6LNqunTKijDaCKl3SXHl1GExMnTdoMaeMUN4X6Hap40wQ3DcnXb6NG3JxYkliNETM/VL8s0UG3TyTteLBFSthVHHSEGB4l9qA64VcXdibbGKox/mifNeJsqLTa0Xh0dGwh7IO0PT58vdZefUJYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjCYtsp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FF4C4CEF5;
	Wed,  5 Nov 2025 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376705;
	bh=27i30BHoqn/BGY6ARghdzM2ne1ZlXRlOL17r9Y9xQIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JjCYtsp3arDlgdSCfdYrEjKJJfAZqUk+QbEPyc2euy9ldASDGzJtMX8bz/0nOmNgj
	 zsZ+vpJgn3AxZvB3v7wgjYYdLkl/efj/scWiKiLXsx7hEPwP+jUEEox9tNkyI+T8LR
	 lRCed7eIknTR5DbF0lhv3ITbCqLMbkvyjAk9puPccy0ayechj8tB8UtvPdguu3Yw0Y
	 BCKDGsuZwbOlB4jsmIR08Lzzhb+iELcBSQO7SkLi+GCXK5mmbiJ9L1dTXuMryEm/UZ
	 XtSns050xBjEYfez0HKsI7LLuRlY0s7cEVB1GqOcLsUXQcxaSKFvbdXSgs2bx+2oc6
	 SNhAbL25yT/1A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 08/31] net: Keep ignoring isolated cpuset change
Date: Wed,  5 Nov 2025 22:03:24 +0100
Message-ID: <20251105210348.35256-9-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RPS cpumask can be overriden through sysfs/syctl. The boot defined
isolated CPUs are then excluded from that cpumask.

However HK_TYPE_DOMAIN will soon integrate cpuset isolated
CPUs updates and the RPS infrastructure needs more thoughts to be able
to propagate such changes and synchronize against them.

Keep handling only what was passed through "isolcpus=" for now.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ca878525ad7c..07624b682b08 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1022,7 +1022,7 @@ static int netdev_rx_queue_set_rps_mask(struct netdev_rx_queue *queue,
 int rps_cpumask_housekeeping(struct cpumask *mask)
 {
 	if (!cpumask_empty(mask)) {
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
 		if (cpumask_empty(mask))
 			return -EINVAL;
-- 
2.51.0


