Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E942C31D4
	for <lists+cgroups@lfdr.de>; Tue, 24 Nov 2020 21:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgKXUSu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Nov 2020 15:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKXUSt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Nov 2020 15:18:49 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CA1C061A4F
        for <cgroups@vger.kernel.org>; Tue, 24 Nov 2020 12:18:48 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so192653pge.6
        for <cgroups@vger.kernel.org>; Tue, 24 Nov 2020 12:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+d3Q+FJMp5wysv4Lgx699qsAFKb+B/URuOmqRGlIss4=;
        b=TA5DY7nVqkkzYdJjhDZ7R6UmWPWd8fAOJab+j7WazNhY9amUjOXgvlKUExj5nM0/C1
         tuvCwJ51PeL/Uh0G6D/cXPDxSLt8rfmR1a3ZaY4592VbSNFaD23grfs14In9FAyLsEgK
         bozL0Uvjw8VXTlKfXj1fMjLYK538qEX5PDaYDIWRv/JRMFVDtisCW1k3pKdVPB2VBz7u
         H58vHaVo6y+yHnDoul/bD568yBKNAdiz2YAZWxSqWb50sXX/ME509J8HKbv3UV/7fgKk
         wcXgqmyLiFBeBDfKBkwDGLN4MqRGRVR663Kr1T1N6znwkZES50/JIREOyoBOICeJ6KGK
         MHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+d3Q+FJMp5wysv4Lgx699qsAFKb+B/URuOmqRGlIss4=;
        b=fmDsbLI0CzYl0pbLYFTB/qudJ/uWhsLbwE2qmsMd0jMhV0a1mahCLXNzY2+OsnZmEQ
         6XrjtzebiYFnyrp2csRdx7bj+tmtvUquSBkvtYGlPmp39wZVpIWmy6bFxOwWe3WBDxJe
         6lLSxVOJIr4lhYrKuxcYsu8+I2RMB3Fk8qynoytOcjdlq5Vn+WNLNBg87uSkV3oNF4QR
         AmURbvBQjGv8Zk8Pp70l3bnf22qszJCdnSQlMD6K9eCR4uIM9kx66JApWq5yVhqJxdU4
         V19KGoO4UYQ608dQ4PREgekXoAWQ8mdakAf9HvYILWDMWjKxrstKq0Dw0aEXNUa4HNKe
         hOzA==
X-Gm-Message-State: AOAM5334gY7VOe7J9Vcg5pPRPFtm5CBb2q1K23MlLm/BLyJL+ORZTI7L
        jAIX4wpXY27UurRD9RGF/RlIEw==
X-Google-Smtp-Source: ABdhPJy43I36Ch2HoOAJBNeRJ9IXB+JaaxA0NK+B43dRGgE//jaRqGi7ACQhDCbCOOv/Bl9EOkU5bw==
X-Received: by 2002:a62:f20e:0:b029:197:f6d8:8d4d with SMTP id m14-20020a62f20e0000b0290197f6d88d4dmr457862pfh.58.1606249127350;
        Tue, 24 Nov 2020 12:18:47 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id h16sm72362pgd.62.2020.11.24.12.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 12:18:46 -0800 (PST)
Date:   Tue, 24 Nov 2020 12:18:45 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Vipin Sharma <vipinsh@google.com>
cc:     Sean Christopherson <seanjc@google.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Lendacky@google.com, Thomas <thomas.lendacky@amd.com>,
        pbonzini@redhat.com, tj@kernel.org, lizefan@huawei.com,
        joro@8bytes.org, corbet@lwn.net, Singh@google.com,
        Brijesh <brijesh.singh@amd.com>, Grimm@google.com,
        Jon <jon.grimm@amd.com>, VanTassell@google.com,
        Eric <eric.vantassell@amd.com>, gingell@google.com,
        kvm@vger.kernel.org, x86@kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC Patch 0/2] KVM: SVM: Cgroup support for SVM SEV ASIDs
In-Reply-To: <20201124194904.GA45519@google.com>
Message-ID: <alpine.DEB.2.23.453.2011241215400.3594395@chino.kir.corp.google.com>
References: <alpine.DEB.2.23.453.2011131615510.333518@chino.kir.corp.google.com> <20201124191629.GB235281@google.com> <20201124194904.GA45519@google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 24 Nov 2020, Vipin Sharma wrote:

> > > Looping Janosch and Christian back into the thread.                           
> > >                                                                               
> > > I interpret this suggestion as                                                
> > > encryption.{sev,sev_es,keyids}.{max,current,events} for AMD and Intel         
> > 
> > I think it makes sense to use encryption_ids instead of simply encryption, that
> > way it's clear the cgroup is accounting ids as opposed to restricting what
> > techs can be used on yes/no basis.
> > 

Agreed.

> > > offerings, which was my thought on this as well.                              
> > >                                                                               
> > > Certainly the kernel could provide a single interface for all of these and    
> > > key value pairs depending on the underlying encryption technology but it      
> > > seems to only introduce additional complexity in the kernel in string         
> > > parsing that can otherwise be avoided.  I think we all agree that a single    
> > > interface for all encryption keys or one-value-per-file could be done in      
> > > the kernel and handled by any userspace agent that is configuring these       
> > > values.                                                                       
> > >                                                                               
> > > I think Vipin is adding a root level file that describes how many keys we     
> > > have available on the platform for each technology.  So I think this comes    
> > > down to, for example, a single encryption.max file vs                         
> > > encryption.{sev,sev_es,keyid}.max.  SEV and SEV-ES ASIDs are provisioned      
> > 
> > Are you suggesting that the cgroup omit "current" and "events"?  I agree there's
> > no need to enumerate platform total, but not knowing how many of the allowed IDs
> > have been allocated seems problematic.
> > 
> 
> We will be showing encryption_ids.{sev,sev_es}.{max,current}
> I am inclined to not provide "events" as I am not using it, let me know
> if this file is required, I can provide it then.
> 
> I will provide an encryption_ids.{sev,sev_es}.stat file, which shows
> total available ids on the platform. This one will be useful for
> scheduling jobs in the cloud infrastructure based on total supported
> capacity.
> 

Makes sense.  I assume the stat file is only at the cgroup root level 
since it would otherwise be duplicating its contents in every cgroup under 
it.  Probably not very helpful for child cgroup to see stat = 509 ASIDs 
but max = 100 :)
