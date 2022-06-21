Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49737553739
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiFUQFC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiFUQFB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 12:05:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26B226;
        Tue, 21 Jun 2022 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=E2A5u8QnSoMuLSc5EffUox9oGwY+67AbE7UeaWIqBa0=; b=jVTclS4fLpxKLJMGDBlW0xO1Vd
        lawqGsyENs/93M71b4W1moKdogZEArIvMitxBhpmz+0XLVPhoGV+VmTnLXTSnMMp8AYgDKOCn1tGa
        cwrsCFEvN03D4f7XuVHFomvs8wpU34WjbmnTQjYf+T3lDlOUip7av9mQjc5G7Vw1hN5EgKLXqIHn9
        nUsVQRxKkFBQlznowevdLf5OpyZeLf3tgV5pW5i0M0pdIbUYa4UWRq5LO+cUxE67bxQL8udNqVomQ
        QlVa6wR2XwpN739g9Cmfqz5C9w8JAx/WGiI4yNiu3PvGF51j95mqG2d4B0znzhtd8IUfUZwqa7fEX
        xN0Y11Bg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3gID-00AUbS-E0; Tue, 21 Jun 2022 16:00:43 +0000
Message-ID: <7933e208-cd4f-2234-58cb-2e5b40e795d8@infradead.org>
Date:   Tue, 21 Jun 2022 08:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] sched: RT bandwidth interface for cgroup unified
 hierarchy
Content-Language: en-US
To:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220621123542.1444-1-zhouchengming@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220621123542.1444-1-zhouchengming@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi--

On 6/21/22 05:35, Chengming Zhou wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 176298f2f4de..3d2949e16e04 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1055,6 +1055,19 @@ All time durations are in microseconds.
>  
>  	The burst in the range [0, $MAX].
>  
> +  cpu.max.rt
> +	A read-write two value file which exists on all cgroups when

	             two-value

> +	CONFIG_RT_GROUP_SCHED enabled, to control CPU bandwidth for

	                      is enabled,

> +	RT threads in the task group.
> +
> +	The maximum bandwidth limit.  It's in the following format::
> +
> +	  $MAX $PERIOD
> +
> +	which indicates that RT threads in the group may consume upto

	                                                         up to

> +	$MAX in each $PERIOD duration.  "max" for $MAX indicates no
> +	limit.  If only one number is written, $MAX is updated.

-- 
~Randy
