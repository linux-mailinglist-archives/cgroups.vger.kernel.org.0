Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB271984EF
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2020 21:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgC3TxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Mar 2020 15:53:04 -0400
Received: from mail.efficios.com ([167.114.26.124]:51508 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgC3TxE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Mar 2020 15:53:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0AD55251A67;
        Mon, 30 Mar 2020 15:53:03 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9b75kJbjV4wT; Mon, 30 Mar 2020 15:53:02 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CB5C4251A66;
        Mon, 30 Mar 2020 15:53:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CB5C4251A66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585597982;
        bh=gw3EOeeRn8TwcNYr/XONiZlE5qIU4OEg5lWi3bCmVfs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Rx4PF07tkD4lV5RmbBpWW063TmT2yF/R9wlH2eHnjoVswpS/t5/Zxp2YZptg4agEm
         j7qJCws6zF9awHxUSG8/6BMZysOFMg/+wtkOtlLXWhwo0msL7c56yIQxFUZ19c2N6G
         OCgm3lSwsdexQjDF1QdFkfBSeTcmK/Lwyk2tbmtMMz9qaMLZteAtHuE8sX75v6ulIZ
         CYH364HljGpdR67yJsDxO5DHdk+XJbw5GV8GcHtoMeYewn2XlckErSUeCMCeR2Eiw/
         yGfsUSYuEIC7tprALzu1uPwz8xRGqHtL6j3tf+KQzjD/1Lsj5hWUN3eqCOXPT3D5hx
         gqCe1kySr6Uyw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IgQoVtsz-yHh; Mon, 30 Mar 2020 15:53:02 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BFE77251D45;
        Mon, 30 Mar 2020 15:53:02 -0400 (EDT)
Date:   Mon, 30 Mar 2020 15:53:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <266054305.17171.1585597982690.JavaMail.zimbra@efficios.com>
In-Reply-To: <195391080.10219.1585078246788.JavaMail.zimbra@efficios.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com> <20200219161222.GF698990@mtj.thefacebook.com> <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com> <20200312182618.GE79873@mtj.duckdns.org> <1289608777.27165.1584042470528.JavaMail.zimbra@efficios.com> <20200324180139.GB162390@mtj.duckdns.org> <195391080.10219.1585078246788.JavaMail.zimbra@efficios.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: +1BxSgW2D8wtgSc9ZwTWM+7saWQ/2wNdvK99
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Mar 24, 2020, at 3:30 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Mar 24, 2020, at 2:01 PM, Tejun Heo tj@kernel.org wrote:
> 
>> On Thu, Mar 12, 2020 at 03:47:50PM -0400, Mathieu Desnoyers wrote:
>>> The basic idea is to allow applications to pin to every possible cpu, but
>>> not allow them to use this to consume a lot of cpu time on CPUs they
>>> are not allowed to run.
>>> 
>>> Thoughts ?
>> 
>> One thing that we learned is that priority alone isn't enough in isolating cpu
>> consumptions no matter how low the priority may be if the workload is latency
>> sensitive. The actual computation capacity of cpus gets saturated way before cpu
>> time is saturated and latency impact from lowered mips becomes noticeable. So,
>> depending on workloads, allowing threads to run at the lowest priority on
>> disallowed cpus might not lead to behaviors that users expect but I have no idea
>> what kind of usage models you have on mind for the new system call.
> 
[...]

One possibility would be to use SCHED_IDLE scheduling class rather than SCHED_OTHER
with nice +19. The unfortunate side-effect AFAIU shows up when a thread requests to
be pinned on a CPU which is continuously overcommitted. It may never run. This could
come as a surprise for the user. The only case where this would happen is if:

- A thread is pinned on CPU N, and
  - CPU N is not part of the allowed mask for the task's cpuset (and is overcommitted), or
  - CPU N is offline, and the fallback CPU is not part of the allowed mask for the
    task's cpuset (and is overcommitted).

Is it an acceptable behavior ? How is userspace supposed to detect this kind of situation
and mitigate it ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
