Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3148C339C76
	for <lists+cgroups@lfdr.de>; Sat, 13 Mar 2021 07:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhCMGvs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Mar 2021 01:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbhCMGvd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 13 Mar 2021 01:51:33 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67068C061574;
        Fri, 12 Mar 2021 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=TwM+34ovqWzke2UroJ5Fb4rXHMkhYWeBFaPdq+c3MEY=; b=vAla+2hs9fXA6ziQtEpcwEIPBP
        pAudnvS3kBR/tnbbsZlXTGQtJPjNZ58YTLej24+Rl4N3lxEGjreB0FeKLGRb/bReWrO/syCYj+UTm
        6SN2qU5tl9rt4Z+aHj8s218mP4GwkxQ1c6xfXGKJdIFNW/rDw7OhV68sELuQP9/ozjVkR3BAwlhOs
        K4yak9IhNu6sX10SXvZJ+sN5TQcaOWMsBE+fTecMdSFGvGo9eG1PtsBIjaFQD2u1VFVK5gZ5XNwe4
        Y8Gz126N4sylodBm4SCwSFGfKjlv8BVzTBUtj335Y8W4iEYQ3wU3YEPEQvZe4lh+WX9E7e6+TRtUe
        nhnIOr+g==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKy7O-0017jJ-8z; Sat, 13 Mar 2021 06:51:29 +0000
Subject: Re: [PATCH] docs: admin-guide: cgroup-v1: Fix typos in the file
 memory.rst
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210313061029.28024-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f3a59b47-5706-4da9-f6f6-b325b2edd289@infradead.org>
Date:   Fri, 12 Mar 2021 22:51:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210313061029.28024-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/12/21 10:10 PM, Bhaskar Chowdhury wrote:
> 
> s/overcommited/overcommitted/
> s/Overcommiting/Overcommitting/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> index 52688ae34461..0d574fd3f8e3 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -360,8 +360,8 @@ U != 0, K = unlimited:
> 
>  U != 0, K < U:
>      Kernel memory is a subset of the user memory. This setup is useful in
> -    deployments where the total amount of memory per-cgroup is overcommited.
> -    Overcommiting kernel memory limits is definitely not recommended, since the
> +    deployments where the total amount of memory per-cgroup is overcommitted.
> +    Overcommitting kernel memory limits is definitely not recommended, since the
>      box can still run out of non-reclaimable memory.
>      In this case, the admin could set up K so that the sum of all groups is
>      never greater than the total memory, and freely set U at the cost of his
> --


-- 
~Randy

