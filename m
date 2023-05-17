Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003E706219
	for <lists+cgroups@lfdr.de>; Wed, 17 May 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjEQIBX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 May 2023 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQIBV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 May 2023 04:01:21 -0400
X-Greylist: delayed 518 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 01:01:14 PDT
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE43C0A
        for <cgroups@vger.kernel.org>; Wed, 17 May 2023 01:01:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684309952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyZ0cuqsL7jrvxzaZVQwwm8jIYz1ppUq/Jum/QlaPHY=;
        b=OqE8aN8JSmdgKToLUX971c7a3DiU0pJ/sWtW/fk/TdEd7ve3MsuPqQUmLvJYFdYZAWuF/L
        fY3RAA8bI8+JkKFtpGNXuWnggvdU95pfY1QJ/kI1njPSw/kCFj3CliY7MVbJz9tDqJudfU
        OnoMOIJFePDXRG526clf0FUO/xpivRE=
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup: fix missing cpus_read_{lock,unlock}() in
 cgroup_transfer_tasks()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230517074545.2045035-1-qi.zheng@linux.dev>
Date:   Wed, 17 May 2023 15:51:56 +0800
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Zhao Gongyi <zhaogongyi@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75E872A8-652F-40B0-80D0-378569E77775@linux.dev>
References: <20230517074545.2045035-1-qi.zheng@linux.dev>
To:     Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On May 17, 2023, at 15:45, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> The commit 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> =
cpus_read_lock()
> deadlock") fixed the deadlock between cgroup_threadgroup_rwsem and
> cpus_read_lock() by introducing cgroup_attach_{lock,unlock}() and =
removing
> cpus_read_{lock,unlock}() from cpuset_attach(). But =
cgroup_transfer_tasks()
> was missed and not handled, which will cause th following warning:
>=20
> WARNING: CPU: 0 PID: 589 at kernel/cpu.c:526 =
lockdep_assert_cpus_held+0x32/0x40
> CPU: 0 PID: 589 Comm: kworker/1:4 Not tainted 6.4.0-rc2-next-20230517 =
#50
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 =
04/01/2014
> Workqueue: events cpuset_hotplug_workfn
> RIP: 0010:lockdep_assert_cpus_held+0x32/0x40
> <...>
> Call Trace:
>  <TASK>
>  cpuset_attach+0x40/0x240
>  cgroup_migrate_execute+0x452/0x5e0
>  ? _raw_spin_unlock_irq+0x28/0x40
>  cgroup_transfer_tasks+0x1f3/0x360
>  ? find_held_lock+0x32/0x90
>  ? cpuset_hotplug_workfn+0xc81/0xed0
>  cpuset_hotplug_workfn+0xcb1/0xed0
>  ? process_one_work+0x248/0x5b0
>  process_one_work+0x2b9/0x5b0
>  worker_thread+0x56/0x3b0
>  ? process_one_work+0x5b0/0x5b0
>  kthread+0xf1/0x120
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>  </TASK>
>=20
> So just use the cgroup_attach_{lock,unlock}() helper to fix it.
>=20
> Fixes: 4f7e7236435c ("cgroup: Fix threadgroup_rwsem <-> =
cpus_read_lock() deadlock")
> Reported-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

