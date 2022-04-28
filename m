Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463F4513AEE
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiD1Rbj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbiD1Rbi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:31:38 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2A043ED0
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 10:28:23 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id js10so3734900qvb.0
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 10:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ywIQvVwgag1com6bDxPqmKMeB7A08MtYuevMsyOSOPQ=;
        b=8QDJnLhAmNHGsLaBQmDqBrcILYyDP9jv4WD9nDDyluZQ3AyEx3MdCGQSDqxW70SGO6
         dHjEacPn670Cttc+vma5fsmybXQrEWDwOSriDm4M1zh/p8R0cfGR+P2UeAOOswBdPoPN
         UymIxmq005YN0pWaKnhy3Qt5T8fMP40inSpO/g4yKZyoeuGW2l3pub90YoPGUGQkiuLX
         cmUr1lNoAFW3vWIR6Ju6NmnMFVQlilVHADUJd9/Hwy6MK77xIUrA6Iyos41ScIK3y026
         cbYAaiaMgarYe1E4TgstRbzWse+RFycZstcjBiJwinrr2bYwiHSWcfz1tz0VoDWKMy1B
         frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ywIQvVwgag1com6bDxPqmKMeB7A08MtYuevMsyOSOPQ=;
        b=DpyQ2UKi02gq7/67lPnYm8bMqg+rYS3CgGKv9pgj+sDtcm2uT5bGjtcT0wBQKD0b3i
         B9BYc/u0DlkcRWnmv/MlcsFbbhIQ0Jbkkgr1ct+5/DWCjEDemSMjEiXz5ghSkba2qGMO
         xgLa2IH0Le/hp6BZVOCCNVCdEAFUVOGhKgp2Yvx/RcyHPipkeVi0NAzA9UY0VwaYUKgJ
         HPumY5zhUD85vg3LRp+gTH3QYIy9qvjXeNGNrcS3vh9vGwwRpRwbn9LnCBYbSrlIpYPY
         WzA/xCyZ0XOEcgUSytsksdjXUdC0KTo8/CiEBXbDQ0OJX+zTAvisHPf5cFr5k9G1dAoi
         t5bg==
X-Gm-Message-State: AOAM533bBG5ZdHA2vFXADKvrpxBUVmLqXXIQ35ulzChN37QRIMOEVguK
        nHbMuWvjkH3UXoiU9d+g7QgnJg==
X-Google-Smtp-Source: ABdhPJxRLZPBYQ+Renj2m3NAsWJcy1DxTlhIKkjU4+EhSPE4VL4dcK8UCxfEtZem5IKqTdfDjqjM5A==
X-Received: by 2002:ad4:5f05:0:b0:456:306d:333d with SMTP id fo5-20020ad45f05000000b00456306d333dmr18665310qvb.16.1651166902753;
        Thu, 28 Apr 2022 10:28:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm327527qtz.59.2022.04.28.10.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:28:22 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:27:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmrOkk3jKr4dsjkJ@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
 <Ymm/wayEB3MH6ZRY@google.com>
 <YmqfGaIhE8W+Z1mo@cmpxchg.org>
 <YmrItoe1W9dya+An@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmrItoe1W9dya+An@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 10:02:46AM -0700, Minchan Kim wrote:
> On Thu, Apr 28, 2022 at 10:05:13AM -0400, Johannes Weiner wrote:
> > But I'd ack a patch that adds a combined "Compressed" counter for zram
> > + zswap if you send it, Minchan.
> 
> If we really want to go separate stat for zswap and zram, it would
> be better to use direct name "Zram: " instead of comrpessed.

That works for me as well.
