Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC94A5B28EF
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIHWDB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 18:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiIHWCx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 18:02:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135573AB;
        Thu,  8 Sep 2022 15:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4B593CE20FD;
        Thu,  8 Sep 2022 22:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250DC433D6;
        Thu,  8 Sep 2022 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662674569;
        bh=8sy1ATs3JDer4J6KBpLpL/36vh5+x6IuTH2whh/yMVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x1eZtPss8z2xDuQ68b7Q5wAXvxzGWI3qEDMWP24UxzJLRN0Ko2W1T66YWttxzQSug
         fl4/D5KUwLVvlUF4thcLin9nf2YLrJqrxEww2eV1LvdGqPuFVeNXBhmHAFqIVnbKnm
         uoyYf/5C6LmYn6auMZsETC++A5gpXT7EgxuY4U8w=
Date:   Thu, 8 Sep 2022 15:02:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/memcontrol: use kstrtobool for swapaccount param
 parsing
Message-Id: <20220908150248.85fff32bf275844f0927a856@linux-foundation.org>
In-Reply-To: <20220908083452.2844125-1-liushixin2@huawei.com>
References: <20220908083452.2844125-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 8 Sep 2022 16:34:52 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -194,7 +194,7 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
>  	return 0;
>  nomem:
>  	pr_info("couldn't allocate enough memory for swap_cgroup\n");
> -	pr_info("swap_cgroup can be disabled by swapaccount=0 boot option\n");
> +	pr_info("swap_cgroup can be disabled by swapaccount=[oO][Ff]/N/n/0 boot option\n");

I'm not sure this really needed changing.  "=0" was OK and the message
now looks rather silly.  But whatever.
