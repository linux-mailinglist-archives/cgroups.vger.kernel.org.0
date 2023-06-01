Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC47A71F2BB
	for <lists+cgroups@lfdr.de>; Thu,  1 Jun 2023 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFATQY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jun 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjFATQY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jun 2023 15:16:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FF184
        for <cgroups@vger.kernel.org>; Thu,  1 Jun 2023 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685646936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sTw7D4C+tdrDjUAl3eL33ndjxBJJWM8+IdlGnpSawqo=;
        b=IkeITqdXl2QMrKGfTayB+CnAoMLSkK5SwJvYNL7Eqm1w6W/SYDax7hePjEwwfNrbKrOA3u
        scEGSNJ5diy70vTcs5kIGdf/hIR308MIQos6KxDcKm4mIRlVoYyOV4Iv8vjryNXoG2pHUs
        9bgeEp5nngUGR56LLenoIQWxfhPKkTw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-VjBtih65NBieEvKm0UOqAg-1; Thu, 01 Jun 2023 15:15:30 -0400
X-MC-Unique: VjBtih65NBieEvKm0UOqAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82189800B2A;
        Thu,  1 Jun 2023 19:15:29 +0000 (UTC)
Received: from [10.22.8.52] (unknown [10.22.8.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1EA9202696C;
        Thu,  1 Jun 2023 19:15:28 +0000 (UTC)
Message-ID: <e6ae97f4-cdae-e655-d118-a11b3d679fd6@redhat.com>
Date:   Thu, 1 Jun 2023 15:15:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] Documentation: Clarify usage of memory limits
Content-Language: en-US
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230601183820.3839891-1-schatzberg.dan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/23 14:38, Dan Schatzberg wrote:
> The existing documentation refers to memory.high as the "main mechanism
> to control memory usage." This seems incorrect to me - memory.high can
> result in reclaim pressure which simply leads to stalls unless some
> external component observes and actions on it (e.g. systemd-oomd can be
> used for this purpose). While this is feasible, users are unaware of
> this interaction and are led to believe that memory.high alone is an
> effective mechanism for limiting memory.
>
> The documentation should recommend the use of memory.max as the
> effective way to enforce memory limits - it triggers reclaim and results
> in OOM kills by itself.

That is not how my understanding of memory.high works. When memory usage 
goes past memory.high, memory reclaim will be initiated to reclaim the 
memory back. Stall happens when memory.usage keep increasing like by 
consuming memory faster than what memory reclaim can recover. When 
memory.max is reached, OOM killer will then kill off the tasks.

IOW, memory consumption should not go past memory.high in normal usage 
scenario. I believe what you describe here isn't quite correct.

Cheers,
Longman

> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>   Documentation/admin-guide/cgroup-v2.rst | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f67c0829350b..e592a9364473 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1213,23 +1213,25 @@ PAGE_SIZE multiple when read back.
>   	A read-write single value file which exists on non-root
>   	cgroups.  The default is "max".
>   
> -	Memory usage throttle limit.  This is the main mechanism to
> -	control memory usage of a cgroup.  If a cgroup's usage goes
> +	Memory usage throttle limit.  If a cgroup's usage goes
>   	over the high boundary, the processes of the cgroup are
>   	throttled and put under heavy reclaim pressure.
>   
>   	Going over the high limit never invokes the OOM killer and
> -	under extreme conditions the limit may be breached.
> +	under extreme conditions the limit may be breached. The high
> +	limit should be used in scenarios where an external process
> +	monitors the limited cgroup to alleviate heavy reclaim
> +	pressure.
>   
>     memory.max
>   	A read-write single value file which exists on non-root
>   	cgroups.  The default is "max".
>   
> -	Memory usage hard limit.  This is the final protection
> -	mechanism.  If a cgroup's memory usage reaches this limit and
> -	can't be reduced, the OOM killer is invoked in the cgroup.
> -	Under certain circumstances, the usage may go over the limit
> -	temporarily.
> +	Memory usage hard limit.  This is the main mechanism to limit
> +	memory usage of a cgroup.  If a cgroup's memory usage reaches
> +	this limit and can't be reduced, the OOM killer is invoked in
> +	the cgroup. Under certain circumstances, the usage may go
> +	over the limit temporarily.
>   
>   	In default configuration regular 0-order allocations always
>   	succeed unless OOM killer chooses current task as a victim.
> @@ -1238,10 +1240,6 @@ PAGE_SIZE multiple when read back.
>   	Caller could retry them differently, return into userspace
>   	as -ENOMEM or silently ignore in cases like disk readahead.
>   
> -	This is the ultimate protection mechanism.  As long as the
> -	high limit is used and monitored properly, this limit's
> -	utility is limited to providing the final safety net.
> -
>     memory.reclaim
>   	A write-only nested-keyed file which exists for all cgroups.
>   

