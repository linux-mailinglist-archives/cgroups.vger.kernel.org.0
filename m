Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948234C02EA
	for <lists+cgroups@lfdr.de>; Tue, 22 Feb 2022 21:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiBVUQG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 15:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiBVUQF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 15:16:05 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4DE111DC7
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 12:15:37 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id y5so13203781pfe.4
        for <cgroups@vger.kernel.org>; Tue, 22 Feb 2022 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fHZn57YiuoTnK0EKZvz7HI7Nd0DP8QYFjsQdFzVXMFs=;
        b=PzeW3vcRswi8fsIW41W0CmUWmlC/VGhxSu3tDNJ+9/vWm8vh9IH+t0SDbpFlxuTcvX
         MdSs5Mik5i0lL6Ms/Pmf7NHgbVg6SA/6k87JlKRKbOohpl6Luzp+6N9TpmmOvo2FsN7x
         /aj03E0KxG3ITYQo1nxeqP6g4EliLEDQSlZEMGDvfExe+uCvxV/bpWAR3wnf4skSVBLB
         lfjbonMPB+wHXN9i7l/n+biQTSaPfFZTggxHHlq1KyGzKl7eqqdmPJAhUCOc1MxikDnx
         CEGoxCU5Lf6JsOf1dVrypRCejqAoNpWbLcl2q5Bz7eJW7EYbXDaZQyxmgCvNMkIi8hOg
         mHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fHZn57YiuoTnK0EKZvz7HI7Nd0DP8QYFjsQdFzVXMFs=;
        b=Yqc5/qVzbVyGoOPN68YKfdmQ9j6Jk8eQSugGci2/0fY9PcM24UqCTWvn1W76zEDWnJ
         36b/bjDDEHmkZKFk0ItTEo0+csq+f5LkSUESz8JBBJnj0yBGAXyHVn23wpV13OcUdq9+
         yi7LDFa4NgpnN4ujcCEGH+79yAbVOklXfAd8ry4Co1s1uYKvlZqPTYpTSRmSMDdCVHeJ
         sNgwiadA9z7wfYLRctc32grCQiLDo78V+J/v+pZbJtY/6scHjwi5qA5Ek/+Is8GPDknf
         cKGEVghaE7sNZYZCYwzVEA/a23iyXRZKzRyWbd2zqflakTQ2xhIksMdZ/RxjyLg/pG40
         9cHA==
X-Gm-Message-State: AOAM5300by0JVk7RkAD6FeLD++KkmHLcgeR5e1uUtT9lzswU51AzSid4
        MXWdf57DRW4DidD0ZG5zMio=
X-Google-Smtp-Source: ABdhPJxgiGeGSGuKkMo4JxhMaz3h+PTdaOE3NaMTo54gynrqapmj+A9++PN7fM454gYNdxAh2LwpFg==
X-Received: by 2002:a05:6a00:807:b0:4f1:1458:87e5 with SMTP id m7-20020a056a00080700b004f1145887e5mr14898891pfk.73.1645560937165;
        Tue, 22 Feb 2022 12:15:37 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c68sm21713915pga.1.2022.02.22.12.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:15:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Feb 2022 10:15:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: kernel BUG at lib/list_debug.c:54! RIP:
 0010:__list_del_entry_valid.cold+0x1d/0x47
Message-ID: <YhVEZq/XMR0kUS+7@slm.duckdns.org>
References: <CAJCQCtRjgrjWYwA1M99NMLdy-Y=nvQvrrps8A0hG5wX+qf94vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRjgrjWYwA1M99NMLdy-Y=nvQvrrps8A0hG5wX+qf94vg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, Feb 09, 2022 at 10:23:18AM -0700, Chris Murphy wrote:
> I hit this bug out of the blue (haven't seen it before) with 5.16.5,
> the activity at the time was logging out of GNOME shell, and dropping
> to a tty, and then got a hard lockup. And cgwb_release_workfn brought
> me here, let me know if it should go elsewhere.
> 
> [35824.733029] kernel: list_del corruption. next->prev should be
> ffff93e01fa2f550, but was 0000000000000000
> [35824.733085] kernel: ------------[ cut here ]------------
> [35824.733104] kernel: kernel BUG at lib/list_debug.c:54!
> [35824.733127] kernel: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [35824.733149] kernel: CPU: 1 PID: 27905 Comm: kworker/1:2 Not tainted
> 5.16.5-200.fc35.x86_64 #1
> [35824.733179] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
> BIOS N2HET66W (1.49 ) 11/10/2021
> [35824.733208] kernel: Workqueue: cgwb_release cgwb_release_workfn
> [35824.733234] kernel: RIP: 0010:__list_del_entry_valid.cold+0x1d/0x47
> [35824.733260] kernel: Code: c7 c7 38 a8 64 91 e8 47 d8 fd ff 0f 0b 48
> 89 fe 48 c7 c7 c8 a8 64 91 e8 36 d8 fd ff 0f 0b 48 c7 c7 78 a9 64 91
> e8 28 d8 fd ff <0f> 0b 48 89 f2 48 89 fe 48 c7 c7 38 a9 64 91 e8 14 d8
> fd ff 0f 0b
> [35824.733322] kernel: RSP: 0018:ffffa710470ffe40 EFLAGS: 00010082
> [35824.733343] kernel: RAX: 0000000000000054 RBX: ffff93e01fa2f540
> RCX: 0000000000000000
> [35824.733370] kernel: RDX: 0000000000000002 RSI: ffffffff91634c5d
> RDI: 00000000ffffffff
> [35824.733396] kernel: RBP: 0000000000000202 R08: 0000000000000000
> R09: ffffa710470ffc88
> [35824.733423] kernel: R10: ffffa710470ffc80 R11: ffffffff91f462a8
> R12: 00000000ffffffff
> [35824.733449] kernel: R13: ffff93e0092f1000 R14: ffff93e01fa2f400
> R15: ffff93e36e879b05
> [35824.733475] kernel: FS:  0000000000000000(0000)
> GS:ffff93e36e840000(0000) knlGS:0000000000000000
> [35824.733505] kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [35824.733527] kernel: CR2: 00007fcbd0ef9e40 CR3: 0000000057e10001
> CR4: 00000000003726e0
> [35824.733553] kernel: Call Trace:
> [35824.733566] kernel:  <TASK>
> [35824.733577] kernel:  percpu_counter_destroy+0x24/0x80
> [35824.733599] kernel:  cgwb_release_workfn+0xf9/0x210
> [35824.733619] kernel:  process_one_work+0x1e5/0x3c0
> [35824.733639] kernel:  worker_thread+0x50/0x3b0
> [35824.733656] kernel:  ? rescuer_thread+0x350/0x350
> [35824.733674] kernel:  kthread+0x169/0x190
> [35824.733704] kernel:  ? set_kthread_struct+0x40/0x40
> [35824.733725] kernel:  ret_from_fork+0x1f/0x30
> [35824.733747] kernel:  </TASK>

It's difficult to tell with the available information. I'd be surprised if
it's a bug in the cgwb release path itself given that all the prior steps in
the release path ran fine - e.g. if it were a double free, it should have
triggered earlier. One possibility is something is overwriting the linked
pointer through use-after-free or whatever. The best way forward would be
finding a way to reproduce the problem.

Thanks.

-- 
tejun
