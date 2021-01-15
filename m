Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF322F70DC
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 04:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732388AbhAODSX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 22:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbhAODSW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 22:18:22 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659CDC061575;
        Thu, 14 Jan 2021 19:18:07 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j26so5158614qtq.8;
        Thu, 14 Jan 2021 19:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ZQN0t+SyirEWcCnAtJWFZVAj9QfKHKmBdxx1H8XwTE=;
        b=odr0pw6Tc4JOSEerz1bsmasAi60PTA3HexpYK4sUs3CMn4UPSHFwTCje4xad/XxtEo
         CL84jc8pHGUYe8mImzQQI3TrdZy6n/CgU1UHZSBLdxA5xctlwgyV+D4xOimaT3M6uWyT
         yiC+nw82au74Mn/hxt1Q73E4iXvgTMSWKcum2qqT00gXo5gMUSwrJNfOUBzDgWGhaVZr
         A+HnmBgxn9RcuYCDgGweJehTinfBAxFcUQLNNsL5QESd//9e+7jh3Jq2A0LopjvMf4re
         P6TlcVR0r52q1udIrdYpghFbEKwq+iNPduY4Xrr4tZCXtYcK1zOszrey0pwB48dKpeTq
         MTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5ZQN0t+SyirEWcCnAtJWFZVAj9QfKHKmBdxx1H8XwTE=;
        b=ouu/qK/nCL88aUzcG46TMPXzEB570BC138ZuZMd4/8DGgIoG3Fpk0CkeByTEzMbBVd
         4EbjNRbe1fZyClsGu1kjtdJgHdIiGjd5CI2AqdsjzNLENN1yo3Y3F6Wv8GPe4ZcMJ4l1
         az++lL1ce3Wa9END7WOQaH7K67YroElq4AgXbbJElyJWVbLaQuampu1ju3hAqTamJeYI
         Q7uxgVXWqmMBSWryZZg4AWgBxqkio8bNRs/HxQRqZUE/7WX1LkocJ3i+kfBayVv+T1Ev
         vzB49N1cOU6jB921+T0Tv9S0yJtAtJbqTCUd2ablm59dOnDydF4wp/czaF1yx0G1kkEN
         q3ZQ==
X-Gm-Message-State: AOAM533sO3LamVBFGcgX0RZ972tuAbNke9fwbvNkAcQWTP222EyCyPaK
        haslpmQW/7JtVMiRhxKb0Dc=
X-Google-Smtp-Source: ABdhPJw8HJjhzyHwUf31NT2HnwAkb5iOzHboKS6INWtGtE+2frw4nADvVWrGcv0jHhVrEAShsd+hXQ==
X-Received: by 2002:ac8:6f65:: with SMTP id u5mr9949979qtv.303.1610680686426;
        Thu, 14 Jan 2021 19:18:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:c885])
        by smtp.gmail.com with ESMTPSA id c7sm3929094qtw.70.2021.01.14.19.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 19:18:05 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Jan 2021 22:17:18 -0500
From:   Tejun Heo <tj@kernel.org>
To:     chenzhou <chenzhou10@huawei.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup-v1: add disabled controller check in
 cgroup1_parse_param()
Message-ID: <YAEJPs4DJIgAXWul@mtj.duckdns.org>
References: <20201218061755.121205-1-chenzhou10@huawei.com>
 <YABDWvI2PWQpnv59@blackbook>
 <d4ba14b0-ee06-b793-a840-2c2ff369d890@huawei.com>
 <YAB3Wuu+hFpN698N@blackbook>
 <7804658e-7644-8edb-5ca8-0c97389c8c62@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7804658e-7644-8edb-5ca8-0c97389c8c62@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 15, 2021 at 09:55:43AM +0800, chenzhou wrote:
> Yeah, this will select all enabled controllers, but which doesn't the behavior we want.
> I think the case should return error with information "Disabled controller xx" rather than
> attaching all the other enabled controllers.
> 
> For example, boot with cgroup_no_v1=cpu, and then mount with
> "mount -t cgroup -o cpu cpu /sys/fs/cgroup/cpu", then all enabled controllers will
> be attached expect cpu.

Okay, that explanation actually makes sense. Can you please update the
description to include what's broken and how it's being fixed? It really
isn't clear what the patch is trying to achieve from the current
description.

Thanks.

-- 
tejun
