Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFBA75E4E2
	for <lists+cgroups@lfdr.de>; Sun, 23 Jul 2023 22:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGWUhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Jul 2023 16:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWUhm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Jul 2023 16:37:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232E0E49;
        Sun, 23 Jul 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qy3ZfgxHtTZ+H6cA0c7w6ZZsFamgKKUHdZT7/5uteAk=; b=kTr4Znvd56MMHUXN0EHN8A34Ch
        yiVFzsJ9la7YOzyYLmo8iAxAVQiM+usii43xNwFPgEB3Dm89Ext45zyoZLgfbRA4T8YE2AeEfACaF
        hdlN4RXUJW4jvNU4NOJzGo99BTK+HQo9ASaYlCCYkYPE+iNCCcK8LV1kVkn/JsqOaCl/XMoyn0hJx
        RQw2aR4JbD5kt7Z+XuffKRiNWeewjEJlhH9GuiZ0SgDFWquMWUKmsqdV/kHmkhcqVJkPVS4IHakPG
        tjL6ymvrdGUk+ht5MZQDwVUrFlesfweWrITUN076QSLeriL/Y/lb2HtYOOEDJfCYwzH0LEY4YDomT
        0eS8ohCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNfpX-003aTh-8Y; Sun, 23 Jul 2023 20:37:27 +0000
Date:   Sun, 23 Jul 2023 21:37:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: fix obsolete function name in
 mem_cgroup_protection()
Message-ID: <ZL2Ph5g05Ud5vAdT@casper.infradead.org>
References: <20230723032538.3190239-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723032538.3190239-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jul 23, 2023 at 11:25:38AM +0800, Miaohe Lin wrote:
> @@ -582,9 +582,9 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
>  	/*
>  	 * There is no reclaim protection applied to a targeted reclaim.
>  	 * We are special casing this specific case here because
> -	 * mem_cgroup_protected calculation is not robust enough to keep
> -	 * the protection invariant for calculated effective values for
> -	 * parallel reclaimers with different reclaim target. This is
> +	 * mem_cgroup_calculate_protection calculation is not robust enough
> +	 * to keep the protection invariant for calculated effective values
> +	 * for parallel reclaimers with different reclaim target. This is
>  	 * especially a problem for tail memcgs (as they have pages on LRU)
>  	 * which would want to have effective values 0 for targeted reclaim
>  	 * but a different value for external reclaim.

This reads a little awkwardly now.  How about:

 	 * We are special casing this specific case here because
-	 * mem_cgroup_protected calculation is not robust enough to keep
+	 * mem_cgroup_calculate_protection is not robust enough to keep
 	 * the protection invariant for calculated effective values for
	 * parallel reclaimers with different reclaim target. This is
