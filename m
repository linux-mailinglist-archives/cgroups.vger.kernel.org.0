Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48CC533589
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 04:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbiEYCyq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 22:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243744AbiEYCyp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 22:54:45 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DA712C9;
        Tue, 24 May 2022 19:54:41 -0700 (PDT)
Date:   Tue, 24 May 2022 19:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653447280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9r78ys+sFIRi18dVakR08V039gBRNdiX9MSBliDjxpI=;
        b=afEYlSyLJ5Xk3VJuKx26Zo0GENFgJqk9oCu0Vx/BwtysJQwObgrzcEzJPc1bjErkGbw2Lx
        r25L7BolKeJgGeXKhsltj9GcWp6BbtTtdWO5E5xHY76UFxwOd1cPXYy4Z3iDfPluyZK9id
        DWWBqP0J9yOpySzBbvxKZmLx2Syr5XE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 06/11] mm: thp: make split queue lock safe when LRU
 pages are reparented
Message-ID: <Yo2aa661fepAOvjO@carbon>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-7-songmuchun@bytedance.com>
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

On Tue, May 24, 2022 at 02:05:46PM +0800, Muchun Song wrote:
> Similar to the lruvec lock, we use the same approach to make the split
> queue lock safe when LRU pages are reparented.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Please, merge this into the previous patch (like Johannes asked
for the lruvec counterpart).

And add:
Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

Thanks!
