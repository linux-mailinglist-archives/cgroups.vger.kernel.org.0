Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC97CE9D6
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 23:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjJRVNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjJRVN0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 17:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19537FE;
        Wed, 18 Oct 2023 14:12:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D02C433C8;
        Wed, 18 Oct 2023 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697663534;
        bh=v0mycPn3E3zjUT2kT9+qpZamlgS19LMrA2IlGjIHwWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lu1T455un28uaa0f21CJNoJiCVebBrEeT+s1wLlK947EmPR8JPfQuJuyu8/OfEnSo
         i9o59Rm6NviZT5byWy9C3pPKUwE7IB6jy1iBtFTUJT4m0W6E3t6AN8dOcphCMwMK4Y
         7qG1XlNzgpJZbL6n3xQT3tSym36HYNrpcmkYhywE=
Date:   Wed, 18 Oct 2023 14:12:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?ISO-8859-1?Q? "Michal_?= =?ISO-8859-1?Q?Koutn=FD" ?= 
        <mkoutny@suse.com>, Waiman Long <longman@redhat.com>,
        kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: memcg: subtree stats flushing and thresholds
Message-Id: <20231018141213.b80ad9742d41dd11fb122e10@linux-foundation.org>
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
References: <20231010032117.1577496-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 Oct 2023 03:21:11 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> This series attempts to address shortages in today's approach for memcg
> stats flushing, namely occasionally stale or expensive stat reads. The
> series does so by changing the threshold that we use to decide whether
> to trigger a flush to be per memcg instead of global (patch 3), and then
> changing flushing to be per memcg (i.e. subtree flushes) instead of
> global (patch 5).
> 
> Patch 3 & 5 are the core of the series, and they include more details
> and testing results. The rest are either cleanups or prep work.
> 
> This series replaces the "memcg: more sophisticated stats flushing"
> series [1], which also replaces another series, in a long list of
> attempts to improve memcg stats flushing. It is not a new version of
> the same patchset as it is a completely different approach. This is
> based on collected feedback from discussions on lkml in all previous
> attempts. Hopefully, this is the final attempt.

Seems that Shakeel's performance concerns have largely been set aside. 
It would be good to have some affirmative input on this patchset from
the memcg developers, please?
