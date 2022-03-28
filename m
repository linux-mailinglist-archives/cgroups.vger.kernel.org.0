Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7567C4E9F0D
	for <lists+cgroups@lfdr.de>; Mon, 28 Mar 2022 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiC1Siq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Mar 2022 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241852AbiC1Siq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Mar 2022 14:38:46 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F091CB38;
        Mon, 28 Mar 2022 11:37:03 -0700 (PDT)
Date:   Mon, 28 Mar 2022 11:36:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648492622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h9MsA+GclozGfTkyz42oHeJp6VqOMhntLWNp3G32vsA=;
        b=UJbaFFfOQmizKMVOaoqPioI2HGGuGtUMezMSWJbhRnuH1/3nZZnfcB29o8OE+4UDzrn3Gl
        JsLwZZdLt4ZDZ49HMbnXHrHNVXh9xHJf/PH759+MEmoofsgzw16STYBz9FT8RUNZOkf7cK
        KGDBEBSa3xTF2jqt4u+RmzC64sP3uRw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: remove unneeded nr_scanned
Message-ID: <YkIARkqHjA2EOjTZ@carbon.dhcp.thefacebook.com>
References: <20220328114144.53389-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328114144.53389-1-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 28, 2022 at 07:41:44PM +0800, Miaohe Lin wrote:
> The local variable nr_scanned is unneeded as mem_cgroup_soft_reclaim always
> does *total_scanned += nr_scanned. So we can pass total_scanned directly to
> the mem_cgroup_soft_reclaim to simplify the code and save some cpu cycles
> of adding nr_scanned to total_scanned.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!
