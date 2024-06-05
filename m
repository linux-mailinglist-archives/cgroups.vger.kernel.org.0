Return-Path: <cgroups+bounces-3106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE488FD3C1
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A25286740
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452C13A269;
	Wed,  5 Jun 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDPLG01R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E136E1F
	for <cgroups@vger.kernel.org>; Wed,  5 Jun 2024 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607960; cv=none; b=Ve3LhDmZjEeLBFJZGRtkbGf5geyNE8uwB+htLZRslF1hkGIcCc9XOlEVDORDXbit315R7vpnkBpFYBEui5TJ66sZJ2eHZontrNu144A1EgG8z2M2ey+vEOPEt4nT6582JQs7ddxP0cy3zj/vfdupq1rgQVuziGF392uwPoc7xQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607960; c=relaxed/simple;
	bh=W+wxBm3RxC5Ki14djoLkxw0QjNOmecFvYqeOqobZ7Do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NWcwz2GUQSLj2i7fW/hsqXn2THq1tnyk5aloIbf5NDzWxxYow/z2bjUr8CkkBwJIdkKtAwNsFQMkOgEfiLlSyXr2gjoS688FBUPi9J6ZTYzDWqiAjVtcikCwmuJ3K5ET1AtcrQPe8PJ7Lp5UjEJ2jtOACUhbDghlIjeWr6aoSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDPLG01R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717607957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TS9fGEndQOk3FBiJhTOyAAupDT0mnziDl7E1bdw4eT0=;
	b=TDPLG01RS0DjCZ1WuZlmEa+pOCwaaubcKQ9s9mlNFzKbhamUOqPzVTNv7gxAO62xv2cha5
	dXhTpyTFMxWmFFHLG+f9goplHC7PigbFDhYyopv8JVMeMXbUeNfCSNp1jqUPneRnIwpp/Q
	heDW0irvCAo4Xw+cGHpSxA2+GoeHUNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-mfeQ7FoJPJmzF9TnQ3MmNw-1; Wed,
 05 Jun 2024 13:19:12 -0400
X-MC-Unique: mfeQ7FoJPJmzF9TnQ3MmNw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74446195C26F;
	Wed,  5 Jun 2024 17:19:10 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CDE31956055;
	Wed,  5 Jun 2024 17:19:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/2] cgroup/cpuset: Fix remote root partition creation problem
Date: Wed,  5 Jun 2024 13:18:56 -0400
Message-Id: <20240605171858.1323464-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

While reviewing the generate_sched_domains() function, I found a bug
in generating sched domains for remote non-isolating partitions. After
extending test_cpuset_prs.sh to cover those cases, the bug is confirmed.

The first patch fixes the remote partitions sched domain generation
problem and the second patch updates the test.

Waiman Long (2):
  cgroup/cpuset: Fix remote root partition creation problem
  selftest/cgroup: Dump expected sched-domain data to console

 kernel/cgroup/cpuset.c                        | 55 ++++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh       | 29 +++++++++-
 2 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.39.3


