Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B735AEFDD
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2019 18:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436907AbfIJQqx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Sep 2019 12:46:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44519 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436888AbfIJQqw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Sep 2019 12:46:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so21521974qth.11;
        Tue, 10 Sep 2019 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nGPjMw+0bTsKBBz+LmEuKCB2oVregNeJBfTo1Ogq1SQ=;
        b=FY0tyhssl1v85cCyEg/NN4HRY3hq/KixekXYiv8rvrGa4KLzdIXYwP88+KEqt0xLKP
         Lm3en+mF7zbP0lJwoeia/6SfM9NCrpaqdkvWSbdxYkg/b86FtG8DZ0/aFKRRlul5AgC3
         +tNTkDQWPK8jdHELiV3V521mz8taG6/Nh1vtKQMGwsv8zUaC392ADsHzRhgYPVSbNONE
         jxvAV6uvzks29ehtS4ROxp9pgEyRvO6RS6MhrltSuaS0Cs1RvhPpgKCALvCLNWKQFdGo
         1o3NR3mB5VE8GPy419vLO4w8tvWVSGITf0+OG95W6U077OyWW0JFcdEYPXYVWKu9GXhx
         /uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nGPjMw+0bTsKBBz+LmEuKCB2oVregNeJBfTo1Ogq1SQ=;
        b=LA576xAKjGZJRL+ad53o7qecFOD+ocXyWT/imAd9CTFt/BFzQARR+3Iap1FbspN2jM
         aZ4TsfEqrA2k+5qSJVQ4R7dYzCy3CpTF0CsPBTG5va1oKgnFugANW9IPBshcnW66mC0e
         kyTVZ2cTBztgafaVN7uxvqK9i+46Zlkbr4u1d9m5qEGUGXrjKzGJNhWW44/pKr9SBqjn
         0RLAstMZD3FIEkm4BsVxv6Drr8q9d7HyW8iJn7orFUD1BsfUskGfYUZ/QJR1RDYaxH0B
         ifb3AlDGRMBupL/m+mnSd11fYvR2zscZBQE9dfd45fcyaggCzNltmojNxqIe8PAz3Z3Z
         W6TQ==
X-Gm-Message-State: APjAAAUWQYijVK3sBNJjhzHmfR9fuwSijLRFI+M4Km4SL8a2FFIlzmEH
        ubH/KmktcWzGlSQrZtTJuFA=
X-Google-Smtp-Source: APXvYqyiQ2s8WjuQP9qYS3CQ8WNDKlDn9POEcaQAsSNMbNxSXWQESzwg1Gt0T7EsNBNCl24sR7DCyg==
X-Received: by 2002:a05:6214:1709:: with SMTP id db9mr19081358qvb.243.1568134011638;
        Tue, 10 Sep 2019 09:46:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f049])
        by smtp.gmail.com with ESMTPSA id a4sm12552484qtb.17.2019.09.10.09.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:46:50 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:46:49 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ivan Safonov <insafonov@gmail.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: use kv(malloc|free) instead of
 pidlist_(allocate|free)
Message-ID: <20190910164649.GU2263813@devbig004.ftw2.facebook.com>
References: <20190908144041.19667-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908144041.19667-1-insafonov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 08, 2019 at 05:40:41PM +0300, Ivan Safonov wrote:
> Resolve TODO:
> > The following two functions "fix" the issue where there are more pids
> > than kmalloc will give memory for; in such cases, we use vmalloc/vfree.
> > TODO: replace with a kernel-wide solution to this problem
> 
> kv(malloc|free) is appropriate replacement for pidlist_(allocate|free).
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>

An equivalent patch is already queued.

https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?h=for-5.4&id=653a23ca7e1e1ae907654e91d028bc6dfc7fce0c

Thanks.

-- 
tejun
