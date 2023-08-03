Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCBF76EEEF
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 18:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjHCQCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 12:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjHCQBx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 12:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E193C02
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 09:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691078459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=cwXRj1KBICVmDyXNwF6/K1df3vGE/T6x9GRpnMzQtuM=;
        b=fXfuTyl9529XxoXuRK1mBvY3jcrxrtPpo+yFmuET/VL2QOqPRAu1A9YoOkE6eWBrS5OL19
        h/k77UDupzGe7rCKuwh+WyBDBtY8AWkkMIj/Vx2Uonc/KucOrYzpsI7ioE+RInu/hraBFu
        PCzyPk9XivrdzH22N0cuGzDoQ1sADHs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-LJ50CI25OkWi7ud9tMEjAQ-1; Thu, 03 Aug 2023 12:00:58 -0400
X-MC-Unique: LJ50CI25OkWi7ud9tMEjAQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cf3d966e1so11584516d6.1
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 09:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078458; x=1691683258;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwXRj1KBICVmDyXNwF6/K1df3vGE/T6x9GRpnMzQtuM=;
        b=B12wexmNi7GsZE9QoOaFyRQVOCs6agl0nNHvaOiQHMjlv76UCkdDmH5TJ6TYrr85ID
         tFCxc6clmNnEuB2Ws3W55Lherz5htF28IoGYaZUtRX+D9f0FOwAk7d1dvb2aIMETA81f
         xi+fbwD+Ebvvg072D4S+HI/hFy5O0L70gpEoUxiZOhsO7KBL8il0qel9rK4MwIZlGvyM
         PDGG3WiKlcwq45cNqaeNAa1ew4aeDZSIyfLGB5p6OIbxcmP5yJdhkjGTobkt6tf6zbVq
         e35Bvu3/ZPSzIbd6xRGWgTWBzKe13vIcDLLMfKKUdPilGpxvJSskVO5PhRzPmNu/kfj+
         3GtQ==
X-Gm-Message-State: ABy/qLZp2o7jctW6rXmBGl65IYXZxllvFSOg9r4jjkUyMDMXi9y1or53
        01yIXONs5/ugMPoxc/XQwhw0WYHofRf239yk7h9HVZrpfM6mqKYNGfIKrROI/u7XskwK/DMaQ3I
        tlcA7B1xFNOvPKvZbRg==
X-Received: by 2002:a0c:cb86:0:b0:63d:b75:c971 with SMTP id p6-20020a0ccb86000000b0063d0b75c971mr19142298qvk.15.1691078457936;
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFCc7WuuoDe+WhLh9WzsibbctR6fIN91ahYBGVYqFqyM7r8CuW7h/Cye78YzhzmJhvadLpnLg==
X-Received: by 2002:a0c:cb86:0:b0:63d:b75:c971 with SMTP id p6-20020a0ccb86000000b0063d0b75c971mr19142272qvk.15.1691078457517;
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id w19-20020a0cdf93000000b0062de6537febsm2729qvl.58.2023.08.03.09.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:00:57 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:00:47 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: cgroup: fix test_kmem_basic slab1 check
Message-ID: <ix6vzgjqay2x7bskle7pypoint4nj66fwq7odvd5hektatvp2l@kukoifnfj3dr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

test_kmem_basic creates 100,000 negative dentries, with each one mapping
to a slab object. After memory.high is set, these are reclaimed through
the shrink_slab function call which reclaims all 100,000 entries. The
test passes the majority of the time because when slab1 is calculated,
it is often above 0, however, 0 is also an acceptable value.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
https://lore.kernel.org/all/m6jbt5hzq27ygt3l4xyiaxxb7i5auvb2lahbcj4yaxxigqzu5e@5rn6s2yjzv7u/
V2: Corrected title

 tools/testing/selftests/cgroup/test_kmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 258ddc565deb..ba0a0bfc5a98 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -71,7 +71,7 @@ static int test_kmem_basic(const char *root)
 
 	cg_write(cg, "memory.high", "1M");
 	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
-	if (slab1 <= 0)
+	if (slab1 < 0)
 		goto cleanup;
 
 	current = cg_read_long(cg, "memory.current");
-- 
2.41.0

