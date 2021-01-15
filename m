Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A02F70EA
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 04:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAODXX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 22:23:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49308 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAODXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 22:23:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F3KCLk168130;
        Fri, 15 Jan 2021 03:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=IOXbYHXHreW/DM/cC1BlOLyDYYZQRT6FD474gUtPV4A=;
 b=bEPJJSBKEY26381CteMXcM4TUtEgoNn7H/6Rj2Fypaq1KcWpgvxWwf+JT51UyPqMBfLU
 z4XGtzk1ndfrc/YAierZRu8Y86WIPMsivOrf/Y0gSoD3VutNeQ14tbaclOeHXO6zDT2U
 JDqZC1A1fdnzmxHZJY87mMZdb55T7Z+HczXUWTjsiU6OYzicqpmmTE6AtcFnknnwMjLg
 aXWGjJkmveVKL93gWjnihgvAyIxdmP8K2uKCqQWMSRElLbNy3MpZZTbY6Hq3znlVDiy2
 th6Uds65hwxEYViQeguOCfM9EEcXPWxXXjPogQle01Bu/mBImohggC0CRTiZiBXkdjVI /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kd0355f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 03:22:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10F3M1SL106622;
        Fri, 15 Jan 2021 03:22:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360keaps4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 03:22:04 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10F3LUj3020589;
        Fri, 15 Jan 2021 03:21:31 GMT
Received: from parnassus (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 19:21:30 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to
 finish on cpu online
In-Reply-To: <87k0tritvq.fsf@oracle.com>
References: <20201203171431.256675-1-aklimov@redhat.com>
 <20201207083827.GD3040@hirez.programming.kicks-ass.net>
 <87k0tritvq.fsf@oracle.com>
Date:   Thu, 14 Jan 2021 22:21:25 -0500
Message-ID: <87im7yc2bu.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150015
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150015
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:
> Peter Zijlstra <peterz@infradead.org> writes:
>>> The nature of this bug is also described here (with different consequences):
>>> https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/
>>
>> Yeah, pesky deadlocks.. someone was going to try again.
>
> I dug up the synchronous patch
>
>     https://lore.kernel.org/lkml/1579878449-10164-1-git-send-email-prsood@codeaurora.org/
>
> but surprisingly wasn't able to reproduce the lockdep splat from
>
>     https://lore.kernel.org/lkml/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/
>
> even though I could hit it a few weeks ago.

oh okay, you need to mount a legacy cpuset hierarchy.

So as the above splat shows, making cpuset_hotplug_workfn() synchronous
means cpu_hotplug_lock (and "cpuhp_state-down") can be acquired before
cgroup_mutex.

But there are at least four cgroup paths that take the locks in the
opposite order.  They're all the same, they take cgroup_mutex and then
cpu_hotplug_lock later on to modify one or more static keys.

cpu_hotplug_lock should probably be ahead of cgroup_mutex because the
latter is taken in a hotplug callback, and we should keep the static
branches in cgroup, so the only way out I can think of is moving
cpu_hotplug_lock to just before cgroup_mutex is taken and switching to
_cpuslocked flavors of the static key calls.

lockdep quiets down with that change everywhere, but it puts another big
lock around a lot of cgroup paths.  Seems less heavyhanded to go with
this RFC.  What do you all think?

Absent further discussion, Alexey, do you plan to post another version?
