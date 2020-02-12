Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C94615B375
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 23:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLWPq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 17:15:46 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42932 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWPq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 17:15:46 -0500
Received: by mail-qk1-f195.google.com with SMTP id o28so2376202qkj.9;
        Wed, 12 Feb 2020 14:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lt2bmGLGUi0Zcu/H421eTEe1/qtmGCD9EmboSnT4OXI=;
        b=ewzHnGuNrwUuIGR6/XbkIYVSSuohB/DF5TrOVfr1xP6bvsBmLUB7R2bhUngJhyL0B6
         EwRPVIk4ou9BNMLoFTtJaP09iN7769B6Vx7JbyiQNmQ8cjxvzgBXKgHs6pDRTkZHJP3I
         /Dt0CRoHfvHPjw+dcxB6vtWocysqrhIpmBfRJyodr5oBqhn47sz2D8su7Vgaz5YCsJSR
         I00e7uGihZvOR/Py3sMZuULUe99x+RYFHHtqnKmKKRmrH7XeuHWodyfLERHVGxyy2oOZ
         Q8B8nChKVR+77Vm8gkChlv2ve6fLlDl046ax2696x+k8z3i5fIM8EnmNqQ45Q1DK4snn
         M5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Lt2bmGLGUi0Zcu/H421eTEe1/qtmGCD9EmboSnT4OXI=;
        b=q0zkKNzbW9lr798goMzHU/W6dEnJ4Ao2Z93UkRRDSLEZl2M+FR3gqmqe/U43B+BVZP
         tmUMs7fvbztyfpFJKBdBdNd08An5+HuX6tDyVSZZg7iT68UIsISXo5mt9y2KqPKa7q2s
         chZmA7+tX0jhDMfOCCGS3MlLHX4XT72e+wMjPfxwPqCl174nkgU4YN+OKSgmZPM2iGBA
         siVZHgCwSxSQCkYE/hcCAQih1q4icq2jZ/bB2QwUTosvI7OY9AZfpt9PN9I7ez9O9Fn5
         RVYkh4Yl/VuXNeMLBFgKMEqu08UIE61qAEl5oshD2RzHgV6WstCc05R6Cu3DMQkI2vBk
         M1Tg==
X-Gm-Message-State: APjAAAWXQbVXD+h1+a3Ah030IKastINBFdOGXbYpRhmILkadprPYqzyK
        BSygid2vJwS98MoEGi/WQj8iw51pe5Y=
X-Google-Smtp-Source: APXvYqwYfD4KSlbK1dpX18C/12OLrdhbhPusAXIVmNbVBj5RqaXfER318Nz0gjCui2M+n/63mYi+tA==
X-Received: by 2002:a37:6551:: with SMTP id z78mr13075067qkb.86.1581545744793;
        Wed, 12 Feb 2020 14:15:44 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id y21sm304358qto.15.2020.02.12.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:15:44 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:15:43 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Fix a race condition when reading cpuset.*
Message-ID: <20200212221543.GL80993@mtj.thefacebook.com>
References: <20200211141554.24181-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211141554.24181-1-qais.yousef@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 11, 2020 at 02:15:54PM +0000, Qais Yousef wrote:
> LTP cpuset_hotplug_test.sh was failing with the following error message
> 
> 	cpuset_hotplug 1 TFAIL: root group's cpus isn't expected(Result: 0-5, Expect: 0,2-5).
> 
> Which is due to a race condition between cpu hotplug operation and
> reading cpuset.cpus file.
> 
> When a cpu is onlined/offlined, cpuset schedules a workqueue to sync its
> internal data structures with the new values. If a read happens during
> this window, the user will read a stale value, hence triggering the
> failure above.
> 
> To fix the issue make sure cpuset_wait_for_hotplug() is called before
> allowing any value to be read, hence forcing the synchronization to
> happen before the read.
> 
> I ran 500 iterations with this fix applied with no failure triggered.
> 
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>

Hello, Qais. I just applied a patch which makes the operation
synchronous. Can you see whether the problem is gone on the
cgroup/for-next branch?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next

Thanks.

-- 
tejun
