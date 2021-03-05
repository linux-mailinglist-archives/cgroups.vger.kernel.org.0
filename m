Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA532F0F5
	for <lists+cgroups@lfdr.de>; Fri,  5 Mar 2021 18:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCERRc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Mar 2021 12:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhCERRJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Mar 2021 12:17:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2E6C061756
        for <cgroups@vger.kernel.org>; Fri,  5 Mar 2021 09:17:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so2904020wrn.6
        for <cgroups@vger.kernel.org>; Fri, 05 Mar 2021 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Omevd0FBx005iXL14bFQltfa8ss9fF32vxOQu4J/uVM=;
        b=tzl5fhX/krPPRB6sEiaTWhW3YSjAMn88PlLbuYq0oNviAauvjp07tfa/KV98lTpk8/
         NLtaeVriS8ldYE4HDi94XRMPJg/1jy8NVsE89wO9zNH5POQyMAGWdMezN8SXiSGCA+SW
         kTdZqwqIDjGngUrv3hzgxlYhC+UDloP7Y7T0o+4Iw9QzRzG2RT802XrB52IFqNQMSJTj
         98HpANBxIWiGVNQHsqfmaNpvFN2VFuPOYEeZzoSAYzrboUEKuii9VegR/lZKLsUtYiId
         OItjdFaJCWib4s1ZjBYyiFg/qes7r9HJfyzcGqhdcmnL0LKAYU+sK7HFcG7Iii62F6mW
         2C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Omevd0FBx005iXL14bFQltfa8ss9fF32vxOQu4J/uVM=;
        b=si+IDkHIxCqeU1grWRrrNnrxsR37GKbr67CsIcZnStghD/CPR/b9whhH4NTM8uvNH5
         BvtzRrrbssRxH5J33Zpy3BmOcFEAVjfUZZMe6oGGw9W2l8+yK4DZl1RXYct30clrGnHJ
         n5MKXVkqRQrHGsyEQquWSHKSC9Eim78/tQCFUA9cuqw3hfFzFvIjw14D4kmsHcQzZDha
         4duu/fw++Hk9UILDgkAQWm4k58IZ7IpSTObdgPiY4AqsXgKfWH7041wGN8q/MXC7NoHc
         hu9Mpc44I4zczfryR4ZCCtwA4ZusAPLwc4Uqlo3VQv7tMmqp2CrbWJBfeDih8suG1wMt
         APTw==
X-Gm-Message-State: AOAM532KSq1L8buu1odzJyhLdJnLdXE7bPaRBavFpJeEahxgThvH9AIq
        k1JLqwOHvGdPLfL2UmrDoosWbw==
X-Google-Smtp-Source: ABdhPJzfKiNKYjg6f7z6fr15XCgQ0/breZONvYfwgXzPwXgjDe6AXHNnBp9m+CxfcpCHPXsoaldN7Q==
X-Received: by 2002:a5d:468e:: with SMTP id u14mr10462111wrq.359.1614964627745;
        Fri, 05 Mar 2021 09:17:07 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id l15sm5462818wru.38.2021.03.05.09.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 09:17:07 -0800 (PST)
Date:   Fri, 5 Mar 2021 18:16:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
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
Message-ID: <YEJnfe+E0ZifuFR+@myrica>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org>
 <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder>
 <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder>
 <YEHsOR/XjDxQapE6@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEHsOR/XjDxQapE6@myrica>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 05, 2021 at 09:30:49AM +0100, Jean-Philippe Brucker wrote:
> That works but isn't perfect, because the hardware resource of shared
> address spaces can be much lower that PID limit - 16k ASIDs on Arm. To

Sorry I meant 16-bit here - 64k

Thanks,
Jean
