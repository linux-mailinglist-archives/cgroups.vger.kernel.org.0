Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E98178C18
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 09:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCDICw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 03:02:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44927 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCDICw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 03:02:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id a10so908697ljp.11
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 00:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJwXQHOGfBvRfP8VBWg2bX3dJRR6Y/FuTLO1IQfTw1A=;
        b=Yz3sfhkQCsVRs2839qs1BfeyedHx2siPjrgeKySlIDpScCfojGKQCbXYvL39Fq3EYM
         HHQGJyPEuUTpxzf4IuJCTMQa8C2Gn3y1ANBqWZ4zlVXkkyoLFVlRGvWQ4LTj6mBNrHZU
         xOeDs9VQ4NyQhxwcungr9jQGvvJVT8rKEv72BnR3jOkYDQ9WzJY+wTzkBVKqf/lOyb/s
         lgZxU6z9GXgYBYPL5KJ2XcjhqcSfqSiyHtUFMLmLiCexiiZWysJzBYl6FpHvkJsQ1Z7r
         RQMUwPw8LxBzH/6ihsNX+3J1/vHGjtrOmbgn19h1VGvkNQrp+VNCRy1vb1zxbUV4G283
         XUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJwXQHOGfBvRfP8VBWg2bX3dJRR6Y/FuTLO1IQfTw1A=;
        b=i2SSvQgLJLZ6wkjR2f67VScJX61AYGYVEhKgHoiRDZ0/11vNDwwzWz6zHoCxNCg05V
         bBtwkUs2nXQONHD31UeKOn1BfzuNkQRQaCBuXkrbRld1jc6nBZsuUR8riZV1JO7cgDPR
         P/BXWqD+65Nr61GQjGFNwaX8HIe5/QjnNhxWGPO8XRxqsSdwytALyrKYpNC97R03JYT9
         Q3XnuIa24YZq4f7VAo4huHwqTjIGIcX6saMguRg+wtrV+9ansTxgcioPIV+ZQazDXWub
         MCE0weOUL7SbOQliRJDaeUHcZt/1PRut1AV96RyZruLSvyXCI8GK8S8HiM3lAI1vrge0
         1b0g==
X-Gm-Message-State: ANhLgQ32eA84bDiWG6MymzQr2FhWJAKa5S8KfPOOLCgExMcDuAZQS3nv
        r/AC5xiE4BnPOOXIab/PecjY9A==
X-Google-Smtp-Source: ADFU+vvkwU/GzcL4pLeLhMMhkTpWZOVBAFzfm69VarafgvEVC8sWssS6tTWvQlMWM188Qc550cKVCQ==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr1215994ljg.194.1583308970222;
        Wed, 04 Mar 2020 00:02:50 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s21sm15487953lfb.27.2020.03.04.00.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 00:02:49 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7F01F100FE1; Wed,  4 Mar 2020 11:02:48 +0300 (+03)
Date:   Wed, 4 Mar 2020 11:02:48 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/20] mm/thp: narrow lru locking
Message-ID: <20200304080248.wuj3vqlz46ehhptg@box>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583146830-169516-7-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 02, 2020 at 07:00:16PM +0800, Alex Shi wrote:
> @@ -2564,6 +2565,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  		xa_lock(&swap_cache->i_pages);
>  	}
>  
> +	/* Lru list would be changed, don't care head's LRU bit. */
> +	spin_lock_irqsave(&pgdat->lru_lock, flags);
> +
>  	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
>  		__split_huge_page_tail(head, i, lruvec, list);
>  		/* Some pages can be beyond i_size: drop them from page cache */

You change locking order WRT i_pages lock. Is it safe?

-- 
 Kirill A. Shutemov
