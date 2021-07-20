Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595AC3CFFB9
	for <lists+cgroups@lfdr.de>; Tue, 20 Jul 2021 18:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGTQDi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jul 2021 12:03:38 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:46012 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhGTQCT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jul 2021 12:02:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5spc-006lfH-Av; Tue, 20 Jul 2021 10:42:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:50550 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5spb-004FeE-0Y; Tue, 20 Jul 2021 10:42:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
        <cover.1626688654.git.vvs@virtuozzo.com>
        <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
        <87k0lmryyp.fsf@disp2133>
        <56816a9d-c2e5-127d-4d90-5d7d17782c8a@virtuozzo.com>
Date:   Tue, 20 Jul 2021 11:42:47 -0500
In-Reply-To: <56816a9d-c2e5-127d-4d90-5d7d17782c8a@virtuozzo.com> (Vasily
        Averin's message of "Tue, 20 Jul 2021 11:35:19 +0300")
Message-ID: <87wnplos1k.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m5spb-004FeE-0Y;;;mid=<87wnplos1k.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JI59ywzeupllyPmyImzi2tt60wS/c3Cs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Vasily Averin <vvs@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 548 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 15 (2.7%), b_tie_ro: 12 (2.3%), parse: 1.23
        (0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 6 (1.0%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.18 (0.2%), tests_pri_-90: 107 (19.6%), check_bayes:
        105 (19.2%), b_tokenize: 10 (1.7%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 3.7 (0.7%), b_tok_touch_all: 74 (13.5%), b_finish: 1.10
        (0.2%), tests_pri_0: 383 (70.0%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 3.7 (0.7%), poll_dns_idle: 2.2 (0.4%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 12 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> writes:

> On 7/19/21 8:32 PM, Eric W. Biederman wrote:
>> Vasily Averin <vvs@virtuozzo.com> writes:
>> 
>>> When a user send a signal to any another processes it forces the kernel
>>> to allocate memory for 'struct sigqueue' objects. The number of signals
>>> is limited by RLIMIT_SIGPENDING resource limit, but even the default
>>> settings allow each user to consume up to several megabytes of memory.
>>> Moreover, an untrusted admin inside container can increase the limit or
>>> create new fake users and force them to sent signals.
>> 
>> Not any more.  Currently the number of sigqueue objects is limited
>> by the rlimit of the creator of the user namespace of the container.
>> 
>>> It makes sense to account for these allocations to restrict the host's
>>> memory consumption from inside the memcg-limited container.
>> 
>> Does it?  Why?  The given justification appears to have bit-rotted
>> since -rc1.
>
> Could you please explain what was changed in rc1?
> From my POV accounting is required to help OOM-killer to select proper target.

You can no longer escape the rlimit of the creator of the user
namespace, by creating multiple users inside of the user namespace.  The
users (in the user namespace) will have their individual rlimits but
are jointly by the limit of the creator of the user namespace at the
time the user namespace was created.

>> I know a lot of these things only really need a limit just to catch a
>> program that starts malfunctioning.  If that is indeed the case
>> reasonable per-resource limits are probably better than some great big
>> group limit that can be exhausted with any single resource in the group.
>> 
>> Is there a reason I am not aware of that where it makes sense to group
>> all of the resources together and only count the number of bytes
>> consumed?
>
> Any new limits:
> a) should be set properly depending on huge number of incoming parameters.
> b) should properly notify about hits
> c) should be updated properly after b) 
> d) do a)-c) automatically if possible
>
> In past OpenVz had own accounting subsystem, user beancounters (UBC).
> It accounted and limited 20+ resources  per-container: numfiles, file locks,
> signals, netfilter rules, socket buffers and so on.
> I assume you want to do something similar, so let me share our experience. 
>
> We had a lot of problems with UBC:
> - it's quite hard to set up the limit. 
>   Why it's good to consume N entities of some resource but it's bad to consume N+1 ones? 
>   per-process? per-user? per-thread? per-task? per-namespace? if nested? per-container? per-host?
>   To answer the questions host admin should have additional knowledge and skills.
>
> - Ok, we have set all limits. Some application hits it and fails.
>   It's quite hard to understand that application hits the limit, and failed due to this reason.
>   From users point of view, if some application does not work (stable enough)
>   inside container => containers are guilty.
>
> - It's quite hard to understand that failed application just want to increase limit X up to N entities.
>
> As result both host admins and container users was unhappy.
> So after years of such fights we decided just to limit accounted
> memory instead.


Which is a perfectly fine justification.  However the justification
presented in the change log was that there is no existing limit, and
that is what is factually wrong.

Different kinds of limits serve different purposes.  An accounting of how
many instance of a resource has been used serve the purpose of detecting
when an application has gone completely out of spec.

Limits like you are implementing here are much better for just sharing and
managing system resources.

> Anyway, OOM-killer must know who consumed memory to select proper
> target.

The limits I am talking about are not useful to the OOM killer as
usually the amount of resources that indicates something has gone wrong
are too small to be a system-wide problem.

So please just correct the justification in the commit message and I
will be happy.

Eric  
