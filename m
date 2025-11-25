Return-Path: <cgroups+bounces-12185-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6554C8339C
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 04:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F3A4E7065
	for <lists+cgroups@lfdr.de>; Tue, 25 Nov 2025 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEDD221FCC;
	Tue, 25 Nov 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCIk1Tjm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C732248BE
	for <cgroups@vger.kernel.org>; Tue, 25 Nov 2025 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041240; cv=none; b=oeZHKxcHNFNnAtxh0CJgTd8fnevJdC/y7Bo3zDL0IKwVne11VGhsk66576vEQtBsBPtX0Ie6+RND/fAXaa9WOkIrXhNj5SyfOTWhLJCei2azlvxLbKlffeT+eerbTYbyP1ConKZMTwC+JsZXeeUc04o2URANSlKs2UgZtXoYcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041240; c=relaxed/simple;
	bh=KYE5/C0JBhx3vM/Qd7qmoOZU/0dzqPu/Uae7upy8C64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmVLHv6lm/c/ljQcfE5VprTZK94gIm76og+gZje4CetZ4O84onb3c+qHHiW1X+yRxsYSri1TffFQ/SSwwGolPGFWii/NqZ+nry0rhAgW055ZhEC8QHeLKEK4MGcxHP2ZWtLWP9mV65nAer3edcs/Euo7nx3HsYjwChqDxKnAqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCIk1Tjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764041237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fq2sJVHn5K65A5wgA+jYbiI+7RyvEdnAtWFQVvmO5KM=;
	b=iCIk1TjmxfjPvL7EfkfaZVBXpwXLZmDDJSCoDwHWT4b06xWZBSoe12xu1Gx0BGS7Ou+Fw2
	qQ1q0rrLDadfEfADmONX6KULxBoCN+avCob4o1R6SU6yBULEORkh1D4cM35zlZ6KcHmEQx
	FT7xWGmXQIt6dApR3sAzAUpS6ku7hBs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-KbZJDvdZNxyvv8-5j5oe5g-1; Mon,
 24 Nov 2025 22:27:09 -0500
X-MC-Unique: KbZJDvdZNxyvv8-5j5oe5g-1
X-Mimecast-MFC-AGG-ID: KbZJDvdZNxyvv8-5j5oe5g_1764041227
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DFA41800357;
	Tue, 25 Nov 2025 03:27:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D44E43003761;
	Tue, 25 Nov 2025 03:26:58 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv2 0/2] sched/deadline: Fix potential race in dl_add_task_root_domain()
Date: Tue, 25 Nov 2025 11:26:28 +0800
Message-ID: <20251125032630.8746-1-piliu@redhat.com>
In-Reply-To: <20251119095525.12019-3-piliu@redhat.com>
References: <20251119095525.12019-3-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

These two patches address the issue reported by Juri [1] (thanks!).

The first removes an unnecessary comment, the second is the actual fix.

@Tejun, while these could be squashed together, I kept them separate to
maintain the one-patch-one-purpose rule. let me know if you'd like me to
resend these in a different format, or feel free to adjust as needed.

[1]: https://lore.kernel.org/lkml/aSBjm3mN_uIy64nz@jlelli-thinkpadt14gen4.remote.csb

Pingfan Liu (2):
  sched/deadline: Remove unnecessary comment in
    dl_add_task_root_domain()
  sched/deadline: Fix potential race in dl_add_task_root_domain()

 kernel/sched/deadline.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

-- 
2.49.0


