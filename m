Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815DE27461C
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIVQFQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 12:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIVQFQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 12:05:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC42C0613CF
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 09:05:14 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k14so12316988pgi.9
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3cb2ln5okcTwbkZwIHw36/uS8TyOTC34MG+GPkwSrZc=;
        b=ket6MFsKGgeTKg06rAwU3VDAPgvifvWos8wL/PnPWPRsfN8itIg22pijPAXgFiUxD8
         Fd7QHl+cLoi+AojYI/uzZLiSnkiKfZrV0aT1MEDwgG5wUcL5BAy0o6ZN9q6zf5x5EzEe
         +vgACDfDyXI94Lso05jFSaPdPdjsYsl78/DZsmWSL+HdbBnaqlPM35rtfcVt5gLOelRw
         Yo9TEUDsIhXgyB14PuoaFO8HxUGK2iYlLlmUDF49sNxPlVfj/fCxmT+ONyEa9FVYQg8v
         qBO57Zf8p6I4kE7DkzGlQqZdpm45ZncnEFrK0CQkrt73NeKcuVR1Km00Fjp55T7bNcux
         ++6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3cb2ln5okcTwbkZwIHw36/uS8TyOTC34MG+GPkwSrZc=;
        b=LxYxsf/IDOcMSmtj0LRFMsDyT/WqSLHF6HJLmN8+BcXALtNO9+z0iHfWBvb0pk6K60
         2dyvJrenxBR0agOqI+0UdZuDAfLwbkniRLTWyWZKbAkasvYEMeAu6pnqNOeTXDbPo10r
         FjJNc5f2iVrIiNJzUWgfB4bU90bw/F8f36I6l5Z2V7tVHyxYVOu+ZY6XeUvNp7WFZCQv
         axfPTGA9mO/H0SQBU18MXjifgpJgva40suEPipJ3mEbj8YffzsaRDbT21Pyvj9LRxNZY
         BRjqStr9y4ZWJCOl6oS6rMyVJ1jZh+4A6P6aOD4xwy98XuHcsnx+Hg+JQISLK+a0CHRB
         hvmw==
X-Gm-Message-State: AOAM533ISqIB0ij1f/26f4UYlShrqdgxsfbVbscerlnlOovH/yv1Fi74
        Fxsc13we5OaDcnEhiBJA+u+MiQ==
X-Google-Smtp-Source: ABdhPJwDhQVCK5kMBC//E0Erf3yB57sWYMqIm4wY94GLY8PY9N2Jd3FgOvpyMgKERXA4LDx3m9cFUg==
X-Received: by 2002:a17:902:bb85:b029:d2:21cf:dc77 with SMTP id m5-20020a170902bb85b02900d221cfdc77mr5483863pls.66.1600790714148;
        Tue, 22 Sep 2020 09:05:14 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:1ea0:b8ff:fe75:b885])
        by smtp.gmail.com with ESMTPSA id i1sm15473209pfk.21.2020.09.22.09.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:05:13 -0700 (PDT)
Date:   Tue, 22 Sep 2020 09:05:08 -0700
From:   Vipin Sharma <vipinsh@google.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, thomas.lendacky@amd.com,
        pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com,
        joro@8bytes.org, corbet@lwn.net, brijesh.singh@amd.com,
        jon.grimm@amd.com, eric.vantassell@amd.com, gingell@google.com,
        rientjes@google.com, kvm@vger.kernel.org, x86@kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dionna Glaze <dionnaglaze@google.com>,
        Erdem Aktas <erdemaktas@google.com>
Subject: Re: [RFC Patch 1/2] KVM: SVM: Create SEV cgroup controller.
Message-ID: <20200922160508.GA4017872@google.com>
References: <20200922004024.3699923-1-vipinsh@google.com>
 <20200922004024.3699923-2-vipinsh@google.com>
 <94c3407d-07ca-8eaf-4073-4a5e2a3fb7b8@infradead.org>
 <20200922012227.GA26483@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922012227.GA26483@linux.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 21, 2020 at 06:22:28PM -0700, Sean Christopherson wrote:
> On Mon, Sep 21, 2020 at 06:04:04PM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > On 9/21/20 5:40 PM, Vipin Sharma wrote:
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d6a0b31b13dc..1a57c362b803 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1101,6 +1101,20 @@ config CGROUP_BPF
> > >  	  BPF_CGROUP_INET_INGRESS will be executed on the ingress path of
> > >  	  inet sockets.
> > >  
> > > +config CGROUP_SEV
> > > +	bool "SEV ASID controller"
> > > +	depends on KVM_AMD_SEV
> > > +	default n
> > > +	help
> > > +	  Provides a controller for AMD SEV ASIDs. This controller limits and
> > > +	  shows the total usage of SEV ASIDs used in encrypted VMs on AMD
> > > +	  processors. Whenever a new encrypted VM is created using SEV on an
> > > +	  AMD processor, this controller will check the current limit in the
> > > +	  cgroup to which the task belongs and will deny the SEV ASID if the
> > > +	  cgroup has already reached its limit.
> > > +
> > > +	  Say N if unsure.
> > 
> > Something here (either in the bool prompt string or the help text) should
> > let a reader know w.t.h. SEV means.
> > 
> > Without having to look in other places...
> 
> ASIDs too.  I'd also love to see more info in the docs and/or cover letter
> to explain why ASID management on SEV requires a cgroup.  I know what an
> ASID is, and have a decent idea of how KVM manages ASIDs for legacy VMs, but
> I know nothing about why ASIDs are limited for SEV and not legacy VMs.

Thanks for the feedback, I will add more details in the Kconfig and the
documentation about SEV and ASID.
