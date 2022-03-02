Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBE4C9DE0
	for <lists+cgroups@lfdr.de>; Wed,  2 Mar 2022 07:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiCBGjg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Mar 2022 01:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiCBGjg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Mar 2022 01:39:36 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFD13E3A
        for <cgroups@vger.kernel.org>; Tue,  1 Mar 2022 22:38:54 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 195so830301pgc.6
        for <cgroups@vger.kernel.org>; Tue, 01 Mar 2022 22:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K4RKtZ4EM/v8P4fEu3jSYrerGRfgI+G2IZ0OObJQr4k=;
        b=j1HfZ85jE8z4taKaq8Wr1YttYtwHmHsIKldoldrrQSTsgqOxVM4cs32oAUlhIT4+qK
         j4TLqlA3XWATSrnLL3yV2FkNzyCj7dDJuMOHZBykJT6qR7X88qL8TjI2oaYzo+M+cAbt
         tfs+DYMPDwHpM4ZZY/5rNTTvyr1sFdFs+z5vXsYSq08M7KjCT+OdfKPvMVQmcXHOcQNW
         zMl2yWg+QNS5K8uEP/ZG357TZMisvH+aA3ZU6l7gX/VRKI0H+yVrsYUjorF5TOAQu3GE
         kg3MhOIDOGPciobnNiaLlYzM4tT45kpkdwdZEBi/jt3MDPUoFqFmw/Y8BFUnAv5ikHno
         Ln8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K4RKtZ4EM/v8P4fEu3jSYrerGRfgI+G2IZ0OObJQr4k=;
        b=snyIioFSE76xsSan0Rv/KTxrSLN4iYhDYV6PpgqNCHsZRAhuqbQufalzfBgyVIyzKB
         Xwfa4PhHsEGl5AuA+Y9pjb5S1V6ZKqHuPPnG2GE4EHmtaVatwtvqLcdadlKISy0r8SBs
         o7QeJkMY8pADSlyYqoInKuPmdNTj5K0Tmt6ZokYrf3+7QNdFpfnShfsir/74/ex/Nj/3
         yKE4CYrJeSWYWtzX+lEdLRrNAUZLG/EZWhfruOE2Zq0a3vMGGiqivYqHSfF1MukpD/Un
         e8xZBkh3Lsr1/HFjyY5F5vB3PVhyR4F3kXTreQq04MN6Px5SMKIAZ04lQjQC/kCSpNHN
         +DAw==
X-Gm-Message-State: AOAM532QXYgjXi7O0rEfodrLmMMSnVmlFP+N45iXoeDmmQOYyvYVNgvu
        Qs1takd44ceXdvaAz0eqSAion68j2ag=
X-Google-Smtp-Source: ABdhPJytz+Ys8ZC903CaYKhGua+qCS/DAZYdF6uMHs4RsPDwD+SppfvEKqZUC4/0HUyiryizTgn++w==
X-Received: by 2002:aa7:9f5b:0:b0:4cc:964c:99dd with SMTP id h27-20020aa79f5b000000b004cc964c99ddmr31620007pfr.42.1646203133248;
        Tue, 01 Mar 2022 22:38:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a450900b001b9b5ca299esm3886296pjg.54.2022.03.01.22.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 22:38:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 1 Mar 2022 20:38:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] cgroup: Use irqsave in cgroup_rstat_flush_locked().
Message-ID: <Yh8Q+wjgk6dkDphR@slm.duckdns.org>
References: <[PATCH0/2]CorrectlockingassumptiononPREEMPT_RT>
 <20220301122143.1521823-1-bigeasy@linutronix.de>
 <20220301122143.1521823-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301122143.1521823-2-bigeasy@linutronix.de>
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

On Tue, Mar 01, 2022 at 01:21:42PM +0100, Sebastian Andrzej Siewior wrote:
> All callers of cgroup_rstat_flush_locked() acquire cgroup_rstat_lock
> either with spin_lock_irq() or spin_lock_irqsave().
> cgroup_rstat_flush_locked() itself acquires cgroup_rstat_cpu_lock which
> is a raw_spin_lock. This lock is also acquired in cgroup_rstat_updated()
> in IRQ context and therefore requires _irqsave() locking suffix in
> cgroup_rstat_flush_locked().
> Since there is no difference between spin_lock_t and raw_spin_lock_t
> on !RT lockdep does not complain here. On RT lockdep complains because
> the interrupts were not disabled here and a deadlock is possible.
> 
> Acquire the raw_spin_lock_t with disabled interrupts.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Can you please add a comment explaining why irqsave is being used? As it
stands, it just looks spurious.

Thanks.

-- 
tejun
