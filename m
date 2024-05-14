Return-Path: <cgroups+bounces-2889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B328C5A97
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 19:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BC282135
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 17:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F91802CC;
	Tue, 14 May 2024 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFP9iZDf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1671802AE
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709216; cv=none; b=Kqeal9zBeSISS1GAqotRotwng8WNpGEx0ynsvBPyqb/qP7KYQFyisBgRNPLaE7+AYJmcfQqdAurSixw5Lhs9QytJDuJNT2biv/g+t/cbjfhxEoc+KrVgZlu7BGrfztX2cDvupOBYEsRrg4w7+8Jkpxpi9aF1S9OIYo8RcB1BAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709216; c=relaxed/simple;
	bh=FJaZmjT1hm0xa3Y4JcEKdowyRdIxVEbdxk+ZXFURNAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=OS6MrEdoylnLYdX1ljy4Xv245Tq5x0QD38Z9Kk0YUy0hvt/nOweZWazVTAEFXxurU9D4lWJhNuaiWr2zvU/D1d7p7jqeGGsBkMCtqdU9PgQCdF3RSsuhiRtclnzsYcmWhufqZdwR2dKlpqgkPbuAZ/sYrxAqyGbR2T3tFAWmBls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GFP9iZDf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hA07+p0uKBTYe5MM+SIwGglBUwF6JyBwXXElS6xBHO8=;
	b=GFP9iZDfKNaX6p4V/qtE3rIV+GkrEK/Ekm24hizx0WKOvhR/tXb5bnqVpNkBMwz7+Wf/Mk
	HejCvUO6LWbSuiL3Au7VFd/s+k+iYcUxo2T3xcb91N3sGpWV8KTX4cC79NNeiZlc/UNofp
	lJAlqxswhTHfbG//vY2ZA4tTZ9zWyIk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-X-Vf1AQEN72eU3Xt6z5nRA-1; Tue, 14 May 2024 13:53:29 -0400
X-MC-Unique: X-Vf1AQEN72eU3Xt6z5nRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C960841C61;
	Tue, 14 May 2024 17:53:28 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEEFF400057;
	Tue, 14 May 2024 17:53:26 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 0/6] block,nvme: queue-depth and latency I/O schedulers
Date: Tue, 14 May 2024 13:53:16 -0400
Message-Id: <20240514175322.19073-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Changes since V3:

I've included Ewan's queue-depth patches in this new series and rebased
everything on to nvme-6.10.  Also addressed a few review comments and
modified the commit headers.  The code is unchanged.

Changes since V2:

I've done quite a bit of work cleaning up these patches. There were a
number of checkpatch.pl problems as well as some compile time errors
when config BLK_NODE_LATENCY was turned off. After the clean up I
rebased these patches onto Ewan's "nvme: queue-depth multipath iopolicy"
patches. This allowed me to test both iopolicy changes together. 

All of my test results, together with the scripts I used to generate these
graphs, are available at:

  https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

Changes since V1:

Hi all,

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nlatency' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script with 512 byte blocksize I'm getting
the following latencies (in usecs) as a baseline:
- seq write: avg 186 stddev 331
- rand write: avg 4598 stddev 7903
- seq read: avg 149 stddev 65
- rand read: avg 150 stddev 68

Enabling the 'latency' iopolicy:
- seq write: avg 178 stddev 113
- rand write: avg 3427 stddev 6703
- seq read: avg 140 stddev 59
- rand read: avg 141 stddev 58

Setting the 'decay' parameter to 10:
- seq write: avg 182 stddev 65
- rand write: avg 2619 stddev 5894
- seq read: avg 142 stddev 57
- rand read: avg 140 stddev 57  

That's on a 32G FC testbed running against a brd target,
fio running with 48 threads. So promises are met: latency
goes down, and we're even able to control the standard
deviation via the 'decay' parameter.

As usual, comments and reviews are welcome.

Changes to the original version:
- split the rqos debugfs entries
- Modify commit message to indicate latency
- rename to blk-nlatency

Ewan D. Milne (3):
  nvme: multipath: Implemented new iopolicy "queue-depth"
  nvme: multipath: only update ctrl->nr_active when using queue-depth
    iopolicy
  nvme: multipath: Invalidate current_path when changing iopolicy

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

John Meneghini (1):
  nvme: multipath: pr_notice when iopolicy changes

 MAINTAINERS                   |   1 +
 block/Kconfig                 |   9 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nlatency.c          | 389 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 143 ++++++++++++-
 drivers/nvme/host/nvme.h      |   9 +
 include/linux/blk-mq.h        |  11 +
 10 files changed, 563 insertions(+), 10 deletions(-)
 create mode 100644 block/blk-nlatency.c

-- 
2.39.3


