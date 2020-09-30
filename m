Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D289C27EE2E
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgI3QD2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgI3QD2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 12:03:28 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91477C061755;
        Wed, 30 Sep 2020 09:03:27 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so1612055qtv.3;
        Wed, 30 Sep 2020 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qq54/nTErxi0RFH786s9sI+Dgv5bltXrwyKiIEnYNfw=;
        b=arKX5oW7pd33EJ5Cl2u/Ne1vMb9nMCv5Ys1X66cp96FJiTOEdRzKGfWfUm2SZd9FKf
         jkGdGXaSX4KL7lVTu71skCNWvTsgeE0zxCj3DUeJW5DYYHtqyMoMDjg0wBth0CEYpQTq
         JUNMjupuAzHYSyImMMMtX87Id4XFz+qQbLBmNUD8izu+6iTQa41ZFUQtT2aTq7BFn7+w
         i24gfA3zfz8boF/AlUL8cSc+szkaciIS63foOp+RqmJ0lNHrswpxhi1tQKNH/Cr9PApR
         4VI36IjJxLT/WMSBZQnXKiYMzULHayFZBz1sM0qc6lKsr8Feo2Y98B2+QuZezXIPqAEu
         fCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qq54/nTErxi0RFH786s9sI+Dgv5bltXrwyKiIEnYNfw=;
        b=Ox5grk1eUWyg6utd0LArRCtorNfI0Tpt6HbLp0dV17fh9HxtEPsQe8OM/goPWRHzGb
         oirRRmcrAi1SkcRN6rmwd6LGdXxUDpY/eEdo64n/cDg+soltRw3hkkTONPijLjKQ3+25
         iEq1rlmtdfY5wL0pNr0SZbU4GikvI324mlOExTB41jTJh29wn/dAR1Hh+yF6IPd2PRIv
         UwhKLeP3l2LKcvt0EC9wCNMo5lDDaA/G+uQbn5KQD3gzpiYu7UjCXsDrVrdO0IJDTLJs
         PKy5eOOsP1uqiHyhYY9cpqMFGmBzrte+2CV0J2fR/2DqGapPFajVJlF5mZyT6/+E9xcy
         8pFw==
X-Gm-Message-State: AOAM5316yM/85lP2ftjMyGC54tSAa+DRK/5KCQx5eVv0X6VGR4jEthNz
        vDOL7udu7afZOPqU9YZp9KU=
X-Google-Smtp-Source: ABdhPJxhRM2+EtxeMMNNbVCJmTYJGjAiuc2DGTi39XGVYmi2tSe4h/KwXyCFk8nZyZ7DabpQ9pOfGw==
X-Received: by 2002:ac8:44c2:: with SMTP id b2mr2930428qto.277.1601481806766;
        Wed, 30 Sep 2020 09:03:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id g19sm2465750qka.84.2020.09.30.09.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:03:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 12:03:24 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove redundant kernfs_activate in
 cgroup_setup_root()
Message-ID: <20200930160324.GD4441@mtj.duckdns.org>
References: <20200925091110.17189-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925091110.17189-1-richard.weiyang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 25, 2020 at 05:11:10PM +0800, Wei Yang wrote:
> This step is already done in rebind_subsystems().
> 
> Not necessary to do it again.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Applied to cgroup/for-5.10.

Thanks.

-- 
tejun
