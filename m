Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB759A330
	for <lists+cgroups@lfdr.de>; Fri, 19 Aug 2022 20:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiHSREy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Aug 2022 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349920AbiHSREh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Aug 2022 13:04:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCED13729B;
        Fri, 19 Aug 2022 09:25:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFE46B8281F;
        Fri, 19 Aug 2022 16:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEF7C433D6;
        Fri, 19 Aug 2022 16:23:47 +0000 (UTC)
Date:   Fri, 19 Aug 2022 12:23:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] kernel: move from strlcpy with unused retval to strscpy
Message-ID: <20220819122359.050a3432@gandalf.local.home>
In-Reply-To: <Yv8lb1tUKxYlAcp8@shikoro>
References: <20220818210202.8227-1-wsa+renesas@sang-engineering.com>
        <20220818181506.0d838d02@gandalf.local.home>
        <Yv8lb1tUKxYlAcp8@shikoro>
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

On Fri, 19 Aug 2022 07:53:51 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> > But in my cases I actually do trust the source string. They are all  
> 
> The ultimate goal is to remove strlcpy entirely. My motivation is to get
> rid of the extra work for maintainers that they need to ensure that the
> author of a patch paid attention to the detail that the source string
> must be trusted.

After reading Linus's rant, I figured as much.

-- Steve
