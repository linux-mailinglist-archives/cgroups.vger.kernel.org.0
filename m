Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABA3398F3
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhCLVPl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 16:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbhCLVPU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 16:15:20 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534CC061763
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 13:15:19 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n10so16666075pgl.10
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oK13NYYObq7fILet15UhnXXbfKNqEk2c8gMn7wJFCws=;
        b=L/HGcpkaoKR032Ed2ki/P9yv8JigIq1I+XKxVu7Ofi15Aw2uLnI9zseSnLb0HbWpkJ
         XkKtQeqG9NJjlGQ3Otgauzs6NMkxAh5sXneh2ZGDisPS4wAjGaeShvuHapM+QQabnPka
         vu0eFLci/ShYfmigzoVRXjHbKBTqk5P9e8yqvJscm/GaYakLFEBiyZflNAVYu/bwWREf
         LnmFkwJssPewJhlPRqeAwa6abZP9J/hSgZfwMws0IFJ4aeNXd3ppUL+NEJbI9rue7qsR
         vzGEQ1dTDt71MLv5xsaf5NAQ95F0lgx0IcGUFb7eS+E2XTlXxk7gOi7ypjpkVfjbiA6I
         mNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oK13NYYObq7fILet15UhnXXbfKNqEk2c8gMn7wJFCws=;
        b=ehnM/BRHmYO4Cu/L58he0cnB7Z0SB7YcFccX/8bCIQrErE2sw4oP5biuIUFWWnJhbn
         KB4w40ld20heFPB/w5EO+97BXN7ZZN4IyYy/nLXBvpsCKwX8pVQKrwXYBppAg7U2V4qK
         5FkhoUcpBwWXIqsQmDrmHDIWunH/x90LR8fbtxT5zM9G5EhZhEWXrjt8fgtIZJr+Koi2
         yRpFL6hlQddm2Eh3A30vpNrvvXbw6khMF0ja899ydYMWBlsqsr/9c6MiLwYTWGugKHV5
         n6D/zkRbPVTiVW6UKYJpfNifwbi/Z+byxJEPa+BPQYk8xnuMacAIY0nnexmRULcO6g24
         ck5w==
X-Gm-Message-State: AOAM5314lWXkw/dG6R2mD3g+91QpULYgLVrij1nqD7BDEBmwMHkYuKBC
        SjTox5v6hB+EBnnTXyaEmXclVg==
X-Google-Smtp-Source: ABdhPJy4/Uxnif26wUEK4U1K6ZPijd6cr4jh14DFJYjawn64Jo04S1CH1erOsWzJeiFa4ClQiuNfpA==
X-Received: by 2002:a62:b416:0:b029:1e4:fb5a:55bb with SMTP id h22-20020a62b4160000b02901e4fb5a55bbmr80217pfn.80.1615583719066;
        Fri, 12 Mar 2021 13:15:19 -0800 (PST)
Received: from google.com ([2620:0:1008:10:18a1:1d64:e35b:961e])
        by smtp.gmail.com with ESMTPSA id g21sm6621507pfk.30.2021.03.12.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 13:15:18 -0800 (PST)
Date:   Fri, 12 Mar 2021 13:15:14 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Tejun Heo <tj@kernel.org>, mkoutny@suse.com, rdunlap@infradead.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC v2 2/2] cgroup: sev: Miscellaneous cgroup documentation.
Message-ID: <YEvZ4muXqiSScQ8i@google.com>
References: <20210302081705.1990283-1-vipinsh@google.com>
 <20210302081705.1990283-3-vipinsh@google.com>
 <20210303185513.27e18fce@jacob-builder>
 <YEB8i6Chq4K/GGF6@google.com>
 <YECfhCJtHUL9cB2L@slm.duckdns.org>
 <20210312125821.22d9bfca@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312125821.22d9bfca@jacob-builder>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 12, 2021 at 12:58:21PM -0800, Jacob Pan wrote:
> Hi Vipin & Tejun,
> 
> Sorry for the late reply, I sent from a different email address than I
> intended. Please see my comments inline.
> 
> 
> On Thu, 4 Mar 2021 03:51:16 -0500, Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Wed, Mar 03, 2021 at 10:22:03PM -0800, Vipin Sharma wrote:
> > > > I am trying to see if IOASIDs cgroup can also fit in this misc
> > > > controller as yet another resource type.
> > > > https://lore.kernel.org/linux-iommu/20210303131726.7a8cb169@jacob-builder/T/#u
> > > > However, unlike sev IOASIDs need to be migrated if the process is
> > > > moved to another cgroup. i.e. charge the destination and uncharge the
> > > > source.
> > > > 
> > > > Do you think this behavior can be achieved by differentiating resource
> > > > types? i.e. add attach callbacks for certain types. Having a single
> > > > misc interface seems cleaner than creating another controller.  
> > > 
> > > I think it makes sense to add support for migration for the resources
> > > which need it. Resources like SEV, SEV-ES will not participate in
> > > migration and won't stop can_attach() to succeed, other resources which
> > > need migration will allow or stop based on their limits and capacity in
> > > the destination.  
> > 
> Sounds good. Perhaps some capability/feature flags for each resource such
> that different behavior can be accommodated?
> Could you please include me in your future posting? I will rebase on yours.

Hi Jacob

Based on Tejun's response, I will not add charge migration support in
misc controller.

I can definitly add you in my future posting, if you still wanna use it
without charge migration support.

Thanks
Vipin
