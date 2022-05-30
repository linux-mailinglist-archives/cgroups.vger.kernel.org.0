Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916F53888A
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 23:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiE3VRR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiE3VRQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 17:17:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A524BB9F;
        Mon, 30 May 2022 14:17:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE2BCB80EF5;
        Mon, 30 May 2022 21:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C217C385B8;
        Mon, 30 May 2022 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653945432;
        bh=aXsj1AN3iBU3BXc0wD+tbUHvcr/SpDhRS0i5ip2Fcl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q3B/aOrqXsxw/hc5+6ZVsej/3uJqaMiGaW+7fR+NImiQeu4ORuUaQQE8mOE9NDECH
         lxW5h+8c7Rqvbtz53LzjdCSZ9LK4CMcNT8D5zIlUOxI2ybjChjYcFYfpFtbYpQYSJn
         Gyi9yVtiJxVuHdQBYMqy4NfacbOFu1m7vQ/NURxw=
Date:   Mon, 30 May 2022 14:17:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-Id: <20220530141711.6cf70dcf200e28aa40407f6e@linux-foundation.org>
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 30 May 2022 15:49:08 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> This version is rebased on v5.18.

Not a great choice of base, really.  mm-stable or mm-unstable or
linux-next or even linus-of-the-day are all much more up to date.

Although the memcg reviewer tags are pretty thin, I was going to give
it a run.  But after fixing a bunch of conflicts I got about halfway
through then gave up on a big snarl in get_obj_cgroup_from_current().

> RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/

Surprising, that was over a year ago.  Why has is taken so long?

