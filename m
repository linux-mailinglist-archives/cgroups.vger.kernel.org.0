Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7445226F8
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 00:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiEJWkn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 18:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEJWkm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 18:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518181FA70;
        Tue, 10 May 2022 15:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C908461811;
        Tue, 10 May 2022 22:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7375C385D1;
        Tue, 10 May 2022 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652222439;
        bh=Uep9omWAHUgcNmftnhT+OxXsLVstbaEvQlnJP1mh//w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aU3hfLPZDr+uUiq73DIBtXvAfY5S2GiWrylBB7qJs04cVSM3a032pbem+F+SzA3nD
         NmTFsl/iikJ9L8A13NTBsku9/0KwxWXCPXKeZ6/c0JvI6ckcVLMmTGJmlWcWt3QzJh
         PiasBPNTr9le1p4IUa0r4IApkoasZ/VAVs0RChD0=
Date:   Tue, 10 May 2022 15:40:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/6] mm: Kconfig: group swap, slab, hotplug and thp
 options into submenus
Message-Id: <20220510154037.c7916ee9d7de90eedd12f92c@linux-foundation.org>
In-Reply-To: <20220510152847.230957-4-hannes@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
        <20220510152847.230957-4-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 10 May 2022 11:28:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> There are several clusters of related config options spread throughout
> the mostly flat MM submenu. Group them together and put specialization
> options into further subdirectories to make the MM submenu a bit more
> organized and easier to navigate.

Causes

hp2:/usr/src/25> make allnoconfig

WARNING: unmet direct dependencies detected for ARCH_WANT_GENERAL_HUGETLB
  Depends on [n]: TRANSPARENT_HUGEPAGE [=n]
  Selected by [y]:
  - X86 [=y]

WARNING: unmet direct dependencies detected for ARCH_WANTS_THP_SWAP
  Depends on [n]: TRANSPARENT_HUGEPAGE [=n]
  Selected by [y]:
  - X86 [=y] && X86_64 [=y]
#
# configuration written to .config
#


I'll disable this and [4/6] for now.
