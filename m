Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E40B546FD8
	for <lists+cgroups@lfdr.de>; Sat, 11 Jun 2022 01:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244438AbiFJXI1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 19:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344836AbiFJXI0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 19:08:26 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161FAFD24;
        Fri, 10 Jun 2022 16:08:25 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:08:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654902503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7qscO1Vtb3X66YSDizljaZgEO4PdhU7TjZ1ZnrPRUo=;
        b=ZtiKgrfdV4L1XyviDb233nRIQBlSe9wmuFm6YDm+4CalI0EPaZbRXv2lNJK3+HtxrWskCh
        YbefZi4UBEK0dEtaQ2fz8mermVf8mItetmiXscBb/PV/Q5UbH1NdG5UOTU1s0nHZ7yiSJM
        Q1KDlojAGVtO+bOpJoAR/0KBVopsi20=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 02/11] mm: rename unlock_page_lruvec{_irq,
 _irqrestore} to lruvec_unlock{_irq, _irqrestore}
Message-ID: <YqPO4YhRJq7gTsjV@carbon>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530074919.46352-3-songmuchun@bytedance.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 30, 2022 at 03:49:10PM +0800, Muchun Song wrote:
> It is weird to use folio_lruvec_lock() variants and unlock_page_lruvec() variants
> together, e.g. locking folio and unlocking page.  So rename
> unlock_page_lruvec{_irq, _irqrestore} to lruvec_unlock{_irq, _irqrestore}.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Looks nice!

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
