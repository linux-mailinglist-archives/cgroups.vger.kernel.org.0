Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5825AEEE6
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbiIFPdV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbiIFPdD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 11:33:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51759DB7A;
        Tue,  6 Sep 2022 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jx46skhkYJ7CRZ0Qm2k8P6SrP0P68ycbdV/aTLvLqRE=; b=NZnEwekYJDhfBID21ehPz4VPhB
        kMsNTUZWCVo3xCgP3gXXbsHeAgXYdPwC3KIgIiuG2fhaBrd7WB5A1WuY0xke7TV9h8WLtsUeWjpHm
        otfpdfYaVqF1HNcjENHzZocgs2UpVFKV/FfKAdbUpDbb83unT/KRxCQSrWdgBhxLWYdsn/zzTwMYF
        DEm7B5ZyJtS8c2mbEH0+EN6bin+ZFXeQEyOiniVwIEUtFLrrW2MXgZnO0N+uF3D+YKMnTj/1SOBbD
        BHA3AgC5E/QSycFaXcosebs6LqOfpq8PmRh6+B0ljbJe9OqCsNgjBU6PffHz/j7n2yyZtMlrn5m/p
        evQDbwXw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVZnD-00ABOr-Fl; Tue, 06 Sep 2022 14:43:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D08D0300023;
        Tue,  6 Sep 2022 16:43:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C3FA2B928DEC; Tue,  6 Sep 2022 16:43:09 +0200 (CEST)
Date:   Tue, 6 Sep 2022 16:43:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, tj@kernel.org, surenb@google.com,
        mkoutny@suse.com, mingo@redhat.com, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v4 00/10] sched/psi: some optimizations and extensions
Message-ID: <YxdcfX4Ss/9k8qA9@hirez.programming.kicks-ass.net>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
 <be071d5a-ff2d-d06e-2f89-f2ca247dd19e@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be071d5a-ff2d-d06e-2f89-f2ca247dd19e@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 06, 2022 at 09:13:27PM +0800, Chengming Zhou wrote:

Ah, I see Johannes has acked them all, I missed that.

> > Chengming Zhou (9):
> >   sched/psi: fix periodic aggregation shut off
> >   sched/psi: don't create cgroup PSI files when psi_disabled
> >   sched/psi: save percpu memory when !psi_cgroups_enabled
> >   sched/psi: move private helpers to sched/stats.h
> >   sched/psi: optimize task switch inside shared cgroups again
> >   sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
> >   sched/psi: consolidate cgroup_psi()
> >   sched/psi: cache parent psi_group to speed up groups iterate
> >   sched/psi: per-cgroup PSI accounting disable/re-enable interface
> > 
> > Johannes Weiner (1):
> >   sched/psi: remove NR_ONCPU task accounting

For future reference:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

Note all patches violate 1.2.2 for not starting the patch description
with a uppercase letter. I'll go manually fix up this time.
