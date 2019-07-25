Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D7D75093
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGYOHm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 10:07:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37385 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfGYOHm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 10:07:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so25868578wrr.4
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2019 07:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFn09RalEUIKtnUE8NV4uNNiwjv0Llrv8izPJjzEejo=;
        b=URuJONOj28NUQTgva0JRP8dqNC9QiX0dDAmphhPxvFxHOrCH010j8OlN6TGYuJc0x6
         jVQI41eK1X1PDOsEndwTP0HB9ym9gvGisex+BdoqhSRWXQoLmiM86HeoR2dmgMnyERq6
         k0w51iyxp6sfJodUJJq9tSEurSSV0rR29SNjkJZyQaA/16LhjYiViAKwXi9FXM7c5sVb
         MYcJzGyAELCtCkAv3KNMsqI0YwmRBxBR6BhvIuRdUOB+MVbNxb+51U0TuJozD+x6fIbL
         iQg4c/i0rPYRm24sh06/8Y0yqiiIjAbkM1+CwnLKIdEc5WQkmZvGVme1fzUEBY/759bE
         Lr6w==
X-Gm-Message-State: APjAAAVP157Rycur/H3mDFFIjjUT5pWEUWPnurAaThX9xmaP/cakuqML
        esPSwbKMtkJ56nt0RsOiwhuWLg==
X-Google-Smtp-Source: APXvYqwQhtIOnV5ZljsfFGSDBzHtyXIAFpCL227sE7G1MAY4H2h2s62ayu8HX/oOObnUjrnXBvCHvQ==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr99702005wrj.283.1564063660364;
        Thu, 25 Jul 2019 07:07:40 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.107])
        by smtp.gmail.com with ESMTPSA id i12sm58112809wrx.61.2019.07.25.07.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 07:07:39 -0700 (PDT)
Date:   Thu, 25 Jul 2019 16:07:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        dietmar.eggemann@arm.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20190725140737.GM25636@localhost.localdomain>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20190725135351.GA108579@gmail.com>
 <20190725135615.GB108579@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725135615.GB108579@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 25/07/19 15:56, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Juri Lelli <juri.lelli@redhat.com> wrote:
> > 
> > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > operations information about the current deadline bandwidth held in the
> > > root domain is lost.
> > > 
> > > This patch addresses the issue by recalculating the lost deadline
> > > bandwidth information by circling through the deadline tasks held in
> > > CPUsets and adding their current load to the root domain they are
> > > associated with.
> > > 
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > 
> > Was this commit written by Mathieu? If yes then it's missing a From line. 
> > If not then the Signed-off-by should probably be changed to Acked-by or 
> > Reviewed-by?
> 
> So for now I'm assuming that the original patch was written by Mathieu, 
> with modifications by you. So I added his From line and extended the SOB 
> chain with the additional information that you modified the patch:
> 
>     Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>     Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>     [ Various additional modifications. ]
>     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Let me know if that's not accurate!

Looks good to me, thanks. And sorry for the confusion.

Best,

Juri
