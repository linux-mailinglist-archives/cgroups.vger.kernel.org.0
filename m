Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9236F3397C2
	for <lists+cgroups@lfdr.de>; Fri, 12 Mar 2021 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhCLTtQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Mar 2021 14:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbhCLTsp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Mar 2021 14:48:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28BC061762
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 11:48:45 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o38so16530141pgm.9
        for <cgroups@vger.kernel.org>; Fri, 12 Mar 2021 11:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zuaTRfZk4KRzZSmxlNItyx5xWByHUkD0/JshLCV8WMM=;
        b=IaU52dkJTOEb+ySNKCWrDTgUccXTzzNVSIkFb/oKqISl2Zm82pfTIJJrINPh3gEISu
         wqODIgofIW2biXzNaXrk3K+R3ysiwdg1lxXYXgGwQhEoZim8L6kmWGvPvbPFsLuqwe2Q
         vVCGaYGtGcQzOgriqb7Hp2kKwnHn7/oAzr0LLbRo1OS1HxJtuPo8NChHgDBZXrOz/HOG
         VG/JR249fw7osncKemnky6bHNM+nEzmsBDygYDdRYTuS9U36krcOs5ZhiEDJ6Ylcq2sW
         2+IGeAShq0oeY79hz1mA+M0B0L64tNihivmYUoJmtqNaIdMvuwJtTIpBY/LhINyzP5aT
         1/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zuaTRfZk4KRzZSmxlNItyx5xWByHUkD0/JshLCV8WMM=;
        b=jHFpSpuWm2Dy7v3JWF44TW+2A+vcZPffL4yX4gws7AFV9An2xFeybcQtg1WM+eh/v/
         M7ydTPz7MyfELTmsGSeCT3ngHHsgqZ4fyhUVf2XH17gMSSrTrQZN8f5uXvw7jpKbuKpc
         wwVIbeC7cojrsmCz/BhlpUtrv3iwnfGtvVVF7O2IopYDg1GjWx3hXEldgC435C9NiopL
         kyku/CxnlVRjRuBu9UwqAumDOqQkhB62n2KQSRnqY/HscTtGTKNiVIHgsaRpRQDYTWxk
         mW3c/L4bg+K4niayFL7t7TWNp3pHzWHrklvIKpuFZN8IFmLlZY2fqf2OBztsf3WTv4y1
         +/rA==
X-Gm-Message-State: AOAM533wHXa+fdN/yXdnujECGuVbD8zAehtmwO+yu2eXDbsNBYt8Tx69
        130xCTMYFCBCZkTCYWPLOqkFtA==
X-Google-Smtp-Source: ABdhPJzGk8z+hRYJIelsgLmqze4xOJsszbrmql44ifGCVwomYJCoZkZ9EwNOwzZxf4uGsUWJtnSg9A==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr13639513pgd.385.1615578524487;
        Fri, 12 Mar 2021 11:48:44 -0800 (PST)
Received: from google.com ([2620:0:1008:10:18a1:1d64:e35b:961e])
        by smtp.gmail.com with ESMTPSA id d22sm5745803pfn.25.2021.03.12.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 11:48:43 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:48:37 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        thomas.lendacky@amd.com, brijesh.singh@amd.com
Cc:     tj@kernel.org, rdunlap@infradead.org, jon.grimm@amd.com,
        eric.vantassell@amd.com, pbonzini@redhat.com, hannes@cmpxchg.org,
        frankja@linux.ibm.com, borntraeger@de.ibm.com, corbet@lwn.net,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, gingell@google.com,
        rientjes@google.com, dionnaglaze@google.com, kvm@vger.kernel.org,
        x86@kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 1/2] cgroup: sev: Add misc cgroup controller
Message-ID: <YEvFldKZ8YQM+t2q@google.com>
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

On Thu, Mar 11, 2021 at 07:59:03PM +0100, Michal Koutný wrote:
> > +#ifndef CONFIG_KVM_AMD_SEV
> > +/*
> > + * When this config is not defined, SEV feature is not supported and APIs in
> > + * this file are not used but this file still gets compiled into the KVM AMD
> > + * module.
> > + *
> > + * We will not have MISC_CG_RES_SEV and MISC_CG_RES_SEV_ES entries in the enum
> > + * misc_res_type {} defined in linux/misc_cgroup.h.
> BTW, was there any progress on conditioning sev.c build on
> CONFIG_KVM_AMD_SEV? (So that the defines workaround isn't needeed.)

Tom, Brijesh,
Is this something you guys thought about or have some plans to do in the
future? Basically to not include sev.c in compilation if
CONFIG_KVM_AMD_SEV is disabled.

Michal,
This should not be a blocker for misc controller. This thing can change
independent of misc cgroup.

Thanks
Vipin
