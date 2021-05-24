Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EADA38F1B8
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhEXQrr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 12:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXQrq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 May 2021 12:47:46 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5B8C061574
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 09:46:16 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id e8so11234890qvp.7
        for <cgroups@vger.kernel.org>; Mon, 24 May 2021 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xb83GxWuZ4lA/TU3wPWgTdHTzlUcMb9aPuUp5f5l1bc=;
        b=J267Mg6sPL7xE5r9tBvmjLBHGaBUmRVpD3f92Vtj67ZkwORZs3Q4mDEy1QhHVfEflK
         HzJjehPKFCqWxXQ6rpg8xm3BFOitPCoAgWbvCGUEti0QxKOxkZJmYbLQ34H9xvgQEsnI
         ujKY84Y6zP9TNU4RKNXw8cJiimowP9K8MEVQdHzIUmugq97OA1r4Wajn4Qnrb42G4cxj
         HxFv93uMSj/LWyB+rr++cTQ2ltzpGeCZmQjRqS5TYdSqgs7dB5pSfOUeyloG5u1jbQ1w
         9pnhZfgEeUqE3nNCrOLcEC5m/wlwxRednw3NF7KhUXdX1xLPjxqXT+C1xRnfYMl6aReR
         4dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xb83GxWuZ4lA/TU3wPWgTdHTzlUcMb9aPuUp5f5l1bc=;
        b=fY2t0AKXG9KkoZj15D5W9pdTcSg/nFmzGV9WAORj7eO3F1xMqjUeqnl/dIsThbdvx1
         +mfhwAbrMhb85N1kfI7XwWremBDLdfaDzmSI2qryKTkMD335pbE45uriFD2zVAUmMkfA
         oFvS5Z7+L5MUG9srqIf/Nt+JWvC29PnXC2gK9lniFSq88Bsryco8JEORs/z2FJt0GPba
         1kqlZwsOSCFTYf5+kTuikRXwNetZGcCIxK7dz+OzqeqwKHDtPInTVL9h18QCX9qQvwP6
         EdL+qbaUxPHTmR6CRIaS/gHYDgwmPzthbUV57AUI1B1yI+f4Zn8gw32MxX/NjBtevv/x
         7Z2g==
X-Gm-Message-State: AOAM530PA35Po33AVjoNsNpdYwkDYBdJCp1L/dajNaQw94+J7u8dmMII
        FZ2ZiE0K+scffjzXbO1SN8I=
X-Google-Smtp-Source: ABdhPJyEc9lkJXWADLEb9F2tI9RH+3+VJVjlITjl7m8cnGDvqZPix30vZMoFMqPC5N4VbpjQjaFw7w==
X-Received: by 2002:a05:6214:f05:: with SMTP id gw5mr31481652qvb.44.1621874775484;
        Mon, 24 May 2021 09:46:15 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id f19sm11686608qkg.70.2021.05.24.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:46:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 24 May 2021 12:46:13 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 1/1] cgroup: fix spelling mistakes
Message-ID: <YKvYVQAK/vq4+W1D@slm.duckdns.org>
References: <20210524082943.8730-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524082943.8730-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 24, 2021 at 04:29:43PM +0800, Zhen Lei wrote:
> Fix some spelling mistakes in comments:
> hierarhcy ==> hierarchy
> automtically ==> automatically
> overriden ==> overridden
> In absense of .. or ==> In absence of .. and
> assocaited ==> associated
> taget ==> target
> initate ==> initiate
> succeded ==> succeeded
> curremt ==> current
> udpated ==> updated
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied to cgroup/for-5.13-fixes.

Thanks.

-- 
tejun
