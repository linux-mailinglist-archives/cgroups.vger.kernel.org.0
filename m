Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65A77FEC3
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354788AbjHQT7N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Aug 2023 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354748AbjHQT6n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Aug 2023 15:58:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A89359C
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692302280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=M+cHwSXYqzyiBAs9LYfm9bQki8Ktpzfnu45rfgTUfPw=;
        b=TLwweBo8vhcHQPXVebA4cRIYmiGacO/t78+g+Tcl+8KxHB+jqxAv3A1TNsHp/MtfZ+uwxo
        tNeYCKbiZ3PdniFuUVs0dUhQK5kjbptq2u3Nwic1BmwhUe9GKrK8RFkDdN+BA3TC7bThmB
        R/qZe2BQrRPiVheFpXjrpGq+udakLcc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-iiY5wuMqMvmpU5Fo8oV_7A-1; Thu, 17 Aug 2023 15:57:59 -0400
X-MC-Unique: iiY5wuMqMvmpU5Fo8oV_7A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76d845cb4cfso23225885a.0
        for <cgroups@vger.kernel.org>; Thu, 17 Aug 2023 12:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692302278; x=1692907078;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+cHwSXYqzyiBAs9LYfm9bQki8Ktpzfnu45rfgTUfPw=;
        b=PrHI6O9rpgACnKeJit/QyxZAcUMYTwBWNsjUn+Zm4aaT03U+avjC6txQIOXSWCzPUt
         hPpeyE41fr9ymAbNl1Gsr++MNlf/P0RHeyj1IBrcQUl63w8T6dddU8VjV07dwlEyyqF1
         RXzTSiTtzkp2cKld9Gst4vcKgrnlajPhApw6bxxV72TUrCX8J8Wz1lN8W9Cc/8SN+W0/
         PiVST/iAw+PjuIhpOprG5qYZU8+SXHaJErln1VFV/ZQ1+Nnp4eru4UwTuyXTgZeDap4R
         5wsQUkaTArZ4rmUB4iFw+aAiJZsAXYsTboT3bZ2z7mSC+bTFy1/SzQ0lcdr3EtAocYFn
         FPGw==
X-Gm-Message-State: AOJu0YxQN7Zeu+BgstN0iATylsFn2ZcXUGUGS6PVhNg/KeYKKKlI5i6J
        N2aMK5EuOlUMcIO8J7fn+Nz7/isLngl841yphh+bEz5uva95kCd/kzuOq+ZHjsoQw+fLhAbQ9Ui
        ERipGXhtAMaM4T+AGDw==
X-Received: by 2002:a05:620a:258e:b0:765:7d7b:7197 with SMTP id x14-20020a05620a258e00b007657d7b7197mr645100qko.31.1692302278585;
        Thu, 17 Aug 2023 12:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQgXuoDpTI5a32rf3ve8W0aO5TbiD9EyI1QuhXrP4vNvyIDNys5Ml/PftOW0Uy323gwFC5NQ==
X-Received: by 2002:a05:620a:258e:b0:765:7d7b:7197 with SMTP id x14-20020a05620a258e00b007657d7b7197mr645085qko.31.1692302278329;
        Thu, 17 Aug 2023 12:57:58 -0700 (PDT)
Received: from fedora ([174.89.37.104])
        by smtp.gmail.com with ESMTPSA id o10-20020a05620a130a00b00767c961eb47sm37865qkj.43.2023.08.17.12.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 12:57:58 -0700 (PDT)
Date:   Thu, 17 Aug 2023 15:57:48 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: cgroup: fix test_kmem_memcg_deletion kernel
 mem check
Message-ID: <bvrhe2tpsts2azaroq4ubp2slawmop6orndsswrewuscw3ugvk@kmemmrttsnc7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, not all kernel memory usage is being accounted for. This
commit switches to using the kernel entry within memory.stat which
already includes kernel_stack, pagetables, and slab. The kernel entry
also includes vmalloc and other additional kernel memory use cases which
were missing.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
Changes in v3:
    - Fixed test case description
    - Included anon, file, and sock as mentioned by Shakeel.

 tools/testing/selftests/cgroup/test_kmem.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index ed2e50bb1e76..c82f974b85c9 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -162,11 +162,11 @@ static int cg_run_in_subcgroups(const char *parent,
  * allocates some slab memory (mostly negative dentries) using 2 * NR_CPUS
  * threads. Then it checks the sanity of numbers on the parent level:
  * the total size of the cgroups should be roughly equal to
- * anon + file + slab + kernel_stack.
+ * anon + file + kernel + sock.
  */
 static int test_kmem_memcg_deletion(const char *root)
 {
-	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
+	long current, anon, file, kernel, sock, sum;
 	int ret = KSFT_FAIL;
 	char *parent;
 
@@ -184,29 +184,22 @@ static int test_kmem_memcg_deletion(const char *root)
 		goto cleanup;
 
 	current = cg_read_long(parent, "memory.current");
-	slab = cg_read_key_long(parent, "memory.stat", "slab ");
 	anon = cg_read_key_long(parent, "memory.stat", "anon ");
 	file = cg_read_key_long(parent, "memory.stat", "file ");
-	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
-	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
-	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
+	kernel = cg_read_key_long(parent, "memory.stat", "kernel ");
 	sock = cg_read_key_long(parent, "memory.stat", "sock ");
-	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
-	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
+	if (current < 0 || anon < 0 || file < 0 || kernel < 0 || sock < 0)
 		goto cleanup;
 
-	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
+	sum = anon + file + kernel + sock;
 	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
 		printf("memory.current = %ld\n", current);
-		printf("slab + anon + file + kernel_stack = %ld\n", sum);
-		printf("slab = %ld\n", slab);
+		printf("anon + file + kernel + sock = %ld\n", sum);
 		printf("anon = %ld\n", anon);
 		printf("file = %ld\n", file);
-		printf("kernel_stack = %ld\n", kernel_stack);
-		printf("pagetables = %ld\n", pagetables);
-		printf("percpu = %ld\n", percpu);
+		printf("kernel = %ld\n", kernel);
 		printf("sock = %ld\n", sock);
 	}
 
-- 
2.41.0

