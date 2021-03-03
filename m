Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575B232C280
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 01:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhCCUy1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Mar 2021 15:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCCPpQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Mar 2021 10:45:16 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8931C06175F;
        Wed,  3 Mar 2021 07:44:31 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id s17so7334739qvr.12;
        Wed, 03 Mar 2021 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAenZ2k324Y74inyHnLSpf4GKMijWe+eb5zJ0f7us3Y=;
        b=Yo/WbLtNEcukoBaVIbtOmoJkqQ78eohGvlv9L6yTWcdDIuU+1DKAsD3fh1HE47Xrp+
         QFlB7j0powGVx/NAToiiojNwZYwizMSL3bMhnmCO5LXvVsufMjP7GNnPm8L/4Z04DNED
         PwkvridEsCPsRoNu/6CyDKV6GbFO6q2fPyLhHKJnUfbBGoKhaEDc7kAAkZXc5ASnjGnj
         COSukL6HNRaAnW+dWsCVUTEWV6O1Sj57SBKzdk7nqI1XHIiwgqRSH+n321SqE/5pCgGy
         ZRtUeRAi9hqP8qbDLI7pXQc3l3kAvlrBrJ0G4HVsFGa3WxRqSwAhAuIuaJFI+TFc8FpN
         EZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=yAenZ2k324Y74inyHnLSpf4GKMijWe+eb5zJ0f7us3Y=;
        b=GOPo44OjVFNC9CLZGaKYRfU+mn2tolvjltWa3daK+7ZlcpvFxAwq2hdmkJLsmQBTSE
         +PDZQ8p2iZm1odp2wxytxbXAlUxIu//KYIN97JTUbfTfkfJn+1JWmMOeAHEgnQ76g1oa
         mX2redR5lC67iGBY92ma3ZR26+TNxWLWImWfh4n6XKTQ169oTuEGk9pge1NrdXKw4HU+
         ApyMrc2L/35etDuQjxfvm2/hKUnh4ECraMlj1yEbFLTKQNq9uXVMSIE3z8V3xG3yxK4W
         gcrpY0yVG/JYIsYKC6TGX6/xI/7SICj6mxmRl2Nj1M+vBAa0Dj3bolMuRrYbE1xBakVL
         dBcw==
X-Gm-Message-State: AOAM531wBswscg5TgokYVxEh8Y8lSMLtFfpf4+qxCoJxLRdsEo+JQM39
        ymVEFo5Jt28D5WGvXh+xL8oBVANgJ1a/Tg==
X-Google-Smtp-Source: ABdhPJzfFnuZzOw9IZBrOfo12BzAhQPTqGWB0InFeznSDVw2hz00sFHfeQE8i+h+temYeCDQwJeU0A==
X-Received: by 2002:ad4:4581:: with SMTP id x1mr3253236qvu.9.1614786270710;
        Wed, 03 Mar 2021 07:44:30 -0800 (PST)
Received: from localhost (2603-7000-9602-8233-06d4-c4ff-fe48-9d05.res6.spectrum.com. [2603:7000:9602:8233:6d4:c4ff:fe48:9d05])
        by smtp.gmail.com with ESMTPSA id g6sm1590177qtg.91.2021.03.03.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:44:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 3 Mar 2021 10:44:28 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <YD+u3CXhwOi2LC+4@slm.duckdns.org>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Feb 27, 2021 at 02:01:23PM -0800, Jacob Pan wrote:
> IOASIDs are used to associate DMA requests with virtual address spaces.
> They are a system-wide limited resource made available to the userspace
> applications. Let it be VMs or user-space device drivers.
> 
> This RFC patch introduces a cgroup controller to address the following
> problems:
> 1. Some user applications exhaust all the available IOASIDs thus
> depriving others of the same host.
> 2. System admins need to provision VMs based on their needs for IOASIDs,
> e.g. the number of VMs with assigned devices that perform DMA requests
> with PASID.

Please take a look at the proposed misc controller:

 http://lkml.kernel.org/r/20210302081705.1990283-2-vipinsh@google.com

Would that fit your bill?

Thanks.

-- 
tejun
