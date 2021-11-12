Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8791D44EACD
	for <lists+cgroups@lfdr.de>; Fri, 12 Nov 2021 16:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhKLPtN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Nov 2021 10:49:13 -0500
Received: from goliath.siemens.de ([192.35.17.28]:35309 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbhKLPtN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Nov 2021 10:49:13 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1ACFk9A6018818
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 16:46:09 +0100
Received: from [167.87.32.54] ([167.87.32.54])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1ACFk9hp015435;
        Fri, 12 Nov 2021 16:46:09 +0100
Subject: Re: Questions about replacing isolcpus by cgroup-v2
To:     "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Schild, Henning (T RDA IOT SES-DE)" <henning.schild@siemens.com>,
        "Schmidt, Adriaan (T RDA IOT SES-DE)" <adriaan.schmidt@siemens.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <AM9PR10MB48692A964E3106D11AC0FDEE898D9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
 <20211112153656.qkwyvdmb42ze25iw@linutronix.de>
 <AM9PR10MB4869F9A2D7F5F95C29B5521889959@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2587fcb7-6c3f-e44c-ba4b-20e7327337e3@siemens.com>
Date:   Fri, 12 Nov 2021 16:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AM9PR10MB4869F9A2D7F5F95C29B5521889959@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12.11.21 16:45, Moessbauer, Felix (T RDA IOT SES-DE) wrote:
> Hi Sebastian,
> 
>> -----Original Message-----
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Sent: Friday, November 12, 2021 4:37 PM
>> To: Moessbauer, Felix (T RDA IOT SES-DE) <felix.moessbauer@siemens.com>;
>> cgroups@vger.kernel.org
>> Cc: linux-rt-users@vger.kernel.org; Schild, Henning (T RDA IOT SES-DE)
>> <henning.schild@siemens.com>; Kiszka, Jan (T RDA IOT)
>> <jan.kiszka@siemens.com>; Schmidt, Adriaan (T RDA IOT SES-DE)
>> <adriaan.schmidt@siemens.com>; Frederic Weisbecker <frederic@kernel.org>
>> Subject: Re: Questions about replacing isolcpus by cgroup-v2
>>
>> On 2021-11-04 17:29:08 [+0000], Moessbauer, Felix wrote:
>>> Dear subscribers,
>> Hi,
>>
>> I Cced cgroups@vger since thus question fits there better.
>> I Cced Frederic in case he has come clues regarding isolcpus and cgroups.
> 
> Indeed. Thanks!
> 
>>
>>> we are currently evaluating how to rework realtime tuning to use cgroup-v2
>> cpusets instead of the isolcpus kernel parameter.
>>> Our use-case are realtime applications with rt and non-rt threads. Hereby, the
>> non-rt thread might create additional non-rt threads:
>>>
>>> Example (RT CPU=1, 4 CPUs):
>>> - Non-RT Thread (A) with default affinity 0xD (1101b)
>>> - RT Thread (B) with Affinity 0x2 (0010b, via set_affinity)
>>>
>>> When using pure isolcpus and cgroup-v1, just setting isolcpus=1 perfectly
>> works:
>>> Thread A gets affinity 0xD, Thread B gets 0x2 and additional threads get a
>> default affinity of 0xD.
>>> By that, independent of the threads' priorities, we can ensure that nothing is
>> scheduled on our RT cpu (except from kernel threads, etc...).
>>>
>>> During this journey, we discovered the following:
>>>
>>> Using cgroup-v2 cpusets and isolcpus together seems to be incompatible:
>>> When activating the cpuset controller on a cgroup (for the first time), all
>> default CPU affinities are reset.
>>> By that, also the default affinity is set to 0xFFFF..., while with isolcpus we
>> expect it to be (0xFFFF - isolcpus).
>>> This breaks the example from above, as now the non-RT thread can also be
>> scheduled on the RT CPU.
>>>
>>> When only using cgroup-v2, we can isolate our RT process by placing it in a
>> cgroup with CPUs=0,1 and remove CPU=1 from all other cgroups.
>>> However, we do not know of a strategy to set a default affinity:
>>> Given the example above, we have no way to ensure that newly created
>> threads are born with an affinity of just 0x2 (without changing the application).
>>>
>>> Finally, isolcpus itself is deprecated since kernel 5.4.
>>
>> Where is this the deprecation of isolcpus announced/ written?
> 
> https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
> isolcpus=       [KNL,SMP,ISOL] Isolate a given set of CPUs from disturbance.
>                         [Deprecated - use cpusets instead]
>                         Format: [flag-list,]<cpu-list>
> 

That was Frederic himself via b0d40d2b22fe - but already for 4.15...

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
