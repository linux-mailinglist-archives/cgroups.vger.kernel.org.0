Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D26D538842
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbiE3UiK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 16:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiE3UiJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 16:38:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955D354BE4
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 13:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FCB260F19
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 20:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28522C385B8;
        Mon, 30 May 2022 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653943085;
        bh=EgZSRpIvza4/feORMuYAVyeFfwuHkSzhuAxB/51p+YQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T/KtKDTOjmbUAvZXUh7CFi3RvMpybj7HCsKVqlf77jkECjyf4tatE02G3y0Mp5h5b
         JgVO5LMnrDP7d/iKtZkTkK6iKsgRy6L38NFoVAC7ZOhFY5vXmz+5hn32XgKmUGCyMD
         j+CEpNd3noRQb3YxsLRy6ZkeY8m0cXEe0TCKQufw=
Date:   Mon, 30 May 2022 13:38:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Yutian Yang <nglaive@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH] memcg: enable accounting in keyctl subsys
Message-Id: <20220530133804.9215aa841958e84fdfe5272f@linux-foundation.org>
In-Reply-To: <ca0ba233-ed09-5dce-5f38-2e05b1114610@linux.dev>
References: <1626682667-10771-1-git-send-email-nglaive@gmail.com>
        <0017e4c6-84d8-6d62-2ceb-4851771fec18@linux.dev>
        <YovnzLqXqEHY6SAC@kernel.org>
        <ca0ba233-ed09-5dce-5f38-2e05b1114610@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 30 May 2022 12:38:28 +0300 Vasily Averin <vasily.averin@linux.dev> wrote:

> Dear Andrew,
> could you please pick up this patch too?
> 
> ...
>
> >> Reviewed-by: Vasily Averin <vvs@openvz.org>
>
> ...
>
> >> PS. Should I perhaps resend it?

Yes, would someone please resend.  And please also retest it - the
patch is almost a year old.

> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

