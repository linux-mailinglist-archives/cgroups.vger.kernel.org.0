Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AAF7CB551
	for <lists+cgroups@lfdr.de>; Mon, 16 Oct 2023 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJPVcg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVcf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 17:32:35 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE194A7
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 14:32:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9c939cc94so37664185ad.1
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 14:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697491953; x=1698096753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+t15XOMF8Yqimk8R2WgZJ6PJZRWQZddWx2hFeG4o13M=;
        b=hFvcy9PEmmo0QNNVLwXpHUcGnJ4AhGnvtLiZO4Ks+tOeAE4FGzQLiycFdaC0F3Wwgk
         94ikGqvnGcqoRuteuXz1aeWfwnW6veqLdXZpMit3d/vmpUEYjtcd5IYKu2seOO5iJlY9
         +rxcKhVtghO1MyNbBF1FwFjKq+QZK1KfqSZg4+hW0uZDa0G07+jXtLKRActVuEht41Np
         +IeU2JsFK3TpVGDhtI1g3IJgu1GNZH9Z08dUBLnrP/w6f1/QALgZrk3THJGUo4zefnyj
         fcK1+wQMC01Oh/0/FkYVa48h/vHuPVv1EWVnc6uYl6Uzf9KXMyQTdrf+2VYYgg3cyP/1
         Lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697491953; x=1698096753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t15XOMF8Yqimk8R2WgZJ6PJZRWQZddWx2hFeG4o13M=;
        b=KcNqrvMLs1teX2hY5Khx3PGgQyld9cdpGK9BGvfNnpYh406MUyAIXbKVjKooi9QuVd
         yhKKN5qjJ5v9WLmBaGGad0qs1WOtqfLTKe8u1sxwXW4Vbd9G6aLdeTmZB5wU1AvKlTzZ
         0XVByNCKngQbAt3LPHsclEcZEkKs6J6kUmqFtyvFYn3P35yS/Qi48D0NU8gur8aMsJAE
         BIRwox9Vzg0G20SM8d4QWQob42EFpLND5U/Vzf5rt6/7QNvh1xuyCRFIU4zD2u07ttw8
         dNkGQ4301RwPzKMyT4LTdlLkR25LiWPTKbikE9IrDBLJHzjtZ5UPuQ8u7H5TgKCPuqaN
         8umA==
X-Gm-Message-State: AOJu0Ywl+nQOExTS5WSqWw+VESBKH1XCF6CQ+0yeYpL4jx0TwB8rePmR
        sFvK9hBavjXzTy3LHEtHdH5BgSOyqEs=
X-Google-Smtp-Source: AGHT+IE6Gm95fqx0JC6BEhdIzOrR5zXb+sa8Sase/8Z7RiVJkC4hqH8082U4743Kum3fpsqf1eYfGLxMISc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:706:b0:1c5:7c07:e403 with SMTP id
 kk6-20020a170903070600b001c57c07e403mr9215plb.10.1697491953065; Mon, 16 Oct
 2023 14:32:33 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:32:31 -0700
In-Reply-To: <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Mime-Version: 1.0
References: <20230923030657.16148-13-haitao.huang@linux.intel.com>
 <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
 <ZSSZaFrxvCvR1SOy@google.com> <06142144151da06772a9f0cc195a3c8ffcbc07b7.camel@intel.com>
 <1f7a740f3acff8a04ec95be39864fb3e32d2d96c.camel@intel.com>
 <op.2clydbf8wjvjmi@hhuan26-mobl.amr.corp.intel.com> <631f34613bcc8b5aa41cf519fa9d76bcd57a7650.camel@intel.com>
 <op.2cpecbevwjvjmi@hhuan26-mobl.amr.corp.intel.com> <aa404549c7e292dd2ec93a5e6a8c9d6d880c06b3.camel@intel.com>
 <op.2cxatlafwjvjmi@hhuan26-mobl.amr.corp.intel.com>
Message-ID: <ZS2r7-EAEovpV4BN@google.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 16, 2023, Haitao Huang wrote:
> From this perspective, I think the current implementation is "well-defined":
> EPC cgroup limits for VMs are only enforced at VM launch time, not runtime.
> In practice,  SGX VM can be launched only with fixed EPC size and all those
> EPCs are fully committed to the VM once launched.

Fully committed doesn't mean those numbers are reflected in the cgroup.  A VM
scheduler can easily "commit" EPC to a guest, but allocate EPC on demand, i.e.
when the guest attempts to actually access a page.  Preallocating memory isn't
free, e.g. it can slow down guest boot, so it's entirely reasonable to have virtual
EPC be allocated on-demand.  Enforcing at launch time doesn't work for such setups,
because from the cgroup's perspective, the VM is using 0 pages of EPC at launch.

> Because of that, I imagine people are using VMs to primarily partition the
> physical EPCs, i.e, the static size itself is the 'limit' for the workload of
> a single VM and not expecting EPCs taken away at runtime.

If everything goes exactly as planned, sure.  But it's not hard to imagine some
configuration change way up the stack resulting in the hard limit for an EPC cgroup
being lowered.

> So killing does not really add much value for the existing usages IIUC.

As I said earlier, the behavior doesn't have to result in terminating a VM, e.g.
the virtual EPC code could provide a knob to send a signal/notification if the
owning cgroup has gone above the limit and the VM is targeted for forced reclaim.

> That said, I don't anticipate adding the enforcement of killing VMs at
> runtime would break such usages as admin/user can simply choose to set the
> limit equal to the static size to launch the VM and forget about it.
> 
> Given that, I'll propose an add-on patch to this series as RFC and have some
> feedback from community before we decide if that needs be included in first
> version or we can skip it until we have EPC reclaiming for VMs.

Gracefully *swapping* virtual EPC isn't required for oversubscribing virtual EPC.
Think of it like airlines overselling tickets.  The airline sells more tickets
than they have seats, and banks on some passengers canceling.  If too many people
show up, the airline doesn't swap passengers to the cargo bay, they just shunt them
to a different plane.

The same could be easily be done for hosts and virtual EPC.  E.g. if every VM
*might* use 1GiB, but in practice 99% of VMs only consume 128MiB, then it's not
too crazy to advertise 1GiB to each VM, but only actually carve out 256MiB per VM
in order to pack more VMs on a host.  If the host needs to free up EPC, then the
most problematic VMs can be migrated to a different host.

Genuinely curious, who is asking for EPC cgroup support that *isn't* running VMs?
AFAIK, these days, SGX is primarily targeted at cloud.  I assume virtual EPC is
the primary use case for an EPC cgroup.

I don't have any skin in the game beyond my name being attached to some of the
patches, i.e. I certainly won't stand in the way.  I just don't understand why
you would go through all the effort of adding an EPC cgroup and then not go the
extra few steps to enforce limits for virtual EPC.  Compared to the complexity
of the rest of the series, that little bit seems quite trivial.
