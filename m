Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BCD7C45CC
	for <lists+cgroups@lfdr.de>; Wed, 11 Oct 2023 02:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJKABc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Oct 2023 20:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344268AbjJKAB3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Oct 2023 20:01:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097D91
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 17:01:27 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f61a639b9so96101467b3.1
        for <cgroups@vger.kernel.org>; Tue, 10 Oct 2023 17:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696982487; x=1697587287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx6blw3s97QmWxGpjq4G1Ep7AiFARQsfwR/ogZE8NGk=;
        b=cYxIPgft69sX9irmLtF0U6HBpxczMc/SfecP0u31r3wQL1jpZy51X2LfuGlmvkdg8X
         QAP5NEAC18akGQHyT7LThqI160sgPyslaSr6zqbC5+znjgtk33z+f2bt+4Tp/bejRJkj
         KfKzdhcg8q64gUR7aY4CDIFWk/XQ1m1PbqwlsXW0jOZDoTM72Dno0ByIrXhX5WG5/QLi
         IRsYElQ6aGhAsUuV5U4pBBBDDdjlmcfnSn39b+Y3FA5yfyew1VSfqXkvUULIEeIIr6b6
         jNhysV1DfFHQenxyRnVwUsp+WZAf0Heqim2KshNGIQGGI9yEzkBU5y8FtM8Tmhb/dL9u
         sNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982487; x=1697587287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zx6blw3s97QmWxGpjq4G1Ep7AiFARQsfwR/ogZE8NGk=;
        b=OvVmkAzyoqSCsPU2BBshTTdGA6GYLXboTj4s0L0ZBbIg4w3BvenVapKuSgehBeMxf1
         Sm29jNxhOfcq0HAuh57aYb8OOEeFU5YjIc26Vb86Hf103cuVC677dNoxhm2JuEEkAh/n
         TTbk047cloChAergle2NTTDD8bioIQCVnNCCuYEnpnL+hxtm8kWQWrLfBC/N8mCpQeQi
         4wV8HwhNYKTujT+69A1yBb8Q9TMoDOhvkQNzmDAbrFvq2jghHjgKk2OgVzbs7GJN9z05
         KkWWvsjOeaGImgeJEC/VAcBelspf/ygdHJP2Ayki/CwVExRNsA4+mYcgS+Ro24upjSrK
         CW+A==
X-Gm-Message-State: AOJu0YxoScY3OfKv0E2bDIoDPdrhnuxhwf9CUPqJ2jJTkPGcv+o6BRUa
        S6xEUsaU2CCSc8843kmHhdXwHtbRIMM=
X-Google-Smtp-Source: AGHT+IEKuW2OKzqEEWYv+2fZtWZtfiPj3BAGUj929Zhf8Qm2555JJ1KwmHC9AyWLdElRmEBP1Fx5a9qarns=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ca4d:0:b0:59b:e81f:62ab with SMTP id
 y13-20020a81ca4d000000b0059be81f62abmr403963ywk.7.1696982486958; Tue, 10 Oct
 2023 17:01:26 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:01:25 -0700
In-Reply-To: <op.2clox2zewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Mime-Version: 1.0
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com> <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com> <op.2cksdjamwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <548d2ab828307f7d1c6d7f707e587cd27b0e7fe4.camel@intel.com> <op.2clox2zewjvjmi@hhuan26-mobl.amr.corp.intel.com>
Message-ID: <ZSXl1VXTM0c8qpZj@google.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim EPC
From:   Sean Christopherson <seanjc@google.com>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Kai Huang <kai.huang@intel.com>, Bo Zhang <zhanb@microsoft.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        Zhiquan1 Li <zhiquan1.li@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 10, 2023, Haitao Huang wrote:
> On Mon, 09 Oct 2023 21:23:12 -0500, Huang, Kai <kai.huang@intel.com> wrote:
> 
> > On Mon, 2023-10-09 at 20:42 -0500, Haitao Huang wrote:
> > > Hi Sean
> > > 
> > > On Mon, 09 Oct 2023 19:23:04 -0500, Sean Christopherson
> > > <seanjc@google.com> wrote:
> > > > I can see userspace wanting to explicitly terminate the VM instead of
> > > > "silently"
> > > > the VM's enclaves, but that seems like it should be a knob in the
> > > > virtual EPC
> > > > code.
> > > 
> > > If my understanding above is correct and understanding your statement
> > > above correctly, then don't see we really need separate knob for vEPC
> > > code. Reaching a cgroup limit by a running guest (assuming dynamic
> > > allocation implemented) should not translate automatically killing
> > > the VM.
> > > Instead, it's user space job to work with guest to handle allocation
> > > failure. Guest could page and kill enclaves.
> > > 
> > 
> > IIUC Sean was talking about changing misc.max _after_ you launch SGX VMs:
> > 
> > 1) misc.max = 100M
> > 2) Launch VMs with total virtual EPC size = 100M	<- success
> > 3) misc.max = 50M
> > 
> > 3) will also succeed, but nothing will happen, the VMs will be still
> > holding 100M EPC.
> > 
> > You need to somehow track virtual EPC and kill VM instead.
> > 
> > (or somehow fail to do 3) if it is also an acceptable option.)
> > 
> Thanks for explaining it.
> 
> There is an error code to return from max_write. I can add that too to the
> callback definition and fail it when it can't be enforced for any reason.
> Would like some community feedback if this is acceptable though.

That likely isn't acceptable.  E.g. create a cgroup with both a host enclave and
virtual EPC, set the hard limit to 100MiB.  Virtual EPC consumes 50MiB, and the
host enclave consumes 50MiB.  Userspace lowers the limit to 49MiB.  The cgroup
code would reclaim all of the enclave's reclaimable EPC, and then kill the enclave
because it's still over the limit.  And then fail the max_write because the cgroup
is *still* over the limit.  So in addition to burning a lot of cycles, from
userspace's perspective its enclave was killed for no reason, as the new limit
wasn't actually set.

> I think to solve it ultimately, we need be able to adjust 'capacity' of VMs
> not to just kill them, which is basically the same as dynamic allocation
> support for VMs (being able to increase/decrease epc size when it is
> running). For now, we only have static allocation so max can't be enforced
> once it is launched.

No, reclaiming virtual EPC is not a requirement.  VMM EPC oversubscription is
insanely complex, and I highly doubt any users actually want to oversubcribe VMs.

There are use cases for cgroups beyond oversubscribing/swapping, e.g. privileged
userspace may set limits on a container to ensure the container doesn't *accidentally*
consume more EPC than it was allotted, e.g. due to a configuration bug that created
a VM with more EPC than it was supposed to have.  

My comments on virtual EPC vs. cgroups is much more about having sane, well-defined
behavior, not about saying the kernel actually needs to support oversubscribing EPC
for KVM guests.
