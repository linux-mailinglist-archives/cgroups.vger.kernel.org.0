Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F26E50A813
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiDUSas (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389167AbiDUSaq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 14:30:46 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F0277;
        Thu, 21 Apr 2022 11:27:56 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:27:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650565674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NLNyYOb3KLGGVorwsN8XSXsL2aBq/Eak31L0IM28kbY=;
        b=WXc9PPWlfnoWGuoV9R1mzgCuJPRJaSm/d6dMbgm9Is9eDUq9uvc5xXqmz+VUIl33nQ8Llr
        rjwy+CbrlzOjMBE9ycR3KCbpL/NpjwWOpIFMhBycu/uXDRMrrraouu3GI0bPwD2eu2kWHj
        G88okiSLmUCFFaNdFPxdTEPnOncZpZo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next] mm/memcontrol.c: remove unused private flag of
 memory.oom_control
Message-ID: <YmGiJYFUWjYQkovG@carbon>
References: <20220421122755.40899-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421122755.40899-1-lujialin4@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 21, 2022 at 08:27:55PM +0800, Lu Jialin wrote:
> There is no use for the private value, __OOM_TYPE and OOM notifier
> OOM_CONTROL. Therefore remove them to make the code clean.
> 
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
