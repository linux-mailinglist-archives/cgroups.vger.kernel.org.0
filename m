Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F693DBEDC
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhG3TQw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 15:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhG3TQw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 15:16:52 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA27C06175F;
        Fri, 30 Jul 2021 12:16:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 00A512A0;
        Fri, 30 Jul 2021 19:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 00A512A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1627672607; bh=YZc6mmNZCtOeBrjLGQq95v8TtG0AvIQbj6k4rdcz9zg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qmn7LCq42csnsffDQi5ZEs3vj9qdZow+WW/D2/zM9ft36MrKc+uu3WSDWCOp1pk65
         uTR+PpaYMkp76pYJrDsBkBRRfnalc6hLzagHP4EByWUqIEGarFVmx0i8me+2+g9pBj
         VI9eEAVIL6q5f69dVukJDgUA8ccztyhjzI6xVrvYy8yGThpgnV0KyKSYIaNEtFGUSv
         R9csgOPitVaOAKMOhEkxUsDI3bq/ZaFinWeegdVjPf77MmmSX/q1MM+VT1DYnZyyQH
         9HGZm/yJsx7WP5dG3dJCYpNIT2AjoRCdLeEiKPFiIA6ILZWYByVUBaH5iObjbdmsha
         hdwc5xwHL1pgA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix typo in comments and documents
In-Reply-To: <YQQUwX+/1N9utKEN@casper.infradead.org>
References: <20210730051605.2626-1-caihuoqing@baidu.com>
 <87lf5nc0su.fsf@meer.lwn.net> <YQQUwX+/1N9utKEN@casper.infradead.org>
Date:   Fri, 30 Jul 2021 13:16:46 -0600
Message-ID: <87im0ra9y9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jul 30, 2021 at 08:51:29AM -0600, Jonathan Corbet wrote:
>> Cai Huoqing <caihuoqing@baidu.com> writes:
>> 
>> > Fix typo: iff  ==> if
>> >
>> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>> 
>> This is becoming an FAQ ...  "iff" in mathematical English means "if and
>> only if"; its usage in these documents is correct.
>
> ... and yet it's clearly not understood.  Similarly to the [start..end)
> convention (also the [start..end[ convention).  Should we deprecate
> use of it in kernel documentation, and if so, what should we replace it
> with?

I'm never quite sure what to do with these things...we want to be
inclusive, but we don't want to hobble the language we use beyond a
certain point.  We could ask people to spell out "if and only if", I
suppose, but that sounds like the kind of thing that leads to unpleasant
messages in my inbox.

Thanks,

jon
