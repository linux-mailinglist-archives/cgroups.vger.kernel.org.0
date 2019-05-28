Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366042CF1D
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 21:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfE1TCm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 15:02:42 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39504 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfE1TCm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 15:02:42 -0400
Received: by mail-ua1-f66.google.com with SMTP id w44so485463uad.6
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+9BnizOCabQkDdyYFoUODFzvXj83s9DouynwLQc1zAo=;
        b=vPZeoGpM1TxM+rkKkDVkj/pk7NjplN75jwOoId2JL3sEUhdp82vzMeQ0BrLfkPmlpv
         8j6SaTx4hbfC4z2optFvqnvYxlQrR/KwVtQtVbHV8o5bEn6GPfhrEW3CD1R3gKB0yR8a
         ar6ngjcK1UwlF9lGj2IxX8XVABFdvomtIoapBuBP1hwQuvbmC3WO3dXLGFRY61Bf6Ihg
         YojYnc9v7viqOHt+w8M3FL4G6MC5ijYel/0VDKBEQ4WYGeNiMWymsff+b9nL7+VH5stZ
         sroJGWWwChj5gdmlIPBUS1pVd9qwdq92JlQYPD+p0ix1h58hROUG0o8EyO4m/FMxj3z7
         tZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+9BnizOCabQkDdyYFoUODFzvXj83s9DouynwLQc1zAo=;
        b=E6S1dYTYTCsnvbdFKlUgAJo54gYcBbB09CXZDmKVnrL98d/KZqAbFTbyTV/cfBVd2N
         f9TH8AiuqRHIcKcCNNo5Qgul/BA6YE+VIYUNmxiGuMFW6se5A2eXdr02AlOsGeZL2wiz
         AbbQyTENSb9TGuWuNV0MyQuQ7i55Sre24dOKdmqh4YfcdCsL32A38QmNmZWHo1GTJ0W/
         XOWE/kDMO6Q2FXD7kRQeDXX8hTIu5EsTCyQHXgm3NzdGPHSbyQn1Mj0iEsVIn5h89aQe
         tAG8Lutq/xojr10Uk7lDmGdMA/wB0ItVukqaMupnwgw7vMisg6uby1GQ7+j105TCs2ds
         70nw==
X-Gm-Message-State: APjAAAWT1napq/f1LgJvdTHcG5TsYt4ZGAxfDl0f+2HJo6BkRdOzhs72
        mjSfKtVJ13zr6jCvtQxAn+qhu5MI
X-Google-Smtp-Source: APXvYqzm/Llg3EcAmooSmrW8alU2K3WRudRMe2u8y10GPBYXtzgiDWUSwvNxu2yC3/mHUonjW+RP1w==
X-Received: by 2002:ab0:7346:: with SMTP id k6mr40444068uap.89.1559070161378;
        Tue, 28 May 2019 12:02:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d74f])
        by smtp.gmail.com with ESMTPSA id 60sm4466721uah.1.2019.05.28.12.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 12:02:40 -0700 (PDT)
Date:   Tue, 28 May 2019 12:02:39 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 4/4] drm/amdkfd: Check against device cgroup
Message-ID: <20190528190239.GM374014@devbig004.ftw2.facebook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
 <20190517161435.14121-5-Harish.Kasiviswanathan@amd.com>
 <e547c0a1-e153-c3a6-79bc-67f59f364c3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e547c0a1-e153-c3a6-79bc-67f59f364c3e@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, May 17, 2019 at 08:12:17PM +0000, Kuehling, Felix wrote:
> Patches 1,2,4 will be submitted through amd-staging-drm-next. Patch 3 
> goes through the cgroup tree. Patch 4 depends on patch 3. So submitting 
> patch 4 will need to wait until we rebase amd-staging-drm-next on a new 
> enough kernel release that includes patch 3.
> 
> Patch 1 and 2 could be submitted now or wait for patch 3 as well so we 
> submit all our cgroup stuff in amdgpu and KFD together. It probably 
> makes most sense to wait since unused code tends to rot.
> 
> Patches 1,2,4 are already reviewed by me. Feel free to add my Acked-by 
> to patch 3.

Please feel free to add my acked-by and take patch 3 with the rest of
the patchset.

Thanks.

-- 
tejun
