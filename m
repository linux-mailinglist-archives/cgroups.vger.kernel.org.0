Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C53F73C3
	for <lists+cgroups@lfdr.de>; Wed, 25 Aug 2021 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhHYKzO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Aug 2021 06:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231697AbhHYKzN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Aug 2021 06:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629888868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dbXTR2d96IOT3FxhihVlnlP/ppDRoO6Czu1qX4JGEHY=;
        b=Uo2aee+n8qrkm0oUZiLrivvFX3FY+ErOCYXtPxPluzQ0DHVCmKCGG6m+/V0rBwyoHLBmm9
        rXj4MyxhAfEhb6Za2cud+4ySBmCeA/+JpkxkOUz1D8NtAZu8OEtm654omldpbTFGXW0mtd
        jRzYRI5URD26GdS//1/peLAI14xMRAk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-SExJaJhTObeEh_SGGyl9mQ-1; Wed, 25 Aug 2021 06:54:27 -0400
X-MC-Unique: SExJaJhTObeEh_SGGyl9mQ-1
Received: by mail-wr1-f71.google.com with SMTP id p1-20020adfcc81000000b001576cccf12cso978518wrj.6
        for <cgroups@vger.kernel.org>; Wed, 25 Aug 2021 03:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dbXTR2d96IOT3FxhihVlnlP/ppDRoO6Czu1qX4JGEHY=;
        b=MqOcrMkeJUy1J9sHui6yhfKzleyyTRF9T7FM/E6A60ShAID/u61/0+ll0WW4HpBwx8
         caBC9dsiBG5+xRxfBysURlH1f6gGEdcwh5C82+33rDl7XlmEXOg2oLK3Cqqow8+3jlTX
         +kbuk0f9Ugqqw7xC/aahWI03Zx2k/xYMBKavwRIy6g4Wz4kz7+MJrt/jGLgJzVMPPoNy
         WYawlGftkVeijC2JobIrSQFt8f1c4IwKqs4F7Hknp8PAappgDk/xXKnppKwzT24AmyCk
         U/wzEjxRY4r9tkDX9BtItbogVgiUf6x3+NV6W1bWaIKt3uqgnB/MBYMndeHhu7J6Hund
         Xedw==
X-Gm-Message-State: AOAM532P1G7h2guvtTbnd7Q2YLARwVF9GSFiwcz/0Oas77Bo5mjrr4es
        43tSN+U+Ar3wiL/jE3hZ+gij0f5i3lAv6/Qi422FP9rR3z6v8CH0Ac07Fu4Z9okkIyCfVIGk5yw
        pF2QacT3Lsilvd5E7RGpmWqj1WaULEe9PQZDxozYO+7d5hfwHoaqG6WKQIeogHnqu70cibA==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr8746033wml.1.1629888865530;
        Wed, 25 Aug 2021 03:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygtNPMYyRbegzm7x8jmXGimlCDppGqavxle5xpP/MTCxXKYyjlX9GKvmLUt2w1f9KNIwMjCg==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr8746004wml.1.1629888865286;
        Wed, 25 Aug 2021 03:54:25 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1e06:4300:1420:811d:467:5b5f])
        by smtp.gmail.com with ESMTPSA id r1sm21194460wrt.24.2021.08.25.03.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:54:25 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mtosatti@redhat.com, nilal@redhat.com, frederic@kernel.org,
        longman@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] cgroup/cpuset: Avoid memory migration when nodemasks match
Date:   Wed, 25 Aug 2021 12:54:15 +0200
Message-Id: <20210825105415.1365360-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the introduction of ee9707e8593d ("cgroup/cpuset: Enable memory
migration for cpuset v2") attaching a process to a different cgroup will
trigger a memory migration regardless of whether it's really needed.
Memory migration is an expensive operation, so bypass it if the
nodemasks passed to cpuset_migrate_mm() are equal.

Note that we're not only avoiding the migration work itself, but also a
call to lru_cache_disable(), which triggers and flushes an LRU drain
work on every online CPU.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---

NOTE: This also alleviates hangs I stumbled upon while testing
linux-next on systems with nohz_full CPUs (running latency sensitive
loads). ee9707e8593d's newly imposed memory migration never finishes, as
the LRU drain is never scheduled on isolated CPUs.

I tried to follow the user-space call trace, it's something like this:

  Create new tmux pane, which triggers hostname operation, hangs...
    -> systemd (pid 1) creates new hostnamed process (using clone())
      -> hostnamed process attaches itself to:
  	 "system.slice/systemd-hostnamed.service/cgroup.procs"
        -> hangs... Waiting for LRU drain to finish on nohz_full CPUs.

As far as CPU isolation is concerned, this calls for better
understanding of the underlying issues. For example, should LRU be made
CPU isolation aware or should we deal with it at cgroup/cpuset level? In
the meantime, I figured this small optimization is worthwhile on its
own.

 kernel/cgroup/cpuset.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 44d234b0df5e..d497a65c4f04 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1634,6 +1634,11 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
 {
 	struct cpuset_migrate_mm_work *mwork;
 
+	if (nodes_equal(*from, *to)) {
+		mmput(mm);
+		return;
+	}
+
 	mwork = kzalloc(sizeof(*mwork), GFP_KERNEL);
 	if (mwork) {
 		mwork->mm = mm;
-- 
2.31.1

