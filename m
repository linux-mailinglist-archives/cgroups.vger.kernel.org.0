Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844D673AF14
	for <lists+cgroups@lfdr.de>; Fri, 23 Jun 2023 05:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjFWD3R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Jun 2023 23:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjFWD3O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Jun 2023 23:29:14 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE802680;
        Thu, 22 Jun 2023 20:29:12 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-77b00bb3fd6so32314239f.1;
        Thu, 22 Jun 2023 20:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687490952; x=1690082952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oykh8upio4KWx42BN7+F1eKW1AfSHCbplOupgu5pOVQ=;
        b=fePx1OJnZi4IrLpHfykS+J6zcosxE2iBfuWtNP/lUUGaH9DCTDuR7gYdOxbqG8+RGJ
         LNNIIY7W7l1LTINZoc4nZLQY9MvJtHnMQdDV/B5guPSJQV1JoKGYRPc9rgMrca/LDonz
         hz5ynrXgIp/9+uDwvtgABpMEPl0P6AEIrSTWu3VsPwAwld4SnmZmeL/PiarsBBl8puuA
         HTXLzPAGgrhJ38YEXKYoqp6Yl/zhH0lb+Z0Q5L4OwLbkQdAaQs/z1CO8OX8KIP7il/l0
         eI11o7u4VALza9t/pR8bwmxrHw0c0dleDjwyq0ZMyU3DPuc0OZ/EDg68Au6cgvaBxMMz
         zLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687490952; x=1690082952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oykh8upio4KWx42BN7+F1eKW1AfSHCbplOupgu5pOVQ=;
        b=i5tKE+YSSYndxn0Ble+sAj3mEb0eYyomYC9Iv0tyIkJyxRfxdCPHdviDw2HmvKYTIF
         pyR4um7zvhYNxVv20VN7u/BYldmrTwXSPkyb+oYigfleop8Sqx3V9kVL4EVDGOLK0Wse
         41HNFDkdRpodOd1rx3UcYB7eeHI8gHU6WT9+nj9FlfzOgXf7ux6lvDe4G8GLZpwIRUyR
         69ufKM6qYddO8X58Ftc1gHoOOxMoGhEtyfvpapfxnnGGYqT1QHsxUIiaFvg9L/jzxWgv
         60q27AFCtGAL5JXy4hqHtjT5maU08AKASi/NMOAhmC8g4ZvopRiHnUYf12/oXqmmy4Ml
         Qlbw==
X-Gm-Message-State: AC+VfDwRL58X9a7lSJaE77GTg9hB5QNCNq6sS+59Ur7qv4dAVh0Wlljr
        1y9/AfRxZt6loBgWs9PBw5OEkOPkAVrD7Sulbdk=
X-Google-Smtp-Source: ACHHUZ6JwRYwO1xkk92xQY+/hbQQwkVYJsGvU5g2JLQTVxCgBsMh5eljyDsC+nhJmlneBZnQcULBYiP5uGVM/lWxuPM=
X-Received: by 2002:a05:6602:2d16:b0:780:c765:6d6f with SMTP id
 c22-20020a0566022d1600b00780c7656d6fmr4087547iow.1.1687490951814; Thu, 22 Jun
 2023 20:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230620022120.27448-1-jefexiaomi@xiaomi.com> <ZJFLfRCZuPXN+p9I@dhcp22.suse.cz>
 <CAFtB3FY-0uyJchUtUPph-pUeQVRpddi-3xDSGzhJEhFqWck4XQ@mail.gmail.com> <ZJKnqJ7XTvvt8MYM@dhcp22.suse.cz>
