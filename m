Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF86762064
	for <lists+cgroups@lfdr.de>; Tue, 25 Jul 2023 19:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGYRnP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGYRnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 13:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256AC1B8;
        Tue, 25 Jul 2023 10:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB9F161839;
        Tue, 25 Jul 2023 17:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F20C433C8;
        Tue, 25 Jul 2023 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690306992;
        bh=fu3IBUmM1hIiTky2e88ZAQ1t8ZP4sqKPRBI5GS1mp2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xoVJF9/q0IT6pL9/yc5wwBX7EHfCwvlEl4/DiYssHgWeqQNMhcfXcGDzScpcyCIMd
         tlnZ8bZIOgFu+gE3EABqIhknibOnNkJ9hjO7Qa23BWJSdiOehqY3no7LPHsYODoLUE
         rXXfP+4vkrQHN/YDiIx2d2B+GU/qfbLduSUExjYY=
Date:   Tue, 25 Jul 2023 10:43:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
Message-Id: <20230725104310.ac652a03ab92357a162b1f92@linux-foundation.org>
In-Reply-To: <20230725140435.GB1146582@cmpxchg.org>
References: <20230719174613.3062124-1-yosryahmed@google.com>
        <20230725140435.GB1146582@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 25 Jul 2023 10:04:35 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> But I want to be clear: this isn't a regression fix. It's a new
> performance optimization for the deprecated cgroup1 code. And it comes
> at the cost of higher memory footprint for both cgroup1 AND cgroup2.

Thanks.

Yosry, could you please send along a suitably modified changelog?
