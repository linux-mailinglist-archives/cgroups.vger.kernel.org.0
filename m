Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137625974D9
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiHQROc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 13:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbiHQROS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 13:14:18 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6599F18C
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 10:13:58 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h27so6407318qkk.9
        for <cgroups@vger.kernel.org>; Wed, 17 Aug 2022 10:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=aN3vJ2rM0Hc11j+m8iw80ADUWQ38gpksEtAyFV9ecwc=;
        b=Cv+aYyMKycJyWptvlaesV64u0spW8xgqi87m6gWliE2zm+TlFIJRBz4eef1VJh4su5
         2xKgis8HA+lsKsAeI2kU2YR+KP3VaxwEcex4Mxcof6JmcmUuRjEniNMV0zATu+OOBW7L
         mvu2T7fDSz/AUAM43nuCqWYUchFzewT5cUgdhGCVmQYV/uXi8/3iF5UrC9ASGtCUy2c6
         Ik1JekdH7bUFcNdRE38RgVYtwzuEs6pd65rCt5yn9ZZObw1t1+hJdchdKR1bD6AfraT+
         R9t9ejemuhDNp3LEgtKtikAGixilncS/OhUs2PEOFTHC4niIjw4yqoUBrEucXy/4eAYK
         Kl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=aN3vJ2rM0Hc11j+m8iw80ADUWQ38gpksEtAyFV9ecwc=;
        b=BvJ+aJL+FE1VLWPD6a1A6dRG8ZZKIrN1JTurKmOKHp4XOniHMY+FtDx0C6iLqUYJNs
         /HgIMnmDwAPNy75OEJGKLNUNflUqGPE0lQG2fNADijcugy9uB4J5dq8rk0cYaYZX6Srd
         88yBah//49kkdM0LLyVSPtBIVVDaz7ijc7gYX7j9zYu1NPPUq7KCvyodxYbD1DQxTFaL
         53Zkldlv7B8CLW1IBkjHD4w/WUEIiu8rnZwjimt3p7+ckN2gFqvaGB9oJ4uuL/Cc+EaM
         7d0NHwO5yz7kvCSlC6xQkjSBPMXtTLnNV2IGKbu8n8pfxxw2Lyfq9lip7J6ufoVAidaS
         Ce1Q==
X-Gm-Message-State: ACgBeo0csRa2e7ooYOMvAyWo/Ih1W/wTwToqhaoEnekEyMDxbnjN8qAU
        4LSHQI8X/wDyBLYs6mIBB0Wj6Q==
X-Google-Smtp-Source: AA6agR5uymcSZsYdlIY7eiAbG0a6+f9+a1QeHjqeo8s6Oz95BxxN/uSL0IXX1JzDHxabpZhGjvPTpg==
X-Received: by 2002:a05:620a:28c1:b0:6bb:5deb:a888 with SMTP id l1-20020a05620a28c100b006bb5deba888mr7109059qkp.485.1660756437198;
        Wed, 17 Aug 2022 10:13:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::39e8])
        by smtp.gmail.com with ESMTPSA id y6-20020ae9f406000000b006aee5df383csm3679070qkl.134.2022.08.17.10.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:13:56 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:13:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>
Cc:     Wei Wang <weiwan@google.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: UDP rx packet loss in a cgroup with a memory limit
Message-ID: <Yv0h1PFxmK7rVWpy@cmpxchg.org>
References: <CANOLnON11vzvVdyJfW+QJ36siWR4-s=HJ2aRKpRy7CP=aRPoSw@mail.gmail.com>
 <CANOLnOPeOi0gxYwd5+ybdv5w=RZEh5JakJPE9xgrSL1cecZHbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANOLnOPeOi0gxYwd5+ybdv5w=RZEh5JakJPE9xgrSL1cecZHbw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 17, 2022 at 07:50:13PM +0300, Gražvydas Ignotas wrote:
