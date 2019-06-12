Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB7342B1E
	for <lists+cgroups@lfdr.de>; Wed, 12 Jun 2019 17:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfFLPjB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jun 2019 11:39:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39752 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfFLPjB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 11:39:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so9889689pfe.6;
        Wed, 12 Jun 2019 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JuROWLVzxIFjnfWdTCsoegNVj2txOGgaIFKDPlu0MV8=;
        b=Xdp8UdIQpUWGHrfMgzQC4yhmJgOSy7bMYuN+V2wIvnXufG/JkdgwAn5A7Ib40gYEtx
         xc1wgOKi9WG7MZOiHNxUHSqd/iHlEnTCFxumomjOr3Yx5aC21bKBRkzfg8VC1waY6HEi
         /4A+V2YcoXnWKNsTlZPOovLuwBYBZ6QtZVURGDdG8JC/7fvzgiXl+C9O90BDjGaOiaPR
         VJCNr255zjzT2by8TcDY5vrhDw+X1d0/Zzdg650GBBwk7q38DRd88wgqI0NikESWEBkT
         vu9GaGzfuiSo70RxER42IQUgxN/wjaZKAY5g/c4QWRnLEMnPSq2vW1X2CJBqXEKXbUc/
         UYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuROWLVzxIFjnfWdTCsoegNVj2txOGgaIFKDPlu0MV8=;
        b=JgDZInHqEvVKD0Tk6/yOGybl73g2Vuj5Sl5vNyyQrUhyOX5oykOOD/1EfqiFsDHSU8
         Jj7CR4t+Wy/tnGaxB7VDzDIkyorfSFavxpMKpXzSzRr6hxvgGibp4ckugF5NNTPaXm9i
         z7NA5F3HYyQfzDOVIXCPNQmeyxTTCB+X0n8kDescrYpmYqbbsf+Asi3A9DJ8nKr4thcO
         iuCJpr0BFydhf7N1jmvPe8xJVWuonR3+tBBJBE+Jnquir9Pae+T/hY336zRKk/s3PRQu
         Y9G7Z2iHlLqX4OMzv6hAdNZPmH3pJD4rvc2K8uSIy115DCVabL/0W/34BP4DWJunf24V
         L2Fw==
X-Gm-Message-State: APjAAAVTUOPiiuMmR2nwp2nigp4pttAtKmdLLM1jpYzcJy/lNOLJxefp
        sSkoqvzpox8UQvIwei/4aK8=
X-Google-Smtp-Source: APXvYqwSIbc5oBkfVRJFJC6GYmIb6+HeXogVZ9zBOeP0n4JJZ7oaBkFU3/GaUZRKOBTbX+5C/rvpxA==
X-Received: by 2002:a63:84c1:: with SMTP id k184mr23511489pgd.7.1560353940210;
        Wed, 12 Jun 2019 08:39:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::c431])
        by smtp.gmail.com with ESMTPSA id l7sm19901776pfl.9.2019.06.12.08.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:38:59 -0700 (PDT)
Date:   Wed, 12 Jun 2019 08:38:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v3] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190612153857.GO3341036@devbig004.ftw2.facebook.com>
References: <1560352395-19977-1-git-send-email-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560352395-19977-1-git-send-email-jsavitz@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Joel.

On Wed, Jun 12, 2019 at 11:13:15AM -0400, Joel Savitz wrote:
> In the case that a process is constrained by taskset(1) (i.e.
> sched_setaffinity(2)) to a subset of available cpus, and all of those are
> subsequently offlined, the scheduler will set tsk->cpus_allowed to
> the current value of task_cs(tsk)->effective_cpus.
> 
> This is done via a call to do_set_cpus_allowed() in the context of 
> cpuset_cpus_allowed_fallback() made by the scheduler when this case is
> detected. This is the only call made to cpuset_cpus_allowed_fallback()
> in the latest mainline kernel.
> 
> However, this is not sane behavior.

So, I fully agree the whole thing is insane.  It has always been so
and the root cause of the problem is that we aren't distinguishing
restrictions put on by the cpuset and individual tasks' configured
cpumask.  Ultimately, for this to make actual sense, we need to
separate out per-task effective and configured and cpuset-imposed
masks.

That said, the suggested behavior seems way better than the current
one, so no objection from me, but can you please repost w/ scheduler
ppl cc'd?

Thanks.

-- 
tejun
