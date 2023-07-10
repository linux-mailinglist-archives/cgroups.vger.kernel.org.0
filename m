Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3911C74DF26
	for <lists+cgroups@lfdr.de>; Mon, 10 Jul 2023 22:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGJUX6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jul 2023 16:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjGJUX6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jul 2023 16:23:58 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C58C195;
        Mon, 10 Jul 2023 13:23:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5634d8d1db0so3577965eaf.0;
        Mon, 10 Jul 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020636; x=1691612636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g3hnCKeeyeonNdi0zcIUQvwxiCz8ApNLGQhrycIqAg=;
        b=InVMQ/VHuNqtCpU4ma8Y21k3oB+fidG93tXHBhrC3ZOKYvY/UZG4FsP66pjY0mgpDJ
         3pv3u/0paL3IwW9nRC9ZrNoiMMuKN25Im4NcY3lF2dlzQp/b/DmcluJqVVszIH0AsKRC
         AtUnniXbcxTE5nJE3D6iTs/yjmGh3dcJ+n6U7bWrJikla5ZnWTEiNJS7mFcIoYiqJce2
         xgwrPsTcojI/lkJZ/N7crWEIaywUMgnpBk2+FlYr5pwtxxiYXRVrFCmbz3CCtQc29kuK
         U2B8zjrFqdM9TEIyFlPRnPLd1uxDwlPRZ1wOeOXzAPXK3qujLb2mGu+byssJ+BclvlX3
         x5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020636; x=1691612636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9g3hnCKeeyeonNdi0zcIUQvwxiCz8ApNLGQhrycIqAg=;
        b=CakTbI7kDVTmVifreAxPuwwMxOQf+xmTgsev9dQykQRj+v/XpWDmGqPbn1Kebi3c1J
         L8csZ6baS6G0AV+jY88YLST2a70f5H0nPuX0ULRhK6P6QxuDKH8/YIfE1QCYVb8xcLt4
         j519IaO46d+LxkabsUdR8aV5kHu3cirUqrCYHLtBZVl8uXKhRVJqs5NCGDpXGO5lZ+Qe
         oXsXOJ2lxso9HJXsJ2Dyedft6Y7ArB52z0UW+/LNq0AajLLvqjAvWByGIQ4TWu1Z3lpR
         WYPLKUKs+vfrd1beLywC77gYTDnZJn4NGgQK5rUifhu73x47UDnCpGC1w3pEoOFc+jkf
         e8YA==
X-Gm-Message-State: ABy/qLbU5rSOJW8DkHbxbwFXoL/hsNd+pE64ZLZQ+zS5txGB+CH4WLu6
        yUSHMyWfVYE3QvGcTGqOUK0=
X-Google-Smtp-Source: APBJJlH0t8DAII3NgZX7psR9fvgTvIW8NuVL5fe4+b79ZE/gryTOABuHFUNrDks7dfRmKdaTjH2VCA==
X-Received: by 2002:a05:6808:2022:b0:3a3:6e43:e681 with SMTP id q34-20020a056808202200b003a36e43e681mr14341272oiw.58.1689020636419;
        Mon, 10 Jul 2023 13:23:56 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78496000000b00682b4e5246csm213060pfn.23.2023.07.10.13.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:23:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:23:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, lizefan.x@bytedance.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor cleanup for cgroup_extra_stat_show()
Message-ID: <ZKxo2gzxmBMCKrE5@slm.duckdns.org>
References: <20230706094242.1707709-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706094242.1707709-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 06, 2023 at 05:42:42PM +0800, Miaohe Lin wrote:
> Make it under CONFIG_CGROUP_SCHED to rid of __maybe_unused annotation.
> And further fetch cgrp inside cgroup_extra_stat_show() directly to rid
> of __maybe_unused annotation of cgrp. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to cgroup/for-6.6.

Thanks.

-- 
tejun
