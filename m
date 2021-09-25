Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6762641847B
	for <lists+cgroups@lfdr.de>; Sat, 25 Sep 2021 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhIYUrc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Sep 2021 16:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYUrb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Sep 2021 16:47:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B937BC061570
        for <cgroups@vger.kernel.org>; Sat, 25 Sep 2021 13:45:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u8so55704790lff.9
        for <cgroups@vger.kernel.org>; Sat, 25 Sep 2021 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4uS3HBDLrNVH5OQU2j6dDHcKqPuLsmrUNZZ6YSb7PBg=;
        b=d/uTxYEYeqJ2+l/8hTE5bTj5SEuXMq/EBeRLi2SG307hDbyPQHuGO5sDaGHRwwyI0n
         46IRki/tbyw4F1KTHm0ErJ9jcQZoEpNvjYT/FAeRStH9u92Ef/Pj74Z0tLBKrl9Jz1EM
         edcHW+eL1LC9YPQV6PDRl0B8Wfd/P5hmFyv/JydLLxMj2U+AcdKMG1PZNUC1L3J0fFnS
         lkJ5S8NfzBTY2U1LLivepGT/z9nnvHnTqHzjeZv32iJMq05GMcgMHna264IeO5Q/bIxs
         s0MQugc1w4n29ZDeIM8hQdp0KCJFDCCIrSFV9cCq/H6DmQH5oyU78fGDkyypsyY4mdvl
         JEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4uS3HBDLrNVH5OQU2j6dDHcKqPuLsmrUNZZ6YSb7PBg=;
        b=iNIs502QzPxFXL0Y6NOc8j14FsOL/l1bho0G02kP58EY2cNabc28aAYuw0yK4ftSQq
         5J9uSfvaqj5EZefR5As48pNB4h3cjONgwloTXF/UpLUrvvbHwXBp8cLiqc39zY/bbReN
         V2xQvL9aInsE8L5IS5+frVSDtus1JSGwzWkxUlMWkXBJD6f3ZSzjFuQHM5oxY2h2xZej
         yI+8cHqFHtW1+moWga8IUDe53sGqqCVj7XrjlLZIKjvgGmCdPlkJW7Q/O3KpL3OP7beT
         ERd40D36ox2o7JBCAQzJ2VVJgWsXQ5lC3SKysdI9+9MWl8RHCwlpd/wWvPgp7eDwzaDt
         PWuw==
X-Gm-Message-State: AOAM530JLx729iI7vmvyQ/iseWmclG1b0DvUjGy9qSn58J0e1kpSELgp
        JiNZI1f7vDs1xzqIolNx5nOEUh7sEvCeN7/irDzvRuYS28Q=
X-Google-Smtp-Source: ABdhPJy3TfgBUaDS+CRSeR+djo2+W0qqal3l7Vz/9xhBfs0KSn0sMM9Fc5tpQUKq5bqNcTYt22aKuuZd/M8cy3QxnOI=
X-Received: by 2002:a05:6512:781:: with SMTP id x1mr15957626lfr.231.1632602754678;
 Sat, 25 Sep 2021 13:45:54 -0700 (PDT)
MIME-Version: 1.0
From:   Hans-Jacob Enemark <hjenemark@gmail.com>
Date:   Sat, 25 Sep 2021 22:45:43 +0200
Message-ID: <CAFx0Op3b7KeAT0_Dd_eAMKh85=6qY_X6-BHGJdS2TN8UtJMytg@mail.gmail.com>
Subject: pthread_setschedparam returns 1 (Operation Not Permitted) after
 including docker in yocto build
To:     cgroups@vger.kernel.org
Cc:     Hans-Jacob Enemark <hjenemark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi
In a yocto build for a multicore system, pulling in docker through the
meta-virtualization layer from open-embedded, a multi-threaded app
suddenly starts failing.
For some reason it is no longer possible to set the priority and the
scheduling policy of a running pthread inside the thread function
itself - even with the app running as root..
The kernel configuration changed with the addition of the
meta-virtualization layer.
I hope to get docker running on the build to be able to build on that.
So I hope you can help as this is beyond me
Best regards
Hans-Jacob S. Enemark

Appendices:
1) The minimal code that fails on the yocto build with docker but runs
fine on the old build without the docker modifications.
2) Kernel config diffs. Left has docker included. Right is the one
without. Several cgroup configs has been enabled and the reason why I
post to this mailing list.
3) A small snippet of the strace output that shows the issue I am facing.


1) ---------------------------------------------------------
#include <stdio.h>
#include <pthread.h>
#include <string.h>
#include <sys/resource.h>

#define POLICY SCHED_FIFO
static void *thread_routine(void *arg)
{
  int ret;
  struct sched_param param;
  param.sched_priority = sched_get_priority_max(POLICY) - 2;

  ret = pthread_setschedparam(pthread_self(), POLICY, &param);

  printf("%s: pthread_setschedparam result: [%d] %s\n", __func__, ret,
strerror(ret));

  return NULL;
}

