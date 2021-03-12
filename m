Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA85339723
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 20:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbhCLTHi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 14:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbhCLTHW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 14:07:22 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CC4C061574
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 11:07:22 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so11180878pjq.5
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 11:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tJjzSwOgveQ7vdx3Cu3uc6PULmHuHzmVLjdTR0gLlhA=;
        b=ntQoBbcWXqtifUBev/B0KOJ7BdEhMcK4Vt5DvxlbjWTaLmYcIzto4hVOQ019Ktjclt
         IzpMHUC/yiAR42nNISAaWyzIojLrbFqvLiuqfCJeg4pkWHKlQIuqvE/fB5ka2n9/pkxv
         YKc+kNafGRjUbzhy/8GpyCOkWZhLaF7gTkkwxvjBQ05Zb4MpXjI1NEx/9kHWr5VG/hr9
         fyFTu4Dx4sGcxcI4/77RGpWwmxVRidKc9jp2iRX8mPbvdvav/UYKiLxb3Kwnjf/GxyYm
         jnVuPX8KHdjB2ohJT5DD6zNXt2j3Go/jUeaKAltxlVB+ClDE9O+cvF1HmjxqqD3oE3ec
         Q9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tJjzSwOgveQ7vdx3Cu3uc6PULmHuHzmVLjdTR0gLlhA=;
        b=Jb9rwWmZDgFAcLx3brf0MDaQbCgUnHaV8NxVh0+Qcjb2vsip+gbcwkBwOVNndFpR8q
         I0y+7Q8wq0+B92svJPS8FGs3FIooUy5aEhxvz2FcYUX2RBFdtmtJUL+UgkhEDYbV7CTe
         ln4cP9QdeoRDkfVzXNKIYSL6Q18ibTgNdWvL/UaskR9FJfADjCFX7jVP3yIkk0jKnXKL
         0A5nyiZX6rg9hSvCCUZXjBDlcedTIjwLuwQfVuKj85HKNLdDQ7+GqX5PPizA3/fOQVe6
         FvuIuYQnCc/iQWmpSnJ1niWda6CfKw8wLRif+7502xaXCyVCjoMjyScTOxhrWGubPEuj
         2Qyg==
X-Gm-Message-State: AOAM533hdsYVzUSxgTuQoQLf8Wx5p5Olxqh06wjJ/jGGysa/gCIkTRv8
        X5y1ewPT2F/YXf+a8tL8wIqwLw==
X-Google-Smtp-Source: ABdhPJyGnJc8lVpyplLP6vlQnQwwdL2pHC8tPobUN/3QxEpjMo2qw2d2f4Wb0MPIAgUMFkwynpk4RA==
X-Received: by 2002:a17:902:ba0a:b029:e6:5c5c:d3b8 with SMTP id j10-20020a170902ba0ab02900e65c5cd3b8mr466876pls.79.1615576041235;
        Fri, 12 Mar 2021 11:07:21 -0800 (PST)
Received: from google.com ([2620:0:1008:10:18a1:1d64:e35b:961e])
        by smtp.gmail.com with ESMTPSA id b3sm2917024pjg.41.2021.03.12.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:07:20 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:07:14 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     tj@kernel.org, rdunlap@infradead.org, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, jon.grimm@amd.com, eric.vantassell@amd.com,
        pbonzini@redhat.com, hannes@cmpxchg.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, corbet@lwn.net, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/2] cgroup: sev: Add misc cgroup controller
Message-ID: <YEu74hkEPEyvxC85@google.com>
References: <20210304231946.2766648-1-vipinsh@google.com>
 <20210304231946.2766648-2-vipinsh@google.com>
 <YEpod5X29YqMhW/g@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEpod5X29YqMhW/g@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 11, 2021 at 07:59:03PM +0100, Michal Koutn� wrote:
> Given different two-fold nature (SEV caller vs misc controller) of some
> remarks below, I think it makes sense to split this into two patches:
> a) generic controller implementation,
> b) hooking the controller into SEV ASIDs management.

Sounds good. I will split it.

> > +	if (misc_res_capacity[type])
> > +		cg->res[type].max = max;
> In theory, parallel writers can clash here, so having the limit atomic
> type to prevent this would resolve it. See also commit a713af394cf3
> ("cgroup: pids: use atomic64_t for pids->limit").

We should be fine without atomic64_t because we are using unsigned
long and not 64 bit explicitly. This will work on both 32 and 64 bit
machines.

But I will add READ_ONCE and WRITE_ONCE because of potential chances of
load tearing and store tearing.

Do you agree?

> > +static int misc_cg_capacity_show(struct seq_file *sf, void *v)
> > +{
> > +	int i;
> > +	unsigned long cap;
> > +
> > +	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
> > +		cap = READ_ONCE(misc_res_capacity[i]);
> Why is READ_ONCE only here and not in other places that (actually) check
> against the set capacity value? Also, there should be a paired
> WRITE_ONCCE in misc_cg_set_capacity().

This was only here to avoid multiple reads of capacity and making sure
if condition and seq_print will see the same value. Also, I was not
aware of load and store tearing of properly aligned and machine word
size variables. I will add READ_ONCE and WRITE_ONCE at
other places.

Thanks
Vipin
