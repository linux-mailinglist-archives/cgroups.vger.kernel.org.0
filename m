Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B5935E63
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2019 15:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfFENxX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jun 2019 09:53:23 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42601 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfFENxX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jun 2019 09:53:23 -0400
Received: by mail-qk1-f169.google.com with SMTP id b18so5152484qkc.9;
        Wed, 05 Jun 2019 06:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FETSS3J4eD7K515d8ScmcKfF1wyotHso7dwlnNKYVC8=;
        b=O84ji0lXN+RqkutIEaEyEEqQXcFVzeG64E5D+IGzwBJcDRXFIhtWb80kt89787ERae
         SVgqIrHUOdqzFOWmqqrmY63CyKPgJHTijErg98dUmfPqYT4f200Pa3v2DHmAPP/DgulF
         7nlCPUR8C5qMCx8d5XN1RqshszE7/VRzXBHkrkM8ioHtBsYqvXGLKiUWOF8TgpJfByAC
         WxpTcx4EhwfLIK2ozup8V4g1ahyLKPG66YNnH3iOR2HOqHPyAVljLcZGRtEvSJDYYBBK
         ph5a0gf262q4Ydh7OMHdU6YtIKKeID7muJi8gChJSfg446PN8vB787GwyVShso3Jk9H1
         cbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FETSS3J4eD7K515d8ScmcKfF1wyotHso7dwlnNKYVC8=;
        b=r0mbxdxC2c6ZsvXW2vmZr/cms3LF83TmsVzYAIQCT0jOVQBlzXPAZ+tMQwmmrod10H
         INY/Ywkv3GhnngHsfYJzxvKP02D8bvNbj+ML28ob31ysBBXuJpKtu9XOlpDku5A7v2J/
         OcDjqxH3sEYkD7CVIgSbN21CBNAFgM1C+5q4gM+z7VHgM+rh05bmZP6fq2MMTka8cSyD
         XblTl4a2iJH+HGrCDqePHWN3cz/60amfZXn+u1ehh7FTjOSt5FNB2v7xsY/r0x60k3yL
         B+ZmZg9Wqt4t+A+YoH0XUtZs4uDIl6Y6J8mJ+x8Futyq9zudKcsOQuVDjiLWoKMcPpxQ
         qBHA==
X-Gm-Message-State: APjAAAWPmgi/9fDw7PEutsI8qYpCuuUSVTvqzracNoy7Z1+0V2J0euUl
        KWkf7dnfxuuyP0Ei3EWHkU8=
X-Google-Smtp-Source: APXvYqzgbDsZ1PJ/Ceon86CDXM/qpmDYa498SwcV19QGw1THKkkoAkdv6IOc/u1X7CTxkAGOqabeTg==
X-Received: by 2002:a37:9ece:: with SMTP id h197mr14387983qke.50.1559742802150;
        Wed, 05 Jun 2019 06:53:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id l3sm10177469qkd.49.2019.06.05.06.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 06:53:21 -0700 (PDT)
Date:   Wed, 5 Jun 2019 06:53:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     hannes@cmpxchg.org, jiangshanlai@gmail.com, lizefan@huawei.com,
        bsd@redhat.com, dan.j.williams@intel.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v2 0/5] cgroup-aware unbound workqueues
Message-ID: <20190605135319.GK374014@devbig004.ftw2.facebook.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Daniel.

On Wed, Jun 05, 2019 at 09:36:45AM -0400, Daniel Jordan wrote:
> My use case for this work is kernel multithreading, the series formerly known
> as ktask[2] that I'm now trying to combine with padata according to feedback
> from the last post.  Helper threads in a multithreaded job may consume lots of
> resources that aren't properly accounted to the cgroup of the task that started
> the job.

Can you please go into more details on the use cases?

For memory and io, we're generally going for remote charging, where a
kthread explicitly says who the specific io or allocation is for,
combined with selective back-charging, where the resource is charged
and consumed unconditionally even if that would put the usage above
the current limits temporarily.  From what I've been seeing recently,
combination of the two give us really good control quality without
being too invasive across the stack.

CPU doesn't have a backcharging mechanism yet and depending on the use
case, we *might* need to put kthreads in different cgroups.  However,
such use cases might not be that abundant and there may be gotaches
which require them to be force-executed and back-charged (e.g. fs
compression from global reclaim).

Thanks.

-- 
tejun
