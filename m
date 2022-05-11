Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05E523B91
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbiEKRas (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 13:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbiEKRar (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 13:30:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70587FF7;
        Wed, 11 May 2022 10:30:46 -0700 (PDT)
Date:   Wed, 11 May 2022 10:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652290243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hGt3BnCoU4kW+K89I9JK4z3L3KmFUi2s6F9PRzSqJy4=;
        b=je+mlCfAdY+4OyJgDBp5E3GBVuEBLdvt6J+eoOdJnIYkin2GEDUy3o1Xu4pmthPdnADjnW
        y1H2V1XbN5Q/fcQSXljhOoimbX3DNpiiDGnDR+z0zWakiPMO6Msv/BaB0DNLnlU7MSn595
        ruFFuRlABf7+uSqATZ77rTKjlERBqG0=
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
Message-ID: <YnvyvaPWONjULpIa@carbon>
References: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
 <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org>
 <YnsgbXKiNNSF+1ZO@carbon>
 <30a47b4e-7c4b-cd2d-998d-cfaf8d12d342@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a47b4e-7c4b-cd2d-998d-cfaf8d12d342@openvz.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 08:11:54AM +0300, Vasily Averin wrote:
> On 5/11/22 05:33, Roman Gushchin wrote:
> > On Fri, May 06, 2022 at 10:29:25PM +0300, Vasily Averin wrote:
> >>  TRACE_EVENT(percpu_alloc_percpu,
> >>  
> >> -	TP_PROTO(bool reserved, bool is_atomic, size_t size,
> >> -		 size_t align, void *base_addr, int off, void __percpu *ptr),
> >> +	TP_PROTO(unsigned long call_site,
> >> +		 bool reserved, bool is_atomic, size_t size,
> >> +		 size_t align, void *base_addr, int off,
> >> +		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),
> > 
> > Don't we want to preserve the order and add the call_site at the end?
> > Trace events are not ABI, but if we don't have a strong reason to break it,
> > I'd preserve the old order.
> 
> I checked recent trace patches and found that order changes is acceptable.
> 
> commit 8c39b8bc82aafcc8dd378bd79c76fac8e8a89c8d
> Author: David Howells <dhowells@redhat.com>
> Date:   Fri Jan 14 11:44:54 2022 +0000
> 
>     cachefiles: Make some tracepoint adjustments
> 
> -           TP_printk("o=%08x i=%lx e=%d",
> -                     __entry->obj, __entry->ino, __entry->error)
> +           TP_printk("o=%08x dB=%lx B=%lx e=%d",
> +                     __entry->obj, __entry->dino, __entry->ino, __entry->error)
> 
> On the other hand I'm agree to keep old order by default.
> that's why I added bytes_alloc and gfp_flags to end of output.
> However I think call_site is an exception. In all cases found, 
> call_site is output first.
> For me personally it simplified output parsing.
> 
> So I would like to know Steven's position on this question.

Ok, not a strong opinion, I think both options are acceptable.

Thanks!
