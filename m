Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809FF1DA12C
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2020 21:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgESToP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 15:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgESToP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 15:44:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA73C08C5C0;
        Tue, 19 May 2020 12:44:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so676383wrp.12;
        Tue, 19 May 2020 12:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xFV+cj6HEJHn0MIcsHsaFrhUc7+md/w1l40PLXGAstk=;
        b=dlHck/0guzfnK9XYMp97OS5uhmBcXogUsswoxl9Oi8x6HliBCNH8Zbc+Gm1DmJpHbi
         o0nEnYX3bW6KvAq48RjV5o9WszYYnsnPfEsa5QQJm+Llpz8uYwnNwnE2wfTWVm/hO9Jo
         B3Ez9WmXJ91723fNiFQC34tMX+dxMZedaP4Ir1sB+85MAhi9aRNYWsEiDbhgjAZS3p5K
         xKVLc+59210r3T9K+sK8Nx267x2mZ2vydf3nZe7ZVU/1ZFsOQ/QFC3DfEui9Fm/174wG
         a26zieqVj4AZ8OLN3g0y+MopZmOSig3/Wbtp4mf6QiYXHLVABu42q0E8NroLajycFKoE
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xFV+cj6HEJHn0MIcsHsaFrhUc7+md/w1l40PLXGAstk=;
        b=BEz4O5xGastrcT/yItsptAi6x4wZxsiUa+fgC5J3WDov+4yTR+eqvkHl9HGE2I0nR6
         Ph7oFC76/QR8bnCUfDOlbV8BNikkzIMDf3xAgsEl8DcQqHAoVaLLejGo/2OEORA6qIlV
         KYTxRMWSqg2gUKulJ98AKH+kIWGGIgXrz9pWac7tPesBCea0t4CRMLOD8oXY6rBAqm2T
         5Id+w/dhvus2aveLbwZGakP99QS2t1xWvVcipS/0rwD6yIdJR205+KyppzZDpIRB8uDZ
         xF0V5cBvG78ecwPrbsuKLfZYC8ZERlH7gvYiXSTBJRzORr4xgMP1X2oG4NVlHXy9hg22
         wc9w==
X-Gm-Message-State: AOAM5321oR07jf2K0U0qGk1c5lva3Kgb+tatFH8CC57bqdcid6tKRSjV
        ZYdriFWLw/DQe4Ru7zc5hDE=
X-Google-Smtp-Source: ABdhPJw1lQ0FCGlQ9kdVIm6w3W2PfGMO9rpiFnKnUnpvz3U2brmW7EPgNtP1C+JliGuGm+4+gAbtdg==
X-Received: by 2002:adf:f207:: with SMTP id p7mr540993wro.20.1589917453895;
        Tue, 19 May 2020 12:44:13 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id p9sm500077wrj.29.2020.05.19.12.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 12:44:13 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        cgroups@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        oleg@redhat.com, tj@kernel.org
Subject: Re: [PATCH v2] clone.2: Document CLONE_INTO_CGROUP
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <CAKgNAkhL0zCj11LS9vfae872YVeRsxdz20sZWuXdi+UjH21=0g@mail.gmail.com>
 <20200518175549.3400948-1-christian@brauner.io>
 <25b2d051-d276-d570-5608-2bf0f4f46ef1@gmail.com>
 <20200519135124.xhgdeaogmvmwbofc@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <db0d3e1b-a0d4-20de-90e4-bb6549ac4cb7@gmail.com>
Date:   Tue, 19 May 2020 21:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519135124.xhgdeaogmvmwbofc@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/19/20 3:51 PM, Christian Brauner wrote:
> On Tue, May 19, 2020 at 03:36:28PM +0200, Michael Kerrisk (man-pages) wrote:
>> On 5/18/20 7:55 PM, Christian Brauner wrote:
>>> From: Christian Brauner <christian.brauner@ubuntu.com>
>>> +
>>> +Spawning a process into a cgroup different from the parent's cgroup
>>> +makes it possible for a service manager to directly spawn new
>>> +services into dedicated cgroups. This allows eliminating accounting
>>> +jitter which would be caused by the new process living in the
>>> +parent's cgroup for a short amount of time before being
>>> +moved into the target cgroup. This flag also allows the creation of
>>> +frozen child process by spawning them into a frozen cgroup (see
>>> +.BR cgroups (7)
>>> +for a description of the freezer feature in version 2 cgroups).
>>> +For threaded applications or even thread implementations which
>>> +make use of cgroups to limit individual threads it is possible to
>>> +establish a fixed cgroup layout before spawning each thread
>>> +directly into its target cgroup.
>>
>> Thanks for these use cases; that's great!
>>
>> So, I did some fairly heavy editing, which resulted in the
>> following (the sum of the diffs is shown at the end of this
>> mail):
>>
>>        CLONE_INTO_CGROUP (since Linux 5.7)
>>               By default, a child process is placed in the same version 2
>>               cgroup  as  its  parent.   The CLONE_INTO_CGROUP allows the
> 
> Not a native speaker, but is this missing a noun like "flag"?
> "The CLONE_INTO_CGROUP {flag,feature} allows the [...]"?

Yes, "flag" was missing. Thanks.

>>               child process to  be  created  in  a  different  version  2
>>               cgroup.   (Note  that CLONE_INTO_CGROUP has effect only for
>>               version 2 cgroups.)
>>
>>               In order to place the child process in a different  cgroup,
>>               the caller specifies CLONE_INTO_CGROUP in cl_args.flags and
>>               passes a file descriptor that refers to a version 2  cgroup
>>               in  the cl_args.cgroup field.  (This file descriptor can be
>>               obtained by opening a cgroup v2 directory file using either
> 
> Should this just be "opening a cgroup v2 directory" and not "directory
> file"? Feels redundant.

Yes, better. Changed.
 
>>               the  O_RDONLY  or  the  O_PATH flag.)  Note that all of the
>>               usual restrictions (described in cgroups(7)) on  placing  a
>>               process into a version 2 cgroup apply.
>>
>>               Spawning  a  process  into a cgroup different from the par‐
>>               ent's cgroup makes it possible for  a  service  manager  to
>>               directly  spawn  new services into dedicated cgroups.  This
>>               eliminates the accounting jitter that would  be  caused  if
>>               the  child  process was first created in the same cgroup as
>>               the parent and then moved  into  the  target  cgroup.   The
> 
> I forgot to mention that spawning directly into a target cgroup is also
> more efficient than moving it after creation. The specific reason is
> mentioned in the commit message, the write lock of the semaphore need
> not be taken in contrast to when it is moved afterwards. That
> implementation details is not that interesting but it might be
> interesting to know that it provides performance benefits in general.

Thanks. I added this sentence:

    Furthermore, spawning the child process directly into a 
    target cgroup is significantly cheaper than moving the child 
    process into the target cgroup after it has been created.

>> Look okay to you?
> 
> Yep, looks great!

Good!

Thanks for the review.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
