Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95723520668
	for <lists+cgroups@lfdr.de>; Mon,  9 May 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiEIVKW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiEIVKL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 17:10:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6B269EEA;
        Mon,  9 May 2022 14:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3638661713;
        Mon,  9 May 2022 21:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8E1C385BA;
        Mon,  9 May 2022 21:06:06 +0000 (UTC)
Date:   Mon, 9 May 2022 17:06:05 -0400
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
Message-ID: <20220509170605.2eb7637e@gandalf.local.home>
In-Reply-To: <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
References: <8d627f02-183f-c4e7-7c15-77b2b438536b@openvz.org>
        <202205070420.aAhuqpYk-lkp@intel.com>
        <e1c09bbb-2c58-a986-c704-1db538da905a@openvz.org>
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

On Sat, 7 May 2022 17:51:16 +0300
Vasily Averin <vvs@openvz.org> wrote:

> The same messages are generated for any other gfp_t argument in trace events.
> As far as I understand it is not a bug per se,
> but trace macros lacks __force attribute in 'gfp_t'-> 'unsigned long' casts.
> The same thing happens with mode_t and with some other places using __print_flags()
> for __bitwise marked types.

I'm curious as to where the gfp_t to unsigned long is happening in the
macros?

-- Steve
