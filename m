Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6315B450
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 00:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgBLXDJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 18:03:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42377 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgBLXDJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 18:03:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id r5so2966214qtt.9;
        Wed, 12 Feb 2020 15:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=h0k/SZhy37SnuN8KJidHabKu5pvAsxYyNUGMmuRSfDg=;
        b=tftmUFzF0KyV09ppAzS+euVqTcoxJSUxBn+2PzjFhtOrQnhrlkLo7hs/q/cj7aLfKG
         vHyAYb64po/qFI9SgO7D2JRpddg/qxZleL5GPfdLH8ZHbm1sRMJp92aBI1/dwLNfIKZH
         kq9qtNIKy8tSXfaYHBpczb0volZ3yx0mgw/5bYX17wqE5qfrc/DXG0c4t5y59BSXWhkT
         dEgxxKVyXS8PJDhVnw3G5mn6RYVtlbMolwloM0KjLKS36shfX52NeoBdOBvIucejJeLv
         bPtRu9V5A1wqcsPkrBRlQEIimcLJNa4anWWLPYkTCfCRi2cPvaZqHuoh/moejqJMgK/9
         MX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=h0k/SZhy37SnuN8KJidHabKu5pvAsxYyNUGMmuRSfDg=;
        b=Cd6uDdGfw6XQNow2w+QKz81G2Ck3NFbflLRT6etF8OHVXdxYMVgUYHPALzkJ1vBFJ2
         4WanhFc+BpAn15vygnAA9+15VIZkw35bxw9OhUEm9bDMtHpSjhey5WVFcXRjK8zDkSg6
         QiauCcVHHrPM+emsJJz7dxPTA1VUoL7jRpr3iVGs30hxcS64T1KU2MZ5m0dQ7uaFTCtH
         UWIitHH0+1DoqCsAlu/V9CVslZLJKUajFxR/h1x4/IrSGpS1OhR+uGfeqmUhc5+loOgx
         reuDCJYv/5a//SIMtBiCG07svE4nub8pG+DH1D6pSmWCheVwuJuREq44p6eKZhdRHHoZ
         nTSg==
X-Gm-Message-State: APjAAAUYtmqViCU+ws8B5WP3Hq6xwpdePDsqVd/dTXGcuYG6mP9o5Fqt
        Xc7dpWdQLxB0mxFdkBT4xJY=
X-Google-Smtp-Source: APXvYqzVA6cwrSsQLXdS+2xVyZd6jCbA/D9uNrVcefcwOkaOV6OioIWWxreBUnQU/sP8a5CkfdkEIw==
X-Received: by 2002:ac8:4d0b:: with SMTP id w11mr21270023qtv.385.1581548587963;
        Wed, 12 Feb 2020 15:03:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id m95sm367585qte.41.2020.02.12.15.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:03:07 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:03:07 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] cgroup/pids: Separate semantics of
 pids.events related to pids.max
Message-ID: <20200212230307.GB88887@mtj.thefacebook.com>
References: <20191128172612.10259-1-mkoutny@suse.com>
 <20200205134426.10570-1-mkoutny@suse.com>
 <20200205134426.10570-2-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200205134426.10570-2-mkoutny@suse.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 05, 2020 at 02:44:24PM +0100, Michal Koutný wrote:
> Currently, when pids.max limit is breached in the hierarchy, the event
> is counted and reported in the cgroup where the forking task resides.
> 
> This decouples the limit and the notification caused by the limit making
> it hard to detect when the actual limit was effected.
> 
> Let's introduce new events:
> 	  max
> 		The number of times the limit of the cgroup was hit.
> 
> 	  max.imposed
> 		The number of times fork failed in the cgroup because of self
> 		or ancestor limit.

Can you please follow the same convention as memory.events and
memory.events.local?

Thanks.

-- 
tejun