In-Reply-To: <ZJKnqJ7XTvvt8MYM@dhcp22.suse.cz>
From:   junfei fang <jefexiaomi@gmail.com>
Date:   Fri, 23 Jun 2023 11:29:00 +0800
Message-ID: <CAFtB3FaQQoFv6ffcJ2h0dOQbUjsTyiNdDaCiHtXmfQqGZ-95EA@mail.gmail.com>
Subject: Re: kasan cgroup user-after-free in get_mem_cgroup_from_mm
To:     Michal Hocko <mhocko@suse.com>
Cc:     andrew.zhu@mediatek.com, colin.peng@mediatek.com,
        wangbiao3@xiaomi.com, yangjianlong@xiaomi.com,
        linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi

Thank you for the reminder.
This is a use-after-free issue with the cgroup module.

Detail:
[196171.685352][ T6071]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[196171.685411][ T6071] BUG: KASAN: use-after-free in
get_mem_cgroup_from_mm+0x90/0x2f4
[196171.685461][ T6071] Read of size 8 at addr ffffff809f2f7420 by
task elastic_postChe/6071
[196171.685486][ T6071]
[196171.685508][ T6071] CPU: 0 PID: 6071 Comm: elastic_postChe
Tainted: P S      WC OE     5.15.78-android13-8-g4e9374fdd4e9 #1
[196171.685536][ T6071] Hardware name: MT6985 (DT)
[196171.685558][ T6071] Call trace:
[196171.685575][ T6071]  dump_backtrace+0x0/0x41c
[196171.685604][ T6071]  show_stack+0x1c/0x2c
[196171.685628][ T6071]  dump_stack_lvl+0x68/0x84
[196171.685659][ T6071]  print_address_description+0x78/0x38c
[196171.685689][ T6071]  kasan_report+0x184/0x1e4
[196171.685715][ T6071]  __asan_report_load8_noabort+0x48/0x58
[196171.685743][ T6071]  get_mem_cgroup_from_mm+0x90/0x2f4
[196171.685770][ T6071]  __mem_cgroup_charge+0x28/0xd0
[196171.685794][ T6071]  __add_to_page_cache_locked+0x23c/0x7d8
[196171.685824][ T6071]  add_to_page_cache_lru+0x104/0x214
[196171.685851][ T6071]  page_cache_ra_unbounded+0x394/0x67c
[196171.685880][ T6071]  do_page_cache_ra+0xc4/0xe0
[196171.685906][ T6071]  do_sync_mmap_readahead+0x480/0x628
[196171.685931][ T6071]  filemap_fault+0x4a4/0x990
[196171.685955][ T6071]  f2fs_filemap_fault+0x84/0x264 [mifs]
[196171.686860][ T6071]  __do_fault+0x19c/0x334
[196171.686887][ T6071]  do_fault+0x108/0x70c
[196171.686911][ T6071]  handle_pte_fault+0x134/0x210
[196171.686936][ T6071]  __handle_mm_fault+0xac8/0xd04
[196171.686960][ T6071]  do_handle_mm_fault+0x2cc/0x5bc
[196171.686984][ T6071]  do_page_fault+0x890/0xae0
[196171.687012][ T6071]  do_translation_fault+0xb0/0xd8
[196171.687037][ T6071]  do_mem_abort+0x70/0x1d0
[196171.687063][ T6071]  el0_da+0x3c/0x74
[196171.687087][ T6071]  el0t_64_sync_handler+0xc4/0xec
[196171.687111][ T6071]  el0t_64_sync+0x1a8/0x1ac
[196171.687136][ T6071]
[196171.687152][ T6071] Allocated by task 1851:
[196171.687173][ T6071]  ____kasan_kmalloc+0xdc/0x118
[196171.687198][ T6071]  __kasan_kmalloc+0x14/0x24
[196171.687223][ T6071]  kmem_cache_alloc_trace+0x264/0x39c
[196171.687251][ T6071]  find_css_set+0x6bc/0x1368
[196171.687275][ T6071]  cgroup_migrate_prepare_dst+0xcc/0x674
[196171.687299][ T6071]  cgroup_attach_task+0x254/0x594
[196171.687322][ T6071]  __cgroup1_procs_write+0x268/0x4c8
[196171.687348][ T6071]  cgroup1_procs_write+0x18/0x28
[196171.687373][ T6071]  cgroup_file_write+0x208/0x448
[196171.687397][ T6071]  kernfs_fop_write_iter+0x210/0x310
[196171.687425][ T6071]  vfs_write+0x5e8/0x92c
[196171.687449][ T6071]  ksys_write+0x124/0x1e8
[196171.687472][ T6071]  __arm64_sys_write+0x7c/0x94
[196171.687495][ T6071]  invoke_syscall+0x80/0x270
[196171.687521][ T6071]  el0_svc_common+0x110/0x1e0
[196171.687546][ T6071]  do_el0_svc+0x50/0xe8
[196171.687570][ T6071]  el0_svc+0x24/0x58
[196171.687592][ T6071]  el0t_64_sync_handler+0x88/0xec
[196171.687615][ T6071]  el0t_64_sync+0x1a8/0x1ac
[196171.687637][ T6071]
[196171.687653][ T6071] Freed by task 5518:
[196171.687673][ T6071]  kasan_set_track+0x50/0x84
[196171.687696][ T6071]  kasan_set_free_info+0x2c/0x54
[196171.687721][ T6071]  ____kasan_slab_free+0x108/0x158
[196171.687746][ T6071]  __kasan_slab_free+0x1c/0x30
[196171.687769][ T6071]  slab_free_freelist_hook+0xe8/0x21c
[196171.687793][ T6071]  kfree+0xf4/0x2e0
[196171.687818][ T6071]  kvfree+0x34/0x48
[196171.687841][ T6071]  kfree_rcu_work+0x7e8/0xa6c
[196171.687869][ T6071]  process_one_work+0x564/0xc68
[196171.687895][ T6071]  worker_thread+0x7d4/0xe34
[196171.687920][ T6071]  kthread+0x324/0x454
[196171.687944][ T6071]  ret_from_fork+0x10/0x20
[196171.687967][ T6071]
[196171.687983][ T6071] Last potentially related work creation:
[196171.688001][ T6071]  kasan_save_stack+0x44/0x74
[196171.688025][ T6071]  __kasan_record_aux_stack+0xc8/0xf4
[196171.688050][ T6071]  kasan_record_aux_stack_noalloc+0x18/0x28
[196171.688075][ T6071]  kvfree_call_rcu+0xf4/0x4e0
[196171.688100][ T6071]  put_css_set_locked+0x39c/0x62c
[196171.688127][ T6071]  cgroup_migrate_finish+0x70/0x280
[196171.688149][ T6071]  cgroup_attach_task+0x2e0/0x594
[196171.688172][ T6071]  __cgroup1_procs_write+0x268/0x4c8
[196171.688197][ T6071]  cgroup1_procs_write+0x18/0x28
[196171.688222][ T6071]  cgroup_file_write+0x208/0x448
[196171.688245][ T6071]  kernfs_fop_write_iter+0x210/0x310
[196171.688270][ T6071]  vfs_write+0x5e8/0x92c
[196171.688294][ T6071]  ksys_write+0x124/0x1e8
[196171.688317][ T6071]  __arm64_sys_write+0x7c/0x94
[196171.688341][ T6071]  invoke_syscall+0x80/0x270
[196171.688366][ T6071]  el0_svc_common+0x110/0x1e0
[196171.688390][ T6071]  do_el0_svc+0x50/0xe8
[196171.688414][ T6071]  el0_svc+0x24/0x58
[196171.688437][ T6071]  el0t_64_sync_handler+0x88/0xec
[196171.688460][ T6071]  el0t_64_sync+0x1a8/0x1ac
[196171.688482][ T6071]
[196171.688497][ T6071] Second to last potentially related work creation:
[196171.688516][ T6071]  kasan_save_stack+0x44/0x74
[196171.688539][ T6071]  __kasan_record_aux_stack+0xc8/0xf4
[196171.688563][ T6071]  kasan_record_aux_stack_noalloc+0x18/0x28
[196171.688589][ T6071]  insert_work+0x5c/0x27c
[196171.688613][ T6071]  __queue_work+0x734/0xc18
[196171.688638][ T6071]  queue_work_on+0x70/0xb4
[196171.688662][ T6071]  cmdq_pkt_destroy+0x160/0x2b4 [mtk_cmdq_drv_ext]
[196171.688835][ T6071]  _ddp_cmdq_cb+0x4a2c/0x4ddc [mediatek_drm]
[196171.690177][ T6071]
mtk_drm_signal_fence_worker_kthread+0x244/0x310 [mediatek_drm]
[196171.691482][ T6071]  kthread+0x324/0x454
[196171.691510][ T6071]  ret_from_fork+0x10/0x20
[196171.691535][ T6071]
[196171.691552][ T6071] The buggy address belongs to the object at
ffffff809f2f7400
[196171.691552][ T6071]  which belongs to the cache kmalloc-512 of size 512
[196171.691575][ T6071] The buggy address is located 32 bytes inside of
[196171.691575][ T6071]  512-byte region [ffffff809f2f7400, ffffff809f2f760=
0)
[196171.691602][ T6071] The buggy address belongs to the page:
[196171.691622][ T6071] page:00000000223b07e4 refcount:1 mapcount:0
mapping:0000000000000000 index:0x0 pfn:0xdf2f0
[196171.691650][ T6071] head:00000000223b07e4 order:3
compound_mapcount:0 compound_pincount:0
[196171.691673][ T6071] flags: 0x4000000000010200(slab|head|zone=3D1)
[196171.691707][ T6071] raw: 4000000000010200 fffffffe03ee9c00
0000000200000002 ffffff8004802600
[196171.691733][ T6071] raw: 0000000000000000 0000000000200020
00000001ffffffff 0000000000000000
[196171.691751][ T6071] page dumped because: kasan: bad access detected
[196171.691770][ T6071]
[196171.691786][ T6071] Memory state around the buggy address:
[196171.691807][ T6071]  ffffff809f2f7300: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[196171.691827][ T6071]  ffffff809f2f7380: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[196171.691847][ T6071] >ffffff809f2f7400: fa fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[196171.691866][ T6071]                                ^
[196171.691887][ T6071]  ffffff809f2f7480: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[196171.691908][ T6071]  ffffff809f2f7500: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[196171.691948][ T6071]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