> On Tue, Aug 16, 2022 at 9:52 PM Gražvydas Ignotas <notasas@gmail.com> wrote:
> > Basically, when there is git activity in the container with a memory
> > limit, other processes in the same container start to suffer (very)
> > occasional network issues (mostly DNS lookup failures).
> 
> ok I've traced this and it's failing in try_charge_memcg(), which
> doesn't seem to be trying too hard because it's called from irq
> context.
> 
> Here is the backtrace:
>  <IRQ>
>  ? fib_validate_source+0xb4/0x100
>  ? ip_route_input_slow+0xa11/0xb70
>  mem_cgroup_charge_skmem+0x4b/0xf0
>  __sk_mem_raise_allocated+0x17f/0x3e0
>  __udp_enqueue_schedule_skb+0x220/0x270
>  udp_queue_rcv_one_skb+0x330/0x5e0
>  udp_unicast_rcv_skb+0x75/0x90
>  __udp4_lib_rcv+0x1ba/0xca0
>  ? ip_rcv_finish_core.constprop.0+0x63/0x490
>  ip_protocol_deliver_rcu+0xd6/0x230
>  ip_local_deliver_finish+0x73/0xa0
>  __netif_receive_skb_one_core+0x8b/0xa0
>  process_backlog+0x8e/0x120
>  __napi_poll+0x2c/0x160
>  net_rx_action+0x2a2/0x360
>  ? rebalance_domains+0xeb/0x3b0
>  __do_softirq+0xeb/0x2eb
>  __irq_exit_rcu+0xb9/0x110
>  sysvec_apic_timer_interrupt+0xa2/0xd0
>  </IRQ>
> 
> Calling mem_cgroup_print_oom_meminfo() in such a case reveals:
> 
> memory: usage 7812476kB, limit 7812500kB, failcnt 775198
> swap: usage 0kB, limit 0kB, failcnt 0
> Memory cgroup stats for
> /kubepods.slice/kubepods-burstable.slice/kubepods-burstable-podb8f4f0e9_fb95_4f2d_8443_e6a78f235c9a.slice/docker-9e7cad93b2e0774d49148474989b41fe6d67a5985d059d08d9d64495f1539a81.scope:
> anon 348016640
> file 7502163968
> kernel 146997248
> kernel_stack 327680
> pagetables 2224128
> percpu 0
> sock 4096
> vmalloc 0
> shmem 0
> zswap 0
> zswapped 0
> file_mapped 112041984
> file_dirty 1181028352
> file_writeback 2686976
> swapcached 0
> anon_thp 44040192
> file_thp 0
> shmem_thp 0
> inactive_anon 350756864
> active_anon 36864
> inactive_file 3614003200
> active_file 3888070656
> unevictable 0
> slab_reclaimable 143692600
> slab_unreclaimable 545120
> slab 144237720
> workingset_refault_anon 0
> workingset_refault_file 2318
> workingset_activate_anon 0
> workingset_activate_file 2318
> workingset_restore_anon 0
> workingset_restore_file 0
> workingset_nodereclaim 0
> pgfault 334152
> pgmajfault 1238
> pgrefill 3400
> pgscan 819608
> pgsteal 791005
> pgactivate 949122
> pgdeactivate 1694
> pglazyfree 0
> pglazyfreed 0
> zswpin 0
> zswpout 0
> thp_fault_alloc 709
> thp_collapse_alloc 0
> 
> So it basically renders UDP inoperable because of disk cache. I hope
> this is not the intended behavior. Naturally booting with
> cgroup.memory=nosocket solves this issue.

This is most likely a regression caused by this patch:

commit 4b1327be9fe57443295ae86fe0fcf24a18469e9f
Author: Wei Wang <weiwan@google.com>
Date:   Tue Aug 17 12:40:03 2021 -0700

    net-memcg: pass in gfp_t mask to mem_cgroup_charge_skmem()
    
    Add gfp_t mask as an input parameter to mem_cgroup_charge_skmem(),
    to give more control to the networking stack and enable it to change
    memcg charging behavior. In the future, the networking stack may decide
    to avoid oom-kills when fallbacks are more appropriate.
    
    One behavior change in mem_cgroup_charge_skmem() by this patch is to
    avoid force charging by default and let the caller decide when and if
    force charging is needed through the presence or absence of
    __GFP_NOFAIL.
    
    Signed-off-by: Wei Wang <weiwan@google.com>
    Reviewed-by: Shakeel Butt <shakeelb@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

We never used to fail these allocations. Cgroups don't have a
kswapd-style watermark reclaimer, so the network relied on
force-charging and leaving reclaim to allocations that can block.
Now it seems network packets could just fail indefinitely.

The changelog is a bit terse given how drastic the behavior change
is. Wei, Shakeel, can you fill in why this was changed? Can we revert
this for the time being?
