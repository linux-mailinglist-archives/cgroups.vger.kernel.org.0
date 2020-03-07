Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CB17CF3E
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2020 17:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCGQGt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Mar 2020 11:06:49 -0500
Received: from mail.efficios.com ([167.114.26.124]:36038 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCGQGt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Mar 2020 11:06:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CBB6F270B1E;
        Sat,  7 Mar 2020 11:06:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id gEXMLoGvbEdB; Sat,  7 Mar 2020 11:06:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 870472709B7;
        Sat,  7 Mar 2020 11:06:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 870472709B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583597207;
        bh=EY6puMR1j0aA7xNeAuDaWQotUfbBgbb0ktp6KtbehMs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ffR8LwoybG4Qo8XEGy9e4MVOrSP1hrsFn0yvu1AiwN1gbJ9zblmLjST2FKFIpaxCg
         RMaSN3wJIzvvVCk6HdPQXdhGuaksGpjD+kJSuDkLRTUQNEXqT2iksPk9G0Qi5MlkY0
         vkC2ZrbFsY+pgZSJFt8m21rKYo5mfu8X54LC1lvdwFzHZ2Z4MoOtkcSOgJ82wL6gvB
         0W076/8hxLYGIW0jGFRem84QGX+C1GxIUgTSXALrNuTE0rbDFTXb5fAK2fpuEhgMNQ
         yLsj26Ck2VS6wJ27iQmExFodvEfYwSADDscjTkiLFPpbX4N/G5xcLMZZcmjyua9bGO
         /4u5H9i+BOjlA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pJWShRz0bBjD; Sat,  7 Mar 2020 11:06:47 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7926F270939;
        Sat,  7 Mar 2020 11:06:47 -0500 (EST)
Date:   Sat, 7 Mar 2020 11:06:47 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200219161222.GF698990@mtj.thefacebook.com>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <20200219151922.GB698990@mtj.thefacebook.com> <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com> <20200219154740.GD698990@mtj.thefacebook.com> <59426509.702.1582127435733.JavaMail.zimbra@efficios.com> <20200219155202.GE698990@mtj.thefacebook.com> <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com> <20200219161222.GF698990@mtj.thefacebook.com>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: rKDgzQVJg+DUsb3OXMOSNULnDpqU4Q==
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Feb 19, 2020, at 11:12 AM, Tejun Heo tj@kernel.org wrote:

> On Wed, Feb 19, 2020 at 11:08:39AM -0500, Mathieu Desnoyers wrote:
>> I wonder if applying the online cpu masks to the per-thread affinity mask
>> is the correct approach ? I suspect what we may be looking for here is to keep
> 
> Oh, the whole thing is wrong.
> 
>> the affinity mask independent of cpu hotplug, and look-up both the per-thread
>> affinity mask and the online cpu mask whenever the scheduler needs to perform
>> "is_cpu_allowed()" to check task placement.
> 
> Yes, that's what it should have done from the get-go. The way it's
> implemented now, maybe we can avoid some specific cases like cpuset
> not being used at all but it'll constantly get in the way if you're
> expecting thread affinity to retain its value across offlines.

Looking into solving this, one key issue seems to get in the way: cpuset
appear to care about not allowing to create a cpuset which has no currently
active CPU where to run, e.g.:

# it is forbidden to create an empty cpuset if the cpu is offlined first:

mkdir /sys/fs/cgroup/cpuset/test

echo 2 > /sys/fs/cgroup/cpuset/test/cpusets.cpus

cat /sys/fs/cgroup/cpuset/test/cpusets.cpu
2

echo 0 > /sys/devices/system/cpu/cpu1/online

echo 1 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
bash: echo: write error: Invalid argument

cat /sys/fs/cgroup/cpuset/test/cpusets.cpu
2


# but it's perfectly fine to generate this empty cpuset by offlining
# a cpu _after_ creating the cpuset:

echo 0 > /sys/devices/system/cpu/cpu2/online

cat /sys/fs/cgroup/cpuset/test/cpusets.cpu
  <----- empty (nothing)

Some further testing seems to show that tasks belonging to that empty
cpuset are placed anywhere on active cpus.

Clearly, there is an intent that cpusets take the active mask into
account to prohibit creating an empty cpuset, but nothing prevents
cpu hotplug from creating an empty cpuset.

I wonder how to solve this inconsistency ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
