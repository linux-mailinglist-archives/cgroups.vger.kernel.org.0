Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790E24D6D9
	for <lists+cgroups@lfdr.de>; Fri, 21 Aug 2020 16:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHUOB4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Aug 2020 10:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHUOBy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Aug 2020 10:01:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98070C061574
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 07:01:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so1435126qka.3
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cA1F72P9Gm2cautm1YaokGwNbN8rzVJerys9S7kz+dY=;
        b=nkPVH+Ovq+PbJXglpdeME9hid7vf1PM4g5XbkjiJo5EratmsU7t9cUuws/8svKmlrP
         EeJLdQjFqqNF2PsTU39YI7W6UsK8DFi1Nsy2Fsed4IO48Km3gUAjJBL70SSYLIFiXjHT
         apFxLWdt25F9C+P6lXRwJOvayqJmLTXwaQtRh7tn1NVJ1G7xJKl4g02yk1IOhlgJXpgE
         uhu72bWnmxOnt+jHNENMYLGGBUgmEqijytDjIXanSn7EPu572k+I6lEd46ZQ5uvzCaUz
         QOGQUAuwpZeIzffQ1NmA823BQb4J5ZlOOb2aQbwOMLeV5GUlsqBpF4j6iEl1YEtNCXX0
         Dl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cA1F72P9Gm2cautm1YaokGwNbN8rzVJerys9S7kz+dY=;
        b=IE1j7JXcVeMl2QflUo4h70fDQ9z514LMuxjEfU/kqoIg6OntOmkix5s3E3ycf44Sk2
         GvjiktGT1gOjYbgfhipdC8g43igQlEkjv7ePMBy4+Zsf/7N1g3bS67couwem0rCjsVAI
         ASO5LrIYH08VzzyKXVx8UzF38JpCmM68xvJNMuWV6HFy+Rf2Qle5VrossE0PoEbKEoHZ
         P6I9C+DTb8GLrz8af0kQEOmWGKiOMR2omEQBgRes722TIbDsLkyHdLQOBm0ODi6u44Bq
         IjDQhIAuoTy3Tkhwm6J2gOyw42uMyWObndCJiAIylH75hu4+SyOCDRvl6xtRgk5/ESpT
         zIaQ==
X-Gm-Message-State: AOAM530hMNf4lGxBxgeytwsv55Rsq3pBoqseYa1BMFG299oET+1TOqfa
        70JmoJZh15FtnRz3b+iP2REWfA==
X-Google-Smtp-Source: ABdhPJwPS73vtoYQwDHYcuev8ZG8I9A0ALFJUzGNNDGInBppfnv7YCsr8cJGOO2lQw5S4Qj+0Je+7A==
X-Received: by 2002:a37:9b95:: with SMTP id d143mr2782128qke.272.1598018510305;
        Fri, 21 Aug 2020 07:01:50 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 15sm1789776qkm.112.2020.08.21.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:01:49 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:01:43 -0400
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200821140134.GA8147@lca.pw>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200821080127.GD32537@dhcp22.suse.cz>
 <20200821123934.GA4314@lca.pw>
 <20200821134842.GF32537@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821134842.GF32537@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 21, 2020 at 03:48:42PM +0200, Michal Hocko wrote:
> On Fri 21-08-20 08:39:37, Qian Cai wrote:
> > On Fri, Aug 21, 2020 at 10:01:27AM +0200, Michal Hocko wrote:
> > > On Thu 20-08-20 10:58:51, Qian Cai wrote:
> > > > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > > > > Since readahead page is charged on memcg too, in theory we don't have to
> > > > > check this exception now. Before safely remove them all, add a warning
> > > > > for the unexpected !memcg.
> > > > > 
> > > > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > This will trigger,
> > > 
> > > Thanks for the report!
> > >  
> > > > [ 1863.916499] LTP: starting move_pages12
> > > > [ 1863.946520] page:000000008ccc1062 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd3c0
> > > > [ 1863.946553] head:000000008ccc1062 order:5 compound_mapcount:0 compound_pincount:0
> > > 
> > > Hmm, this is really unexpected. How did we get order-5 page here? Is
> > > this some special mappaing that sys_move_pages should just ignore?
> > 
> > Well, I thought everybody should be able to figure out where to find the LTP
> > tests source code at this stage to see what it does. Anyway, the test simply
> > migrate hugepages while soft offlining, so order 5 is expected as that is 2M
> > hugepage on powerpc (also reproduced on x86 below). It might be easier to
> > reproduce using our linux-mm random bug collection on NUMA systems.
> 
> OK, I must have missed that this was on ppc. The order makes more sense
> now. I will have a look at this next week.

Sorry about not mentioning powerpc in the first place. I don't know since when
powerpc will no longer print out hardware information like x86 does in those
warning reports. I'll dig.
