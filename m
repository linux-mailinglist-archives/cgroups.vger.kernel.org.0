Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C069869E525
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 17:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjBUQvx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 11:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjBUQvw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 11:51:52 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A62A140;
        Tue, 21 Feb 2023 08:51:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id ko13so6341950plb.13;
        Tue, 21 Feb 2023 08:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=paiWRoNE8g4hLYXHv2XDWIFqYN/iFdKjh/xR/nU7dP0=;
        b=QJFpoZExKw/R6r2PUd+5zNoa5+G7LbcTOlmyv9bYwCRc5oRXqPs0cXfyZrDZQvOx5r
         NJwt1nZDhqLQfxwo2fy2XfsfqJSQj6w2qwIqL9JLosB3hr5ZTjA00J3/L4I8NI3vUVxt
         V09PAMnguaISmOA7ewfvBPUYM8fkT7FPC5ugQakxDemwbkvtugIo9X6re+G8cbC7ifSa
         zL15HNoHTariSPDw/igK8OFTfJvpTkPGAD6iLlY07tZ96GfsOO3H6JEURvDtL26TDdJV
         /WbjWfu1QRSWfVBytw5xsskhhfDzZE5KaqhgaGo+JJT2i3CilKr+EujAv5TgMBjZVmPD
         Ge7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=paiWRoNE8g4hLYXHv2XDWIFqYN/iFdKjh/xR/nU7dP0=;
        b=g59GbJp9P3d54pWNyExd7ch00+ZoX1iz0oH/hO6PhvvXezUZzQVgioZA7c96GfQxuB
         8SUJMxmd5CdrTj42BOCVmtp9otYo58+9s010T0ZPcWG2eZjMOfkxqfL6etCbK3P/pAGw
         L9dSE2sIrG3kjqYB3G24WNMripx0SiMnA8LcRGY7vJsh/mGyGqDDCFXGFNXlOeolUVf8
         wfVM3VjmhB5vfDH5zfYx1NphWzYaHD5y/fRag6MfBgmSFEELnMEesRXMDWaVHy9Xg0EM
         T5w80If4PmTj3cWgWTrhKCTDWQmr2LPXVyu1KLYIayHyOb3bQcWbCGwcDLvPXyTdmWDH
         nN+A==
X-Gm-Message-State: AO0yUKWbO0f3ifajjCkI+3jx4Vk4wY3n6C7IyxVX2ycG53rkjfqfXJFV
        wtiFVJl6ZP5LYPri/LyQNHg=
X-Google-Smtp-Source: AK7set+akPqx+gmedMgaV+asR6oy5RlxU3pMn1PnO5Np+abmd/nQHxRZKSg4rDU7nLktvl8mibviKg==
X-Received: by 2002:a05:6a20:8f26:b0:c6:7673:f392 with SMTP id b38-20020a056a208f2600b000c67673f392mr6052804pzk.17.1676998310343;
        Tue, 21 Feb 2023 08:51:50 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id m3-20020a637d43000000b004d3f518eea7sm4082680pgn.94.2023.02.21.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 08:51:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 06:51:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
References: <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4lcq4Fge27TQIn@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 16, 2023 at 08:45:38AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 16, 2023 at 09:04:03AM +0100, Michal Hocko wrote:
> 
> > > In most cases the ownship traces back to a file descriptor. When the
> > > file is closed the pin goes away.
> > 
> > This assumes a specific use of {un}pin_user_page*, right? IIUC the
> > cgroup charging is meant to be used from vm_account but that doesn't
> > really tell anything about the lifetime nor the ownership. Maybe this is
> > just a matter of documentation update...
> 
> Yes documentation.
> 
> > > > The interface itself doesn't talk about
> > > > anything like that and so it seems perfectly fine to unpin from a
> > > > completely different context then pinning. 
> > > 
> > > Yes, concievably the close of the FD can be in a totally different
> > > process with a different cgroup.
> > 
> > Wouldn't you get an unbalanced charges then? How can admin recover that
> > situation?
> 
> No, the approach in this patch series captures the cgroup that was
> charged and stores it in the FD until uncharge.
> 
> This is the same as we do today for rlimit. The user/process that is
> charged is captured and the uncharge always applies to user/process
> that was charged, not the user/process that happens to be associated
> with the uncharging context.
> 
> cgroup just add another option so it is user/process/cgroup that can
> hold the charge.
> 
> It is conceptually similar to how each struct page has the memcg that
> its allocation was charged to - we just record this in the FD not the
> page.

I don't have a lot of context here but it looks like the problem here is
that the newly proposed controller is introducing an ownership discrepancy.
If a memory which is pinned by a cgroup is to be charged to the owner of the
fd, the memory which isn't pinned should be charged to the memcg of the same
cgroup, right? It makes little sense to me to separate the owner of the
memory page and the pinner of it. They should be one and the same.

Alistair, can you please elaborate how these pages are allocated, charged
and used?

Thanks.

-- 
tejun
