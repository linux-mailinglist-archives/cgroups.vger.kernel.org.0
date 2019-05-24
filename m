Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1A29BC1
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbfEXQET (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 12:04:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389962AbfEXQET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=udHsjQBKP68t9TZ4H27l2j3R7dmm1NcGJYaKWehd8PE=; b=Ji/F2CZobt5eaIwXFU270PPtZ
        lWbro9qD58JzH3u5iSrGABrhavNQGlQG9qOowF/I85/KPNwLZ/LLPJ3k03wbqOSNrdWu7Vcl8p4KU
        bUFsA2uPdJWh2n12f6c/VJBEQA2R1g88Oc8wLksp4s/GZSbW6SV1861BU2uUfdKtbl1HxRwp8L6yb
        SFtMKbaNlRT/dD+kfvCgm+8cbrjk3onqOCJChb5H0SKJuXWv8jpQrNEtNSZGLej37oK//Zql4ElqN
        XfEldQJv31OFhsagwQYQolonLFHt5VjX4CxLIAY99YW1Ib0FJB/8j9g29HrB6scmWY36BOpf2/h1Q
        4/QI6Oc/w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hUCg6-0000DK-3y; Fri, 24 May 2019 16:04:18 +0000
Date:   Fri, 24 May 2019 09:04:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: fix page cache convergence regression
Message-ID: <20190524160417.GB1075@bombadil.infradead.org>
References: <20190524153148.18481-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524153148.18481-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 24, 2019 at 11:31:48AM -0400, Johannes Weiner wrote:
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 0e01e6129145..cbbf76e4c973 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -292,6 +292,7 @@ struct xarray {
>  	spinlock_t	xa_lock;
>  /* private: The rest of the data structure is not to be used directly. */
>  	gfp_t		xa_flags;
> +	gfp_t		xa_gfp;
>  	void __rcu *	xa_head;
>  };

No.  I'm willing to go for a xa_flag which says to use __GFP_ACCOUNT, but
you can't add another element to the struct xarray.

We haven't even finished the discussion from yesterday.  I'm going to
go back to that thread and keep discussing there.
