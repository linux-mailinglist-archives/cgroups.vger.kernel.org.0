Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276275229EA
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 04:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiEKCrR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 22:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiEKCd2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 22:33:28 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69D994EA;
        Tue, 10 May 2022 19:33:26 -0700 (PDT)
Date:   Tue, 10 May 2022 19:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652236405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/7S2Nfdl9mg+NTUlm8YRagGmVcuRP9spTCxvE0H5V8=;
        b=vBWdSRKNrRSnj63/2q34r3/NwsV2orkeonfypPwEqGznWLw2L0Fz8zfCr/hxvZ99MgLFvr
        WXMEKbGUubwgtQ2jbWiF1CSeAE8kxPdzTlzkXm3kZhuot9A3XTqfPMRehOC6DjskJh353p
        ILl2YaVkng/sfDDk+asuaFioScNzVjo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2] percpu: improve percpu_alloc_percpu event trace
Message-ID: <YnsgbXKiNNSF+1ZO@carbon>
References: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
 <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 06, 2022 at 10:29:25PM +0300, Vasily Averin wrote:
> Added call_site, bytes_alloc and gfp_flags fields to the output
> of the percpu_alloc_percpu ftrace event:
> 
> mkdir-4393  [001]   169.334788: percpu_alloc_percpu:
>  call_site=mem_cgroup_css_alloc+0xa6 reserved=0 is_atomic=0 size=2408 align=8
>   base_addr=0xffffc7117fc00000 off=402176 ptr=0x3dc867a62300 bytes_alloc=14448
>    gfp_flags=GFP_KERNEL_ACCOUNT
> 
> This is required to track memcg-accounted percpu allocations.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

LGTM, thanks Vasily!

One minor thing below.

> ---
> v2: added call_site, improved patch description
> ---
>  include/trace/events/percpu.h | 23 +++++++++++++++++------
>  mm/percpu-internal.h          |  8 ++++----
>  mm/percpu.c                   |  5 +++--
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
> index df112a64f6c9..e989cefc0def 100644
> --- a/include/trace/events/percpu.h
> +++ b/include/trace/events/percpu.h
> @@ -6,15 +6,20 @@
>  #define _TRACE_PERCPU_H
>  
>  #include <linux/tracepoint.h>
> +#include <trace/events/mmflags.h>
>  
>  TRACE_EVENT(percpu_alloc_percpu,
>  
> -	TP_PROTO(bool reserved, bool is_atomic, size_t size,
> -		 size_t align, void *base_addr, int off, void __percpu *ptr),
> +	TP_PROTO(unsigned long call_site,
> +		 bool reserved, bool is_atomic, size_t size,
> +		 size_t align, void *base_addr, int off,
> +		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),

Don't we want to preserve the order and add the call_site at the end?
Trace events are not ABI, but if we don't have a strong reason to break it,
I'd preserve the old order.

Thanks!
