Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87360734C47
	for <lists+cgroups@lfdr.de>; Mon, 19 Jun 2023 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjFSHTv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jun 2023 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjFSHTt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jun 2023 03:19:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7345B1A4;
        Mon, 19 Jun 2023 00:19:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 244021F38D;
        Mon, 19 Jun 2023 07:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687159186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDE22N6RhZJ008soRf2pb0Es9I9DW+ry9z9nMBOE6Qs=;
        b=GIP9IjQevaWuqsO9XKJc0QPPQQxbsj457qjoQ/Jq9JjZyaVqo02HuYv28wkIPbskWuRoj6
        rPPkhzIkTk1xQYcqXuYrg/bazd3S40oCZ04mFdwzlKWloaOe1i3PHk0Doy1lv207fqbPbU
        HXlv+iPFOCBtv1Ul82ato2iLLjC99OI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6C0A138E8;
        Mon, 19 Jun 2023 07:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W78ANpEBkGRhdQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 19 Jun 2023 07:19:45 +0000
Date:   Mon, 19 Jun 2023 09:19:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: remove unneeded header files
Message-ID: <ZJABkaSdZP+K6dOh@dhcp22.suse.cz>
References: <20230617072658.1826560-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617072658.1826560-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 17-06-23 15:26:58, Miaohe Lin wrote:
> Remove some unneeded header files. No functional change intended.

Header inclusion cleanups are certainly welcome but it would be much
more preferred to explain why those are not needed. As build test follow
ups show this is much more subtle than it seems.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d42742edfeac..a2c82a18745d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -30,14 +30,10 @@
>  #include <linux/cgroup.h>
>  #include <linux/pagewalk.h>
>  #include <linux/sched/mm.h>
> -#include <linux/shmem_fs.h>
> -#include <linux/hugetlb.h>
>  #include <linux/pagemap.h>
>  #include <linux/vm_event_item.h>
>  #include <linux/smp.h>
>  #include <linux/page-flags.h>
> -#include <linux/backing-dev.h>
> -#include <linux/bit_spinlock.h>
>  #include <linux/rcupdate.h>
>  #include <linux/limits.h>
>  #include <linux/export.h>
> @@ -66,7 +62,6 @@
>  #include <linux/sched/isolation.h>
>  #include "internal.h"
>  #include <net/sock.h>
> -#include <net/ip.h>
>  #include "slab.h"
>  #include "swap.h"
>  
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
