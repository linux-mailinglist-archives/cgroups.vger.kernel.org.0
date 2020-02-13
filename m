Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A751115BFD9
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgBMN4s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 08:56:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34999 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbgBMN4r (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 08:56:47 -0500
Received: by mail-qk1-f196.google.com with SMTP id v2so5729206qkj.2;
        Thu, 13 Feb 2020 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AZAtGhssrMcATj/gfsevl74sPZK+P31rS05xXvYq1Tc=;
        b=md1ccFZMEzcAFqNwPN4Oy6XeKVmN2Qt8kvZBl/xNivC0jrrU6n02ZxrGcZtOMlTKXn
         AFeCFXftIS+CmyJemHYxBiPNNy+ti/mCaMjqV2/z4sEmlLt+amzUU0DFMf+DEGNH3e1z
         9GLJK9hfClUm6H9lpmmBTX49qOpodxMgz1Nbemd1jLD0j4VTejHSrHZILdNLEitF/QAQ
         EKDPElVCpg/uYSwVovrRh3d+n18tewl34g0WvfojTunTogQzmOwc0aCZ/WcKcmXtUNRh
         5A00Rlkl3m9M436pbIA0B+G0bF81VXCtEfFLSGppEyX1osLRyftNYBY85kx4LBpHbC3p
         K7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AZAtGhssrMcATj/gfsevl74sPZK+P31rS05xXvYq1Tc=;
        b=IYCYzOaT4Mn3QBL+oZi+SqQ45NoML++d6KQuTrNHBXZIZpgg9PJ1WMGRTxwCR5TsmW
         fTylU2G239oJg4QjUq6cCAOiKAui9fAPgMSSlcf7MJPGC5PxYwybBRjjTk9nYaApKhIL
         OtZRWznFdZwHCVAwy2WzDJARwj0cLvaV6Yb7FuzRfrScY4eq2nbwCQ/jZ1kpkF79psoX
         Brs+NCtrtgV3qsXyOYflgdUcSOaZbJDz3epXFhgTeGqj61xK6V5gsBpwldV3tA/rVwYs
         31xGm9Tjq7vtVJOjQMJzuFzTdbwSjXf0+wQxIPVDu5GsNOGApfUyo5KDInpjZHBuXzF+
         iP9A==
X-Gm-Message-State: APjAAAVhpW1vRPAT83rm27di7Mp8x8FHwazKnmrvApcKMKGzcrl2YZWK
        p1HnONFfVweBBNGqBKeICzo=
X-Google-Smtp-Source: APXvYqyqGQ9gj1+1vBYvYKK6x0aFldCpwvjAILJT49aUedu5A1VmOvBxjVfLljwhXBxJeQEqI+JAGA==
X-Received: by 2002:a37:494f:: with SMTP id w76mr14084487qka.309.1581602206577;
        Thu, 13 Feb 2020 05:56:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:f3be])
        by smtp.gmail.com with ESMTPSA id i28sm1595306qtc.57.2020.02.13.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:56:46 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:56:45 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix a race condition when reading cpuset.*
Message-ID: <20200213135645.GG88887@mtj.thefacebook.com>
References: <20200211141554.24181-1-qais.yousef@arm.com>
 <20200212221543.GL80993@mtj.thefacebook.com>
 <20200213115015.hkd6uqwfjosxjfpm@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213115015.hkd6uqwfjosxjfpm@e107158-lin.cambridge.arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 11:50:16AM +0000, Qais Yousef wrote:
> I ran 500 iterations of cpuset_hotplug_test.sh on the branch, it passed.
> 
> I also cherry-picked commit 6426bfb1d5f0 ("cpuset: Make cpuset hotplug synchronous")
> into v5.6-rc1 and ran 100 iterations and it passed too.

Awesome, thanks for verifying.

> While investigating the problem, I could reproduce it all the way back to v5.0.
> Stopped there so earlier versions could still have the problem.
> 
> Do you think it's worth porting the change to stable trees? Admittedly the
> problem should be benign, but it did trigger an LTP failure.

I'm afraid not. It's not an issue which would affect actual use cases
and there's (as always) some risks involved with backporting it, so
the benefit just doesn't seem justifiable here.

Thanks.

-- 
tejun
