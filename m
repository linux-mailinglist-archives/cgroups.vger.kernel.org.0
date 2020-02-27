Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1417263C
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 19:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgB0SOe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 13:14:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34884 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB0SOe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 13:14:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id 145so307605qkl.2
        for <cgroups@vger.kernel.org>; Thu, 27 Feb 2020 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=19sQdZH67v9yOy/BduEXSg0i7G3USqaAUKmseX8opy0=;
        b=0IG8plhA6YTGx0j6rHUrt9WyouEz5FGMjybnDuDbUR7axVZhu+rgZlDa76gtdh8YwP
         /BhvP4PrfAUfKbf4wWhSFJOqBrI7JQ+9WpS63f7uxvjPet4NPXoB3dmwuNdmFwjnk4FX
         1jVKXf8c2T1gFBZuOnwIqt51u2dUPq1cgjvR7zFm0WU9lL6ANWW6XIFJIHX6vK0OhLS1
         J7DzHM0N4FEAk+lKkdDVdPBUOvPR0KzwO8QnjgEOy/J9Ojgvd04vxXAf02MIPcEGOpxb
         EivvMkXIRJkPfKGgDKl8kcG3bTQe25P1HIgY1nQs6rbBZBfIFa/9YWSNslzmqZbSVSLN
         u4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=19sQdZH67v9yOy/BduEXSg0i7G3USqaAUKmseX8opy0=;
        b=XONaz3VqJov2hgjIfkhVXcaPnirrMbjkGOywVBUfMII7038JQnJ+4uQjSfzWuheDnB
         YB+WZu5gkrcGjb17L2v406Dk2Og3YyArYxqhkAgVKBuRL566Akw+cAB0V5lZJajq9kLV
         lixfUyN+/fc3v0IxlC1P5TYKAZROAQxoqysBlLQKJu7B8O8XvM2e52DGo/cqSmlU1mFz
         awcl9rQW6YRQpgw9I05hpcRWrKsrL1IPyFupYwkUUvM6rjDClk1kMhJJqhUoqqrBZA2U
         Cd0DV3FAVxwVc2UJAUZypEooaMxnWBNz42oxyOcHT2VygYZ2mRBVAc0seMpW3ffwpRAc
         UXZw==
X-Gm-Message-State: APjAAAUUNFzG4LBsj7zGYlHlAdecjtqbu+j+IyDp5d4Ktr08QybpZSFV
        pX8LMYZ0SISFFkZ7uK/bjFH+gw==
X-Google-Smtp-Source: APXvYqxPB39ZR+bN2cQMJ9T9w19fRsXPKASGuDOQPUNqv4PuzrnPanLLIWa7wqqTeAv5s2x/5ZezIQ==
X-Received: by 2002:a05:620a:10ac:: with SMTP id h12mr512814qkk.487.1582827272500;
        Thu, 27 Feb 2020 10:14:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:2450])
        by smtp.gmail.com with ESMTPSA id t29sm3712868qtt.20.2020.02.27.10.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:14:31 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:14:30 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/3] loop: Use worker per cgroup instead of kworker
Message-ID: <20200227181430.GA44024@cmpxchg.org>
References: <cover.1582581887.git.schatzberg.dan@gmail.com>
 <eab018412a0c9feb573d757b1bbd5f58b33e2a8d.1582581887.git.schatzberg.dan@gmail.com>
 <1582736558.7365.131.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582736558.7365.131.camel@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 26, 2020 at 12:02:38PM -0500, Qian Cai wrote:
> On Mon, 2020-02-24 at 17:17 -0500, Dan Schatzberg wrote:
> > Existing uses of loop device may have multiple cgroups reading/writing
> > to the same device. Simply charging resources for I/O to the backing
> > file could result in priority inversion where one cgroup gets
> > synchronously blocked, holding up all other I/O to the loop device.
> > 
> > In order to avoid this priority inversion, we use a single workqueue
> > where each work item is a "struct loop_worker" which contains a queue of
> > struct loop_cmds to issue. The loop device maintains a tree mapping blk
> > css_id -> loop_worker. This allows each cgroup to independently make
> > forward progress issuing I/O to the backing file.
> > 
> > There is also a single queue for I/O associated with the rootcg which
> > can be used in cases of extreme memory shortage where we cannot allocate
> > a loop_worker.
> > 
> > The locking for the tree and queues is fairly heavy handed - we acquire
> > the per-loop-device spinlock any time either is accessed. The existing
> > implementation serializes all I/O through a single thread anyways, so I
> > don't believe this is any worse.
> > 
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> The locking in loop_free_idle_workers() will trigger this with sysfs reading,
> 
> [ 7080.047167] LTP: starting read_all_sys (read_all -d /sys -q -r 10)
> [ 7239.842276] cpufreq transition table exceeds PAGE_SIZE. Disabling
> 
> [ 7247.054961] =====================================================
> [ 7247.054971] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> [ 7247.054983] 5.6.0-rc3-next-20200226 #2 Tainted: G           O     
> [ 7247.054992] -----------------------------------------------------
> [ 7247.055002] read_all/8513 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> [ 7247.055014] c0000006844864c8 (&fs->seq){+.+.}, at: file_path+0x24/0x40
> [ 7247.055041] 
>                and this task is already holding:
> [ 7247.055061] c0002006bab8b928 (&(&lo->lo_lock)->rlock){..-.}, at:
> loop_attr_do_show_backing_file+0x3c/0x120 [loop]
> [ 7247.055078] which would create a new lock dependency:
> [ 7247.055105]  (&(&lo->lo_lock)->rlock){..-.} -> (&fs->seq){+.+.}
> [ 7247.055125] 
>                but this new dependency connects a SOFTIRQ-irq-safe lock:
> [ 7247.055155]  (&(&lo->lo_lock)->rlock){..-.}
> [ 7247.055156] 
>                ... which became SOFTIRQ-irq-safe at:
> [ 7247.055196]   lock_acquire+0x130/0x360
> [ 7247.055221]   _raw_spin_lock_irq+0x68/0x90
> [ 7247.055230]   loop_free_idle_workers+0x44/0x3f0 [loop]
> [ 7247.055242]   call_timer_fn+0x110/0x5f0
> [ 7247.055260]   run_timer_softirq+0x8f8/0x9f0
> [ 7247.055278]   __do_softirq+0x34c/0x8c8
> [ 7247.055288]   irq_exit+0x16c/0x1d0
> [ 7247.055298]   timer_interrupt+0x1f0/0x680
> [ 7247.055308]   decrementer_common+0x124/0x130
> [ 7247.055328]   arch_local_irq_restore.part.8+0x34/0x90
> [ 7247.055352]   cpuidle_enter_state+0x11c/0x8f0
> [ 7247.055361]   cpuidle_enter+0x50/0x70
> [ 7247.055389]   call_cpuidle+0x4c/0x90
> [ 7247.055398]   do_idle+0x378/0x470
> [ 7247.055414]   cpu_startup_entry+0x3c/0x40
> [ 7247.055442]   start_secondary+0x7a8/0xa80
> [ 7247.055461]   start_secondary_prolog+0x10/0x14

That's kind of hilarious.

So even though it's a spin_lock_irq(), suggesting it's used from both
process and irq context, Dan appears to be adding the first user that
actually runs from irq context. It looks like it should have been a
regular spinlock all along. Until now, anyway.

Fixing it should be straight-forward. Use get_file() under lock to pin
the file, drop the lock to do file_path(), release file with fput().
