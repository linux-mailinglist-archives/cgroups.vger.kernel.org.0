Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A4C76FA39
	for <lists+cgroups@lfdr.de>; Fri,  4 Aug 2023 08:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHDGiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Aug 2023 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjHDGhv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Aug 2023 02:37:51 -0400
Received: from out-115.mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0528B468A
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 23:37:40 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691131056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGE7IlwwlQoLXGjaNOVIcJyf2once2coPl7qKdP4X7c=;
        b=eXtrKGg9hj64tjMqlRwEdhExZl+fcIsOGj6fMR5eIidNPFrRSEz/JTeYqWy7oof1QW0WwS
        4eZf32iOkbIBdkOiUNoofWKgK21mPqYwxVuvDaZehAs/6W56yyKfloTXJD21IsXMdBctU/
        il7uSAK3OP/3XO4/Dazm3/eRnSnQPL4=
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memcg: fix wrong function name above
 obj_cgroup_charge_zswap()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230803120021.762279-1-linmiaohe@huawei.com>
Date:   Fri, 4 Aug 2023 14:37:00 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <0C7F407E-07AD-45F2-A31B-064080DD4B1C@linux.dev>
References: <20230803120021.762279-1-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 3, 2023, at 20:00, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> The correct function name is obj_cgroup_may_zswap(). Correct the comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

