Return-Path: <cgroups+bounces-3309-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF69915573
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1181C21042
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F78019EEC7;
	Mon, 24 Jun 2024 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWIJ4XBx"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C119DF52
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250368; cv=none; b=nO4EY7pR5jjgRVgpALm7aOOnyXyL+xKMiNU1XHSbx0Is7qG7chKBC+9CAAvNj4L+uy1rP+tAgZndcSMp/uaFQQXWo3g5o06l/dH+WOu7/pyfGoDyTS95cnYiq7jv7Qi2EqgB025lLjLF5ZNeew2FQD7n80ozJVg4tYhL0DZnaHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250368; c=relaxed/simple;
	bh=blL50lx+E+sHZ+kytiiiutI5QbOk9oy5gQkzubHjTJg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=BZsn//Wguv7FkSdhlQ9H08v4UNYq6H++6ShW3VAgNPwvf6QhH6g06Fb5sc/rRTN8y1H7qf+hZB1uMA6jeHFWrqiOkn0F5GMYArRJlVAouEn1TgFjGwg2yVQ4Ghxsoxyp2LvBZR//i8l2LPDo5DU2NI1FQYGqSchZi78FDgCzGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWIJ4XBx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719250366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ONKIJ06lQQFZ/bzHJcIPyP/HDH9k868Uw8F/3bNz1nw=;
	b=MWIJ4XBxhX/J4MtmXGXqSFaLO7TsVhoxqlYOGgUbIF3pOwHPlOZu0tkMlevbIz1XfLlJYR
	tJimwYETvrt40rchm83JbyLiKLEM+HVt6+x8yg4A9b8mRXNzTWX1uVdqYpUzfq63aCYh0P
	CZSCfYxxv3bv1tfUDmorjXAqwEJym1s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-Fd8pM_KhMCy9WM6iDsRFPg-1; Mon,
 24 Jun 2024 13:32:41 -0400
X-MC-Unique: Fd8pM_KhMCy9WM6iDsRFPg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1CFC195608D;
	Mon, 24 Jun 2024 17:32:38 +0000 (UTC)
Received: from [10.22.17.135] (unknown [10.22.17.135])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B38971956087;
	Mon, 24 Jun 2024 17:32:35 +0000 (UTC)
Message-ID: <6c3fbc2d-85d9-4502-b43c-0950ccdd6f7e@redhat.com>
Date: Mon, 24 Jun 2024 13:32:34 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Chris Down <chris@chrisdown.name>,
 Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Rafael Aquini <aquini@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
From: Waiman Long <longman@redhat.com>
Subject: MGLRU OOM problem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi,

We are hitting an OOM issue with our OpenShift middleware which is
based on Kubernetes. Currently, it only sets memory.max when setting
a memory limit.  OOM kills are rather frequently encountered when we
try to write a large data file that exceeds memory.max to a NFS mount
filesystem. I have bisected the problem down to commit 14aa8b2d5c2e
("mm/mglru: don't sync disk for each aging cycle").

The following command can be used to cause an OOM kill when running in a
memory cgroup with a memory.max limit of 600M on a NFS mount filesystem.

  # dd if=/dev/urandom of=/disk/2G.bin bs=32K count=65536 
status=progress iflag=fullblock

In my case, I can cause an OOM when I ran the reproducer the 2nd time in 
a test system.

In the first successful run, the reported data rate was:

   2147483648 bytes (2.1 GB, 2.0 GiB) copied, 57.5474 s, 37.3 MB/s

After reverting commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each
aging cycle"), OOM can no longer be reproduced and the new data rate was:

   2147483648 bytes (2.1 GB, 2.0 GiB) copied, 25.694 s, 83.6 MB/s

If I disabled MGLRU (echo 0 > /sys/kernel/mm/lru_gen/enabled), the data
rate was:

   2147483648 bytes (2.1 GB, 2.0 GiB) copied, 21.184 s, 101 MB/s

I know that the purpose of commit 14aa8b2d5c2e to prevent premature
aging of SSDs. However I would like to find a way to wake up the flusher
whenever the cgroup is under memory pressure and have a lot of dirty
pages, but I don't have a solid clue yet.

I am aware that there was a previous discussion about this commit in
[1], so I would like to engage the same community to see if there can
be a proper solution to this problem.

[1] https://lore.kernel.org/lkml/ZcWOh9u3uqZjNFMa@chrisdown.name/

Cheers,
Longman


