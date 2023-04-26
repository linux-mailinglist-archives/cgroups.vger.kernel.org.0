Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF976EF637
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbjDZOTk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 10:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjDZOTj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 10:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F256E87;
        Wed, 26 Apr 2023 07:19:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5058D62CE6;
        Wed, 26 Apr 2023 14:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537B7C433D2;
        Wed, 26 Apr 2023 14:19:26 +0000 (UTC)
Date:   Wed, 26 Apr 2023 10:19:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] memcg: OOM log improvements
Message-ID: <20230426101922.49a66ee6@gandalf.local.home>
In-Reply-To: <20230426133919.1342942-1-yosryahmed@google.com>
References: <20230426133919.1342942-1-yosryahmed@google.com>
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

On Wed, 26 Apr 2023 13:39:17 +0000
Yosry Ahmed <yosryahmed@google.com> wrote:

> The series uses seq_buf_do_printk() which was only recently introduced
> [1]. It did not land in Linus's tree yet, but ideally it will land this
> merge window. I thought I would share the patches meanwhile for
> feedback.
> 
> [1]https://lore.kernel.org/lkml/20230415100110.1419872-1-senozhatsky@chromium.org/

FYI, it's running through my tests right now (with several other patches).

If everything passes, I'll let it sit in linux-next for a day or two than
push to Linus at the end of the week.

-- Steve
