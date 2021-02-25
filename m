Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA9325753
	for <lists+cgroups@lfdr.de>; Thu, 25 Feb 2021 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhBYUKS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Feb 2021 15:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhBYUKR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Feb 2021 15:10:17 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD8AC061574;
        Thu, 25 Feb 2021 12:09:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3EFDC2C1;
        Thu, 25 Feb 2021 20:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3EFDC2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1614283775; bh=eamGHQqfFKFIt3F2dJcpYXGTGQYPLSSArF/d6nsrqBI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q+8lFvoxPuQgBWLF7iC/BJjOOrr3jc1kYz2wxI0csNbg7zAs2stlHxtSR681ir+HD
         ZzMFNW2KOGcczgTqvvw/5SQHfs2INL0lSjD8x5XD8ED/9dViIwz3eUMR96dnWCdmMJ
         3DuwiLtPCy2CpL9Wrjupc2k/+VV2mAjHh7S9tG9LCOodaviQmiuN6zdO/G3HduqjDA
         1rUNtHm/DsKxAoeeaHkGc09WMGpKQ8lFuJQIrtkQIpi2WFWpIvNcbPSjgkKeX5QA4E
         HpeWqk9ZCZ4G+XlAWOvXPqJynx9OuLkkNGr22iAVt7foh8cr9y6RZQMMet2WBrs7A+
         jG+yZKR1XQEgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Antonio Terceiro <antonio.terceiro@linaro.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jiong Wang <jiong.wang@netronome.com>
Subject: Re: [PATCH] Documentation: cgroup-v2: fix path to example BPF program
In-Reply-To: <20210224131631.349287-1-antonio.terceiro@linaro.org>
References: <20210224131631.349287-1-antonio.terceiro@linaro.org>
Date:   Thu, 25 Feb 2021 13:09:34 -0700
Message-ID: <87zgzrc3k1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Antonio Terceiro <antonio.terceiro@linaro.org> writes:

> This file has been moved into the "progs" subdirectory in
> bd4aed0ee73ca873bef3cb3ec746dd796f03df28, together with all test BPF
> programs.
>
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Jiong Wang <jiong.wang@netronome.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.  I did fix the changelog to include a Fixes: tag with
the commit listed in the proper format.

Thanks,

jon
