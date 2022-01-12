Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E448CC9D
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 20:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350675AbiALT4l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 14:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357666AbiALTzq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 14:55:46 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8905C06173F;
        Wed, 12 Jan 2022 11:55:46 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id l15so5734113pls.7;
        Wed, 12 Jan 2022 11:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTkXuSKZdEidYDtUquppnkS8GPvDaeca2bpqBFg2VUk=;
        b=aVDCcfyGG6eZ7fQRZwIpKvAV3p4XQAIsCDHU4V8R68gVluTPXLyO4TF+tuwhm7XNxH
         2VFN9RxstCr5amo4nthsCVIpWzI31OwDeQN2LuYI4sWHzWcRLMB7vii4FIcLCxFHvuk1
         hQ7tW6OYVeXC6Mkku3+HVMdiL4OicoRI+GOcEe8uOTotfiLnVvGoiJ7mL0/n/Ya0Yqv7
         NfCSAd4pxzo1OW1rtcHHA87G7eCWLKSBrG/jHsP4/JaH4No9utBcUP7RryQqI8z3hg/V
         PUzZYlGbJLCwksdC5V2bXkWcbjX0AEAL/vErnFXE/LmN/wkCJmwpcfVzJIprU1iydK1r
         oKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pTkXuSKZdEidYDtUquppnkS8GPvDaeca2bpqBFg2VUk=;
        b=UMS0+xmWaSaIzOveVXJjY2wqC8Ruu1NM/oZ0S8KvEWAm4Rw9ROdEAAqjoFIEJamS/Z
         SFaROWCnp/MFYicmlqODkN+RSnSNhsKXiHZYll3VjFmfrlyVI2GTp7kZb5p2YnmL+0c7
         v3eYwKluL+iZ8C1OSw631EDNN+6toQPX7oCpEAp/sKCfWZo2h2e/ePm7nszLcMJo9cs5
         /FIK1sCf0h9sRlJmxDwtPA1M2rwnqzJMXos1uRs9KxVdwJ8wqYL/7PR4yzQQ1KYNVRuM
         Q5L8T/amv0nd+eBvksPegppIwC/dr/r2kPVVmklpk2F6fDvKVM9xiMAbrmqW1vr9Q6Nb
         Roew==
X-Gm-Message-State: AOAM530acJndpMcpvrSKflV0eYGHRG8lp/YW83FS6hy0D1d7xkVDBMjJ
        ZQ5foQzpqQMcfl9gwFgkM1Q=
X-Google-Smtp-Source: ABdhPJzHfrBMVxX8lg2F1rhL/JoDTXNGv358VL6jn2+Y1jzcadxQmUz0yRx0vf75QYU8VUnSG4huCg==
X-Received: by 2002:a17:90a:de08:: with SMTP id m8mr1316255pjv.102.1642017346109;
        Wed, 12 Jan 2022 11:55:46 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id x12sm448834pjq.52.2022.01.12.11.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:55:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 09:55:44 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: rstat: use same convention to assign
 cgroup_base_stat
Message-ID: <Yd8yQFx/cOBGd6+N@slm.duckdns.org>
References: <20220108003817.6619-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108003817.6619-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 08, 2022 at 12:38:16AM +0000, Wei Yang wrote:
> In function cgroup_base_stat_flush(), we update cgroup_base_stat by
> getting rstatc->bstat and adjust delta to related fields.
> 
> There are two convention to assign cgroup_base_stat in this function:
> 
>   * rstat2 = rstat1
>   * rstat2.cputime = rstat1.cputime
> 
> The second convention may make audience think just field "cputime" is
> updated, while cputime is the only field in cgroup_base_stat.
> 
> Let's use the same convention to eliminate this confusion.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied 1-2 to cgroup/for-5.18.

Thanks.

-- 
tejun
