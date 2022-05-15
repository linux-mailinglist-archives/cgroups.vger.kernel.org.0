Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC79527A81
	for <lists+cgroups@lfdr.de>; Mon, 16 May 2022 00:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiEOWGs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 May 2022 18:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiEOWGr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 May 2022 18:06:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D67205D5;
        Sun, 15 May 2022 15:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFA49B80E66;
        Sun, 15 May 2022 22:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0803EC385B8;
        Sun, 15 May 2022 22:06:41 +0000 (UTC)
Date:   Sun, 15 May 2022 18:06:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Vasily Averin <vvs@openvz.org>, Shakeel Butt <shakeelb@google.com>,
        Ingo Molnar <mingo@redhat.com>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        "linux-trace-users@vger.kernel.org" 
        <linux-trace-users@vger.kernel.org>
Subject: Re: [PATCH v2] percpu: improve percpu_alloc_percpu event trace
Message-ID: <20220515180640.0ae2ead5@gandalf.local.home>
In-Reply-To: <YnsgbXKiNNSF+1ZO@carbon>
References: <2b388d09-940e-990f-1f8a-2fdaa9210fa0@openvz.org>
        <a07be858-c8a3-7851-9086-e3262cbcf707@openvz.org>
        <YnsgbXKiNNSF+1ZO@carbon>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 May 2022 19:33:17 -0700
Roman Gushchin <roman.gushchin@linux.dev> wrote:

>  --- a/include/trace/events/percpu.h
> > +++ b/include/trace/events/percpu.h
> > @@ -6,15 +6,20 @@
> >  #define _TRACE_PERCPU_H
> >  
> >  #include <linux/tracepoint.h>
> > +#include <trace/events/mmflags.h>
> >  
> >  TRACE_EVENT(percpu_alloc_percpu,
> >  
> > -	TP_PROTO(bool reserved, bool is_atomic, size_t size,
> > -		 size_t align, void *base_addr, int off, void __percpu *ptr),
> > +	TP_PROTO(unsigned long call_site,
> > +		 bool reserved, bool is_atomic, size_t size,
> > +		 size_t align, void *base_addr, int off,
> > +		 void __percpu *ptr, size_t bytes_alloc, gfp_t gfp_flags),  
> 
> Don't we want to preserve the order and add the call_site at the end?
> Trace events are not ABI, but if we don't have a strong reason to break it,
> I'd preserve the old order.

Ideally everyone should be using libtraceevent which will parse the format
file for the needed entries.

Nothing (important) should be parsing the raw ascii from the trace files.
It's slow and unreliable. The raw format (trace_pipe_raw) files, along with
libtraceevent will handle fining the fields you are looking for, even if
the fields move around (internally or externally).

Then there's trace-cruncher (a python script that uses libtracefs and
libtraceevent) that will work too.

  https://github.com/vmware/trace-cruncher

-- Steve
