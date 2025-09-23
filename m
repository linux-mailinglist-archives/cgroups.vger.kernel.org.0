Return-Path: <cgroups+bounces-10386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0222B95020
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 10:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F1A3AADF1
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0A431BCA3;
	Tue, 23 Sep 2025 08:33:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E131A056
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.120.2.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616421; cv=none; b=DkQuZjbV75fweN14mQEqfd2S3ln1aPyp4gl1J+xT1H2sFY4Rn43KVzg4zFM1eB3WrWNWHhtVgqIyAmi4v1y91CyrHN9gt4/zNkhBjtBW+jmCPlQWDu5+TQiBTTfJZQIgrRa8HYLJWwy6wnheImEzeSl2HTmzm1Xz/e/YC8r2eXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616421; c=relaxed/simple;
	bh=1Hz8VuHmXygKh2NcJPgZtYhRty6eWUbr3VEmoWeaiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJuHQDpCMuOOo+kvn/Zu776NE1TCyP8ePjSdn384x5phK4x/vzQMoj7Za5RZWHOwDMO/NST1MQwA9zcOLBPCvDZFsZ9zSPRdCSskH3evk0kxCI2tOV62s+19ii/G5AeuPbZTKw6Kv6prWHE+vRmp+qOkLW9Pib/oMUgSwErHGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn; spf=pass smtp.mailfrom=sjtu.edu.cn; arc=none smtp.client-ip=202.120.2.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sjtu.edu.cn
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 6D214123F30AA;
	Tue, 23 Sep 2025 16:23:33 +0800 (CST)
Received: from sjtu.edu.cn (unknown [10.181.220.127])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 3510037C98C;
	Tue, 23 Sep 2025 16:23:33 +0800 (CST)
From: Zhu Haoran <zhr1502@sjtu.edu.cn>
To: liushixin2@huawei.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	guro@fb.com,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	shakeelb@google.com,
	sunnanyong@huawei.com,
	wangkefeng.wang@huawei.com
Subject: Re: [Question]: pagecache thrashing and hard to trigger OOM in cgroup
Date: Tue, 23 Sep 2025 16:23:21 +0800
Message-ID: <20250923082324.6976-1-zhr1502@sjtu.edu.cn>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c2f4a2fa-3bde-72ce-66f5-db81a373fdbc@huawei.com>
References: <c2f4a2fa-3bde-72ce-66f5-db81a373fdbc@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Liu Shixin,

I’ve been trying to reproduce the thrashing issue you reported. Using QEMU with
the script in [1], the memory-hogging process was always killed quickly in 1-2
minutes, regardless with or without the patch. However, on physical machine
with 6.8 (without your patch [1]) kernel, I was able to reproduce and observe
the long-thrashing installer. I’m now trying to understand why this difference
occurs.

> By bisection, we finally found commit 815744d75152("mm:  memcontrol: don't
> batch updates of local VM stats and events"). Before the commit, the process
> will trigger oom in very short time. We suspect the difference is caused by
> performance changes.

Do you have any insights on why this commit affects OOM triggering?

[1] https://lkml.org/lkml/2024/3/22/410

---
Thanks,
Zhu Haoran

