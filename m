Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A67303AE
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 22:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfE3U7e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 16:59:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43165 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3U7d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 16:59:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so8746941qtj.10;
        Thu, 30 May 2019 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TTwhY4W7bsMQU2b95UCtmjTrgQBWgMfaFKcWD6fHn2Y=;
        b=iAXlbDPirvlihRGO1qbHDrGMPSPT1YVs5ripw25ItuMTE3l/cNb3L41Z8jMWCg9Kob
         1Z9T5/FwlhmVEd+GpkrkbggNtGCQ4yZpb5ZW4+OgD75tfPYXpL4RYPL4lRmqyyv3wpoR
         /YxDPx25zmV9Y8SIPhw5YJYATTrp18w1lq/oemoMJWa/0+SBEem0RZtc3urhaBchBnpg
         56m0B9PA8h1LUgdoQBZfVB/3b0qucgVkWMD8fFf3izjuyl0dvwU89qoFAiGt8hxExONO
         B9gZYhEAp3xcuF+9PP3Z8pM6A0yWtRxE7BkLBTrJdLxUkW4bIwfeL/VEEJWkIa0hWi50
         pBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TTwhY4W7bsMQU2b95UCtmjTrgQBWgMfaFKcWD6fHn2Y=;
        b=cqJJVWkMLHn1et8/6tnm4D2ceuAk2SbR2nPLbuRKKkRfj9TdJi0+QM7YrDn+n4NpwL
         9fkZUJWoUiummEWeq62Mi0hR20VNcQmENYqc7Vw1vQAMvy15c9wPcpCqe9C/mn1rdazP
         GB7lcWQJdRJHspRkIq27BA4V6ufgasZXx4R/UtPK0w9qCEiA35rHyqjNBRpLDqqP0+Du
         6sW3Vi5rXWzG+FZzwDVQHAMntqDwhU0pnTxu4sxzBbVwRmOZJha7TYWVDFcDGqDdvuvM
         d7VfWLFUQh+zzu36K3pBWCCVhjW2RoK0QmUFdqx0PGPMCe2w6vTzAtRHKDvD9tk2VZRv
         q0Iw==
X-Gm-Message-State: APjAAAWgvtKKx/iPxMPTBPO5uM56PNiBoPZnbbsRSNz6nPZ1hBBk5aDp
        DKvkxioQylYzXRmBB5ChsHE=
X-Google-Smtp-Source: APXvYqxrJ3ah20Z+AgJSXVA+GlNjZK8ct2M/F8QOItY6m4FohS5BiGMOctQxVzQP3O9+Tf4jkEP3NQ==
X-Received: by 2002:ac8:96e:: with SMTP id z43mr3514163qth.55.1559249972808;
        Thu, 30 May 2019 13:59:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id u17sm2342884qtk.0.2019.05.30.13.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:59:31 -0700 (PDT)
Date:   Thu, 30 May 2019 13:59:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Xuehan Xu <xxhdx1985126@gmail.com>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>,
        "Yan, Zheng" <ukernel@gmail.com>, cgroups@vger.kernel.org,
        Xuehan Xu <xuxuehan@360.cn>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
Message-ID: <20190530205930.GW374014@devbig004.ftw2.facebook.com>
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
 <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
 <CAJACTueLKEBkuquf989dveBnd5cOknf7LvB+fg+9PyjDw1VX6g@mail.gmail.com>
 <20190528185604.GK374014@devbig004.ftw2.facebook.com>
 <CAJACTucnCGLTbRAX0V5GBMmCQh4Dh8T9b0in1TUMCOVysJ0wjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJACTucnCGLTbRAX0V5GBMmCQh4Dh8T9b0in1TUMCOVysJ0wjw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Wed, May 29, 2019 at 10:27:36AM +0800, Xuehan Xu wrote:
> I think, since we are offering users an interface to control the io
> reqs issuing rate, we'd better provide the interface through the io
> controller, is this right?

I'm not entirely sure what the right approach is here.  For most
controllers, there are concrete resources which are being controlled
even if it's a virtual resource like pids.  Here, it isn't clear how
the resource should be defined.  Ideally, it should be defined as
fractions / weights of whatever backends can do but that might not be
that easy to define.

Another issue is that non-work-conserving limits usually aren't enough
to serve majority of use cases and it's better to at least consider
how work-conserving control should look like before settling interface
decisions.

> Actually, for now, we are considering implement a ceph-specific
> "blkcg_policy" which adds new io controller "cf" files to let users
> modify configurations of the ceph-specific "blkcg_policy" and limit
> the ceph reqs sent to the underlying cluster all by itself rather than
> relying on the existing blkcg_policies like io latency or io throttle.
> Is this the right way to go? Thanks:-)

Can we take a step back and think through what the fundamental
resources are?  Do these control knobs even belong to the client
machines?

Thanks.

-- 
tejun
