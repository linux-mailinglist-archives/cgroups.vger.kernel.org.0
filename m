Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9012FD76F
	for <lists+cgroups@lfdr.de>; Wed, 20 Jan 2021 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbhATRqm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jan 2021 12:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390513AbhATRph (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jan 2021 12:45:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E54C061575
        for <cgroups@vger.kernel.org>; Wed, 20 Jan 2021 09:45:22 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 041346133;
        Wed, 20 Jan 2021 17:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 041346133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611164583; bh=t10z/9IsGKuL0EHjMm0YRCyX2MRbbRcllIYkA3Oblow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=InB65MkkxlBevNgPOKeV8RBG//YJUhsA2r8PVWvyNp2Mw5g/HNf5JeJ4xBBrfpNeo
         YLiRFHpJjNRbBK2QfAcWa0TIPN6QdapdsXeur7r+4kbN9572oTXcIUFMchzrhQsGEU
         JQ1/Xhp0vafrkWbJZg2tqjanqpyh6jlrzQXz480/KsYbpLwDrlNOinLdq7MVyCC2sO
         8vlZ/cJNL19q9y6bW+1P8ey8JE8ZPHBiVKBXNc2+JUKEG9gqrvg5s0gaAO/SNyorrS
         OPybZ7wtWIQwUAJWcusMDEVgpkFhNQLzeCkxX9k36h+d2ob6LB/VVKBYBykRWTRHsk
         1ynMQWpV/glHg==
Date:   Wed, 20 Jan 2021 10:43:01 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kir Kolyshkin <kolyshkin@gmail.com>
Cc:     linux-doc@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 04/10] docs/scheduler/sched-bwc: add proper ref
Message-ID: <20210120104301.2aeda8f9@lwn.net>
In-Reply-To: <20210120001824.385168-5-kolyshkin@gmail.com>
References: <20210120001824.385168-1-kolyshkin@gmail.com>
        <20210120001824.385168-5-kolyshkin@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 19 Jan 2021 16:18:18 -0800
Kir Kolyshkin <kolyshkin@gmail.com> wrote:

> Add a proper reference instead of just using the file name.
> 
> Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> ---
>  Documentation/scheduler/sched-bwc.rst      | 3 ++-
>  Documentation/scheduler/sched-rt-group.rst | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
> index a44860d33ffc..dcec7440c222 100644
> --- a/Documentation/scheduler/sched-bwc.rst
> +++ b/Documentation/scheduler/sched-bwc.rst
> @@ -4,7 +4,8 @@ CFS Bandwidth Control
>  
>  .. note::
>     This document only discusses CPU bandwidth control for SCHED_NORMAL.
> -   The SCHED_RT case is covered in Documentation/scheduler/sched-rt-group.rst
> +   The SCHED_RT case is covered in
> +   :ref:`Documentation/scheduler/sched-rt-group.rst <sched-rt-group>`.
>  
>  CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
>  specification of the maximum CPU bandwidth available to a group or hierarchy.
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index 655a096ec8fb..a3b4aa51c271 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -1,3 +1,5 @@
> +.. _sched-rt-group:
> +

So why do you need to do this?  The build system in recent kernels will
generate that reference automatically without the extra markup.

Thanks,

jon
