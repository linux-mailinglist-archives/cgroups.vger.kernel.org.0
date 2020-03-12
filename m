Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB861839C4
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLTrw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 15:47:52 -0400
Received: from mail.efficios.com ([167.114.26.124]:45420 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLTrw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 15:47:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1E7C4283B3D;
        Thu, 12 Mar 2020 15:47:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aOQH6xH2AcoZ; Thu, 12 Mar 2020 15:47:50 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ABCFB283B3C;
        Thu, 12 Mar 2020 15:47:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ABCFB283B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584042470;
        bh=A1HR5wx2ul5UN/781Z2t5qlpWkPcTJFFf8FZtwQy6S0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=I7XIwjfakzD+Ifo0HlzHk72yMKTKFW2SQR4uZPsMLjCFAmT7H1X/5XqyV/9FAMR2X
         DM+oMyxtBE/rnPjt2hW3PHY0fE2DtI2XgYspcckeHbnchZwyywjLDAL1q4e3ksB/6O
         snuzo2y365fmrlkxdgMu6d0AgnN1i4koJP5A5ytLg83TOm2AbvaOpV7QZf9FX+tCQT
         VKCU7vvkuDNQe7FCkW89i/BkBJckT6wuK2DWcKceDq6A4DYE17lKOklXKgQHzv/Zot
         ln1eVE+etQHwwZrsd+kaVMlfnJ3OYrGZvNIxNx68XFgZ887Oo7/wao7M1PUiCsFU96
         bhr2lRGbzncQA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TLyBoLL87IdR; Thu, 12 Mar 2020 15:47:50 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9B88F283B3A;
        Thu, 12 Mar 2020 15:47:50 -0400 (EDT)
Date:   Thu, 12 Mar 2020 15:47:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <1289608777.27165.1584042470528.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200312182618.GE79873@mtj.duckdns.org>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <20200219154740.GD698990@mtj.thefacebook.com> <59426509.702.1582127435733.JavaMail.zimbra@efficios.com> <20200219155202.GE698990@mtj.thefacebook.com> <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com> <20200219161222.GF698990@mtj.thefacebook.com> <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com> <20200312182618.GE79873@mtj.duckdns.org>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: FByLWuKCPlzdKGK72QNzb8rkGcc4gA==
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Mar 12, 2020, at 2:26 PM, Tejun Heo tj@kernel.org wrote:

> Hello,
> 
> On Sat, Mar 07, 2020 at 11:06:47AM -0500, Mathieu Desnoyers wrote:
>> Looking into solving this, one key issue seems to get in the way: cpuset
>> appear to care about not allowing to create a cpuset which has no currently
>> active CPU where to run, e.g.:
> ...
>> Clearly, there is an intent that cpusets take the active mask into
>> account to prohibit creating an empty cpuset, but nothing prevents
>> cpu hotplug from creating an empty cpuset.
>> 
>> I wonder how to solve this inconsistency ?
> 
> Please try cpuset in cgroup2. It shouldn't have those issues.

After figuring how to use cgroup2 (systemd.unified_cgroup_hierarchy=1 boot
parameter helped tremendously), and testing similar scenarios, it indeed
seems to have a much saner behavior than cgroup1.

Considering that the allowed cpu mask is weird wrt cgroup1 and cpu hotplug,
and that cgroup2 allows thread-level granularity, it does not make much sense
to prevent the pin_on_cpu() system call I am working on from pinning
on cpus which are not present in the allowed mask.

I'm currently investigating approaches that would detect situations
where a thread is pinned onto a CPU which is not part of its allowed
mask, and set the task prio at MAX_PRIO-1 (the lowest fair priority
possible) in those cases.

The basic idea is to allow applications to pin to every possible cpu, but
not allow them to use this to consume a lot of cpu time on CPUs they
are not allowed to run.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
