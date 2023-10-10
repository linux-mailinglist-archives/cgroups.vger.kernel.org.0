Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74097BEFAE
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379142AbjJJAXI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379131AbjJJAXH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:23:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50595A3
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 17:23:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2774c52c8f2so3796776a91.3
        for <cgroups@vger.kernel.org>; Mon, 09 Oct 2023 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696897386; x=1697502186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOn+6Spq2azhJkMg4hExaP36H5dFsqw/dQxW+wM3h5A=;
        b=elUE81bOuBUsQZz+1J97nnnLIjk9GOLa4ydCYixXlK8Tng4gnxKDb9/VzfrHd/6wXu
         iBFWL+JtOMvUTAmLLK/Rmb2Z1ic2TN3BI9ZLjjfCHSnWxhDNlK9mmchX6ffA5K90nlAK
         hS5ZN/T9XQvIM7Bksz3D/xBxxwE89Wnh7zEfi+lgf35VXST3G/ht8w3cZ03ndytJhFew
         bnUJqvYck4v+p6WUq+n7sg6kfOzLRjcDK/s4v1iih6OcMowl0LFuxB4d86Inb+3WTvip
         Nj2KLBat0kYfOoFx0QCZOWoMSuH0bnAKkyayMrIfspqwGZRcXaKzNtNDTewyvUFiavOW
         3SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696897386; x=1697502186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOn+6Spq2azhJkMg4hExaP36H5dFsqw/dQxW+wM3h5A=;
        b=E02HOQ4XxW7Pk779AMhXPc1kSZCMKxHxZ/hI4CV2r2wMkVuZDMTIec/s33cF4MmICb
         yE+xZ8bSi/ykY8EHUjOi9oPIpcfU9J6C8IUUI66wqAv5Co4U7tJN/mJV3U4hMgd7Zb0u
         sGc7L/bpu0wpUS6X60ewpNHSSy5mcNigplZ2fB0uui1BhA15dET22sXlkp+k4Xm5C/+q
         FQScJ/fKOAwWKybF/HHaog0JWVsqPy4oflZtsjE3LCHY+wAGAsHly1GSiIdhWCd/7ECz
         HorUyM0wETI7/tFPuGukucOwK8PeQehCIDzX6dufMSxoZQFqZxu9DqQVAJp6vU2TnR3l
         hSOQ==
X-Gm-Message-State: AOJu0YzJ26gUdJNAEadQRlHEi2jVUrMfYh0vUT78NOWjZ2+2sJtjLN5d
        hjK4rSMuC0TUlq71MQFvq8s6VrYBJ6c=
X-Google-Smtp-Source: AGHT+IFbLc/n3uo86Z6tpo0jwuobqrfsfh2GTwbO6SZvqH3v5T1VXwhgu4RyQspmY0Br2txC4DPxt5YNr6o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cb8b:b0:268:8e93:6459 with SMTP id
 a11-20020a17090acb8b00b002688e936459mr283509pju.8.1696897385772; Mon, 09 Oct
 2023 17:23:05 -0700 (PDT)
Date:   Mon, 9 Oct 2023 17:23:04 -0700
In-Reply-To: <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
Mime-Version: 1.0
References: <20230923030657.16148-1-haitao.huang@linux.intel.com>
 <20230923030657.16148-13-haitao.huang@linux.intel.com> <1b265d0c9dfe17de2782962ed26a99cc9d330138.camel@intel.com>
Message-ID: <ZSSZaFrxvCvR1SOy@google.com>
Subject: Re: [PATCH v5 12/18] x86/sgx: Add EPC OOM path to forcefully reclaim EPC
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "yangjie@microsoft.com" <yangjie@microsoft.com>,
        Zhiquan1 Li <zhiquan1.li@intel.com>,
        "mikko.ylinen@linux.intel.com" <mikko.ylinen@linux.intel.com>,
        Bo Zhang <zhanb@microsoft.com>,
        "anakrish@microsoft.com" <anakrish@microsoft.com>
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

On Mon, Oct 09, 2023, Kai Huang wrote:
> On Fri, 2023-09-22 at 20:06 -0700, Haitao Huang wrote:
> > +/**
> > + * sgx_epc_oom() - invoke EPC out-of-memory handling on target LRU
> > + * @lru:	LRU that is low
> > + *
> > + * Return:	%true if a victim was found and kicked.
> > + */
> > +bool sgx_epc_oom(struct sgx_epc_lru_lists *lru)
> > +{
> > +	struct sgx_epc_page *victim;
> > +
> > +	spin_lock(&lru->lock);
> > +	victim = sgx_oom_get_victim(lru);
> > +	spin_unlock(&lru->lock);
> > +
> > +	if (!victim)
> > +		return false;
> > +
> > +	if (victim->flags & SGX_EPC_OWNER_PAGE)
> > +		return sgx_oom_encl_page(victim->encl_page);
> > +
> > +	if (victim->flags & SGX_EPC_OWNER_ENCL)
> > +		return sgx_oom_encl(victim->encl);
> 
> I hate to bring this up, at least at this stage, but I am wondering why we need
> to put VA and SECS pages to the unreclaimable list, but cannot keep an
> "enclave_list" instead?

The motivation for tracking EPC pages instead of enclaves was so that the EPC
OOM-killer could "kill" VMs as well as host-owned enclaves.  The virtual EPC code
didn't actually kill the VM process, it instead just freed all of the EPC pages
and abused the SGX architecture to effectively make the guest recreate all its
enclaves (IIRC, QEMU does the same thing to "support" live migration).

Looks like y'all punted on that with:

  The EPC pages allocated for KVM guests by the virtual EPC driver are not
  reclaimable by the host kernel [5]. Therefore they are not tracked by any
  LRU lists for reclaiming purposes in this implementation, but they are
  charged toward the cgroup of the user processs (e.g., QEMU) launching the
  guest.  And when the cgroup EPC usage reaches its limit, the virtual EPC
  driver will stop allocating more EPC for the VM, and return SIGBUS to the
  user process which would abort the VM launch.

which IMO is a hack, unless returning SIGBUS is actually enforced somehow.  Relying
on userspace to be kind enough to kill its VMs kinda defeats the purpose of cgroup
enforcement.  E.g. if the hard limit for a EPC cgroup is lowered, userspace running
encalves in a VM could continue on and refuse to give up its EPC, and thus run above
its limit in perpetuity.

I can see userspace wanting to explicitly terminate the VM instead of "silently"
the VM's enclaves, but that seems like it should be a knob in the virtual EPC
code.
