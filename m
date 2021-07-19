Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F1A3CE981
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351229AbhGSQ5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 12:57:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58980 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357721AbhGSQwQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jul 2021 12:52:16 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:57914)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5X8Q-00C5r8-9k; Mon, 19 Jul 2021 11:32:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34170 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m5X8P-003nal-5j; Mon, 19 Jul 2021 11:32:53 -0600
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
Date:   Mon, 19 Jul 2021 12:32:46 -0500
In-Reply-To: <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com> (Vasily
        Averin's message of "Mon, 19 Jul 2021 13:45:44 +0300")
Message-ID: <87k0lmryyp.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m5X8P-003nal-5j;;;mid=<87k0lmryyp.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19riCDlCttkz1EHUrkai0JB6kWYfxt9MHc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Vasily Averin <vvs@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 538 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.4%), parse: 1.00 (0.2%),
        extract_message_metadata: 11 (2.1%), get_uri_detail_list: 1.27 (0.2%),
        tests_pri_-1000: 5 (1.0%), tests_pri_-950: 1.24 (0.2%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 188 (35.0%), check_bayes:
        184 (34.2%), b_tokenize: 10 (1.8%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 3.7 (0.7%), b_tok_touch_all: 161 (29.9%), b_finish: 0.88
        (0.2%), tests_pri_0: 298 (55.3%), check_dkim_signature: 1.73 (0.3%),
        check_dkim_adsp: 10 (1.9%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 19 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v5 13/16] memcg: enable accounting for signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Vasily Averin <vvs@virtuozzo.com> writes:

> When a user send a signal to any another processes it forces the kernel
> to allocate memory for 'struct sigqueue' objects. The number of signals
> is limited by RLIMIT_SIGPENDING resource limit, but even the default
> settings allow each user to consume up to several megabytes of memory.
> Moreover, an untrusted admin inside container can increase the limit or
> create new fake users and force them to sent signals.

Not any more.  Currently the number of sigqueue objects is limited
by the rlimit of the creator of the user namespace of the container.

> It makes sense to account for these allocations to restrict the host's
> memory consumption from inside the memcg-limited container.

Does it?  Why?  The given justification appears to have bit-rotted
since -rc1.

I know a lot of these things only really need a limit just to catch a
program that starts malfunctioning.  If that is indeed the case
reasonable per-resource limits are probably better than some great big
group limit that can be exhausted with any single resource in the group.

Is there a reason I am not aware of that where it makes sense to group
all of the resources together and only count the number of bytes
consumed?

Eric


> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a3229ad..8921c4a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -4663,7 +4663,7 @@ void __init signals_init(void)
>  {
>  	siginfo_buildtime_checks();
>  
> -	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC);
> +	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC | SLAB_ACCOUNT);
>  }
>  
>  #ifdef CONFIG_KGDB_KDB