int main(int argc, char* argv[])
{
  pthread_t threadId;

  printf("Starting main\n");
  if(pthread_create(&threadId, NULL, thread_routine, NULL)){
    printf("%s: Thread creation failed\n", __func__);
  }
  pthread_join(threadId, NULL);
  printf("Done with main\n");
  return 0;
}

2) ---------------------------------------------------------
140,143c140
< CONFIG_PAGE_COUNTER=y
< CONFIG_MEMCG=y
< CONFIG_MEMCG_SWAP=y
< CONFIG_MEMCG_SWAP_ENABLED=y
---
> # CONFIG_MEMCG is not set
149c146
< CONFIG_CGROUP_PIDS=y
---
> # CONFIG_CGROUP_PIDS is not set
153c150
< CONFIG_CGROUP_DEVICE=y
---
> # CONFIG_CGROUP_DEVICE is not set
155c152
< CONFIG_CGROUP_PERF=y
---
> # CONFIG_CGROUP_PERF is not set
157c154
< CONFIG_SOCK_CGROUP_DATA=y
---
> # CONFIG_SOCK_CGROUP_DATA is not set
163c160
< CONFIG_USER_NS=y
---
> # CONFIG_USER_NS is not set
227d223
< # CONFIG_SLUB_MEMCG_SYSFS_ON is not set
791c787
< CONFIG_BRIDGE_NETFILTER=y
---
> CONFIG_BRIDGE_NETFILTER=m
877c873
< CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
---
> # CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
898d893
< CONFIG_NETFILTER_XT_MATCH_IPVS=y
923,962c918
< CONFIG_IP_VS=y
< # CONFIG_IP_VS_IPV6 is not set
< # CONFIG_IP_VS_DEBUG is not set
< CONFIG_IP_VS_TAB_BITS=12
<
< #
< # IPVS transport protocol load balancing support
< #
< # CONFIG_IP_VS_PROTO_TCP is not set
< # CONFIG_IP_VS_PROTO_UDP is not set
< # CONFIG_IP_VS_PROTO_AH_ESP is not set
< # CONFIG_IP_VS_PROTO_ESP is not set
< # CONFIG_IP_VS_PROTO_AH is not set
< # CONFIG_IP_VS_PROTO_SCTP is not set
<
< #
< # IPVS scheduler
< #
< # CONFIG_IP_VS_RR is not set
< # CONFIG_IP_VS_WRR is not set
< # CONFIG_IP_VS_LC is not set
< # CONFIG_IP_VS_WLC is not set
< # CONFIG_IP_VS_FO is not set
< # CONFIG_IP_VS_OVF is not set
< # CONFIG_IP_VS_LBLC is not set
< # CONFIG_IP_VS_LBLCR is not set
< # CONFIG_IP_VS_DH is not set
< # CONFIG_IP_VS_SH is not set
< # CONFIG_IP_VS_SED is not set
< # CONFIG_IP_VS_NQ is not set
<
< #
< # IPVS SH scheduler
< #
< CONFIG_IP_VS_SH_TAB_BITS=8
<
< #
< # IPVS application helper
< #
< # CONFIG_IP_VS_NFCT is not set
---
> # CONFIG_IP_VS is not set
1115c1071
< CONFIG_NET_CLS_CGROUP=y
---
> # CONFIG_NET_CLS_CGROUP is not set
1164,1165c1120,1121
< CONFIG_CGROUP_NET_PRIO=y
< CONFIG_CGROUP_NET_CLASSID=y
---
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
1632c1588
< CONFIG_VETH=y
---
> # CONFIG_VETH is not set
4347,4352c4303
< CONFIG_BTRFS_FS=y
< CONFIG_BTRFS_FS_POSIX_ACL=y
< # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
< # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
< # CONFIG_BTRFS_DEBUG is not set
< # CONFIG_BTRFS_ASSERT is not set
---
> # CONFIG_BTRFS_FS is not set
4376,4378c4327
< CONFIG_OVERLAY_FS=y
< # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
< # CONFIG_OVERLAY_FS_INDEX is not set
---
> # CONFIG_OVERLAY_FS is not set
4776d4724
< CONFIG_XOR_BLOCKS=y

4944d4891
< CONFIG_RAID6_PQ=y
4968d4914
< CONFIG_XXHASH=y
4977,4978d4922
< CONFIG_ZSTD_COMPRESS=y
< CONFIG_ZSTD_DECOMPRESS=y

3) ---------------------------------------------------------
write(1, "Starting main\n", 14)         = 14
mmap2(NULL, 8392704, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK,
-1, 0) = 0xb65cb000
mprotect(0xb65cc000, 8388608, PROT_READ|PROT_WRITE) = 0
clone(child_stack=0xb6dcaf98,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID,
parent_tidptr=0xb6dcb4c8, tls=0xb6dcb920, child_tidptr=0xb6dcb4c8) =
2779
futex(0xb6dcb4c8, FUTEX_WAIT, 2779, NULL) = -1 EAGAIN (Resource
temporarily unavailable)
write(1, "Done with main\n", 15)        = 15
