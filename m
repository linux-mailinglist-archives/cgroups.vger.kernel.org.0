Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECA324769
	for <lists+cgroups@lfdr.de>; Thu, 25 Feb 2021 00:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhBXXOK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Feb 2021 18:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhBXXOJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Feb 2021 18:14:09 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B1C061786
        for <cgroups@vger.kernel.org>; Wed, 24 Feb 2021 15:13:29 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id e6so2524964pgk.5
        for <cgroups@vger.kernel.org>; Wed, 24 Feb 2021 15:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=muWCsWrQoBXyu4MckQ9XwIgh71Pik8fohBKy8+YwG04=;
        b=eALgcZew2EajyVeA/DiBEfM4a24dApZHnvUSzXm8kKOfeR1mXWz+bNzjmsq3m/8hka
         aYPKhw/8/x67hSwUlOdFPiH6qFX9rkoBkdESplPOCsj+JbhWaEasMiAEJ8AgzYIAqm4p
         yp67ujCmh5HofiMxCbHagDi6aOpZ+DYHw/28E0B6cYsGbwJ2RKhYBUtvsLz9dMsfm8gl
         1hwODTkdUw1wXyhfduiO3n9tXE81lWrCqXiRDudm/cd+QUo6Vx0uktrikPYHPySKbZ3v
         Y+quj12JNP7Ur3mxgMxUor82l251R8I8o3h1oJHehxxHbxjaCpy83dNl1o9exjZC+ZeX
         x6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=muWCsWrQoBXyu4MckQ9XwIgh71Pik8fohBKy8+YwG04=;
        b=hVfCJ8yN8wFO206lU9Z+8q9Fav1NiBK4y7qblA3XXD+wdT2+eGiyqnzgAq9lmtIVYM
         ydWppTLvDQAD1pL/J9ipwy9PfnTAgWx9rwJaBpFfF/Odo9CVy8CNslrrMbOVFo01kL0O
         ZO6LJf5khCQpDKujF2V+bk//LGQJNVMyIT8ppArHDHecd32ZL8RmNxz/37KfZ0giPIW3
         MVcvltA3OMbaQkgcgl6tniJIbh0Nm78DZY9ee4qwu3niB7CbasilPQAjdgD5ctUMTMCj
         dmWgbGp46F3lg/5wEAX8i4dJYFsiTGhZy+hbW2aDmiBP5Cs8H6PJAZVpzAIECCAIOs81
         qMiw==
X-Gm-Message-State: AOAM5300kMwGunhXDsX7qpz/58Q1C6jyNUpwIKmAEdq2rwVx+sog+QoK
        axnnk2d6L4VvoFvFnYSMn7xs6g==
X-Google-Smtp-Source: ABdhPJyvL7EJ65szTm5CqCguT3Le4nTVYm9ifanT54NrHZFg7olEuboR95EaeuMWTGAASbHj1KswEQ==
X-Received: by 2002:aa7:8c49:0:b029:1ed:c1dc:4421 with SMTP id e9-20020aa78c490000b02901edc1dc4421mr318307pfd.43.1614208408889;
        Wed, 24 Feb 2021 15:13:28 -0800 (PST)
Received: from google.com ([2620:0:1008:10:94bf:1b67:285c:b7ce])
        by smtp.gmail.com with ESMTPSA id o65sm2713167pfg.44.2021.02.24.15.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 15:13:28 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:13:23 -0800
From:   Vipin Sharma <vipinsh@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     tj@kernel.org, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        jon.grimm@amd.com, eric.vantassell@amd.com, pbonzini@redhat.com,
        hannes@cmpxchg.org, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        corbet@lwn.net, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gingell@google.com, rientjes@google.com, dionnaglaze@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] cgroup: sev: Miscellaneous cgroup documentation.
Message-ID: <YDbdk/aY88t/khY2@google.com>
References: <20210218195549.1696769-1-vipinsh@google.com>
 <20210218195549.1696769-3-vipinsh@google.com>
 <71092e0e-5c72-924b-c848-8ae9a589f6b0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71092e0e-5c72-924b-c848-8ae9a589f6b0@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 19, 2021 at 11:02:41AM -0800, Randy Dunlap wrote:
> > +++ b/Documentation/admin-guide/cgroup-v1/misc.rst
> > @@ -0,0 +1 @@
> > +/Documentation/admin-guide/cgroup-v2.rst
> What is the purpose of this (above) file?

This new controller has both cgroup v1 and v2 support. Tejun suggested
if we can point to v2 doc from v1. If this is not recommended approach I
can add all of the v2 documention of misc controller here, let me know.

I missed a heading and adding this file in cgroup-v1/index.rst.
Fixed it now.

> > +        Limits can be set more than the capacity value in the misc.capacity
> 
>                              higher than
> 

Done

> > +a process to a different cgroup do not move the charge to the destination
> 
>                                    does

Done

> > +Others
> >  ----
> 
> That underline is too short for "Others".
> 

Fixed.

> Try building this doc file, please.
> 
> next-20210219/Documentation/admin-guide/cgroup-v2.rst:2196: WARNING: Unexpected indentation.
> next-20210219/Documentation/admin-guide/cgroup-v2.rst:2203: WARNING: Unexpected indentation.
> next-20210219/Documentation/admin-guide/cgroup-v2.rst:2210: WARNING: Unexpected indentation.
> next-20210219/Documentation/admin-guide/cgroup-v2.rst:2232: WARNING: Title underline too short.
> 
> Others
> ----
> next-20210219/Documentation/admin-guide/cgroup-v2.rst:2232: WARNING: Title underline too short.
> 
> 
> I think that the first 3 warnings are due to missing a blank line after ::
> or they could have something to do with mixed tabs and spaces in the misc.*
> properties descriptions.
> 

Sorry, I was not familiar with Sphinx build and didn't build using that.
I have fixed all of the above warnings. My next patch will reflect
fixes.

Thanks

