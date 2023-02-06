Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1197168C3DE
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBFQw1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 11:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjBFQwP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 11:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF49022
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675702217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yVEU5w2/bUVcxkdB59nbmmH1xHTXkQRMgUkXR85IDjQ=;
        b=jEP6v2tr7GEBa58iTVb2HkcghJ83ecAkknUsjvHgp+LX3tXzv+GG5CWK3wSCzaHVyzFTyT
        v1rU+5fvUh98ddhk42P+q2nL0d4Acf6g4Y9SGbYgWhcBr4hr6OAdaOEZOnCDD4HpGjQ3ee
        O0oWRMI7xDoSdkQTMDMLOvfI3u/A0SU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-iLALzcXMP2-7At9fxoyNzQ-1; Mon, 06 Feb 2023 11:50:13 -0500
X-MC-Unique: iLALzcXMP2-7At9fxoyNzQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29DFD3804505;
        Mon,  6 Feb 2023 16:50:12 +0000 (UTC)
Received: from [10.22.18.235] (unknown [10.22.18.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75CF42026D37;
        Mon,  6 Feb 2023 16:50:11 +0000 (UTC)
Message-ID: <c6bd487d-1436-66f7-ed2a-8679303ad9b5@redhat.com>
Date:   Mon, 6 Feb 2023 11:50:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-3-frederic@kernel.org>
 <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
 <20230206154710.GC21332@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230206154710.GC21332@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/6/23 10:47, Michal Koutný wrote:
> Hello.
>
> On Fri, Feb 03, 2023 at 10:53:46PM -0500, Waiman Long <longman@redhat.com> wrote:
>> CPUs in an isolated cpuset partition is similar to HK_TYPE_DOMAIN CPUs as
>> load balancing is disabled. I can add an API to access the cpumask and add
>> to this API. However, that list is dynamic as it can be changed at run time.
>> Will that be a problem?
> I can see a problem already -- as a CPU can be dynamically switched to
> "isolated" mode so should all dependent operations support that (switch)
> too, i.e. the CPUs local PCP caches would have to be drained when the
> CPU enters isolation.
I see the long term goal is to have more isolation capability to be done 
dynamically. However, we are not there yet. There is still a lot of work 
to do to achieve that.
>
>> Or should that be used separately?
> It'd be nice to have both (cpuset and cmdline flags) eventually unified.
>
> Alas, it only leads me conservatively to:
>
> #ifndef CONFIG_CPUSETS
> // the proposed implementaion
> else
> static inline bool cpu_is_isolated(int cpu) {
> 	return true;
> }
> #endif

That is too conservative from my point of view. We can have further 
discussion when a patch is ready.

Cheers,
Longman

