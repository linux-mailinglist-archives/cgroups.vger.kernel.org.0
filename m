Return-Path: <cgroups+bounces-11617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53116C37DCD
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A90A1885903
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB0634CFDE;
	Wed,  5 Nov 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kItBEaDN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEB34D4F3;
	Wed,  5 Nov 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376697; cv=none; b=IC7rJXTUmnd+7PqjmC7TDqMWuMotCe3p/BbpGVDRL6yL3xB9/M0hn3JMeESvZODxiRJEb/HSQuHEjCDw9YglPWwvwQ0gPdvFEdelb/o7o8C1/Bhj8J35LNPNB9BogMjVHlAwlIHPTt23SzjmNWfvrnvRni5t/xgT5F01Wz9XVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376697; c=relaxed/simple;
	bh=SYoV9ZciDsKT7uyTlAb1HvnL9v8aWR3nKq+oz55/MdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Scelxm7IE1kIyznZQC2KkegnUkhfBYJEbSGbA599KasOEYpNYriHh2wcv6+DbH9vHBKeHOpG2xWZpZZoBzsBt/gwwu/P18k6O+3EyR5tZvApITQE4r6eGfV2mpu8C5xZXWv291JkCrc1L01YFyzpHBwwxe0ZSJL2HxCU3NCko1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kItBEaDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B89C116D0;
	Wed,  5 Nov 2025 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376697;
	bh=SYoV9ZciDsKT7uyTlAb1HvnL9v8aWR3nKq+oz55/MdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kItBEaDNwg83NtBZHN0PY2kO9v4qG9+R9UGhFJXkfz3oeoYG2txCyhHm8tQi1BkuD
	 NWItfaf8aoElYQ+RjvhVLcKuuhff34s1plgMvHf/SEFle9YrkEyqQFq6fErNgLNiEW
	 uYEF73IW+07iSZb619oMuwv6PrVbrMjfvyg+P5grwt/pH++e9JAObxCWjuc5mzZKMy
	 aZ1dugkuLqmPVgs+1gxfJiF2/ehXeFrMHeF5pPRKqaxAvbJcpRFu4H4XfmMUY8PXiD
	 CpEWomCTEysE3h4vCqrk/emFOvpj2sqiG0G0gliDyXtIxhlNYCuVzrEsNmaUc2145Y
	 6h2pO0qbg3p6A==
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
Subject: [PATCH 07/31] driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
Date: Wed,  5 Nov 2025 22:03:23 +0100
Message-ID: <20251105210348.35256-8-frederic@kernel.org>
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

Make sure /sys/devices/system/cpu/isolated only prints what was passed
through the isolcpus= parameter before HK_TYPE_DOMAIN will also
integrate cpuset isolated partitions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fa0a2eef93ac..050f87d5b8d4 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -291,7 +291,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 		return -ENOMEM;
 
 	cpumask_andnot(isolated, cpu_possible_mask,
-		       housekeeping_cpumask(HK_TYPE_DOMAIN));
+		       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
-- 
2.51.0


