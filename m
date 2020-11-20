Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942582BB8B8
	for <lists+cgroups@lfdr.de>; Fri, 20 Nov 2020 23:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgKTWOT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Nov 2020 17:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgKTWOT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Nov 2020 17:14:19 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23193C0613CF;
        Fri, 20 Nov 2020 14:14:19 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d28so10452600qka.11;
        Fri, 20 Nov 2020 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z1pyZKUt70+7Oah4brRuaKPswnwh6VHan/l11sMx/Yg=;
        b=ljsWDBMqGzGOgdCS3yCLBdUS4tlf5XcKxFGdE2y5hnGDPlHFCJvgNgONmquepZKXm3
         gA3I75WL0l/JV+dAYNQwIwXg/ito2mPyy3WMIeEno7t+bzQLXNa+y1vhfB2r9f7Osb2/
         Rc/lpcKXHbQGiSD1QNy3tpmxLvtnTVo+4G7XFjVtBL8QCCQUoKfYoD4A7cLOXlw20f3M
         qGyxp/h6erD4hnK6wMCjix/lF3sUsQozSnQX6aSYEMelVacfe22lymxKLrTNQSMNK25I
         a4JDZtUmf4RU4wuufHvcAW46kKpj++bgP5VpvRvQ047kFD7cyGCF54+mVNun1zsbvTdu
         QSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Z1pyZKUt70+7Oah4brRuaKPswnwh6VHan/l11sMx/Yg=;
        b=l/rKvg8yy9yDUO5tjx8FbPw2RGX7PB6pYwJXGbYd1Nwrm6qHFI/3iSDayNyqDFlfwK
         mZWKYLq2dV9E7oBgUqmRr2FyaujvJV8FK82EDKR9PaF7eor5GVv4YWNkIuP5j6MAWLV8
         I+N43YleRbewLiv5AWJSM5EOWFoAr9d1Vv9qrOD7OtTkz9KP6TN2a+yNIcZMWXBoNY0f
         xMW5hH4MOkDAE5G6mIOSwYxWQuGhISod2jKb2LKCfaf4/G6oRRnqhkrKgGEieI7aPzTX
         m7DErReoJn/72ATaeMlH4BU27CtJPXt1x4jGD/pO+ngmScvGuqlzYRBFsL22MwetILcF
         tynA==
X-Gm-Message-State: AOAM532gm20Fy9eRy4wWUOTb+SXkTPUFlnHX58/G3hsQ387PlCQ9IILB
        zK+ptepKvn+qLoTyXlWUaO8=
X-Google-Smtp-Source: ABdhPJwWmiLh5lhE8VTo8bVOrHhqsC7gkA+K1WDhWiAkSx5wwDJmdi7e0C+ZoL3KAVGwoGYNzYqbtw==
X-Received: by 2002:a37:5243:: with SMTP id g64mr18994470qkb.248.1605910458220;
        Fri, 20 Nov 2020 14:14:18 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id r55sm3097330qte.8.2020.11.20.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 14:14:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 Nov 2020 17:13:57 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, newella@fb.com
Subject: Re: [PATCH 03/27] blk-iocost: use local[64]_t for percpu stat
Message-ID: <X7g/pTLLJEQXdbD7@mtj.duckdns.org>
References: <20200901185257.645114-1-tj@kernel.org>
 <20200901185257.645114-4-tj@kernel.org>
 <20201120215147.GB961977@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120215147.GB961977@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Nov 21, 2020 at 06:51:47AM +0900, Stafford Horne wrote:
> FYI, I am just noticing this but this breaks my allyesconfig build
> on OpenRISC; as 32-bit arch/openrisc doesn't define local64.h
> 
> In general local64 is slow on 32-bit architectures, would that
> be a problem with the usage here?  Are the calls to local64_*
> below on critical paths?

It gets hot when running on really high iops devices but that hopefully
isn't a problem for 32bit openrisc.

> Either way I will submit a patch in include generic local64.h
> on OpenRISC, I confirmed it fixes the build.  I do not know of anyone
> using cgroups on OpenRISC systems.

Yeah, sounds like the right fix.

Thanks.

-- 
tejun
