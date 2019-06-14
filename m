Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C4C46228
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfFNPJb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 11:09:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46993 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNPJb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 11:09:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id e5so1128901pls.13;
        Fri, 14 Jun 2019 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+I9U1GODgSkyxPAIv5uSBlih1n/pRySECC43JZGkdsQ=;
        b=iGhc4xzitJMk67sXbQMyBo8eYE8TxhKJEDf+KuuPxlnOLUZFysidCzwr54Kzzy0K2J
         D+GJRX71MpXYgXx2M6apuBILbtB+nlVv2HxnXhyaQJh8VlGfzYaUAn2jZSunbRUcJP+x
         iOB3D7jvu5eEN6YbwgH60SuKTejWz4B6PizS20cko5zfs7ZiBvyTkCfK/CSqY5Bns3l8
         Ro6EsJZk30weiEJY/Uk5TEteCCGXB8XYvuQXqPh/3FoevGvIok7Er3BS5HLnUo9gdnw3
         FP2pyydyRWD6S3lNwlB6S79WFXpwubyELDGZOmGBXGY7MLSjmvWneimvwEkDnHpcmFWV
         0G/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+I9U1GODgSkyxPAIv5uSBlih1n/pRySECC43JZGkdsQ=;
        b=HyJqtfDS72O5+9b4rUTlWezjRoRGjZcozrgUUZAu/pHK3Ra2m5TzIiRFzDuS26+PtL
         BrTEV7VCmGA6vZkz0pXKdvVNAv25hJ+TR3tbOs4mLP/wmzmrVQEjBenljYN9TsRRumrC
         e51XXRACUySdMtCGx+CMvJ3baFsoIv2nGjl3RrKEsxNYfWBrkDkNURBPUJ6YgqHRISny
         lGSZGSV3l2vNFsKq5bYdRSeykmffCti5Cl1MT5soFduDfrcDLD3bdkXEBwi2GSdZjBha
         oxF0bnd2MGzqz1jGCdKtf0fJ3r18iudr7oV9NdarQp9dM0Ld0IWQuSJWMS7CYOf3HwVC
         EdNg==
X-Gm-Message-State: APjAAAXJQhL/2ux5JThI5KGU1SoHqOQv9PkNNXpkEs48awzC58nuDUEH
        8F2s0wQiWoe0Q73tZmHsO0Y=
X-Google-Smtp-Source: APXvYqxzOCKBrFEtUYYWecwehqGBRjbcRqqz2d1PNNKgZEyBo102COqcOPB0Jz3DOPgdv6CXMm9Xlg==
X-Received: by 2002:a17:902:b70f:: with SMTP id d15mr12366371pls.318.1560524969921;
        Fri, 14 Jun 2019 08:09:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:b330])
        by smtp.gmail.com with ESMTPSA id a22sm4039041pfn.173.2019.06.14.08.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 08:09:28 -0700 (PDT)
Date:   Fri, 14 Jun 2019 08:09:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 08/10] blkcg: implement blk-ioweight
Message-ID: <20190614150924.GB538958@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614015620.1587672-9-tj@kernel.org>
 <87pnngbbti.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnngbbti.fsf@toke.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Toke.

On Fri, Jun 14, 2019 at 02:17:45PM +0200, Toke Høiland-Jørgensen wrote:
> One question: How are equal-weight cgroups scheduled relative to each
> other? Or requests from different processes within a single cgroup for
> that matter? FIFO? Round-robin? Something else?

Once each cgroup got their hierarchical weight and current vtime for
the period, they don't talk to each other.  Each is expected to do the
right thing on their own.  When the period ends, the timer looks at
how the device is performing, how much each used and so on and then
make necessary adjustments.  So, there's no direct cross-cgroup
synchronization.  Each is throttled to their target level
independently.

Within a single cgroup, the IOs are FIFO.  When an IO has enough vtime
credit, it just passes through.  When it doesn't, it always waits
behind any other IOs which are already waiting.

Thanks.

-- 
tejun
