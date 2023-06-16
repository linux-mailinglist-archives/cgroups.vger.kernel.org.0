Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0917329C3
	for <lists+cgroups@lfdr.de>; Fri, 16 Jun 2023 10:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245394AbjFPI2v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jun 2023 04:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbjFPI2u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jun 2023 04:28:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421130D0
        for <cgroups@vger.kernel.org>; Fri, 16 Jun 2023 01:28:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b3be39e666so4135945ad.0
        for <cgroups@vger.kernel.org>; Fri, 16 Jun 2023 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1686904123; x=1689496123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDUVlxr6MIHuvrj4qFPZKLZUZbfg4Er9rrj+u7M45oY=;
        b=RqRoDM6U9yZrXYYLMxuPkioIiUXPKKv4f1voJfglrx856kDWQ4InU3T953oGyFvEx1
         VCtzXMmCfz2+nWM1hHGDbWfIyg+YohWISPrJ5C+isy1rxB3x9zqYAvfFMek7vUt6E5S7
         +xQ53ddcA0Eg7evsHfFGzfTvHPys0n4GIOGNfx7/l1est+VX3BIJwFflM2GRNFBa+Ahf
         NaGx4nl3WpfAIN3qCg4iI8BwXen7OGXZAm6fFB0SUQcRBBy3GOVkWtQXAlZGsqJ1EbAr
         nIFds4nKrdg9MSVAYMPWte1TiPY7Pwd8QwhS56xYzDSu8T+hJAv+A706RnxIh9M4W+NK
         DtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686904123; x=1689496123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oDUVlxr6MIHuvrj4qFPZKLZUZbfg4Er9rrj+u7M45oY=;
        b=b16CBjV8EOnSC7f5YmbqGWq+rPewIEBgdLe/YjKASl/GFSa/DO8vzmQNSsFly3KNc/
         3i/c4wOMssY+tP/UEoamv5b2fR9viCmC6zDqY5J1TFGpZfdhKzeMVv85/G6DPS6DFYvi
         smS+G4cEwYFGHGOTRmc77x7EuzfO15HXQyKWsQiwu2GSrW7oqw+mW6nCQ4PdtcW0I3DK
         ExN/em3ZIopHlL2GMuOmiTqr7CW26MtnVRGJt7aLtvS6Phh1TUeppmdqw9EHPknhFXNQ
         De7SpRWHIYodWoz3/m21UsJpoSH80uZglkp7Ul7NltjSIFdIVVYOQlnVGA28VGh5kPc0
         cZ2Q==
X-Gm-Message-State: AC+VfDySvoKdct+wND6EXraytFUob+HffZ1WYOi/SrgUpj0J01B0EQ/e
        1zchuUZfMVyk/xfADNfVt9o8ww==
X-Google-Smtp-Source: ACHHUZ4KH7TA4LKpFW6ObfZvJDADk1NeKn28oSeId8Ezlgfso5K4plJhA7iHfjiDF40xU3dWhpUmCA==
X-Received: by 2002:a17:903:2310:b0:1b3:bf70:4ed4 with SMTP id d16-20020a170903231000b001b3bf704ed4mr10285440plh.23.1686904123425;
        Fri, 16 Jun 2023 01:28:43 -0700 (PDT)
Received: from [10.54.24.10] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001b24857d1f2sm6625845plb.188.2023.06.16.01.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:28:43 -0700 (PDT)
Message-ID: <47119364-30ac-cb57-7fd8-d9aa4b230478@shopee.com>
Date:   Fri, 16 Jun 2023 16:28:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] mm/memcontrol: do not tweak node in mem_cgroup_init()
To:     Michal Hocko <mhocko@suse.com>
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230615073226.1343-1-haifeng.xu@shopee.com>
 <ZIrIb7pgRXln27nv@dhcp22.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZIrIb7pgRXln27nv@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2023/6/15 16:14, Michal Hocko wrote:
> On Thu 15-06-23 07:32:25, Haifeng Xu wrote:
>> mem_cgroup_init() request for allocations from each possible node, and
>> it's used to be a problem because NODE_DATA is not allocated for offline
>> node. Things have already changed since commit 09f49dca570a9 ("mm: handle
>> uninitialized numa nodes gracefully"), so it's unnecessary to check for
>> !node_online nodes here.
> 
> How have you tested this patch?

Start with one empty node:

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

In addition, I add a debug meesage:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7ebf64e48b25..3d786281377d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7424,7 +7424,7 @@ static int __init mem_cgroup_init(void)
                rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
                if (!rtpn)
                        continue;
-
+               pr_info("allocate rtpn node %d.\n", node);
                rtpn->rb_root = RB_ROOT;
                rtpn->rb_rightmost = NULL;
                spin_lock_init(&rtpn->lock);


[    0.561420] allocate rtpn node 0.
[    0.562324] allocate rtpn node 1.
[    0.563322] allocate rtpn node 2.


> 
> I am not saying it is wrong and it looks like the right thing to do. But
> the early init code has proven to be more subtle than expected so it is
> definitely good to know that this has been tested on memory less setup
> and passed.
> 
>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  mm/memcontrol.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4b27e245a055..c73c5fb33f65 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7421,8 +7421,7 @@ static int __init mem_cgroup_init(void)
>>  	for_each_node(node) {
>>  		struct mem_cgroup_tree_per_node *rtpn;
>>  
>> -		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
>> -				    node_online(node) ? node : NUMA_NO_NODE);
>> +		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
>>  
>>  		rtpn->rb_root = RB_ROOT;
>>  		rtpn->rb_rightmost = NULL;
>> -- 
>> 2.25.1
> 
