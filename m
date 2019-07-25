Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA775367
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 18:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbfGYQAi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 12:00:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35784 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388350AbfGYQAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Jul 2019 12:00:38 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so98383150ioo.2
        for <cgroups@vger.kernel.org>; Thu, 25 Jul 2019 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th3QGwA5K0Aod/hrhTKzXbdEWqw5GM7JKiuVFRg5Xpk=;
        b=u2YxyJZJnPugr5UyAeZSSPQSyKumnK2fNlAhVccfH/AhV/Vq38llxZhgI4Bi2x0pNp
         EnhLr/xJAMwZcuoe+5hEVhhjpzIdWkEotLd0wAVzzVA/ZBEwPeppTrBSmkf6VSZ0SJGH
         yOR2v0t0taqYu6a0uGIbVdts0kiwtd2FrtOrp12uH39YiIJpfgbIetCuK+kiMQrgrosz
         A2fZ04DB5h9guj+1E7Oqu9++XlTqwlH1Pq67jsaW53j3gfl2saHHQy3HqpSS34hBw42r
         sXnB1IhvR2l5kIfS9caL2cTLHNIIA1t3KF7kaW92V8lolMKzxBubTyJAHb9Y0RNWlPyV
         KLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th3QGwA5K0Aod/hrhTKzXbdEWqw5GM7JKiuVFRg5Xpk=;
        b=dtPvZzJfnOAFDaSz4DzTbAbrKDQOfHFYRy/ufROZbJx3gxi/S2jE6/Q20Q1dAoDWwc
         l7KHYViBqUQgpC6LRyGJDTUQTJq92+tOot98l1HPhjn6ftEEQWBuY++oNWI59IZJHmKH
         08Ec8413/fyJdRzZRaQOX2zZYH3eM++40tgLjRz9MwQel7ET7RrJMo4ajHJaPcGK8NYE
         JukXZtKOHT/EvrsngevN1YPfJx+B5fb2UioMeuzcHixd3pkGOgmhA+tPqzZE8IK2151l
         eep92nIy/Y2sXJfh8LPdHHXWXjeaj+zhxlW2uamDqyQWmcnBgEiO2x9myo3TAOzL8q5g
         M+8g==
X-Gm-Message-State: APjAAAU3ssfuzsK9+Wo7zz2vU9jZr5pl/U47r/cX0pgqy2tGtCIFSPgs
        ZsfjF9l/fI9RFoW4x2xTmYhAtxhOQ7ecdqiWUduzgw==
X-Google-Smtp-Source: APXvYqxUNTmUuiAovNvrsLe2yyXqtmRhi5HmhYqJVBw60hM/15ck/+2S2SFKumpxpCa2QMzDo2mkg1I1LsqZi80kuzQ=
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr2820469iod.139.1564070437210;
 Thu, 25 Jul 2019 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190719140000.31694-1-juri.lelli@redhat.com> <20190719140000.31694-4-juri.lelli@redhat.com>
 <20190725135351.GA108579@gmail.com> <20190725135615.GB108579@gmail.com>
In-Reply-To: <20190725135615.GB108579@gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 25 Jul 2019 10:00:26 -0600
Message-ID: <CANLsYkzd1Vt5L+tcmtnC+gm6MCe2yYWNi3WEif+4dN2DmcMijA@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting information
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "luca.abeni" <luca.abeni@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Li Zefan <lizefan@huawei.com>, longman@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 25 Jul 2019 at 07:56, Ingo Molnar <mingo@kernel.org> wrote:
>
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

You are correct - thanks,
Mathieu

>
> Thanks,
>
>         Ingo
