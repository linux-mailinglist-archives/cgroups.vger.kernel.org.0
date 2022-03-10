Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84E4D5615
	for <lists+cgroups@lfdr.de>; Fri, 11 Mar 2022 00:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbiCJX4V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Mar 2022 18:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbiCJX4T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Mar 2022 18:56:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B6D1A06D2
        for <cgroups@vger.kernel.org>; Thu, 10 Mar 2022 15:55:14 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so15565176ejb.13
        for <cgroups@vger.kernel.org>; Thu, 10 Mar 2022 15:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xZ6UNijk+8fR6sxhT3uosvQMAg54vwl80TP88uESaak=;
        b=XM21VLJKPPRv73+hFuw4W1yLb52eqWF02QVjdDSyzl7KvtU0Rbpp6Bz84KC9pdhr+7
         subfZPpcr6GULDAPlJkzxB/38Pd34zsy2PU7hxsmKEvMddHWLrxFbO5TgdsdDDvv7cFm
         yKuaOBOHzREJyz4podBxWUZMvSVipjhzJ11+J5014IfDz+fNuQzXAnNWGCTWYDw2/Bhv
         Vk7noKb8nYu2GNWZfdiwQS4bj2IZK2EcaLOqg8Vzsw580aRuXiN5xXNJl0uZ1oTOZuWJ
         PUv57UQYkFzLQHMw2rrqKBpiaZdAfLBoGr6TjbMCd5kCiv73ndeHtmUjZlmeM3ZEr6ig
         wgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZ6UNijk+8fR6sxhT3uosvQMAg54vwl80TP88uESaak=;
        b=DEzNUirANBUltuityMAXCvwEebVR2dp7ozNZl41RLOFM6aEJY7zjV4eRp1u9W5M+OW
         sQMNZIfPSKf+WFvO+MGPzG7Tptfbu4xoc2woS52pxDjLc/ieA7w3E9aRLz9OdNWMnCp6
         DLvJv3BGExBSjT12+62Bg1WiIAXMFQLthIU0GAiqVN2rAlNQCr7MVXhuSLZ3GJnS6gVz
         uFe/dp/wmFK6lUepvQduaqBpHWnLTftJ4kSdLKt6VpqVr+PjOxzhmUNLbdcTJP5Qx0W/
         BYctOjSn74LkLZaOFspT0y8bZVpV1BpPEbI2qeLTuYJVOP5dS0JD3t9ELzz4NObEVtVy
         A5Gw==
X-Gm-Message-State: AOAM533NaRd4EKzT5eT76kREWUlLDJKRRlPjzZHQGUhtvMoGyLiZMj3Z
        VvhM5+2nKinmjwBCPVpfhTKb0Aod1+A=
X-Google-Smtp-Source: ABdhPJyRkaWoZoOCievIZuzcI+SDCcwGbyfWqVJXeh41CDDL7d9Ntmmw+wHuTB8A4r1Y9Zeg/HjjnQ==
X-Received: by 2002:a17:907:7f94:b0:6da:64ec:fabc with SMTP id qk20-20020a1709077f9400b006da64ecfabcmr6407150ejc.717.1646956512668;
        Thu, 10 Mar 2022 15:55:12 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id w10-20020a17090652ca00b006c605703245sm2325074ejn.43.2022.03.10.15.55.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Mar 2022 15:55:12 -0800 (PST)
Date:   Thu, 10 Mar 2022 23:55:11 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH 3/3] mm/memcg: add next_mz back if not reclaimed yet
Message-ID: <20220310235511.maeewfjl4k5dw576@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20220308012047.26638-1-richard.weiyang@gmail.com>
 <20220308012047.26638-3-richard.weiyang@gmail.com>
 <YicRNofU+L1cKIQp@dhcp22.suse.cz>
 <20220309004620.fgotfh4wsquscbfn@master>
 <YiiwPaCESiTuH22a@dhcp22.suse.cz>
 <Yim98uGgFjTu2HeK@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yim98uGgFjTu2HeK@dhcp22.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 10, 2022 at 09:59:30AM +0100, Michal Hocko wrote:
>On Wed 09-03-22 14:48:46, Michal Hocko wrote:
>> [Cc Tim - the patch is http://lkml.kernel.org/r/20220308012047.26638-3-richard.weiyang@gmail.com]
>> 
>> On Wed 09-03-22 00:46:20, Wei Yang wrote:
>> > On Tue, Mar 08, 2022 at 09:17:58AM +0100, Michal Hocko wrote:
>> > >On Tue 08-03-22 01:20:47, Wei Yang wrote:
>> > >> next_mz is removed from rb_tree, let's add it back if no reclaim has
>> > >> been tried.
>> > >
>> > >Could you elaborate more why we need/want this?
>> > >
>> > 
>> > Per my understanding, we add back the right most node even reclaim makes no
>> > progress, so it is reasonable to add back a node if we didn't get a chance to
>> > do reclaim on it.
>> 
>> Your patch sounded familiar and I can remember now. The same fix has
>> been posted by Tim last year
>> https://lore.kernel.org/linux-mm/8d35206601ccf0e1fe021d24405b2a0c2f4e052f.1613584277.git.tim.c.chen@linux.intel.com/
>
>Btw. I forgot to mention yesterday. Whatever was the reason this has
>slipped through cracks it would great if you could reuse the changelog
>of the original patch which was more verbose and explicit about the
>underlying problem. The only remaining part I would add is a description
>of how serious the problem is. The removed memcg would be out of the
>excess tree until further memory charges would get it back. But that can
>take arbitrary amount of time. Whether that is a real problem would
>depend on the workload of course but considering how coarse of a tool
>the soft limit is it is possible that this is not something most users
>would even notice.

Got it, would send a v2.

>-- 
>Michal Hocko
>SUSE Labs

-- 
Wei Yang
Help you, Help me
