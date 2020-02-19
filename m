Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB03A164927
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 16:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSPuh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 10:50:37 -0500
Received: from mail.efficios.com ([167.114.26.124]:36442 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgBSPuh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 10:50:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0C68A249843;
        Wed, 19 Feb 2020 10:50:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JUDKRNvcXdxi; Wed, 19 Feb 2020 10:50:35 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CCD34249842;
        Wed, 19 Feb 2020 10:50:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CCD34249842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582127435;
        bh=n5cHT89YZyqvy7ZJIr0GDRx3VH9Jg3ndn0oVBAB6nME=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CmPM8/EWqcMTIbi1mbdrVOPedy+TO3w3D66BhLXu7EBQJz/InhT+S9wuJ76gOKznf
         FrMGRQcZR2XJo1sLQSUwR29n8cRxJTP3QF2usBRcVgyIjelW2vJ+yf4wGGzjABmTm9
         XDvuBRIBK9djAXHiX1yvM77F51JVkPHgwatvw5bS87zdCrgOqmcvi4/EyYNhcccpVZ
         6SHL5al2i0pWjfUHghhCLaUihNKQZlQBQhYxxxnAKGyDHYQTOYadJ2GWKjIZaUyzL0
         FCz5giEUKWpDSbfKoEFKL5vBVPZ2g6fdHB0jYLARjs33Z+ZwVW1bbddPAuujNxmK7L
         ydeAy0PBy2qVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L-1Q0gBfzK1s; Wed, 19 Feb 2020 10:50:35 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C4A90249835;
        Wed, 19 Feb 2020 10:50:35 -0500 (EST)
Date:   Wed, 19 Feb 2020 10:50:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200219154740.GD698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <1317969050.4131.1581955387909.JavaMail.zimbra@efficios.com> <20200219151922.GB698990@mtj.thefacebook.com> <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com> <20200219154740.GD698990@mtj.thefacebook.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: S0iZuQsNrtd7VCZ5UFMGGpTw409R/w==
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Feb 19, 2020, at 10:47 AM, Tejun Heo tj@kernel.org wrote:

> On Wed, Feb 19, 2020 at 10:43:05AM -0500, Mathieu Desnoyers wrote:
>> The regression I'm talking about here is that CONFIG_CPUSET=y changes the
>> behavior of the sched_setaffinify system call, which existed prior to
>> cpusets.
>> 
>> sched_setaffinity should behave in the same way for kernels configured with
>> CONFIG_CPUSET=y or CONFIG_CPUSET=n.
>> 
>> The fact that cpuset decides to irreversibly change the task affinity mask
>> may not be considered a regression if it has always done that, but changing
>> the behavior of sched_setaffinity seems to fit the definition of a regression.
> 
> We generally use "regression" for breakages which weren't in past
> versions but then appeared later. It has debugging implications
> because if we know something is a regression, we generally can point
> to the commit which introduced the bug either through examining the
> history or bisection.
> 
> It is a silly bug, for sure, but slapping regression name on it just
> confuses rather than helping anything.

I can look into figuring out the commit introducing this issue, which I
suspect will be close to the introduction of CONFIG_CPUSET into the
kernel (which was ages ago). I'll check and let you know.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
