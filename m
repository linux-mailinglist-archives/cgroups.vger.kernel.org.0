Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897B8769B72
	for <lists+cgroups@lfdr.de>; Mon, 31 Jul 2023 17:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjGaPz2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jul 2023 11:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjGaPzY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jul 2023 11:55:24 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D791708;
        Mon, 31 Jul 2023 08:55:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 164D92C5;
        Mon, 31 Jul 2023 15:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 164D92C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690818923; bh=dtzt/1jmMl4ga6TG3AzFsLIjNNRRFlSVYKzq/KA6aHE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nYMA56oTwm5Bop7XCKDoHg3GVBw08llGFlzSEtzk9O36IZtYIWDQF3rDAQWBxAGKk
         +MNlYbRw4GXjnCCwATwkmhuZMXdvWVobLuVXevNhMBR7rjZvA1M3zwtI3irCuvrs30
         qFeeWxSyqBA4FV1tas9lcBbGpYmTwwz+aNz2y0NR6G+633oKRy1fjjSAXoVIIH+QoU
         hgWWrfgkLtupN2uI7StwPwS3Ky8Bnyuf//DDOG25UwepaDM36UD9HwedPppDML2OTk
         uGKQRJqCxAKGuszQtHIs73dcyJ4lgk2YOp9ZctnuMUthsWHWgPv5vCKdwbayRdaKE1
         fP0MMfyiZzOxw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Pawlaczyk <krzpaw@gmail.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com
Cc:     Krzysztof Pawlaczyk <krzpaw@gmail.com>
Subject: Re: [PATCH] docs: cgroup-v1: replace dead CONFIG_MEM_RES_CTRL_SWAP
 symbol
In-Reply-To: <20230728105723.251892-1-krzpaw@gmail.com>
References: <20230728105723.251892-1-krzpaw@gmail.com>
Date:   Mon, 31 Jul 2023 09:55:22 -0600
Message-ID: <87o7jsdqj9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Krzysztof Pawlaczyk <krzpaw@gmail.com> writes:

> Commit e55b9f96860f ("mm: memcontrol: drop dead CONFIG_MEMCG_SWAP
> config symbol") removed MEMCG_SWAP as it was just a shorthand for
> CONFIG_MEMCG && CONFIG_SWAP.
>
> The commit also adjusted the documentation but missed reference to
> CONFIG_MEM_RES_CTRL_SWAP, which was the previous name of
> CONFIG_MEMCG_SWAP before renaming in commit c255a458055e ("memcg: rename
> config variables").
>
> Update the reference to the current state.
>
> Signed-off-by: Krzysztof Pawlaczyk <krzpaw@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v1/memcg_test.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memcg_test.rst b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> index a402359abb99..1f128458ddea 100644
> --- a/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memcg_test.rst
> @@ -62,7 +62,7 @@ Please note that implementation details can be changed.
>  
>  	At cancel(), simply usage -= PAGE_SIZE.
>  
> -Under below explanation, we assume CONFIG_MEM_RES_CTRL_SWAP=y.
> +Under below explanation, we assume CONFIG_SWAP=y.
>  

Applied, thanks.

jon
