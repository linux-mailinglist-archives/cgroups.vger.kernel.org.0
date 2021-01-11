Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747412F2043
	for <lists+cgroups@lfdr.de>; Mon, 11 Jan 2021 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391232AbhAKUAV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Jan 2021 15:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391167AbhAKUAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Jan 2021 15:00:21 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8741C0617A3
        for <cgroups@vger.kernel.org>; Mon, 11 Jan 2021 11:59:41 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB4C39A8;
        Mon, 11 Jan 2021 19:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB4C39A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610395141; bh=yf8HXOWRvdcuSnkyWSAQrcyC0WoHCnnhgqdxfI1KLHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o0Dwx6XAsQldlWrc8nl1E00cGU3JDMHBOz/DG7sQGIyNcvRvgPYmY2R77c7IxEOnN
         EruGAbSIBfDJLP5dxLtsQyQJBYRKwhhWcYcPfApEffams/+YCPWbVpNz9Y8otFQcVu
         6P6lj7F01H9EpiHey0/y4TgZCC9v+nPr+GQH4oz+dyFW32JFHAtmgHdFjQdVPUX5tl
         tIqw4M1DLaCf4N/FQw+Jz77up7FOQDZYrZDk0DEWfHB2bsKxPkk5JdqNnHka/DmqFa
         Pc5MnrelFPb9Jg6Yc5oV8YouOvIeORonfPysqbTVJ8HXPL/n3W4yHVy8X+C6tGVdud
         iuO5UMYPY8iRg==
Date:   Mon, 11 Jan 2021 12:58:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jiang Biao <benbjiang@gmail.com>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Biao <benbjiang@tencent.com>
Subject: Re: [PATCH] Documentation: Fix typos found in cgroup-v2.rst
Message-ID: <20210111125859.392a5bba@lwn.net>
In-Reply-To: <20210107141118.9530-1-benbjiang@tencent.com>
References: <20210107141118.9530-1-benbjiang@tencent.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu,  7 Jan 2021 22:11:18 +0800
Jiang Biao <benbjiang@gmail.com> wrote:

> Fix typos found in Documentation/admin-guide/cgroup-v2.rst.
> 
> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 63521cd36ce5..e0f6ff7cfa93 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1558,7 +1558,7 @@ IO Interface Files
>  	  8:0 rbytes=90430464 wbytes=299008000 rios=8950 wios=1252 dbytes=50331648 dios=3021
>  
>    io.cost.qos
> -	A read-write nested-keyed file with exists only on the root
> +	A read-write nested-keyed file which exists only on the root
>  	cgroup.
>  
>  	This file configures the Quality of Service of the IO cost
> @@ -1613,7 +1613,7 @@ IO Interface Files
>  	automatic mode can be restored by setting "ctrl" to "auto".
>  
>    io.cost.model
> -	A read-write nested-keyed file with exists only on the root
> +	A read-write nested-keyed file which exists only on the root
>  	cgroup.

Applied, thanks.

jon
