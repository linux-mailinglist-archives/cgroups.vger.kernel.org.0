Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D97339BB30
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 16:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFDOyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 10:54:14 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37864 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOyN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 10:54:13 -0400
Received: by mail-qk1-f182.google.com with SMTP id i67so9564587qkc.4;
        Fri, 04 Jun 2021 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RXCvfYSa38byXD2N1/fwQZOmkk+TUNZ19R3TGRpTRWk=;
        b=bqZuc7V4Te8HZclf1lNnPlamU6AU6Fb50rT8BqxHcQqYIT+TosF8EyGLsla2W/orEI
         8QxZX9Ufyng0ZoOk6XxyiI7Qfq6/t+g2QYiGRVxedBBchWxLWjsWh9pLgseqFFoWc34H
         DRBZfgf4rDURZdNFvmWuIGVOiidbO+ZyPxdnlOTSYEkj8ESjwcENaeiyGS2hK4ZAq3Q9
         7yVCFSMrYjMZMCslbxh+nTCq8SUC0CSEMNlbwD7gMoVEhXwtjVbVE6L7j6kCuVJxsEMq
         6mfXtmESlMAew88ZmVzezfzm9u50P+sYWgJ4FzLcZGjAOHAIgv7r/OMo1Mo9Jwc6Uc6J
         SbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RXCvfYSa38byXD2N1/fwQZOmkk+TUNZ19R3TGRpTRWk=;
        b=o8bmVnzE2Y5RnRqpzRgGrR6WCasfpO+H6euU+UsCF8rayYyuBFw9xfR30Tax73Y83U
         vWchWGeGsczXNOk1LCQemEJc4AR1wQggU4GibEJ/+lxFpnEplN/LWWR/AwlwUawZjRI6
         ++MQMr+sIpKBejl3tSOU6BEivSrfd6Vgd9a2s4uUGS6F0iGYZCx5iTzN8wpxMJXjec1j
         NSPgNpoqa+pxWmaFWs1PoC0IsyGlTYkEEDbNGEYQQphnO5Czq26ycO0LuCitPGjZuZJz
         zxZsM5U+N3qtzy8hjoVUa7+COorDfiMhKh03Tqecl/QkP7CXpCOhotxhONpkCoQTviFa
         PIVw==
X-Gm-Message-State: AOAM5319gfiqFxtt5MPH5K3Xz/RhsrY6ekvkgKE/hBksZQxqfNbkcxQg
        88WnjQGR8/OUABSuUD1qMeA=
X-Google-Smtp-Source: ABdhPJy2Z4akyHTZVttV5fz5tTxU2fZY9aFrZh9M4rj6GXe9WCrg+3Vo8rNYENV74uPiadOhtqfCkA==
X-Received: by 2002:a37:6c07:: with SMTP id h7mr1725830qkc.48.1622818287103;
        Fri, 04 Jun 2021 07:51:27 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id d24sm3824783qtm.70.2021.06.04.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:51:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 10:51:25 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix kernel-doc
Message-ID: <YLo97dfH7YOSLf5S@slm.duckdns.org>
References: <1621997349-118999-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621997349-118999-1-git-send-email-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 26, 2021 at 10:49:09AM +0800, Yang Li wrote:
> Fix function name in cgroup.c and rstat.c kernel-doc comment
> to remove these warnings found by clang_w1.
> 
> kernel/cgroup/cgroup.c:2401: warning: expecting prototype for
> cgroup_taskset_migrate(). Prototype was for cgroup_migrate_execute()
> instead.
> kernel/cgroup/rstat.c:233: warning: expecting prototype for
> cgroup_rstat_flush_begin(). Prototype was for cgroup_rstat_flush_hold()
> instead.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 'commit e595cd706982 ("cgroup: track migration context in cgroup_mgctx")'
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to cgroup/for-5.14.

Thanks.

-- 
tejun
