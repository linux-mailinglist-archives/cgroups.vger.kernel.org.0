Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB2876EC05
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 16:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjHCOMD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 10:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjHCOLn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 10:11:43 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FCF4C0C
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 07:10:55 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d03d3cac6so5429486d6.2
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691071854; x=1691676654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK1kR5msnkStlX/fQur0EoisiWFGZLTUdGslkPaUGUk=;
        b=UFOM7zDVQVcS3LfF/4QazEBXoUPkF5omxMvrFErHuGjaX/itDvATmOxiOE101O+XMw
         gy8iScRh4vaPBjWLFKcTsyeaw5iLs4Wu6simJm1pMbYQMfGTfZz8rmpbjV3TXtOVh60T
         YtAfMqN1tYQyoFfKOcgZ2HDeANRxU8tctaXUHZYCq+W3Kagr5a07jSL42pUev4wm3b0h
         FfWGxKAR53Xvdc/JXLg891qsRI1LjYV81hCLfsAYeVeiOKkE/Wv51Rup2osuUe27Emhy
         Q2bOYlT5SDplenN//8wyLqeEdGGC4NH8nFk9PaAG3zOL163k7T/MRD7QRT66ot4e2Eu5
         qTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071854; x=1691676654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK1kR5msnkStlX/fQur0EoisiWFGZLTUdGslkPaUGUk=;
        b=Td5vLyTCZUo7NhcGLxdBlCajbj/iC16sgnEmxoDEJ+7FE2H+PSLIlCFICQneRAX3Oq
         1oOF5nIFbMFjiUG9r7OVpRmmbHuvmZ9+utsJiruscrJsQXJaTrg+UCuiDkBnfFvaquIq
         17NzaCkaXDvxNAqlOGjaDPX/OcRMScF+65XFEv6qaBBV5V2A3BkdrKosG3ljJnDjymNx
         zE1Ay+BJUsMJH65X/wCva4Y05qOdpHQCQfs1HncKUYhYe8ob7g7hTe19SqZhsRnT3PkU
         1hy0klm6z5Qtu4IQpyBceLFRT8W7MmO8AZfhW0GMWd2GqjmjBzX4MeKN1F2kGlXT619t
         AKzQ==
X-Gm-Message-State: ABy/qLY/6hRGcURk7oGkTdZ1NkryALVj/i51tLMi13EWwQ2teDmRNcji
        lulqa9JjJyEBaOmDvjLFTIKU7w==
X-Google-Smtp-Source: APBJJlHG/HJ8dg2so1MrmKd58NvGTSjLjHljlytzbh4O2k3vFxYFztSYGJceRVx7+cpcvA/Uzuhi5g==
X-Received: by 2002:a0c:e14c:0:b0:626:290f:3e80 with SMTP id c12-20020a0ce14c000000b00626290f3e80mr16822152qvl.50.1691071854445;
        Thu, 03 Aug 2023 07:10:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ce391000000b0063211e61875sm6316535qvl.14.2023.08.03.07.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:10:54 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:10:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix obsolete function name in
 cgroup_destroy_locked()
Message-ID: <20230803141053.GB219857@cmpxchg.org>
References: <20230803115702.741128-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803115702.741128-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 03, 2023 at 07:57:02PM +0800, Miaohe Lin wrote:
> Since commit e76ecaeef65c ("cgroup: use cgroup_kn_lock_live() in other
> cgroup kernfs methods"), cgroup_kn_lock_live() is used in cgroup kernfs
> methods. Update corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
