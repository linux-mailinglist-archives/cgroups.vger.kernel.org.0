Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B850645191
	for <lists+cgroups@lfdr.de>; Wed,  7 Dec 2022 02:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLGByZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Dec 2022 20:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLGBx7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Dec 2022 20:53:59 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329B3AB
        for <cgroups@vger.kernel.org>; Tue,  6 Dec 2022 17:52:33 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-142b72a728fso19664810fac.9
        for <cgroups@vger.kernel.org>; Tue, 06 Dec 2022 17:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2g4EnU2Zj/9WIHBvH/VdPM01QEtKqmAnMzJgcZ6VHQ=;
        b=qApXaWmIPSsbt1t37N/UXspIRY2YX9G+lCexd6I3+q6DAhcxsVtC5HiGEtNK+yKsla
         fR5UsohH8fXItmA4XTxpP+SWfNUOP6XeF7COYuJhZ2CCNwm6hOTCPy8fm6TzWBrx1cOC
         tYSILyxmygDVz91nN0ryG2YtYMT7+JzTDgNBIBbZb+WOJsypItnaG1ncTsMp2zqGaZMm
         feEYFcfotDSARSmqNRvtE4qiibFVHHWf5vwwoy0DFxFgN+j5ExbVRoG6P9Qpu5OD2dhD
         Bd8sp/0CuRHT2nZ8/5uuq9OOF9Dgh8lToFyOEbRhV+EDLbRGT4zlvs4W7ik63KUpAUU+
         sKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2g4EnU2Zj/9WIHBvH/VdPM01QEtKqmAnMzJgcZ6VHQ=;
        b=ueVXQDr0zzcXo7gclFCPZpm/WCNek72+D6V0EuUCkxPsEYM/gEZhzT0CDs3U2JTMAp
         38KvC20wp2QneTwqjSJyPJ3FZYtMDtQkCMNXY/y/egi3C7JfVMnSKgh8gOv3YrOV/Yr9
         bEu+ozmT71VxkY9gAplfY5WRFE5xIsnIVd+6Ev2TJ1UY0eMO+PLUrg89onjw6BrGbkQY
         gLPuOC+n7QPhbLH9vtSiymMRD1UOXXEM0jrT3SnkVeXVBKXUDYtSrIAdw3zSn1O+g2F5
         fxdKplzWQ4S1Q3K1IIElDqWRG6C3/i+WSkhPltnUWdGfjfGD7gfPH3+0YbdEpnoX93ie
         AQfg==
X-Gm-Message-State: ANoB5pmTbr6lgHzd26nF324QPt+LQgpaUe0mkL5rIkKD0NI4W22f6f6e
        ks/ifH0mkXQf2iedSfXQLPJUlg==
X-Google-Smtp-Source: AA0mqf4cXyGL0A42a2mTKQwSekTuTxTQXhOz0FH3P94K3qPwPpOrqkXbj3XjCtzEjrVmenSz6bWusA==
X-Received: by 2002:a05:6870:638f:b0:144:cbb4:7fd4 with SMTP id t15-20020a056870638f00b00144cbb47fd4mr2395995oap.136.1670377952773;
        Tue, 06 Dec 2022 17:52:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b24-20020a9d5d18000000b0066da36d2c45sm9763064oti.22.2022.12.06.17.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:52:32 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:52:30 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: rmap: remove lock_page_memcg()
In-Reply-To: <20221206171340.139790-3-hannes@cmpxchg.org>
Message-ID: <424a805a-28b8-afe1-ad61-f4fdc42aaa8@google.com>
References: <20221206171340.139790-1-hannes@cmpxchg.org> <20221206171340.139790-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 6 Dec 2022, Johannes Weiner wrote:

> The previous patch made sure charge moving only touches pages for
> which page_mapped() is stable. lock_page_memcg() is no longer needed.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/rmap.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index b616870a09be..32e48b1c5847 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1222,9 +1222,6 @@ void page_add_anon_rmap(struct page *page,
>  	bool compound = flags & RMAP_COMPOUND;
>  	bool first = true;
>  
> -	if (unlikely(PageKsm(page)))
> -		lock_page_memcg(page);
> -
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
>  		first = atomic_inc_and_test(&page->_mapcount);
> @@ -1262,15 +1259,14 @@ void page_add_anon_rmap(struct page *page,
>  	if (nr)
>  		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
>  
> -	if (unlikely(PageKsm(page)))
> -		unlock_page_memcg(page);
> -
> -	/* address might be in next vma when migration races vma_adjust */
> -	else if (first)
> -		__page_set_anon_rmap(page, vma, address,
> -				     !!(flags & RMAP_EXCLUSIVE));
> -	else
> -		__page_check_anon_rmap(page, vma, address);
> +	if (likely(!PageKsm(page))) {
> +		/* address might be in next vma when migration races vma_adjust */
> +		if (first)
> +			__page_set_anon_rmap(page, vma, address,
> +					     !!(flags & RMAP_EXCLUSIVE));
> +		else
> +			__page_check_anon_rmap(page, vma, address);
> +	}
>  
>  	mlock_vma_page(page, vma, compound);
>  }
> @@ -1329,7 +1325,6 @@ void page_add_file_rmap(struct page *page,
>  	bool first;
>  
>  	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> -	lock_page_memcg(page);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> @@ -1365,7 +1360,6 @@ void page_add_file_rmap(struct page *page,
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
>  	if (nr)
>  		__mod_lruvec_page_state(page, NR_FILE_MAPPED, nr);
> -	unlock_page_memcg(page);
>  
>  	mlock_vma_page(page, vma, compound);
>  }
> @@ -1394,8 +1388,6 @@ void page_remove_rmap(struct page *page,
>  		return;
>  	}
>  
> -	lock_page_memcg(page);
> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
> @@ -1451,8 +1443,6 @@ void page_remove_rmap(struct page *page,
>  	 * and remember that it's only reliable while mapped.
>  	 */
>  
> -	unlock_page_memcg(page);
> -
>  	munlock_vma_page(page, vma, compound);
>  }
>  
> -- 
> 2.38.1
> 
> 
