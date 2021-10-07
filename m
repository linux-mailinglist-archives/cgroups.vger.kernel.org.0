Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D944254F4
	for <lists+cgroups@lfdr.de>; Thu,  7 Oct 2021 16:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhJGOEo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Oct 2021 10:04:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55394 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbhJGOEo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Oct 2021 10:04:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9AB2A2252E;
        Thu,  7 Oct 2021 14:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633615369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1I72EYHnG0Ll/HtrsN+KFVKnf7WVgvBWjvAI6syAjqc=;
        b=0uOaaQ3swvj/d6JA0JLHXjhrMnICVVihcAMhbNoESIBzDXF7wGhBdCOiw2egny1Mj9RA1t
        d5Igur3Ir+M8wsPuOoU7YQ/HWPev32nCQhlHzHuUyo2qBfYTss6q8Qt9+WWXhFn4dakcLn
        CSli04vid3caxE0XpC0Dug0onC0vq5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633615369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1I72EYHnG0Ll/HtrsN+KFVKnf7WVgvBWjvAI6syAjqc=;
        b=Oircnie37Y2Jpq7n+YZeuPH8FCaUWZ0KaH3snZf+FZ6algRf7L9cQlHyTUzi9iCx1AIydy
        kD9P/UVCr4ES+JDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6880813EAC;
        Thu,  7 Oct 2021 14:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id asXEGAn+XmFXSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 07 Oct 2021 14:02:49 +0000
Message-ID: <d6c04044-71f9-cbeb-b311-edc3999e3641@suse.cz>
Date:   Thu, 7 Oct 2021 16:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: memcg memory accounting in vmalloc is broken
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@openvz.org, Mel Gorman <mgorman@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
References: <b3c232ff-d9dc-4304-629f-22cc95df1e2e@virtuozzo.com>
 <YV6sIz5UjfbhRyHN@dhcp22.suse.cz> <YV6s+ze8LzuxfvOM@dhcp22.suse.cz>
 <953ef8e2-1221-a12c-8f71-e34e477a52e8@virtuozzo.com>
 <20211007102044.GR3959@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20211007102044.GR3959@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/7/21 12:20, Mel Gorman wrote:
> On Thu, Oct 07, 2021 at 11:50:44AM +0300, Vasily Averin wrote:
>> On 10/7/21 11:16 AM, Michal Hocko wrote:
>> > Cc Mel and Uladzislau
>> > 
>> > On Thu 07-10-21 10:13:23, Michal Hocko wrote:
>> >> On Thu 07-10-21 11:04:40, Vasily Averin wrote:
>> >>> vmalloc was switched to __alloc_pages_bulk but it does not account the memory to memcg.
>> >>>
>> >>> Is it known issue perhaps?
>> >>
>> >> No, I think this was just overlooked. Definitely doesn't look
>> >> intentional to me.
>> 
>> I use following patch as a quick fix,
>> it helps though it is far from ideal and can be optimized.
> 
> Thanks Vasily.
> 
> This papers over the problem but it could certainly be optimized. At
> minimum;
> 
> 1. Test (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) in the
>    function preamble and store the result in a bool

memcg_kmem_enabled() is a static key based check so caching that defeats its
purpose and changes it to a normal branch. That leaves gfp & __GFP_ACCOUNT,
which may perhaps still benefit from such caching.

> 2. Avoid the temptation to batch the accounting because if the
>    accounting fails, there is no information on how many pages could be
>    allocated before the limits were hit. I guess you could pre-charge the
>    pages and uncharging the number of pages that failed to be allocated
>    but it should be a separate patch.
> 3. If an allocation fails due to memcg accounting, break
>    out of the loop because all remaining bulk allocations are
>    also likely to fail.
> 
> As it's not vmalloc's fault, I would suggest the patch
> have
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> and
> Cc: <stable@vger.kernel.org>
> 
> Note the Cc should just be in the patch and not mailed directly to
> stable@ as it'll simply trigger a form letter about the patch having to
> be merged to mainline first.
> 

