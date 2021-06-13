Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CAF3A5AEA
	for <lists+cgroups@lfdr.de>; Mon, 14 Jun 2021 01:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhFMXQp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Jun 2021 19:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbhFMXQp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Jun 2021 19:16:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2900C061574
        for <cgroups@vger.kernel.org>; Sun, 13 Jun 2021 16:14:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A2884E5;
        Sun, 13 Jun 2021 23:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A2884E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1623626083; bh=cIkUMkG6OHqOe49DDrQu02Ae9oV0J1wl7Kw82o34ayc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sTxkggdLg5D7gFlllwpB6VkSzg3Wzkb5c/i+crUTDqwDcLehTNX6WQQZcHxQ/asc6
         w8Oc1cnJdfrk1kDM7kS6OA6TnKUK3MlHtWrjohM+3wbKKQAc7+9M5TY0V6UYMhbl+2
         YJYmsaWo8L2YkR0cLh2FkFJKrvwrmOkWtQYWgOemkZ6YPX24Pi1pIWCbX1bNgIz76E
         f18ekzw23lFLa9S5qG53D/i5LQGjTz7jK1N6rUWurRY45TjL5SU/u0V9tOHkbRs+YJ
         Fbx9Jn7e36MKE1qw8kqp/Z2SR/MZkGP6k5UgfqV29+C6F4/YUgQjUYVN54DJwFIi57
         FykkC4i9mtN/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kir Kolyshkin <kolyshkin@gmail.com>, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, axboe@kernel.dk, paolo.valente@linaro.org,
        cgroups@vger.kernel.org, Kir Kolyshkin <kolyshkin@gmail.com>
Subject: Re: [PATCH 1/3] docs: block/bfq: describe per-device weight
In-Reply-To: <20210611030737.1984343-2-kolyshkin@gmail.com>
References: <20210611030737.1984343-1-kolyshkin@gmail.com>
 <20210611030737.1984343-2-kolyshkin@gmail.com>
Date:   Sun, 13 Jun 2021 17:14:42 -0600
Message-ID: <8735tlbbml.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Kir Kolyshkin <kolyshkin@gmail.com> writes:

This work looks generally good, but...

> The functionality of setting per-device weight for BFQ was added
> in v5.4 (commit 795fe54c2a828099), but the documentation was never
> updated.
>
> While at it, improve formatting a bit.
>
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  Documentation/block/bfq-iosched.rst | 38 ++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/block/bfq-iosched.rst b/Documentation/block/bfq-iosched.rst
> index 66c5a4e54130..7200152c461e 100644
> --- a/Documentation/block/bfq-iosched.rst
> +++ b/Documentation/block/bfq-iosched.rst
> @@ -553,20 +553,36 @@ throughput sustainable with bfq, because updating the blkio.bfq.*
>  stats is rather costly, especially for some of the stats enabled by
>  CONFIG_BFQ_CGROUP_DEBUG.
>  
> -Parameters to set
> ------------------
> +Parameters
> +----------
>  
> -For each group, there is only the following parameter to set.
> +For each group, the following parameters cat be set:

Could we please not introduce new typos while fixing other stuff?

Thanks,

jon
