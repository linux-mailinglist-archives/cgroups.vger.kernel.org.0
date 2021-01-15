Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A852F87CE
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 22:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAOVmr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 16:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbhAOVmp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 16:42:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ADFC0613D3
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 13:42:05 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id z21so6860841pgj.4
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bgjnqtpec69vUmjqa2UifvxbYQW35/sgPsKU/7Bo9aI=;
        b=OggvUw0Hm9klzCb2gWzL1xpvM4h0B34ZYVQsxN3wC/zdRTLky1sIVS+aP+RMem0Lx+
         dhCHyUumtATf+63/HrQ39p6Plwn+OkdZ92Gyx3QGmotDVqQ0vYf+OMXeU1OQmZYDLp23
         G67G8V+nMMaSDcNKFXoJsHO5cGVnEx6jZqJiA8UQp+Rg3CH83hN9RC4c94IlDyEIP/st
         zg0JlRpy3X+IW2jLP5T+VNP8gpjIkw7faoZac0GCm/4Jn2YSbPTsHrfhyi9oLgSFjKtZ
         f/L89Eha2I7pIfgNg69nuV+z1VE8VInqryQK7DnoxnSVe+pgyAvVhEv/BLD+I5uOc5dA
         14Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bgjnqtpec69vUmjqa2UifvxbYQW35/sgPsKU/7Bo9aI=;
        b=P97EMNJ1QgKEKSoV6EnCrJ9QgVjxdTC1Vy7iRfJQjxumqrprpfdZUeSQ8pQVoTaQyb
         3u/elRDt801khn5771HYaqs6kL4f1e1dTrp9r8Ds5otxE5to8wHnjuupaSWM2O/TCtpT
         vfQCc3EjKXf7/xb8DJRRHxLCP5YKTDeLvTKSKouqDmwQzGqGLApkPHbDcIWp4d2E3+A7
         uuWr0J7K0Icwu1E+lafn3dV1dIwx2lTwutW3PUDGmS1wy64EeMyU246zGZculxURcqMI
         /AW7BRdpu6X4jkXmafXl4r9QjPzhqtu9NkRyg+PSvnmM/n1XhAszQNTaaNOhATdrksQv
         HKpg==
X-Gm-Message-State: AOAM532LC2pPUStYMYHyyZz2CzlsJ2jECzvJ5ApQ3h6yyiak0ag/aiRa
        yGyRyYTp78OrrP2qYAh26TnHFw==
X-Google-Smtp-Source: ABdhPJxDU0ySQcc7fvev8M9M1d13VC+GIj7HBHfRSvtrxjqTvfzYTvW0G31AsN1nGGS2Xfbxazi8WQ==
X-Received: by 2002:a63:d305:: with SMTP id b5mr14631064pgg.452.1610746924450;
        Fri, 15 Jan 2021 13:42:04 -0800 (PST)
Received: from google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
        by smtp.gmail.com with ESMTPSA id a5sm8911135pgl.41.2021.01.15.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:42:03 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:41:59 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, seanjc@google.com,
        lizefan@huawei.com, hannes@cmpxchg.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, corbet@lwn.net, joro@8bytes.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gingell@google.com, rientjes@google.com, dionnaglaze@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v4 2/2] cgroup: svm: Encryption IDs cgroup documentation.
Message-ID: <YAIMJ9E8NneoAp8H@google.com>
References: <20210108012846.4134815-1-vipinsh@google.com>
 <20210108012846.4134815-3-vipinsh@google.com>
 <YAICaoSyk2O2nU+P@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAICaoSyk2O2nU+P@mtj.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 04:00:26PM -0500, Tejun Heo wrote:
> On Thu, Jan 07, 2021 at 05:28:46PM -0800, Vipin Sharma wrote:
> > Documentation for both cgroup versions, v1 and v2, of Encryption IDs
> > controller. This new controller is used to track and limit usage of
> > hardware memory encryption capabilities on the CPUs.
> > 
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > Reviewed-by: David Rientjes <rientjes@google.com>
> > Reviewed-by: Dionna Glaze <dionnaglaze@google.com>
> > ---
> >  .../admin-guide/cgroup-v1/encryption_ids.rst  | 108 ++++++++++++++++++
> >  Documentation/admin-guide/cgroup-v2.rst       |  78 ++++++++++++-
> 
> Given how trivial it is, I'm not gonna object to adding new v1 interface but
> maybe just point to v2 doc from v1?
> 

Sure, I will just add the path to v2 doc in v1.

> Thanks.
> 
> -- 
> tejun
