Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546FC2B1903
	for <lists+cgroups@lfdr.de>; Fri, 13 Nov 2020 11:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKMK0d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Nov 2020 05:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMK0c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Nov 2020 05:26:32 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED52C0613D1;
        Fri, 13 Nov 2020 02:26:19 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j12so9277217iow.0;
        Fri, 13 Nov 2020 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OzkmFiHGwyD+I15mtrva81uZcY7HDY5tWPQl2Uj50ck=;
        b=K+WAle8GcXxw4uPqUL3iF+4TrsgI5rq+lL7lrFVr6yVcAlbePlqv6f7qb6i2dM+FZd
         E2icUWNakB9SOYmNfM1R+nHqLV1UtP44bsReRVk6nMLaJ6J6MKUufQTVm2FwRgdt2owu
         DNYQDYbTsw1gNPvKRsJz4vR0tp4YkgQ6rluw2pGXjvw2YCe8JLueyLsIggXiKKIZVmN/
         L/qay4mlQ8jTALH9QIdPLCT8R+Sb1Q7IvwdXl4e2FcnGEuw2sSqG3jYi8w4OXUox/NKJ
         HVMNJur/eLs9eK1bOP+D98m0WL8/WcxWxbm+3VAu4mihjfEehI3AFTfZ9t+E2iaw5vAI
         J8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OzkmFiHGwyD+I15mtrva81uZcY7HDY5tWPQl2Uj50ck=;
        b=SHHBoUpRQ9xsa2mOhCiN6pT7hP5aD829PSJ4MaVHUS9J1mMal+2ZJe5cip0fa+8K/J
         IXEiKMwe7n1L0s5//GIHLMRcs7rJAlKpOgSTawhAK7M2r3Ko4XNS0Pp4+HO1YYQmnOdk
         YnhAKJ6hNGhRytnl1VETvvE6/nF5RFHDOmpHRPBWDBliX30qm+MvzNk+vVQMICuqV5Rg
         i4stTcWnv9y7Fd0gwURA7pPEUK7ho/kpgcM404pKVor7vAC8glA9RldBh2pH4wKflzN1
         w0dsBmCkkKyjET0HIkLCMaNRSdy3F2GPlypWbJDJNPHLdyohos3RvvxFm7FJr9ZNl5Pg
         +zEg==
X-Gm-Message-State: AOAM530J6OVwnNklhtseSm6JP+ib6lUnGfRErFSy2qTeKmpKEsBwot6m
        RGS42a4bkcDjMJatd06fnEc=
X-Google-Smtp-Source: ABdhPJwmqJZ75L2k+n4eklNHfhcechXRjLvvnn9Ucn/mwP4/Ltjezj6ZgbqFOHkAQCFZzgG7nUZfMg==
X-Received: by 2002:a6b:7702:: with SMTP id n2mr1238753iom.4.1605263178456;
        Fri, 13 Nov 2020 02:26:18 -0800 (PST)
Received: from localhost ([199.241.171.166])
        by smtp.gmail.com with ESMTPSA id k7sm4632061ilq.48.2020.11.13.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:26:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Nov 2020 05:26:03 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Prateek Sood <prsood@codeaurora.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: fix race between hotplug work and later CPU
 offline
Message-ID: <20201113102603.GG7496@mtj.duckdns.org>
References: <20201112171711.639541-1-daniel.m.jordan@oracle.com>
 <20201113081622.GA2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113081622.GA2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Nov 13, 2020 at 09:16:22AM +0100, Peter Zijlstra wrote:
> Works for me. TJ, do I take this or do you want it in the cgroup tree?
> 
> In that case:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Please take it through the sched tree, and FWIW

 Acked-by: Tejun Heo <tj@kernel.org>

Thank you.

-- 
tejun
