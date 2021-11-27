Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC06045FF7E
	for <lists+cgroups@lfdr.de>; Sat, 27 Nov 2021 16:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242667AbhK0PEw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Nov 2021 10:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbhK0PCw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Nov 2021 10:02:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639DBC061574;
        Sat, 27 Nov 2021 06:59:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o20so50954253eds.10;
        Sat, 27 Nov 2021 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jLD7GABe69Y2XIK8EiAw+ECm8aNoQireR1sVfpfjBUw=;
        b=XZeYzcUqFHoWKneResRr679zdRHeMgo5U8ZyVqUHrxnhcTRHSuLmO2QbJVgmmmJ5PI
         emrMJRDFtSew+vIqtyNpgmnOuT6ZXzc5h+cUGdd5yFK4kWlZVCTF7wsKotojpfNkxMGA
         vGWnEIeLui9YEszzwYJ6DK7iVlghNaFBil3Wxfh7e2Lvg7JCFx9TGd1hx2WOuGX6Jcph
         6j73Mc7Ih40R3MRxbaadn/Sa8bZmvxJIiNyFb2vD0o5pTZA/n79jzxpLeTA+YD94K/+4
         FF68W5SYmJLerPI7RUzDvD6bPf+j7ZV3C1v9UmwtqTYq4xiDn0GCJCQgScXHfIDt7l4w
         KEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jLD7GABe69Y2XIK8EiAw+ECm8aNoQireR1sVfpfjBUw=;
        b=BlS9jLSDZJooy2mBZOzeWWmSWyexQMv8ZBoB4m4icXMQlnQpocpWq9AG0Sn9TU7qk/
         o6ZEyTEhuVmurdVX2el9Hwxz5ROHodw9AmxuQZvxBdefl1jw907p8zgX2u0rA/y0zzsY
         SD5SEHXyim5C0h+YkNWgBUDcAfBjti728TOAzTGZRW79dIiVRkElrvLCH5zXcJCftCGT
         C8643PqjytYNShlBoO/pfmaJRenLPBlPFUUbwdjZTY75p9p6sa7z+KH8V+yWpcHO9kCW
         QcnIfStLBa4ukRQlL593IGI1TADQjQETgFfCBY1U3+4rR5TVxRBFJniGWi8YYQ8qvFGa
         xcAQ==
X-Gm-Message-State: AOAM5322EF3F8AflfmKQhF+hybMslZ6wy81uK8B7bZlb4CRGHMYKKDqY
        rKVwjGxjpoqnMBvYIBNh7IU=
X-Google-Smtp-Source: ABdhPJw/7vg1rXdJOToUI4dhOZBfGuj82hpL3s6C1CytfB9lsuRvrvSiwFzErl6ebe/hcCkQUtoBBw==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr56410757ede.28.1638025175700;
        Sat, 27 Nov 2021 06:59:35 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id r24sm4615734edv.18.2021.11.27.06.59.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Nov 2021 06:59:35 -0800 (PST)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 1/2] cgroup: cgroup_subsys[ssid] is never NULL
Date:   Sat, 27 Nov 2021 14:59:18 +0000
Message-Id: <20211127145919.31159-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the check, (ssid) < CGROUP_SUBSYS_COUNT, passed, it means
cgroup_subsys[ssid] is defined to its proper value. It is not
necessary to use a true to enter the loop.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/cgroup/cgroup-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..0c5d1df6cdef 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -163,7 +163,7 @@ extern struct file_system_type cgroup_fs_type;
  */
 #define for_each_subsys(ss, ssid)					\
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
-	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
+	     ((ss) = cgroup_subsys[ssid]); (ssid)++)
 
 static inline bool cgroup_is_dead(const struct cgroup *cgrp)
 {
-- 
2.33.1

