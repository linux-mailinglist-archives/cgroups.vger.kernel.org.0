Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C170A8AF
	for <lists+cgroups@lfdr.de>; Sat, 20 May 2023 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjETPJd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 May 2023 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjETPJc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 20 May 2023 11:09:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8E2EE
        for <cgroups@vger.kernel.org>; Sat, 20 May 2023 08:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D49F56148A
        for <cgroups@vger.kernel.org>; Sat, 20 May 2023 15:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BC4C433D2;
        Sat, 20 May 2023 15:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684595370;
        bh=4zgFLqedrPYhCRx9gtDlB2omoSFlFonZfeeZY1IDdSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kzEZFk0VO9ueKp77ylIn0iukDF8ZkxVEl5p/Kr9aMczqAZV9awU1UJj6f0bkjHPVo
         4SbCmQr0PhPmDtzoHyfnJ4X1eIdoU7tN1NfIRojKxmCbAl7gY2iWtXT5zBaMsGtsV5
         P376lvmh971ZdlsO81uAsWt3iDDzpj6pOp3+imrGT2+oA4tXubFVWqir63wJudT8QF
         AF71gt/jR2ymlz/bLVIWOMJuN8nqzffSMBWHNYb6yi+udBUSpGu1lxQO32LfwPRw/R
         zjxN+xEFT4tE8DNwP8dyMjf4Yqgbp/4Msc4/IoKWXojOJoqK/b7dNaDT08CwaVMFe6
         OwNy5mhKqEj5w==
Date:   Sat, 20 May 2023 08:09:26 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Kalesh Singh <kaleshsingh@google.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] Reducing zombie memcgs
Message-ID: <ZGjipm8ycoEJGj5z@google.com>
References: <CABdmKX2M6koq4Q0Cmp_-=wbP0Qa190HdEGGaHfxNS05gAkUtPA@mail.gmail.com>
 <ZFLdDyHoIdJSXJt+@google.com>
 <874josz4rd.fsf@nvidia.com>
 <ZFPP71czDDxMPLQK@google.com>
 <877ctm518f.fsf@nvidia.com>
 <ZFbZZPkSpsKMe8iR@google.com>
 <87ttwnkzap.fsf@nvidia.com>
 <ZFuvhP5qGPivokc0@google.com>
 <87jzxe9baj.fsf@nvidia.com>
 <ZF6rACJzilA06oe+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF6rACJzilA06oe+@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 12, 2023 at 06:09:20PM -0300, Jason Gunthorpe wrote:
> On Fri, May 12, 2023 at 06:45:13PM +1000, Alistair Popple wrote:
> 
> > However review comments suggested it needed to be added as part of
> > memcg. As soon as we do that we have to address how we deal with shared
> > memory. If we stick with the original RLIMIT proposal this discussion
> > goes away, but based on feedback I think I need to at least investigate
> > integrating it into memcg to get anything merged.
> 
> Personally I don't see how we can effectively solve the per-page
> problem without also tracking all the owning memcgs for every
> page. This means giving each struct page an array of memcgs
> 
> I suspect this will be too expensive to be realistically
> implementable.

Agree. To get the precise shared usage count, it needs to track
the usage at the page level.

It is possible to track just <smemcg,memcg> pair at the
leaf node of the memcg. At the parent memcg it needs to avoid
counting the same page twice. So it does need to track per page
memcgs set that it belongs to.


Chris

> If it is done then we may not even need a pin controller on its own as
> the main memcg should capture most of it. (althought it doesn't
> distinguish between movable/swappable and non-swappable memory)
> But this is all being done for the libvirt people, so it would be good
> to involve them
> 
> Jason
> 
