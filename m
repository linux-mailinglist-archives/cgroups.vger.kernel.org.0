Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A161B6A52
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgDXAaj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgDXAai (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:30:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1F3C09B042;
        Thu, 23 Apr 2020 17:30:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so3241098pjb.3;
        Thu, 23 Apr 2020 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CI/1B5Cidn96PsLF1+MV6uHHJxnOtG8IuRZiucSwLqg=;
        b=u0+t3gSFNWhK/2bnK/QRc6HtUv83cARoTNpUd4TiJNOcMJz4I9cfqiF0ls+ngsJQFc
         k0oU8JEm6gqxKnX66U5j3OzqbI9sPdzd1V4yDvG3PsPwCzgJcB4FRDncbQJWVPbbvmVu
         /mhMZlY9Vt5ukryupUkZ32AsEqym9dDnewKDOf69r/BHg/V5wmMQrcntbqa4JbfvMEPl
         qVfNo2lKVdjaQU2ihOQ+DC2MYz/U/dhqorIAZSE3n0IqKLAHqPLT86RoUOixMdq2UleY
         +fAFeLfN7qDUWZqIaVIjBMPrOjRYx0ySqgmCxLkApI7G+ttGIXtuo3aiJmwAoE/wfX1Q
         X1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CI/1B5Cidn96PsLF1+MV6uHHJxnOtG8IuRZiucSwLqg=;
        b=qCwQOx0HG++vZtrrAwGqo1o+eyz+hBFqwYS6DxPlmrzNZ/K1DE01a4EIWlDvfrvCya
         qKpCNT7Kr1UqAJ5i4FFgvBuSuUAzhKQfCUhsv6jblRmoasLau6GbAk74NK5UhwLPuwJk
         Wgh3KA5WF2cX/g+vyP9RLhsUuk7JshpK1gqnvsMGo8O9UZV4Oepv1dMR8EZjKsKVArAO
         nYHow35MTUuKjrIW9n5z+gsKW6KCaHZ0uU7QR2FLu1c+Owp2N+N6sWB5pgakhhmrwJcV
         XHwm8VVTCGHLzvjl+wbHeZa8ojFGMtJu46pWFUOkCZGTi1injpLws9KIrPqBpuosgkYN
         56yA==
X-Gm-Message-State: AGi0PuZnqhBZvp24BYJc7AQU3BfdBKZcfOqHBUD13yBRGTfQCDmasz37
        c8Xp0gG/9Edt2Hf3v4ghQtA=
X-Google-Smtp-Source: APiQypI4kk9tAuj7+CPHMQWiRpXqr0HI1QTu0E3mURZ4g1nVG23sqAnrDVS3MlRsbHSWjli8QhETTw==
X-Received: by 2002:a17:90a:cc9:: with SMTP id 9mr3613012pjt.16.1587688238401;
        Thu, 23 Apr 2020 17:30:38 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id x18sm3880817pfi.22.2020.04.23.17.30.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:30:37 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:30:32 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 14/18] mm: memcontrol: prepare swap controller setup for
 integration
Message-ID: <20200424003031.GD13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-15-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-15-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:22PM -0400, Johannes Weiner wrote:
> A few cleanups to streamline the swap controller setup:
> 
> - Replace the do_swap_account flag with cgroup_memory_noswap. This
>   brings it in line with other functionality that is usually available
>   unless explicitly opted out of - nosocket, nokmem.
> 
> - Remove the really_do_swap_account flag that stores the boot option
>   and is later used to switch the do_swap_account. It's not clear why
>   this indirection is/was necessary. Use do_swap_account directly.
> 
> - Minor coding style polishing
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

