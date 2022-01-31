Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D94A5277
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 23:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiAaWgZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 17:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiAaWgY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 17:36:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8983CC061714;
        Mon, 31 Jan 2022 14:36:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4069CB82C8D;
        Mon, 31 Jan 2022 22:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56872C340E8;
        Mon, 31 Jan 2022 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643668581;
        bh=1JoJCnoSkTjuoMaPr44ixmEVlbNRYqEL/DOdLmDrv1k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDvZuVHYqwuPV46o0TbHvDZjgaF9tt1yumFPV8NdVibS+QJwS4/uFLexxFzrTmkBd
         PvdDP7T1WiOpe6ADElmDyXx+qLwjBwUnMTSKNIMCWK5F5JCCSE7uLWzVjjobUm4BD6
         Erv5O5Vhdaf1Yc4OA2QlAIX4f80bBdqqrWhrTorI=
Date:   Mon, 31 Jan 2022 14:36:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, guro@fb.com, vbabka@suse.cz,
        willy@infradead.org, songmuchun@bytedance.com, shy828301@gmail.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-Id: <20220131143620.b619f24f5246b26bce2b717d@linux-foundation.org>
In-Reply-To: <20220131014742.oxcrctcg6sqwvzij@master>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
        <20220131014742.oxcrctcg6sqwvzij@master>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 31 Jan 2022 01:47:42 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> Hi, Andrew
> 
> Would you pick up this patch set, or prefer me to send a v2?
> 

It's unclear to me what's happening with [4/4].  At least a new
changelog with more justification is expected?

So yes, please resend?
