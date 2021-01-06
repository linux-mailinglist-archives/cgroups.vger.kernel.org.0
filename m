Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58022EC369
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 19:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAFSqB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Jan 2021 13:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbhAFSqA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Jan 2021 13:46:00 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863EDC06134C
        for <cgroups@vger.kernel.org>; Wed,  6 Jan 2021 10:45:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id h10so2204341pfo.9
        for <cgroups@vger.kernel.org>; Wed, 06 Jan 2021 10:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ho+xRsAlnZPA9XwreJh6lam3mNeyMrjUZb8gp0Pijj4=;
        b=pp1lm1jkJ+G032pTcswwk6Ab4cZJqTQ98WbtBympCzpKmXncEcv6qCTKzdSbVOifHF
         uO+nl+4aB9LlmW27p+QnG2+/nu8cKCtE16/9E02D0atV5oYdFrwqTeb1hcvmgQQjdytE
         BP1rIL3zXJL23b5bAWRaM36ihs/hLE+PLKsZFbf/TciuW23P2ye6vkAHfsnLnFQiw8op
         SaTOOnQnWIsFOuYSjlppUh85Nmnt1nhpBQbFhMgLCW6419x2Pc3B2b/hRpknb8qcl2/J
         v0XFc/9O3QoVmWuvbjNFMHTi5AJ8M6U2jnYB8YoB90TeBavfL516zS3wbFWGmGUCg3im
         GPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ho+xRsAlnZPA9XwreJh6lam3mNeyMrjUZb8gp0Pijj4=;
        b=WoRsQS7Z/AAFuNuQr6Acd7BbgcZAzHvLu8mOgE1GtRGAqhFKN+HexXLFMsHtxsjOdm
         lPZLFUZjfgAki/NUlGDl7pjgsuOtWyRMyFhaDXsQHptbMeSwV8DcQyd3//bIth3L7oaG
         5LBR8b/97gDtXZbB892Zigp/YWM26WakoLomLBcRWpgOy97ji8CFR7jIizh2AcvMombK
         uyrMlzowTcWhNAv0OdkL+DlgflEfwh7m9uLp7xGI1nXI99KGC+CC7uttZ85z7ctTBIep
         pbhwnlFL+S29gCpLUtAL8Dpr/8wAv1iqNXZ5VrIGaZV8cvLAVII0qbQ6nEmjKSJkLLuD
         s3lg==
X-Gm-Message-State: AOAM530N0ny/wXJ9dX5L3rwAZDmxNQA5tyCJm0uld3Or7M4ZUa/cycgu
        f7zA330NLmV3NM22j8V2byLNsg==
X-Google-Smtp-Source: ABdhPJwtNkxU+RDoHsd2aWmLEUDActU8ItlTVYihGE3QCDrRNmO5CRDj6A156uPcWiMvJZXbiH69+g==
X-Received: by 2002:a63:1261:: with SMTP id 33mr5797347pgs.213.1609958719939;
        Wed, 06 Jan 2021 10:45:19 -0800 (PST)
Received: from google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
        by smtp.gmail.com with ESMTPSA id 21sm3299297pfx.84.2021.01.06.10.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 10:45:19 -0800 (PST)
Date:   Wed, 6 Jan 2021 10:45:14 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh <brijesh.singh@amd.com>, Jon <jon.grimm@amd.com>,
        Eric <eric.vantassell@amd.com>, pbonzini@redhat.com,
        Sean Christopherson <seanjc@google.com>, lizefan@huawei.com,
        hannes@cmpxchg.org, Janosch Frank <frankja@linux.ibm.com>,
        corbet@lwn.net, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, Jim Mattson <jmattson@google.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        Matt Gingell <gingell@google.com>,
        Dionna Glaze <dionnaglaze@google.com>, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 0/2] cgroup: KVM: New Encryption IDs cgroup controller
Message-ID: <X/YFOvLp/mEk5z9W@google.com>
References: <20201209205413.3391139-1-vipinsh@google.com>
 <X9E6eZaIFDhzrqWO@mtj.duckdns.org>
 <4f7b9c3f-200e-6127-1d94-91dd9c917921@de.ibm.com>
 <5f8d4cba-d3f-61c2-f97-fdb338fec9b8@google.com>
 <X9onUwvKovJeHpKR@mtj.duckdns.org>
 <CAHVum0dS+QxWFSK+evxQtZDHkZZx9pr0m_jEDHc9ovd5jQcfaA@mail.gmail.com>
 <X/SHiFHRsQM43VgC@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/SHiFHRsQM43VgC@mtj.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 05, 2021 at 10:36:40AM -0500, Tejun Heo wrote:
> Happy new year!
> 
> On Wed, Dec 16, 2020 at 12:02:37PM -0800, Vipin Sharma wrote:
> > I like the idea of having a separate controller to keep the code simple and
> > easier for maintenance.
> 
> Yeah, the more I think about it, keeping it separate seems like the right
> thing to do. What bothers me primarily is that the internal logic is
> identical between the RDMA controller and this one. If you wanna try
> factoring them out into library, great. If not, I don't think it should
> block merging this controller. We can get to refactoring later.
> 

Happy new year!
Sounds great, I will send out a new patch which will not reject the new
max limit based on the current usage. It will not include refactoring
out common code between RDMA and Encryption ID controller. We can pursue
that later.

Thanks
Vipin
