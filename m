Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC167CC7A9
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344414AbjJQPnO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Oct 2023 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbjJQPnO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Oct 2023 11:43:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984509E
        for <cgroups@vger.kernel.org>; Tue, 17 Oct 2023 08:43:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5836ab12so8133340276.2
        for <cgroups@vger.kernel.org>; Tue, 17 Oct 2023 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697557392; x=1698162192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=afIEXriDw7jR2OJmvlYsK5e8xjDzcS+IGLCS2GPyEaM=;
        b=mrzTpio76QStYgRsezbdWzx3S6MEiwNa7MbZutTB7mbca7K8vxFaL+FaYUWEJNVK6t
         g5cDfuRnPPO1BRC1u3+vFpdozvXu//2qUr76dH6x7ZYFgyucnIykBlhD1UOFmRCxwIOM
         SEPJiZIUsJGjJlfX/U7dMlLrd660fKTnsm2NSbgF3QW2GBBhZ9WPzA+lS45vy1jGi5Ml
         QyUePYtFkHU/pE/zUEweXfHBOxvLnfX85cz7woAa1RnB8DVIZeJrqE2oszW82J70KLs5
         oDpoY6YmoTt97YV63GFi1sh2hWf5eMTeuusao4InlN/qylIiRsgvCzdhNlP25aJHmjMx
         1lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557392; x=1698162192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afIEXriDw7jR2OJmvlYsK5e8xjDzcS+IGLCS2GPyEaM=;
        b=j8Li04sSOkmXAQ6Q7gMTrp6bfJoRKgkIMWrL3f5QBgihkFaRqgcaL5mGN3Q0USFs+S
         ZeOvvrS77R/nkDTfRq0vpg5NsytGXCEPOgK2Dd+4ncEYlY/lCUwiV+ZNeBvpDT6TDEzB
         /KuqAiFswRvw8vMl3R+bS0NdgBsdvMimFaUa26cDXyu/c7eCxYszoZXUu8pHS6ztuHhz
         Nu1DPMOkdf6U7zHKANJArueHcxz2CiVQTPoRhJIR5h+hiz0ZlxquIzVHgx0h+RmOyGmU
         7x2jYtDQUltwkEhl1INuyXIJSFUb2VOG9v+EEf18/ifTYmNRGS+cPHOVpqooa4gdUNVd
         HWrQ==
X-Gm-Message-State: AOJu0YwsrTSYDlWOznWunLzzXn1U3nZ+MrsYgZfiMWPtewQnKBl2cCpP
        Yc+BWx4btPbK6N0Pmd1zW0fta2onw14=
X-Google-Smtp-Source: AGHT+IFgFUQkHTOxsDh5kg7JObNGko3z6UdVNpTTp7isgRewlD1X4IdVH+92V/I/WdEsF3jIGvSWi88MtXA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d885:0:b0:d9a:c27e:5f38 with SMTP id
 p127-20020a25d885000000b00d9ac27e5f38mr49168ybg.12.1697557391852; Tue, 17 Oct
 2023 08:43:11 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:43:10 -0700
In-Reply-To: <op.2cxmpe1awjvjmi@hhuan26-mobl.amr.corp.intel.com>
Mime-Version: 1.0
References: <ZSSZaFrxvCvR1SOy@google.com> <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com> <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com> <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com> <ZS2r7-EAEovpV4BN@google.com>
 <op.2cxmpe1awjvjmi@hhuan26-mobl.amr.corp.intel.com>
Message-ID: <ZS6rjthamgvlzoXD@google.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim EPC
From:   Sean Christopherson <seanjc@google.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Kai Huang <kai.huang@intel.com>, Bo Zhang <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Zhiquan1 Li <zhiquan1.li@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 16, 2023, Haitao Huang wrote:
> Hi Sean
> 
> On Mon, 16 Oct 2023 16:32:31 -0500, Sean Christopherson <seanjc@google.com>
> wrote:
> 
> > On Mon, Oct 16, 2023, Haitao Huang wrote:
> > > From this perspective, I think the current implementation is
> > > "well-defined":
> > > EPC cgroup limits for VMs are only enforced at VM launch time, not
> > > runtime.  In practice,  SGX VM can be launched only with fixed EPC size
> > > and all those EPCs are fully committed to the VM once launched.
> > 
> > Fully committed doesn't mean those numbers are reflected in the cgroup.  A
> > VM scheduler can easily "commit" EPC to a guest, but allocate EPC on
> > demand, i.e.  when the guest attempts to actually access a page.
> > Preallocating memory isn't free, e.g. it can slow down guest boot, so it's
> > entirely reasonable to have virtual EPC be allocated on-demand.  Enforcing
> > at launch time doesn't work for such setups, because from the cgroup's
> > perspective, the VM is using 0 pages of EPC at launch.
> > 
> Maybe I understood the current implementation wrong. From what I see, vEPC
> is impossible not fully commit at launch time. The guest would EREMOVE all
> pages during initialization resulting #PF and all pages allocated. This
> essentially makes "prealloc=off" the same as "prealloc=on".
> Unless you are talking about some custom OS or kernel other than upstream
> Linux here?

Yes, a customer could be running an older kernel, something other than Linux, a
custom kernel, an out-of-tree SGX driver, etc.  The host should never assume
anything about the guest kernel when it comes to correctness (unless the guest
kernel is controlled by the host).

Doing EREMOVE on all pages is definitely not mandatory, especially if the kernel
detects a hypervisor, i.e. knows its running as a guest.
