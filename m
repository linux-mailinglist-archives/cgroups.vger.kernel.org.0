Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE8553B77C
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiFBKss (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiFBKss (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 06:48:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321A7252B7
        for <cgroups@vger.kernel.org>; Thu,  2 Jun 2022 03:48:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cx11so4594992pjb.1
        for <cgroups@vger.kernel.org>; Thu, 02 Jun 2022 03:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mFpX60Bpgj1CZ/r9BaiZqjht5lWPMONlADO9gEwg/QM=;
        b=SwX3dVy3jXK2i5Z7uMI0MgELLNVc2oWbF7lRdRfsT9EqfOJ3hICdbNbgMYcXkoVooC
         MlgCxTXNf14Vl4M1M0BwPslA6dKzAvnrC5y8gpZ8KnUTdXkrj4uIpoCzfUwXG4KImXXC
         NzUsT2IT1TEgI1ZrOK8up2DZ0I7c9OpMbD2tFlQgWa/9mr9adaLsjb4YApgZvWlBZWa1
         A6XaWRRCvcyCJT3zVWP4dYdYmYDcvN6KarzhSqkqS9tDFBh/KH4E3wEXilxg55OSCP8l
         cHTB6ytf08StwYuny4TYXUFaKL5qINmBT6/7EIo1wJYpEKwD8VEP0w7/zSs/Q5iCESf/
         uTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mFpX60Bpgj1CZ/r9BaiZqjht5lWPMONlADO9gEwg/QM=;
        b=W/U7FJNnH07/SdhztvoVI1TqPm3AKFr3XDZA6gj6Zmpjz6hJ+XefIfPKHY0EzN4YKR
         EiZqZpoQHWEnIWwP/7ROBowp40Q8FMHeFMlhlw40WtSfflA0AwuGLzlxtGns6qT2nKcH
         FFoQ2BzG19sdSMeathXOTGQCQMmqExIHsZ/96OhifuyjDjElmJI/CT7fC8sO4pnTVidn
         wYV9J+TdT8xpyPAJj5wAVZIrfRHs9qFjea4wLhnEPqYnD8YtjkhRzLA+fKwVH7lAyZwA
         FLf2Hs/nnQoFmX4/3iffMrRzCnXZ/ywpOxkzXAdyYYBDszWgmszCi3BhrXqQie8hXsEa
         TXeA==
X-Gm-Message-State: AOAM533L+nFDYzqjQ1P9btPpZ7K7SxXRPk91wEGIhPkiHj7pLwj0MCnk
        MHNrs0CMQ1LIPr40yESxe/hcqA==
X-Google-Smtp-Source: ABdhPJwNnEekZvUy1mThm1y0ZTmyfYGaZQG0BXjujVjOVisYjgr6LYgikB1fIrA5FbqrkBSwmK65Xg==
X-Received: by 2002:a17:90a:ae14:b0:1e0:51fa:5182 with SMTP id t20-20020a17090aae1400b001e051fa5182mr39393084pjq.60.1654166926707;
        Thu, 02 Jun 2022 03:48:46 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2468:2a68:7bbe:680c])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709027e0900b00161d8153d56sm3111583plm.148.2022.06.02.03.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 03:48:46 -0700 (PDT)
Date:   Thu, 2 Jun 2022 18:48:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, longman@redhat.com
Subject: Re: [PATCH v5 03/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <YpiVibVoQizVDzOO@FVFYT0MHHV2J.googleapis.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-4-songmuchun@bytedance.com>
 <20220601173434.GB16134@blackbody.suse.cz>
 <YpexCpVBW76GCN2X@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpexCpVBW76GCN2X@carbon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 11:33:46AM -0700, Roman Gushchin wrote:
> On Wed, Jun 01, 2022 at 07:34:34PM +0200, Michal Koutny wrote:
> > Hello.
> > 
> > On Mon, May 30, 2022 at 03:49:11PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> > > So we also allocate an object cgroup for the root_mem_cgroup.
> > 
> > This change made me wary that this patch also kmem charging in the
> > root_mem_cgroup. Fortunately, get_obj_cgroup_from_current won't return
> > this objcg so all is fine.
> 
> Yes, I had the same experience here :)
>

Sorry for the confusing.
 
> Overall I feel like the handling of the root memcg and objcg are begging
> for a cleanup, but it's really far from being trivial.
> 
> Maybe starting with documenting how it works now is a good idea...
> 

You mean add more comments into the commit log to explain the
usage of root memcg and root objcg?

Thanks.
