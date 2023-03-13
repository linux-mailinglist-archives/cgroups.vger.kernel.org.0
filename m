Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FD86B81D4
	for <lists+cgroups@lfdr.de>; Mon, 13 Mar 2023 20:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCMToh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Mar 2023 15:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMTof (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Mar 2023 15:44:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FAE5DC95
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 12:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93BD4B811DA
        for <cgroups@vger.kernel.org>; Mon, 13 Mar 2023 19:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC675C433D2;
        Mon, 13 Mar 2023 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678736672;
        bh=W94HEWIftode6/6zR57Ubi2uQZUtKVwUT0RuE4adZeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YFSLYeGI819Stzjl6ClJqdTFh/Ihg6fYTsWQvoQiC78GMGNGqG5a6KLj5e9mRpPfh
         dnPIAQIl+j99tqT3dq7ZMEWKrX4l/K2ECdNDdtXqK1+TbyzDgcljQWvIBlqMnetHE5
         OJlMJZ1aZJc+hhnYtMdNrG7sdM6aBZXF+dGGE81Q=
Date:   Mon, 13 Mar 2023 12:44:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from
 compound_head(page)
Message-Id: <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
In-Reply-To: <20230313083452.1319968-1-yosryahmed@google.com>
References: <20230313083452.1319968-1-yosryahmed@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:

> From: Hugh Dickins <hughd@google.com>
> 
> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> observed a warning from page_cgroup_ino() when reading
> /proc/kpagecgroup.

If this is the only known situation in which page_memcg_check() is
passed a tail page, why does page_memcg_check() have

	if (PageTail(page))
		return NULL;

?  Can we remove this to simplify, streamline and clarify?


