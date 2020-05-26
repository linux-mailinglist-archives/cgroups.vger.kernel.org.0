Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8B21E2FD1
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbgEZUP6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbgEZUP6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 16:15:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8D3C03E96D;
        Tue, 26 May 2020 13:15:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x29so4098512qtv.4;
        Tue, 26 May 2020 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIlePaEo2DB2lWCSsF6hOGAO/zJmXGR+8z88QbPZwuA=;
        b=vGsBr5wQpHw68zyoZJvgzHNbkgx9psh74mtNJxqpEOgwrQpmej8EZzHAX4XhlgkBAw
         LMMIEgnCRPb4utbn/CnS0mmTr+9tLCJAcYDlmkThNex0SAFcxXvxSps/IwKCuihbUAKw
         /YcMZCmkST4MESr2kDzOSDrPgMTVh1fkmousvPmqj4Hy3X3bCPQ3tan68m6KlRjj6Vfw
         lyXF9bpOir119aygoHP9wIQ4fbD1LqHyTM0finKJh1dqqGmjdDn+ChV2eLSCqAIhqsiL
         PW+Vqyz2HPxXk9Fl5HlmTArOGH2iJoMyRZoYlGJgHisGrNuaCiLCovFib5xYjl8eju23
         E5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OIlePaEo2DB2lWCSsF6hOGAO/zJmXGR+8z88QbPZwuA=;
        b=G3Tubp4O6NyRlMp5HODukT/RmnuLxpnnTsxzEpImLqwAD8jTDmnb1NCxfC/yZWRVlx
         6SOpey42TZiZ3VHsOqQ1MjFrKL9NuNKQU/lSVMc+6Rasmt6flDJS6ldQEsmIQ8dcocKq
         WdmhI7tRXSsmIqX94PdcIx71kkXkl7bIxBRze06jC+iwknfyE6nBRl1KW2fCZ7gsjVR1
         J0JyQyMdwGgYuvts8VfG4Mx+eo3ujlBDooN7ZcLGr8b1nNM+0K1eUT1djToy6cAFUmWa
         YZ+t2/IRIVtcjq6T3E3BNNyf7gAS2P/mbDVUpM1QUu3Mjl5kuvHEPabCaLt5k+Nf7pKD
         BL4g==
X-Gm-Message-State: AOAM530MGvst9Tk6MMf/GDbGp+j4x4jI/sq6UnNasBPBo+SjYcOwKNHJ
        tlTS79jkaE0YirVI3nVLZks=
X-Google-Smtp-Source: ABdhPJwFsA+W7dNO8mOZJWz3XFO0b2jYFQzH2q6iPEOBfPshIJIwCkAhbjiGdUBp1YGreDe/vpnRNw==
X-Received: by 2002:ac8:260b:: with SMTP id u11mr626092qtu.380.1590524157306;
        Tue, 26 May 2020 13:15:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:85c0])
        by smtp.gmail.com with ESMTPSA id d7sm518184qkk.26.2020.05.26.13.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:15:56 -0700 (PDT)
Date:   Tue, 26 May 2020 16:15:54 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.8] cgroup: add cpu.stat file to root cgroup
Message-ID: <20200526201554.GH83516@mtj.thefacebook.com>
References: <20200526200800.3969430-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526200800.3969430-1-boris@bur.io>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, May 26, 2020 at 01:08:00PM -0700, Boris Burkov wrote:
> Currently, the root cgroup does not have a cpu.stat file. Add one which
> is consistent with /proc/stat to capture global cpu statistics that
> might not fall under cgroup accounting.
> 
> We haven't done this in the past because the data are already presented
> in /proc/stat and we didn't want to add overhead from collecting root
> cgroup stats when cgroups are configured, but no cgroups have been
> created.
> 
> By keeping the data consistent with /proc/stat, I think we avoid the
> first problem, while improving the usability of cgroups stats.
> We avoid the second problem by computing the contents of cpu.stat from
> existing data collected for /proc/stat anyway.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> Suggested-by: Tejun Heo <tj@kernel.org>

If there are any objections, please holler. I'll wait a few days and
route it through the cgroup tree.

Thanks.

-- 
tejun
