Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F626550CD3
	for <lists+cgroups@lfdr.de>; Sun, 19 Jun 2022 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiFSTte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jun 2022 15:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiFSTtd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jun 2022 15:49:33 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC3F4F;
        Sun, 19 Jun 2022 12:49:32 -0700 (PDT)
Date:   Sun, 19 Jun 2022 12:49:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655668170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTYDF9D1xRBqvEkIY/ONzMnvR1i6T1Y9BCxsJP7NEik=;
        b=iL6YfmMAG2p0X/5gbwURAp46tCZ3JVCg5XQj8j0kJcfdzd8GpZcwIqK+rrSh2+DfTLgrS/
        fHu0/cvEEvB2i/JDQmg9tGfO7fv+/SvuWHRs+6CJwMgnFSjnJifTMszZdW4NvhhpIw0Y0p
        AqIgK1bpEvvdpQX1YXV1oWGvXxQUtqw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 10/11] mm: lru: add VM_BUG_ON_FOLIO to lru maintenance
 function
Message-ID: <Yq99wcC8wJ/2swzw@castle>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-11-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 03:49:18PM +0800, Muchun Song wrote:
> We need to make sure that the page is deleted from or added to the
> correct lruvec list. So add a VM_WARN_ON_ONCE_FOLIO() to catch
> invalid users.  Then the VM_BUG_ON_PAGE() in move_pages_to_lru()
> could be removed since add_page_to_lru_list() will check that.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
