Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779448CC9F
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 20:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350127AbiALT4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 14:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357910AbiALT4P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 14:56:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB8C06173F;
        Wed, 12 Jan 2022 11:56:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o3so7279254pjs.1;
        Wed, 12 Jan 2022 11:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dNkZ0++TsRPpQCPTOH0l2U03MNR7CYedQf/ILhGHDCQ=;
        b=FVHowSxzxH0lM5OYHTtnXmPdNNn6TwZTY9vMhwV3Kua4R5qH9ahghCKP7BgNpG7w93
         rInTEEox+Pdc4dBwQGdiXhYhIEZ0v6pTLbB4RUTpa8XAsxmzFxZ/yZj+CLIEibwO0QMr
         2alqRU8IwcePCT7PkUZXlrYLqAhIWA38/d9t/nQottPSJeyK9RWnFtx4SHVAr4y83d6Z
         ASGMC5Lca330QH44LwphBzPdIG13gOPVHf5k9fz+hl5kmRZdLBa3ZFmU+aqINGja6WkA
         auzGsDNGemwunjO2nW0VnddXmOXJoo/IsXbtnEISwViLWwN7svOrw8hwgNYTRCQuyaQ1
         Voig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dNkZ0++TsRPpQCPTOH0l2U03MNR7CYedQf/ILhGHDCQ=;
        b=EaMTdGUW1BpH0R9lE2+Q+8AVZf4HNTqtC+d+6aqV5gRxEMsHt/vk4qhGliR7dLvDoZ
         AsxLen2xUaShMOATmnadc8njxs6DWlV9mypUM5rx5dXchHeH9xESsbc8rDM5IaAltGim
         BitAG0042a/0h99uoszuCmYSQcN+nAjBAstfRpiIwtAbmw9K4cM/UN+2zlDazUHse8v4
         z/xiLFyiiwhNIB95Rqao66jEX/Mz5NFPT5Qdb3SZ85MOeJeEa4A3a2rZ6XtFkKdk3dOv
         iiFzDRd5IImJwuH53KjWnnzB5l7sfGfzG+DU44TSYmeEwlsgJ/eL4/XMam8buSYzCRQ/
         12oA==
X-Gm-Message-State: AOAM533MbM+kpnHrheDe75eey3uaa+AGSyPnrJeMsT/viCkoz/zRY7vn
        0kz0oXX+/Y0kvZST2D54+uQ=
X-Google-Smtp-Source: ABdhPJyx1U13I9gL8tC0uj7krseZ+9lkdrgGXHckKEIfuGjNxFyzIsau5hYc+VBvIdDONmEyyifNuA==
X-Received: by 2002:a17:902:c711:b0:14a:3335:acc6 with SMTP id p17-20020a170902c71100b0014a3335acc6mr1020484plp.123.1642017375124;
        Wed, 12 Jan 2022 11:56:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id lk10sm7440106pjb.20.2022.01.12.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:56:14 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 09:56:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] cgroup: Fix cgroup_can_fork() and
 cgroup_post_fork() kernel-doc comment
Message-ID: <Yd8yXXFIU102O/dy@slm.duckdns.org>
References: <20220108063812.50370-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108063812.50370-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 08, 2022 at 02:38:12PM +0800, Yang Li wrote:
> Add the description of @kargs in cgroup_can_fork() and
> cgroup_post_fork() kernel-doc comment to remove warnings found
> by running scripts/kernel-doc, which is caused by using 'make W=1'.
> 
> kernel/cgroup/cgroup.c:6235: warning: Function parameter or member
> 'kargs' not described in 'cgroup_can_fork'
> kernel/cgroup/cgroup.c:6296: warning: Function parameter or member
> 'kargs' not described in 'cgroup_post_fork'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Applied to cgroup/for-5.18.

Thanks.

-- 
tejun