We have added ftrace for retesting and have made the following observations=
:
1. The issue occurs after the filemap operation.
2. We are currently using ftrace logs to determine the address of the
object where the UAF occurs. However, we have not yet found \
    any "put" operation on that object within the time frame recorded by ft=
race.
    Therefore, we are increasing the buffer size to continue retesting.

We will keep you updated on our progress.

Best regards,
fangjunfei@xiaomi.com

Michal Hocko <mhocko@suse.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=B8=89 15:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed 21-06-23 10:18:31, junfei fang wrote:
> > Thank you for your prompt response.
> >
> > We are using kernel-5.15 in our project and cannot change it.
>
> It will be hard to get a community support for such a kernel I am
> afraid. Especially when considering the kernel is heavily tainted
> > CPU: 0 PID: 6071 Comm: elastic_postChe Tainted: P S      WC OE
>
> by proprietary, out-of-tree modules, pre-existing warnings that might be
> related and TAINT_CPU_OUT_OF_SPEC doesn't add much confidence into setup
> either.
>
> > Do you have any suggestions on how to fix this issue?
>
> No, not really. From what I can see the report complains about cset
> associated with the process' mm. I do not recall any specific bug where
> css would be released prematurely. Maybe somebody else who is more
> familiar with the cgroup core would know better.
>
> Btw. you should be sending the full UAF report after you have CCed LKML.
> --
> Michal Hocko
> SUSE Labs
