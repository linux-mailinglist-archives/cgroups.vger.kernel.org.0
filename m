Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECA3CBB95
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 20:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhGPSFv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 14:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhGPSFu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 14:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626458574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjAtGXPGZFlFZsipCtgSHU9hwzzeLIgV7DwDVA8X6EQ=;
        b=DdlHCGdq6mbFgvzMCNxu2wGKsli4+mNF/iZkiJselZUF+rF0oXL/Dec+2bVOtczT8fxEmP
        r2wtxcF9h23z/eb1zQLguFNI+E9a60m2MB6E17o+OeiqJUNUD+f4mo/mHAJk51fCdPWiAR
        AwKOkBNm7D1AN54gzAChS9/zpFr8zwc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-m_AvivGBN3yOgYgkaBavKA-1; Fri, 16 Jul 2021 14:02:53 -0400
X-MC-Unique: m_AvivGBN3yOgYgkaBavKA-1
Received: by mail-qk1-f197.google.com with SMTP id u9-20020a05620a0229b02903b8eff05707so2909791qkm.5
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 11:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xjAtGXPGZFlFZsipCtgSHU9hwzzeLIgV7DwDVA8X6EQ=;
        b=gdxK90krYrYfzZg5iHug/dZPqJ2F4gHhDcxevToPV0uU/QH0EqYT/kOUTqFH5e5Prk
         HojyNHBNtSMFxKK/vQ8ODvNZsoNiixReQVivttMlrI0x5+E3quNLH/ElBUL3lBbB6IsX
         tH4TIlLkPvyqkGxOaUcvUhfaBN/wdlObXPbLHJo0PybWVQb3ln2BG7YpbZL1025T403t
         G5OueZvhwC6pFNQ1xd0AAAZo8q+Anx6XNMiFyNFqAuuVTFmZLdTnXVfZLFKDkeCCcdRX
         bJqJ9236PXnksrqh7wGG6zRkY5Tx9jaA76ADN0w792KpsNLN+mBHlpoXYXiLrApygKVK
         a5Xw==
X-Gm-Message-State: AOAM533DqqyjkaHWVCqEbCJj35hjQrkp/nKYdlkNKimtqx62+AJI+DyG
        AZDloLsgsmf3DYkppU+1ltEmcV8Itrh9Pul4ECNS1aW0qjPeK9r6ZMLb8QXRGuN23glgVCJOWn5
        6ZLX7eafBoCp+HErO30F5d8B3cbaCUiL6zbgSZcNhIK+Lb9SwawfPJkppSwyUS+Q2Nw==
X-Received: by 2002:ae9:de47:: with SMTP id s68mr10928704qkf.39.1626458572690;
        Fri, 16 Jul 2021 11:02:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwae5YdFYG0I3baQoKv4mcuFl8mjhTsD7koRJLmZ9UIxi4hTDocWdqngqIu9AfFP00FoEY77w==
X-Received: by 2002:ae9:de47:: with SMTP id s68mr10928675qkf.39.1626458572435;
        Fri, 16 Jul 2021 11:02:52 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n188sm1890524qke.54.2021.07.16.11.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 11:02:51 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 0/6] cpuset: Allow to modify isolcpus through cpuset
To:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20210714135420.69624-1-frederic@kernel.org>
Message-ID: <8ea7a78f-948e-75e8-1c4f-59b349c858f6@redhat.com>
Date:   Fri, 16 Jul 2021 14:02:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714135420.69624-1-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/14/21 9:54 AM, Frederic Weisbecker wrote:
> The fact that "isolcpus=" behaviour can't be modified at runtime is an
> eternal source of discussion and debate opposing a useful feature against
> a terrible interface.
>
> I've long since tried to figure out a proper way to control this at
> runtime using cpusets, which isn't easy as a boot time single cpumask
> is difficult to map to a hierarchy of cpusets that can even overlap.

I have a cpuset patch that allow disabling of load balancing in a 
cgroup-v2 setting:

https://lore.kernel.org/lkml/20210621184924.27493-1-longman@redhat.com/

The idea of cpuset partition is that there will be no overlap of cpus in 
different partitions. So there will be no confusion whether a cpu is 
load-balanced or not.

>
> The idea here is to map the boot-set isolation behaviour to any cpuset
> directory whose cpumask is a subset of "isolcpus=". I let you browse
> for details on the last patch.
>
> Note this is still WIP and half-baked, but I figured it's important to
> validate the interface early.

Using different cpumasks for different isolated properties is the easy 
part. The hard part is to make different subsystems to change their 
behavior as the isolation masks change dynamically at run time. 
Currently, they check the housekeeping cpumask only at boot time or when 
certain events happen.

Cheers,
Longman


