Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88BC6AF750
	for <lists+cgroups@lfdr.de>; Tue,  7 Mar 2023 22:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCGVOq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Mar 2023 16:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCGVOm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Mar 2023 16:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B0E3403E
        for <cgroups@vger.kernel.org>; Tue,  7 Mar 2023 13:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678223635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RuqdEgW86TqgRF087mijC/p9xtmtsdmCeq1juDgkFI=;
        b=GfqyGDw7FdyPwKRHTDA0jx56vWNqKMUnSjRQ+eXZt/uXJxVCXHIJTMq+nuubuJJkGPvCjZ
        8bDa0/gSQ7/tmpqQlHJSEem7OWodjv/D/1+kmj7cDEsTCLXvg8ZR05ZlDi4+MMGipD2CpE
        q/BDbAho/tgXlZFA1jMCZ+4LBARvXTY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-mqhkam0DOJa-2ECZ36P1KQ-1; Tue, 07 Mar 2023 16:13:52 -0500
X-MC-Unique: mqhkam0DOJa-2ECZ36P1KQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2C6F1C02D30;
        Tue,  7 Mar 2023 21:13:50 +0000 (UTC)
Received: from [10.22.9.63] (unknown [10.22.9.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5741A44037;
        Tue,  7 Mar 2023 21:13:49 +0000 (UTC)
Message-ID: <1f2cf8ea-a9d7-5245-0f69-eb8be9f64afc@redhat.com>
Date:   Tue, 7 Mar 2023 16:13:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <CA+khW7i_Sc0M4FXzojmQ5PSfkPwk6AdcbN9j0gDXZ9FsOMQAwA@mail.gmail.com>
 <f3a99500-e51c-032f-a0c6-01763f0a5be6@redhat.com>
 <CA+khW7iWAn6bbXdkJX1Lt4dWUsN6o4KqVQ8OFTs0B+VTtVjBkw@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CA+khW7iWAn6bbXdkJX1Lt4dWUsN6o4KqVQ8OFTs0B+VTtVjBkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/7/23 16:06, Hao Luo wrote:
> On Tue, Mar 7, 2023 at 12:09 PM Waiman Long <longman@redhat.com> wrote:
>> On 3/7/23 14:56, Hao Luo wrote:
>>> On Mon, Feb 6, 2023 at 2:15 PM Qais Yousef <qyousef@layalina.io> wrote:
>>>> Commit f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
>>>> enabled rebuilding root domain on cpuset and hotplug operations to
>>>> correct deadline accounting.
>>>>
>>>> Rebuilding root domain is a slow operation and we see 10+ of ms delays
>>>> on suspend-resume because of that (worst case captures 20ms which
>>>> happens often).
>>>>
>>>> Since nothing is expected to change on suspend-resume operation; skip
>>>> rebuilding the root domains to regain the some of the time lost.
>>>>
>>>> Achieve this by refactoring the code to pass whether dl accoutning needs
>>>> an update to rebuild_sched_domains(). And while at it, rename
>>>> rebuild_root_domains() to update_dl_rd_accounting() which I believe is
>>>> a more representative name since we are not really rebuilding the root
>>>> domains, but rather updating dl accounting at the root domain.
>>>>
>>>> Some users of rebuild_sched_domains() will skip dl accounting update
>>>> now:
>>>>
>>>>           * Update sched domains when relaxing the domain level in cpuset
>>>>             which only impacts searching level in load balance
>>>>           * update sched domains when cpufreq governor changes and we need
>>>>             to create the perf domains
>>>>
>>>> Users in arch/x86 and arch/s390 are left with the old behavior.
>>>>
>>>> Debugged-by: Rick Yiu <rickyiu@google.com>
>>>> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
>>>> ---
>>> Hi Qais,
>>>
>>> Thank you for reporting this. We observed the same issue in our
>>> production environment. Rebuild_root_domains() is also called under
>>> cpuset_write_resmask, which handles writing to cpuset.cpus. Under
>>> production workloads, on a 4.15 kernel, we observed the median latency
>>> of writing cpuset.cpus at 3ms, p99 at 7ms. Now the median becomes
>>> 60ms, p99 at >100ms. Writing cpuset.cpus is a fairly frequent and
>>> critical path in production, but blindly traversing every task in the
>>> system is not scalable. And its cost is really unnecessary for users
>>> who don't use deadline tasks at all.
>> The rebuild_root_domains() function shouldn't be called when updating
>> cpuset.cpus unless it is a partition root. Is it?
>>
> I think it's because we were using the legacy hierarchy. I'm not
> familiar with cpuset partition though.

In legacy hierarchy, changing cpuset.cpus shouldn't lead to the calling 
of rebuild_root_domains() unless you play with cpuset.sched_load_balance 
file by changing it to 0 in the right cpusets. If you are touching 
cpuset.sched_load_balance, you shouldn't change cpuset.cpus that often.

Cheers,
Longman

