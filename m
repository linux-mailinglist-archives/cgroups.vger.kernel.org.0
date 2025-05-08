Return-Path: <cgroups+bounces-8093-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DB4AB0336
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A706FA00B87
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D128751B;
	Thu,  8 May 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8d3cVmr"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFBE277008
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730182; cv=none; b=i4WFzSacXhozrMBSFAO5bieJjG/PFJUwFnU+YjywErWOjbafFMZwL9aYrsXr8Iqfp5TOqTWPYx272ojQXRmrPlhwk4INEGwHdVqYfsJP+6nFkz6reJ3Dly+M7GWf2jcUh8FSNTtqljtz+8KA37oewchGPqBm/ytCwmGC0RznFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730182; c=relaxed/simple;
	bh=jK92st7X0klV03+jG2bTxf99xWy4odtdMf2NoHOPdXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWTGW6WBDJTZYHV5HJcDh7/Py/oPJ1re2GnadT26Y2bs2CEJEdJ98DARQlmr5Xzk5xsUI+B3UqlCy2zm5HKckhOheZyj9VG1IOdPkuvLAwG94DFUeLCXhHQUfsjttjhpmCuk5EZf13AiJf4e3kcS5l4D8vJc5qH/q7fgSDpwdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8d3cVmr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746730179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IW0+4MWM9x9LMl+OAQiFn/VAiGTBHRX4k1GUGskDHkE=;
	b=f8d3cVmrPM5Vlq4h6lO/+tVdnCqkiBrVWm+rnWmHCml8PfafBgDCjOEToiwoxZrqicqyhL
	CH0L4PTiLAF5buFVVi4xm1ky0CU+/AioAJdSEB0B3PfQzc5J+6NyLsoDMQL7y/b8+GzbHo
	mOCea1r3JVm4kqyiWXmnZHGryFN1f4k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-1IEsC-AOM4yIUb1O4Y_kdg-1; Thu,
 08 May 2025 14:49:36 -0400
X-MC-Unique: 1IEsC-AOM4yIUb1O4Y_kdg-1
X-Mimecast-MFC-AGG-ID: 1IEsC-AOM4yIUb1O4Y_kdg_1746730174
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F191955DE8;
	Thu,  8 May 2025 18:49:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.242])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7458618004A7;
	Thu,  8 May 2025 18:49:32 +0000 (UTC)
From: Joel Savitz <jsavitz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Joel Savitz <jsavitz@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	cgroups@vger.kernel.org
Subject: [PATCH v2 0/2] Minor namespace code simplication
Date: Thu,  8 May 2025 14:49:28 -0400
Message-ID: <20250508184930.183040-1-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The two patches are independent of each other. The first patch removes
unnecssary NULL guards from free_nsproxy() and create_new_namespaces()
in line with other usage of the put_*_ns() call sites. The second patch
slightly reduces the size of the kernel when CONFIG_CGROUPS is not
selected.

Joel Savitz (2):
  kernel/nsproxy: remove unnecessary guards
  include/cgroup: separate {get,put}_cgroup_ns no-op case

Changes from v1:
- now removing the guards instead of adding them where missing since
  checking that all calls in the NULL case were already no-ops
- added second patch

 include/linux/cgroup.h | 26 ++++++++++++++------------
 kernel/nsproxy.c       | 30 ++++++++++--------------------
 2 files changed, 24 insertions(+), 32 deletions(-)

-- 
2.45.2


