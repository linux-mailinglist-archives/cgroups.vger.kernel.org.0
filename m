Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE3521D08
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345053AbiEJOzq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiEJOzS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 10:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B43496AA;
        Tue, 10 May 2022 07:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAAC061679;
        Tue, 10 May 2022 14:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728F2C385C9;
        Tue, 10 May 2022 14:16:01 +0000 (UTC)
Date:   Tue, 10 May 2022 10:16:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@redhat.com>,
        kbuild-all@lists.01.org, Shakeel Butt <shakeelb@google.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH] percpu: improve percpu_alloc_percpu event trace
Message-ID: <20220510101600.48529d5e@gandalf.local.home>
In-Reply-To: <6e68298c-7cdd-9984-215e-7e6fb3d03fe8@openvz.org>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
        <202205070420.aAhuqpYk-lkp@intel.com>
        <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
        <20220509170605.2eb7637e@gandalf.local.home>
        <6e68298c-7cdd-9984-215e-7e6fb3d03fe8@openvz.org>
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

On Tue, 10 May 2022 07:22:02 +0300
Vasily Averin <vvs@openvz.org> wrote:

> ... and when  __def_gfpflag_names() traslates them to unsigned long
> 
>        {(unsigned long)GFP_DMA,                "GFP_DMA"},             \
>        {(unsigned long)__GFP_HIGHMEM,          "__GFP_HIGHMEM"},       \
>        {(unsigned long)GFP_DMA32,              "GFP_DMA32"},           \
> 
> ... it leads to sparse warnings bacuse type gfp_t was declared as 'bitwise'

Ah' it's the printing of the flag bits. Got it.

-- Steve
