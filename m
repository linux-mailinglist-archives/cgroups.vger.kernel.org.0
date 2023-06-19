Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483EC735809
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 15:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFSNG7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 09:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjFSNGY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 09:06:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FB01704
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 06:05:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b5452b77b4so18673525ad.3
        for <cgroups@vger.kernel.org>; Mon, 19 Jun 2023 06:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1687179909; x=1689771909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbDj0tuIsqmd9Jb0jvnKqTFsbroelomAP4JxfiYyGMc=;
        b=UA8q5LtBb0Ykh3MFbdGnfMFxTLoX6PI5I+bsDyEpHus9uTAEWP2yotngxINlDm3Dai
         3YiYw+uTYqOMlR+98nC7buF9L6dLMJJ2p5v6+CrjpvFnkzP4vSq2/lfRGGSkgB13awG/
         ehipcwsazCyFrhWw0vE/vjdkponpzHJ1JraXQLaShlRvGwMX0/tX5GrX5Ry8CNlY68Sj
         ka5N5zANVdqW+vGGUWiFIGzH1rZZKPxxGWTIBq3BrFDiXuL1eYUKLnWUwnVUXSgvChQq
         M6GBny0MHWbHYsnohmZfLj2MnkgepVQAYLHrrlooxS2jbH5m1n6EI4jIGWomLvJ4C3yp
         llAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179909; x=1689771909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbDj0tuIsqmd9Jb0jvnKqTFsbroelomAP4JxfiYyGMc=;
        b=OBYmP+HTYMea1NVX7htX7sR5hVHYlreBGcD9Wv8WLxVFRRNL/X6Vexw9EEbMr8Iim/
         npR/qDJpFc8Wlckz6Lgegv0pT2gLiaF+tH1GR6BwJGmuKjOQKpEM1Z28qHveWooWqJTj
         2SRNHx9CVVDwVUpsR481aVkUJqVU+FwnhwxB6PbTjkfQmFnygsBncrmNa5A65Iabw5QN
         AjmjULAmOZ3URxT8+Bm2kpUfitkKUW5B+cxIdk3zXelKA5SwxKQBc1ccK0RzXZo14uv4
         DMQITF9NfK3S3lYPyzIgcrebrvNKwGh7wr0zn6JiDBawG9qi1/kWVtywGvMwldnLT6/4
         CbpQ==
X-Gm-Message-State: AC+VfDx0pM2CZCoZzfpRJbhGcl/aH3QLT9ilbbjb+kmXFGPfa6F1gGMm
        523UB5SJmjzPQnXirWmN+Nadsw==
X-Google-Smtp-Source: ACHHUZ61V3ZMnYG41ClCRZ+rfd2TfsBGK3nyq4MLTfcXQzlnSEZTBbraxSM5XwAVEsYRCan4M+gbYA==
X-Received: by 2002:a17:902:ea8a:b0:1aa:d545:462e with SMTP id x10-20020a170902ea8a00b001aad545462emr9637270plb.13.1687179909415;
        Mon, 19 Jun 2023 06:05:09 -0700 (PDT)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903120d00b001b53953f306sm5236052plh.178.2023.06.19.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:05:09 -0700 (PDT)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     mhocko@suse.com
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, roman.gushchin@linux.dev, shakeelb@google.com,
        Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v2] mm/memcontrol: do not tweak node in mem_cgroup_init()
Date:   Mon, 19 Jun 2023 13:04:42 +0000
Message-Id: <20230619130442.2487-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZIwghl18d45vPNpd@dhcp22.suse.cz>
References: <ZIwghl18d45vPNpd@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_init() request for allocations from each possible node, and
it's used to be a problem because NODE_DATA is not allocated for offline
node. Things have already changed since commit 09f49dca570a9 ("mm: handle
uninitialized numa nodes gracefully"), so it's unnecessary to check for
!node_online nodes here.

How to test?

qemu-system-x86_64 \
  -kernel vmlinux \
  -initrd full.rootfs.cpio.gz \
  -append "console=ttyS0,115200 root=/dev/ram0 nokaslr earlyprintk=serial oops=panic panic_on_warn" \
  -drive format=qcow2,file=vm_disk.qcow2,media=disk,if=ide \
  -enable-kvm \
  -cpu host \
  -m 8G,slots=2,maxmem=16G \
  -smp cores=4,threads=1,sockets=2  \
  -object memory-backend-ram,id=mem0,size=4G \
  -object memory-backend-ram,id=mem1,size=4G \
  -numa node,memdev=mem0,cpus=0-3,nodeid=0 \
  -numa node,memdev=mem1,cpus=4-7,nodeid=1 \
  -numa node,nodeid=2 \
  -net nic,model=virtio,macaddr=52:54:00:12:34:58 \
  -net user \
  -nographic \
  -rtc base=localtime \
  -gdb tcp::6000

Guest state when booting:

[    0.048881] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.050489] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x13fffffff] -> [mem 0x00000000-0x13fffffff]
[    0.052173] NODE_DATA(0) allocated [mem 0x13fffc000-0x13fffffff]
[    0.053164] NODE_DATA(1) allocated [mem 0x23fffa000-0x23fffdfff]
[    0.054187] Zone ranges:
[    0.054587]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.055551]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.056515]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[    0.057484] Movable zone start for each node
[    0.058149] Early memory node ranges
[    0.058705]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.059679]   node   0: [mem 0x0000000000100000-0x00000000bffdffff]
[    0.060659]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.061649]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
[    0.062638] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.063745] Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
[    0.064855]   DMA zone: 158 reserved pages exceeds freesize 0
[    0.065746] Initializing node 2 as memoryless
[    0.066437] Initmem setup node 2 as memoryless
[    0.067132]   DMA zone: 158 reserved pages exceeds freesize 0
[    0.068037] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.068265] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.124755] On node 0, zone Normal: 32 pages in unavailable ranges

cat /sys/devices/system/node/online
0-1
cat /sys/devices/system/node/possible
0-2

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
---
v2:
- extend changelog by test steps
---
 mm/memcontrol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..c73c5fb33f65 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7421,8 +7421,7 @@ static int __init mem_cgroup_init(void)
 	for_each_node(node) {
 		struct mem_cgroup_tree_per_node *rtpn;
 
-		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
-				    node_online(node) ? node : NUMA_NO_NODE);
+		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
 
 		rtpn->rb_root = RB_ROOT;
 		rtpn->rb_rightmost = NULL;
-- 
2.25.1

